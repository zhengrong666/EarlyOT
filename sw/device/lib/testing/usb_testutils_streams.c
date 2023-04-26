// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// USB streaming utility code
//
// This test code supports a set of concurrent uni/bidirectional streams using
// the Bulk Transfer type, such that all data is delivered reliably to/from the
// USB host.
//
// The data itself is pseudo-randomly generated by the sender and,
// independently, by the receiving code to check that the data has been
// propagated unmodified and without data loss, corruption, replication etc.

#include "sw/device/lib/testing/usb_testutils_streams.h"

#include "sw/device/lib/runtime/print.h"
#include "sw/device/lib/testing/test_framework/check.h"
#include "sw/device/lib/testing/usb_testutils_diags.h"

/**
 * Read method to be employed
 */
static const enum {
  kReadMethodNone = 0u,  // Just discard the data; do not read it from usbdev
  kReadMethodStandard,   // Use standard dif_usbdev_buffer_read() function
  kReadMethodFaster      // Faster implementation
} read_method = kReadMethodStandard;

/**
 * Diagnostic logging; expensive
 */
static bool log_traffic = false;

// Dump a sequence of bytes as hexadecimal and ASCII for diagnostic purposes
static void buffer_dump(const uint8_t *data, size_t n) {
  base_hexdump_fmt_t fmt = {
      .bytes_per_word = 1,
      .words_per_line = 0x20u,
      .alphabet = &kBaseHexdumpDefaultFmtAlphabet,
  };

  base_hexdump_with(fmt, (char *)data, n);
}

// Create a stream signature buffer
static uint32_t buffer_sig_create(usb_testutils_streams_ctx_t *ctx,
                                  usbdev_stream_t *s,
                                  dif_usbdev_buffer_t *buf) {
  usbdev_stream_sig_t sig;

  sig.head_sig = USBDEV_STREAM_SIGNATURE_HEAD;
  sig.init_lfsr = s->tx_lfsr;
  sig.stream = s->id | (uint8_t)s->flags;
  sig.reserved1 = 0U;
  sig.reserved2 = 0U;
  sig.num_bytes = s->transfer_bytes;
  sig.tail_sig = USBDEV_STREAM_SIGNATURE_TAIL;

  size_t bytes_written;
  CHECK_DIF_OK(dif_usbdev_buffer_write(ctx->usbdev->dev, buf, (uint8_t *)&sig,
                                       sizeof(sig), &bytes_written));
  CHECK(bytes_written == sizeof(sig));

  // Note: stream signature is not included in the count of bytes transferred

  return bytes_written;
}

// Fill a buffer with LFSR-generated data
static void buffer_fill(usb_testutils_streams_ctx_t *ctx, usbdev_stream_t *s,
                        dif_usbdev_buffer_t *buf, uint8_t num_bytes) {
  alignas(uint32_t) uint8_t data[USBDEV_MAX_PACKET_SIZE];

  CHECK(num_bytes <= buf->remaining_bytes);
  CHECK(num_bytes <= sizeof(data));

  if (s->generating) {
    // Emit LFSR-generated byte stream; keep this brief so that we can
    // reduce our latency in responding to USB events (usb_testutils employs
    // polling at present)
    uint8_t lfsr = s->tx_lfsr;

    const uint8_t *edp = &data[num_bytes];
    uint8_t *dp = data;
    while (dp < edp) {
      *dp++ = lfsr;
      lfsr = LFSR_ADVANCE(lfsr);
    }

    // Update the LFSR for the next packet
    s->tx_lfsr = lfsr;
  } else {
    // Undefined buffer contents; useful for profiling IN throughput on
    // CW310, because the CPU load at 10MHz can be an appreciable slowdown
  }

  if (s->verbose && log_traffic) {
    buffer_dump(data, num_bytes);
  }

  size_t bytes_written;

  CHECK_DIF_OK(dif_usbdev_buffer_write(ctx->usbdev->dev, buf, data, num_bytes,
                                       &bytes_written));
  CHECK(bytes_written == num_bytes);
  s->tx_bytes += bytes_written;
}

// Check the contents of a received buffer
static void buffer_check(usb_testutils_streams_ctx_t *ctx, usbdev_stream_t *s,
                         dif_usbdev_rx_packet_info_t packet_info,
                         dif_usbdev_buffer_t buf) {
  usb_testutils_ctx_t *usbdev = ctx->usbdev;
  uint8_t len = packet_info.length;

  if (len > 0) {
    alignas(uint32_t) uint8_t data[USBDEV_MAX_PACKET_SIZE];

    CHECK(len <= sizeof(data));

    size_t bytes_read;

    // Notes: the buffer being read here is USBDEV memory accessed as MMIO, so
    //        only the DIF accesses it directly. when we consume the final bytes
    //        from the read buffer, it is automatically returned to the buffer
    //        pool.
    CHECK_DIF_OK(dif_usbdev_buffer_read(usbdev->dev, usbdev->buffer_pool, &buf,
                                        data, len, &bytes_read));
    CHECK(bytes_read == len);

    if (log_traffic) {
      buffer_dump(data, bytes_read);
    }

    // Check received data against expected LFSR-generated byte stream;
    // keep this brief so that we can reduce our latency in responding to
    // USB events (usb_testutils employs polling at present)
    uint8_t rxtx_lfsr = s->rxtx_lfsr;
    uint8_t rx_lfsr = s->rx_lfsr;

    const uint8_t *esp = &data[bytes_read];
    const uint8_t *sp = data;
    while (sp < esp) {
      // Received data should be the XOR of two LFSR-generated PRND streams -
      // ours on the
      //   transmission side, and that of the DPI model
      uint8_t expected = rxtx_lfsr ^ rx_lfsr;
      CHECK(expected == *sp,
            "S%u: Unexpected received data 0x%02x : (LFSRs 0x%02x 0x%02x)",
            s->id, *sp, rxtx_lfsr, rx_lfsr);

      rxtx_lfsr = LFSR_ADVANCE(rxtx_lfsr);
      rx_lfsr = LFSR_ADVANCE(rx_lfsr);
      sp++;
    }

    // Update the LFSRs for the next packet
    s->rxtx_lfsr = rxtx_lfsr;
    s->rx_lfsr = rx_lfsr;
  } else {
    // In the event that we've received a zero-length data packet, we still
    // must return the buffer to the pool
    CHECK_DIF_OK(
        dif_usbdev_buffer_return(usbdev->dev, usbdev->buffer_pool, &buf));
  }
}

// Callback for successful buffer transmission
static status_t strm_tx_done(void *stream_v,
                             usb_testutils_xfr_result_t result) {
  usbdev_stream_t *s = (usbdev_stream_t *)stream_v;
  usb_testutils_streams_ctx_t *ctx = s->ctx;
  usb_testutils_ctx_t *usbdev = ctx->usbdev;

  // If we do not have at least one queued buffer then something has gone wrong
  // and this callback is inappropriate
  uint8_t tx_ep = s->tx_ep;
  uint8_t nqueued = ctx->tx_bufs_queued[tx_ep];

  if (s->verbose) {
    LOG_INFO("strm_tx_done called. %u (%u total) buffers(s) are queued",
             nqueued, ctx->tx_queued_total);
  }

  TRY_CHECK(nqueued > 0);

  // Note: since buffer transmission and completion signalling both occur within
  // the foreground code (polling, not interrupt-driven) there is no issue of
  // potential races here

  if (nqueued > 0) {
    // Shuffle the buffer descriptions, without using memmove
    for (unsigned idx = 1u; idx < nqueued; idx++) {
      ctx->tx_bufs[tx_ep][idx - 1u] = ctx->tx_bufs[tx_ep][idx];
    }

    // Is there another buffer ready to be transmitted?
    ctx->tx_queued_total--;
    ctx->tx_bufs_queued[tx_ep] = --nqueued;

    if (nqueued) {
      TRY(dif_usbdev_send(usbdev->dev, tx_ep, &ctx->tx_bufs[tx_ep][0u]));
    }
  }
  return OK_STATUS();
}

// Callback for buffer reception
static status_t strm_rx(void *stream_v, dif_usbdev_rx_packet_info_t packet_info,
                        dif_usbdev_buffer_t buf) {
  usbdev_stream_t *s = (usbdev_stream_t *)stream_v;
  usb_testutils_streams_ctx_t *ctx = s->ctx;
  usb_testutils_ctx_t *usbdev = ctx->usbdev;

  TRY_CHECK(packet_info.endpoint == s->rx_ep);

  // We do not expect to receive SETUP packets to this endpoint
  TRY_CHECK(!packet_info.is_setup);

  if (s->verbose) {
    LOG_INFO("Stream %u: Received buffer of %u bytes(s)", s->id,
             packet_info.length);
  }

  if (s->sending && s->generating) {
    buffer_check(ctx, s, packet_info, buf);
  } else {
    // Note: this is useful for profiling the OUT performance on CW310
    usb_testutils_ctx_t *usbdev = ctx->usbdev;

    if (read_method != kReadMethodNone && packet_info.length > 0) {
      alignas(uint32_t) uint8_t data[USBDEV_MAX_PACKET_SIZE];
      size_t len = packet_info.length;
      size_t bytes_read;

      switch (read_method) {
#if USBUTILS_MEM_FASTER
        // Faster read performance using custom routine
        case kReadMethodFaster:
          // TODO: faster read method not yet integrated, defaulting to standard
          // no break
#endif
        //  Use the standard interface
        default:
          TRY(dif_usbdev_buffer_read(usbdev->dev, usbdev->buffer_pool, &buf,
                                     data, len, &bytes_read));
          break;
      }
    } else {
      // Just discard the data, without reading it; peak OUT performance
      TRY(dif_usbdev_buffer_return(usbdev->dev, usbdev->buffer_pool, &buf));
    }
  }

  s->rx_bytes += packet_info.length;

  return OK_STATUS();
}

// Callback for unexpected data reception (IN endpoint)
static status_t rx_show(void *stream_v, dif_usbdev_rx_packet_info_t packet_info,
                        dif_usbdev_buffer_t buf) {
  usbdev_stream_t *s = (usbdev_stream_t *)stream_v;
  usb_testutils_streams_ctx_t *ctx = s->ctx;
  usb_testutils_ctx_t *usbdev = ctx->usbdev;
  uint8_t data[0x100U];
  size_t bytes_read;
  TRY(dif_usbdev_buffer_read(usbdev->dev, usbdev->buffer_pool, &buf, data,
                             packet_info.length, &bytes_read));
  LOG_INFO("rx_show packet of %u byte(s) - read %u", packet_info.length,
           bytes_read);
  buffer_dump(data, bytes_read);

  return OK_STATUS();
}

// Returns an indication of whether a stream has completed its data transfer
bool usb_testutils_stream_completed(const usb_testutils_streams_ctx_t *ctx,
                                    uint8_t id) {
  // Locate the stream context information
  const usbdev_stream_t *s = &ctx->streams[id];

  return (s->tx_bytes >= s->transfer_bytes) &&
         (s->rx_bytes >= s->transfer_bytes);
}

// Initialize a stream, preparing it for use
status_t usb_testutils_stream_init(usb_testutils_streams_ctx_t *ctx, uint8_t id,
                                   uint8_t ep_in, uint8_t ep_out,
                                   uint32_t transfer_bytes,
                                   usbdev_stream_flags_t flags, bool verbose) {
  // Locate the stream context information
  TRY_CHECK(id < USBUTILS_STREAMS_MAX);
  usbdev_stream_t *s = &ctx->streams[id];

  // We need to be able to locate the test context given only the stream
  // pointer within the strm_tx_done callback from usb_testutils
  s->ctx = ctx;

  // Remember the stream IDentifier and flags
  s->id = id;
  s->flags = flags;

  // Remember whether verbose reporting is required
  s->verbose = verbose;

  // Extract a couple of convenient flags; from our perspective
  s->sending = ((flags & kUsbdevStreamFlagRetrieve) != 0U);
  s->generating = ((flags & kUsbdevStreamFlagCheck) != 0U);

  // Not yet sent stream signature
  s->sent_sig = false;

  // Initialize the transfer state
  s->tx_bytes = 0u;
  s->rx_bytes = 0u;
  s->transfer_bytes = transfer_bytes;

  // Initialize the LFSR state for transmission and reception sides
  // - we use a simple LFSR to generate a PRND stream to transmit to the USBPI
  // - the USBDPI XORs the received data with another LFSR-generated stream of
  //   its own, and transmits the result back to us
  // - to check the returned data, our reception code mimics both LFSRs
  s->tx_lfsr = USBTST_LFSR_SEED(id);
  s->rxtx_lfsr = s->tx_lfsr;
  s->rx_lfsr = USBDPI_LFSR_SEED(id);

  // Packet size randomization
  s->tx_buf_size = BUFSZ_LFSR_SEED(id);

  // Set up the endpoint for IN transfers (TO host)
  //
  // Note: We install the rx_show handler to catch any misdirected data
  // transfers
  usb_testutils_rx_handler_t rx = (ep_in == ep_out) ? strm_rx : rx_show;

  s->tx_ep = ep_in;
  CHECK_STATUS_OK(usb_testutils_endpoint_setup(
      ctx->usbdev, ep_in, kUsbdevOutStream, s, strm_tx_done, rx, NULL, NULL));

  s->rx_ep = ep_out;
  if (ep_out != ep_in) {
    // Set up the endpoint for OUT transfers (FROM host)
    CHECK_STATUS_OK(usb_testutils_endpoint_setup(
        ctx->usbdev, ep_out, kUsbdevOutStream, s, NULL, strm_rx, NULL, NULL));
  }
  return OK_STATUS();
}

// Service the given stream, preparing and/or sending any data that we can;
// data reception is handled via callbacks and requires no attention here
status_t usb_testutils_stream_service(usb_testutils_streams_ctx_t *ctx,
                                      uint8_t id) {
  // Locate the stream context information
  TRY_CHECK(id < USBUTILS_STREAMS_MAX);
  usbdev_stream_t *s = &ctx->streams[id];

  // Generate output data as soon as possible and make it available for
  //   collection by the host

  uint8_t tx_ep = s->tx_ep;
  uint8_t nqueued = ctx->tx_bufs_queued[tx_ep];

  if (s->tx_bytes < s->transfer_bytes &&      // More bytes to transfer?
      nqueued < ctx->tx_bufs_limit[tx_ep] &&  // Endpoint allowed buffer?
      ctx->tx_queued_total <
          USBUTILS_STREAMS_TXBUF_MAX) {  // Total buffers not exceeded?
    dif_usbdev_buffer_t buf;

    // See whether we can populate another buffer yet
    dif_result_t dif_result = dif_usbdev_buffer_request(
        ctx->usbdev->dev, ctx->usbdev->buffer_pool, &buf);
    if (dif_result == kDifOk) {
      // This is just for reporting the number of buffers presented to the
      // USB device, as a progress indicator
      static unsigned bufs_sent = 0u;
      uint32_t num_bytes;

      if (s->sent_sig) {
        if (s->flags & kUsbdevStreamFlagMaxPackets) {
          num_bytes = USBDEV_MAX_PACKET_SIZE;
        } else {
          // Vary the amount of data sent per buffer
          num_bytes = s->tx_buf_size % (USBDEV_MAX_PACKET_SIZE + 1u);
          s->tx_buf_size = LFSR_ADVANCE(s->tx_buf_size);
        }
        uint32_t tx_left = s->transfer_bytes - s->tx_bytes;
        if (num_bytes > tx_left) {
          num_bytes = tx_left;
        }
        buffer_fill(ctx, s, &buf, num_bytes);
      } else {
        // Construct a signature to send to the host-side software,
        // identifying the stream and its properties
        num_bytes = buffer_sig_create(ctx, s, &buf);
        s->sent_sig = true;
        if (!s->sending) {
          // If not required to send, we send only the stream signature
          // identifying the test properties
          s->tx_bytes = s->transfer_bytes;
        }
      }

      // Remember the buffer until we're informed that it has been
      // successfully transmitted
      //
      // Note: since the 'tx_done' callback occurs from foreground code that
      // is polling, there is no issue of interrupt races here
      ctx->tx_bufs[tx_ep][nqueued] = buf;
      ctx->tx_bufs_queued[tx_ep] = ++nqueued;
      ctx->tx_queued_total++;

      // Can we present this buffer for transmission yet?
      if (nqueued <= 1U) {
        TRY(dif_usbdev_send(ctx->usbdev->dev, tx_ep, &buf));
      }

      if (s->verbose) {
        LOG_INFO(
            "Stream %u: %uth buffer (of 0x%x byte(s)) awaiting transmission",
            s->id, bufs_sent, num_bytes);
      }
      bufs_sent++;
    } else {
      // If we have no more buffers available right now, continue polling...
      CHECK(dif_result == kDifUnavailable);
    }
  }
  return OK_STATUS();
}

status_t usb_testutils_streams_init(usb_testutils_streams_ctx_t *ctx,
                                    unsigned nstreams, uint32_t num_bytes,
                                    usbdev_stream_flags_t flags, bool verbose) {
  TRY_CHECK(nstreams <= USBUTILS_STREAMS_MAX);

  // Remember the stream count
  ctx->nstreams = nstreams;

  // Initialize the state of each stream
  for (unsigned id = 0U; id < nstreams; id++) {
    // Which endpoint are we using for the IN transfers to the host?
    const uint8_t ep_in = 1u + id;
    // Which endpoint are we using for the OUT transfers from the host?
    const uint8_t ep_out = 1u + id;
    TRY(usb_testutils_stream_init(ctx, id, ep_in, ep_out, num_bytes, flags,
                                  verbose));
  }

  // Decide how many buffers each endpoint may queue up for transmission;
  // we must ensure that there are buffers available for reception, and we
  // do not want any endpoint to starve another
  for (unsigned s = 0U; s < nstreams; s++) {
    // This is slightly overspending the available buffers, leaving the
    //   endpoints to vie for the final few buffers, so it's important that
    //   we limit the total number of buffers across all endpoints too
    unsigned ep = ctx->streams[s].tx_ep;
    ctx->tx_bufs_queued[ep] = 0U;
    ctx->tx_bufs_limit[ep] =
        (USBUTILS_STREAMS_TXBUF_MAX + nstreams - 1) / nstreams;
  }
  ctx->tx_queued_total = 0U;
  return OK_STATUS();
}

status_t usb_testutils_streams_service(usb_testutils_streams_ctx_t *ctx) {
  for (unsigned id = 0U; id < ctx->nstreams; id++) {
    TRY(usb_testutils_stream_service(ctx, id));

    // We must keep polling regularly in order to handle detection of packet
    // transmission as well as perform packet reception and checking
    CHECK_STATUS_OK(usb_testutils_poll(ctx->usbdev));
  }
  return OK_STATUS();
}

bool usb_testutils_streams_completed(const usb_testutils_streams_ctx_t *ctx) {
  // See whether any streams still have more work to do
  unsigned id = 0U;
  while (id < ctx->nstreams && usb_testutils_stream_completed(ctx, id)) {
    id++;
  }
  return (id >= ctx->nstreams);
}
