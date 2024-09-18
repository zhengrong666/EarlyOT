// Generated register defines for puf_reg

#ifndef _puf_reg_REG_DEFS_
#define _puf_reg_REG_DEFS_

#ifdef __cplusplus
extern "C" {
#endif
// Register width
#define puf_reg_PARAM_REG_WIDTH 32

// puf_reg Control Register
#define puf_reg_CTRL_REG_OFFSET 0x0
#define puf_reg_CTRL_REG_RESVAL 0x0u
#define puf_reg_CTRL_SELECT_MASK 0x1fu
#define puf_reg_CTRL_SELECT_OFFSET 0
#define puf_reg_CTRL_SELECT_FIELD \
  ((bitfield_field32_t) { .mask = puf_reg_CTRL_SELECT_MASK, .index = puf_reg_CTRL_SELECT_OFFSET })
#define puf_reg_CTRL_WR_EN_BIT 5
#define puf_reg_CTRL_RD_EN_BIT 6

// puf_reg Write Register (common parameters)
#define puf_reg_puf_reg_WR_DATA_FIELD_WIDTH 32
#define puf_reg_puf_reg_WR_MULTIREG_COUNT 8

// puf_reg Write Register
#define puf_reg_puf_reg_WR_0_REG_OFFSET 0x4
#define puf_reg_puf_reg_WR_0_REG_RESVAL 0x0u

// puf_reg Write Register
#define puf_reg_puf_reg_WR_1_REG_OFFSET 0x8
#define puf_reg_puf_reg_WR_1_REG_RESVAL 0x0u

// puf_reg Write Register
#define puf_reg_puf_reg_WR_2_REG_OFFSET 0xc
#define puf_reg_puf_reg_WR_2_REG_RESVAL 0x0u

// puf_reg Write Register
#define puf_reg_puf_reg_WR_3_REG_OFFSET 0x10
#define puf_reg_puf_reg_WR_3_REG_RESVAL 0x0u

// puf_reg Write Register
#define puf_reg_puf_reg_WR_4_REG_OFFSET 0x14
#define puf_reg_puf_reg_WR_4_REG_RESVAL 0x0u

// puf_reg Write Register
#define puf_reg_puf_reg_WR_5_REG_OFFSET 0x18
#define puf_reg_puf_reg_WR_5_REG_RESVAL 0x0u

// puf_reg Write Register
#define puf_reg_puf_reg_WR_6_REG_OFFSET 0x1c
#define puf_reg_puf_reg_WR_6_REG_RESVAL 0x0u

// puf_reg Write Register
#define puf_reg_puf_reg_WR_7_REG_OFFSET 0x20
#define puf_reg_puf_reg_WR_7_REG_RESVAL 0x0u

// puf_reg Read Register (common parameters)
#define puf_reg_puf_reg_RD_DATA_FIELD_WIDTH 32
#define puf_reg_puf_reg_RD_MULTIREG_COUNT 8

// puf_reg Read Register
#define puf_reg_puf_reg_RD_0_REG_OFFSET 0x24
#define puf_reg_puf_reg_RD_0_REG_RESVAL 0x0u

// puf_reg Read Register
#define puf_reg_puf_reg_RD_1_REG_OFFSET 0x28
#define puf_reg_puf_reg_RD_1_REG_RESVAL 0x0u

// puf_reg Read Register
#define puf_reg_puf_reg_RD_2_REG_OFFSET 0x2c
#define puf_reg_puf_reg_RD_2_REG_RESVAL 0x0u

// puf_reg Read Register
#define puf_reg_puf_reg_RD_3_REG_OFFSET 0x30
#define puf_reg_puf_reg_RD_3_REG_RESVAL 0x0u

// puf_reg Read Register
#define puf_reg_puf_reg_RD_4_REG_OFFSET 0x34
#define puf_reg_puf_reg_RD_4_REG_RESVAL 0x0u

// puf_reg Read Register
#define puf_reg_puf_reg_RD_5_REG_OFFSET 0x38
#define puf_reg_puf_reg_RD_5_REG_RESVAL 0x0u

// puf_reg Read Register
#define puf_reg_puf_reg_RD_6_REG_OFFSET 0x3c
#define puf_reg_puf_reg_RD_6_REG_RESVAL 0x0u

// puf_reg Read Register
#define puf_reg_puf_reg_RD_7_REG_OFFSET 0x40
#define puf_reg_puf_reg_RD_7_REG_RESVAL 0x0u

#ifdef __cplusplus
}  // extern "C"
#endif
#endif  // _puf_reg_REG_DEFS_
// End generated register defines for puf_reg