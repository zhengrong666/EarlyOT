// Generated register defines for sm3

#ifndef _SM3_REG_DEFS_
#define _SM3_REG_DEFS_

#ifdef __cplusplus
extern "C" {
#endif
//定义输入的消息
static unsigned int message_4word[4] ={0x76543210,0xfedcba98,0x89abcdef,0x01234567};
static unsigned int message_1word[1] ={0x61626364};

void SM3_hash_function(const unsigned int *message,unsigned long message_long,uint8_t last_msg_type,hmac_digest_t hash_result);

void SM3_hash_one_word(unsigned int message_word,unsigned int hash_result[8]);

uint8_t checkBit(unsigned int* registerAddress, unsigned int bit);

void wait_for_dataout(void);

void set_msg_vld_byte(uint8_t mask);

void set_the_last_message_flag(uint8_t flag);

void wait_for_RDY_BIT(void);

//消息有效位
#define full 4

#define high_3bits 3

#define high_2bits 2

#define high_1bit  1

// Number registers for output data
#define SM3_PARAM_RESULT_DATA 8

// Register width
#define SM3_PARAM_REG_WIDTH 32

// Control
#define SM3_CTRL_SIGNALS_REG_OFFSET 0x0
#define SM3_CTRL_SIGNALS_REG_RESVAL 0x0u
#define SM3_CTRL_SIGNALS_MSG_INPT_LST_BIT 0
#define SM3_CTRL_SIGNALS_MSG_INPT_VLD_BYTE_0_BIT 1
#define SM3_CTRL_SIGNALS_MSG_INPT_VLD_BYTE_1_BIT 2
#define SM3_CTRL_SIGNALS_MSG_INPT_VLD_BYTE_2_BIT 3
#define SM3_CTRL_SIGNALS_MSG_INPT_VLD_BYTE_3_BIT 4

// The sm3 states
#define SM3_STATE_SIGNALS_REG_OFFSET 0x4
#define SM3_STATE_SIGNALS_REG_RESVAL 0x0u
#define SM3_STATE_SIGNALS_CMPRSS_OTPT_VLD_BIT 0
#define SM3_STATE_SIGNALS_MSG_INPT_RDY_BIT 1

// input message.
#define SM3_MESSAGE_IN_REG_OFFSET 0x8
#define SM3_MESSAGE_IN_REG_RESVAL 0x0u

// result output (common parameters)
#define SM3_RESULT_OUT_RESULT_OUT_FIELD_WIDTH 32
#define SM3_RESULT_OUT_MULTIREG_COUNT 8

// result output
#define SM3_RESULT_OUT_0_REG_OFFSET 0xc
#define SM3_RESULT_OUT_0_REG_RESVAL 0x0u

// result output
#define SM3_RESULT_OUT_1_REG_OFFSET 0x10
#define SM3_RESULT_OUT_1_REG_RESVAL 0x0u

// result output
#define SM3_RESULT_OUT_2_REG_OFFSET 0x14
#define SM3_RESULT_OUT_2_REG_RESVAL 0x0u

// result output
#define SM3_RESULT_OUT_3_REG_OFFSET 0x18
#define SM3_RESULT_OUT_3_REG_RESVAL 0x0u

// result output
#define SM3_RESULT_OUT_4_REG_OFFSET 0x1c
#define SM3_RESULT_OUT_4_REG_RESVAL 0x0u

// result output
#define SM3_RESULT_OUT_5_REG_OFFSET 0x20
#define SM3_RESULT_OUT_5_REG_RESVAL 0x0u

// result output
#define SM3_RESULT_OUT_6_REG_OFFSET 0x24
#define SM3_RESULT_OUT_6_REG_RESVAL 0x0u

// result output
#define SM3_RESULT_OUT_7_REG_OFFSET 0x28
#define SM3_RESULT_OUT_7_REG_RESVAL 0x0u

#ifdef __cplusplus
}  // extern "C"
#endif
#endif  // _SM3_REG_DEFS_
// End generated register defines for sm3