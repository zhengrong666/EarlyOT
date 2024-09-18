#include "hw/top_earlgrey/sw/autogen/top_earlgrey.h"
#include "sw/device/lib/base/mmio.h"
#include "sw/device/lib/runtime/log.h"
#include "sw/device/lib/testing/test_framework/check.h"
#include "sw/device/lib/testing/test_framework/ottf_main.h"
#include "hw/ip/pcr/pcr_sw_smoketest/pcr_regs.h"

static const uint32_t kTestData = 0xDEADBEEF;
static mmio_region_t pcr_base_addr;

static void init_pcr_base_addr(void) {
  pcr_base_addr = mmio_region_from_addr(TOP_EARLGREY_PCR_BASE_ADDR);
  LOG_INFO("PCR base address: 0x%08x", pcr_base_addr);
}

static void write_pcr(uint32_t select, uint32_t data) {
  // Set PCR select and enable write
  mmio_region_write32(pcr_base_addr, PCR_CTRL_REG_OFFSET, 
                      ((select & 0x1F) << PCR_CTRL_SELECT_OFFSET) | (1 << PCR_CTRL_WR_EN_BIT));
  asm volatile("" ::: "memory");

  // Read back and print the control register value
  uint32_t read_ctrl = mmio_region_read32(pcr_base_addr, PCR_CTRL_REG_OFFSET);
  LOG_INFO("Control register value after write: 0x%08x", read_ctrl);

  // Write data to PCR
  for (int i = 0; i < PCR_PCR_WR_MULTIREG_COUNT; i++) {
    mmio_region_write32(pcr_base_addr, PCR_PCR_WR_0_REG_OFFSET + (i * 4), data);
    asm volatile("" ::: "memory");
  }

  // Clear write enable bit
  mmio_region_write32(pcr_base_addr, PCR_CTRL_REG_OFFSET, 
                      ((select & 0x1F) << PCR_CTRL_SELECT_OFFSET));
}

static bool read_and_check_pcr(uint32_t select, uint32_t expected_data) {
  // Set PCR select and enable read
  mmio_region_write32(pcr_base_addr, PCR_CTRL_REG_OFFSET, 
                      ((select & 0x1F) << PCR_CTRL_SELECT_OFFSET) | (1 << PCR_CTRL_RD_EN_BIT));
  asm volatile("" ::: "memory");
  
    // Read back and print the control register value
  uint32_t read_ctrl = mmio_region_read32(pcr_base_addr, PCR_CTRL_REG_OFFSET);
  LOG_INFO("Control register value after write: 0x%08x", read_ctrl);

  // Read and verify data
  for (int i = 0; i < PCR_PCR_RD_MULTIREG_COUNT; i++) {
    uint32_t read_data = mmio_region_read32(pcr_base_addr, PCR_PCR_RD_0_REG_OFFSET + (i * 4));
    if (read_data != expected_data) {
      LOG_ERROR("PCR %d, register %d: expected 0x%08x, got 0x%08x", select, i, expected_data, read_data);
      return false;
    }
  }

  // Clear read enable bit
  mmio_region_write32(pcr_base_addr, PCR_CTRL_REG_OFFSET, 
                      ((select & 0x1F) << PCR_CTRL_SELECT_OFFSET));

  return true;
}

bool test_pcr(void) {
  // Test writing and reading from PCR 7
  write_pcr(7, kTestData);
  CHECK(read_and_check_pcr(7, kTestData));

  // Test writing and reading from PCR 1
  write_pcr(1, ~kTestData);
  CHECK(read_and_check_pcr(1, ~kTestData));

  return true;
}

bool test_main(void) {
  init_pcr_base_addr();
  return test_pcr();
}

OTTF_DEFINE_TEST_CONFIG();