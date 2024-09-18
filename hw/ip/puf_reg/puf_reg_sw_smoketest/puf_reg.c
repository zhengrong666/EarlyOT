#include "sw/device/lib/puf_reg.h"

#include <string.h>

#include "sw/device/lib/base/macros.h"
#include "sw/device/lib/base/mmio.h"
#include "sw/device/lib/base/status.h"
#include "sw/device/lib/crypto/sha256.h"
#include "hw/ip/puf_reg/puf_reg_sw_smoketest/puf_reg_regs.h"
#include "sw/device/lib/runtime/hart.h"
#include "sw/device/lib/runtime/log.h"
#include "hw/top_earlgrey/sw/autogen/top_earlgrey.h"

// Define the base address of the puf_reg registers.
#define puf_reg_BASE_ADDR <YOUR_puf_reg_BASE_ADDRESS>
