#ifndef OPENTITAN_SW_DEVICE_LIB_puf_reg_H_
#define OPENTITAN_SW_DEVICE_LIB_puf_reg_H_

#include <stddef.h>
#include <stdint.h>

#include "sw/device/lib/base/macros.h"
#include "sw/device/lib/base/mmio.h"
#include "sw/device/lib/base/status.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

/**
 * Initializes the puf_reg module at TPM startup.
 */
status_t puf_reg_startup(void);

/**
 * Extends the puf_reg value.
 *
 * @param puf_reg_index The index of the puf_reg to extend.
 * @param data The data to extend.
 * @param data_len The length of the data.
 */
status_t puf_reg_extend(uint32_t puf_reg_index, const uint8_t *data, size_t data_len);

/**
 * Reads the puf_reg value.
 *
 * @param puf_reg_index The index of the puf_reg to read.
 * @param[out] out_value The buffer to store the puf_reg value.
 * @param out_len The length of the output buffer.
 */
status_t puf_reg_read(uint32_t puf_reg_index, uint8_t *out_value, size_t out_len);

/**
 * Sets the initial value of the puf_reg.
 *
 * @param puf_reg_index The index of the puf_reg to set.
 * @param value The initial value to set.
 * @param value_len The length of the value.
 */
status_t puf_reg_set_value(uint32_t puf_reg_index, const uint8_t *value, size_t value_len);

/**
 * Checks if extending the puf_reg is allowed.
 *
 * @param puf_reg_index The index of the puf_reg to check.
 * @param[out] allowed True if extending is allowed.
 */
status_t puf_reg_is_extend_allowed(uint32_t puf_reg_index, bool *allowed);

/**
 * Checks if resetting the puf_reg is allowed.
 *
 * @param puf_reg_index The index of the puf_reg to check.
 * @param[out] allowed True if resetting is allowed.
 */
status_t puf_reg_is_reset_allowed(uint32_t puf_reg_index, bool *allowed);

#ifdef __cplusplus
}
#endif  // __cplusplus

#endif  // OPENTITAN_SW_DEVICE_LIB_puf_reg_H_
