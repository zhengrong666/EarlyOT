#ifndef OPENTITAN_SW_DEVICE_LIB_PCR_H_
#define OPENTITAN_SW_DEVICE_LIB_PCR_H_

#include <stddef.h>
#include <stdint.h>

#include "sw/device/lib/base/macros.h"
#include "sw/device/lib/base/mmio.h"
#include "sw/device/lib/base/status.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

/**
 * Initializes the PCR module at TPM startup.
 */
status_t pcr_startup(void);

/**
 * Extends the PCR value.
 *
 * @param pcr_index The index of the PCR to extend.
 * @param data The data to extend.
 * @param data_len The length of the data.
 */
status_t pcr_extend(uint32_t pcr_index, const uint8_t *data, size_t data_len);

/**
 * Reads the PCR value.
 *
 * @param pcr_index The index of the PCR to read.
 * @param[out] out_value The buffer to store the PCR value.
 * @param out_len The length of the output buffer.
 */
status_t pcr_read(uint32_t pcr_index, uint8_t *out_value, size_t out_len);

/**
 * Sets the initial value of the PCR.
 *
 * @param pcr_index The index of the PCR to set.
 * @param value The initial value to set.
 * @param value_len The length of the value.
 */
status_t pcr_set_value(uint32_t pcr_index, const uint8_t *value, size_t value_len);

/**
 * Checks if extending the PCR is allowed.
 *
 * @param pcr_index The index of the PCR to check.
 * @param[out] allowed True if extending is allowed.
 */
status_t pcr_is_extend_allowed(uint32_t pcr_index, bool *allowed);

/**
 * Checks if resetting the PCR is allowed.
 *
 * @param pcr_index The index of the PCR to check.
 * @param[out] allowed True if resetting is allowed.
 */
status_t pcr_is_reset_allowed(uint32_t pcr_index, bool *allowed);

#ifdef __cplusplus
}
#endif  // __cplusplus

#endif  // OPENTITAN_SW_DEVICE_LIB_PCR_H_
