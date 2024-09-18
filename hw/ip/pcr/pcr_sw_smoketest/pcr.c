#include "sw/device/lib/pcr.h"

#include <string.h>

#include "sw/device/lib/base/macros.h"
#include "sw/device/lib/base/mmio.h"
#include "sw/device/lib/base/status.h"
#include "sw/device/lib/crypto/sha256.h"
#include "hw/ip/pcr/pcr_sw_smoketest/pcr_regs.h"
#include "sw/device/lib/runtime/hart.h"
#include "sw/device/lib/runtime/log.h"
#include "hw/top_earlgrey/sw/autogen/top_earlgrey.h"

// Define the base address of the PCR registers.
#define PCR_BASE_ADDR <YOUR_PCR_BASE_ADDRESS>
