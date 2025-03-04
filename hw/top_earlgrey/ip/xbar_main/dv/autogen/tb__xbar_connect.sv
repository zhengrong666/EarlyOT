// Copyright lowRISC contributors (OpenTitan project).
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// tb__xbar_connect generated by `tlgen.py` tool

xbar_main dut();

`DRIVE_CLK(clk_main_i)
`DRIVE_CLK(clk_fixed_i)
`DRIVE_CLK(clk_usb_i)
`DRIVE_CLK(clk_spi_host0_i)
`DRIVE_CLK(clk_spi_host1_i)

initial force dut.clk_main_i = clk_main_i;
initial force dut.clk_fixed_i = clk_fixed_i;
initial force dut.clk_usb_i = clk_usb_i;
initial force dut.clk_spi_host0_i = clk_spi_host0_i;
initial force dut.clk_spi_host1_i = clk_spi_host1_i;

// TODO, all resets tie together
initial force dut.rst_main_ni = rst_n;
initial force dut.rst_fixed_ni = rst_n;
initial force dut.rst_usb_ni = rst_n;
initial force dut.rst_spi_host0_ni = rst_n;
initial force dut.rst_spi_host1_ni = rst_n;

// Host TileLink interface connections
`CONNECT_TL_HOST_IF(rv_core_ibex__corei, dut, clk_main_i, rst_n)
`CONNECT_TL_HOST_IF(rv_core_ibex__cored, dut, clk_main_i, rst_n)
`CONNECT_TL_HOST_IF(rv_dm__sba, dut, clk_main_i, rst_n)

// Device TileLink interface connections
`CONNECT_TL_DEVICE_IF(rv_dm__regs, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(rv_dm__mem, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(rom_ctrl__rom, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(rom_ctrl__regs, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(peri, dut, clk_fixed_i, rst_n)
`CONNECT_TL_DEVICE_IF(spi_host0, dut, clk_spi_host0_i, rst_n)
`CONNECT_TL_DEVICE_IF(spi_host1, dut, clk_spi_host1_i, rst_n)
`CONNECT_TL_DEVICE_IF(usbdev, dut, clk_usb_i, rst_n)
`CONNECT_TL_DEVICE_IF(flash_ctrl__core, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(flash_ctrl__prim, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(flash_ctrl__mem, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(hmac, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(kmac, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(aes, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(entropy_src, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(csrng, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(edn0, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(edn1, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(rv_plic, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(otbn, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(keymgr, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(rot_top, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(sm3, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(sm4, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(rs_encode, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(rs_decode, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(puf1, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(puf2, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(puf_reg, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(pcr, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(rv_core_ibex__cfg, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(sram_ctrl_main__regs, dut, clk_main_i, rst_n)
`CONNECT_TL_DEVICE_IF(sram_ctrl_main__ram, dut, clk_main_i, rst_n)
