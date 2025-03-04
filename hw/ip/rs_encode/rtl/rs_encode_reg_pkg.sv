// Copyright lowRISC contributors (OpenTitan project).
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Register Package auto-generated by `reggen` containing data structure

package rs_encode_reg_pkg;

  // Param list
  parameter int NumRegs_Data_in = 42;
  parameter int NumRegs_encoded_data = 50;

  // Address widths within the block
  parameter int BlockAw = 9;

  ////////////////////////////
  // Typedefs for registers //
  ////////////////////////////

  typedef struct packed {
    struct packed {
      logic        q;
      logic        qe;
    } clrn;
    struct packed {
      logic        q;
      logic        qe;
    } encode_en;
  } rs_encode_reg2hw_ctrl_signals_reg_t;

  typedef struct packed {
    struct packed {
      logic        q;
    } ready_bit;
    struct packed {
      logic        q;
    } valid_bit;
  } rs_encode_reg2hw_state_signals_reg_t;

  typedef struct packed {
    logic [31:0] q;
    logic        qe;
  } rs_encode_reg2hw_data_in_mreg_t;

  typedef struct packed {
    logic [31:0] q;
  } rs_encode_reg2hw_encoded_data_out_mreg_t;

  typedef struct packed {
    struct packed {
      logic        d;
      logic        de;
    } valid_bit;
    struct packed {
      logic        d;
      logic        de;
    } ready_bit;
  } rs_encode_hw2reg_state_signals_reg_t;

  typedef struct packed {
    logic [31:0] d;
    logic        de;
  } rs_encode_hw2reg_encoded_data_out_mreg_t;

  // Register -> HW type
  typedef struct packed {
    rs_encode_reg2hw_ctrl_signals_reg_t ctrl_signals; // [2991:2988]
    rs_encode_reg2hw_state_signals_reg_t state_signals; // [2987:2986]
    rs_encode_reg2hw_data_in_mreg_t [41:0] data_in; // [2985:1600]
    rs_encode_reg2hw_encoded_data_out_mreg_t [49:0] encoded_data_out; // [1599:0]
  } rs_encode_reg2hw_t;

  // HW -> register type
  typedef struct packed {
    rs_encode_hw2reg_state_signals_reg_t state_signals; // [1653:1650]
    rs_encode_hw2reg_encoded_data_out_mreg_t [49:0] encoded_data_out; // [1649:0]
  } rs_encode_hw2reg_t;

  // Register offsets
  parameter logic [BlockAw-1:0] RS_ENCODE_CTRL_SIGNALS_OFFSET = 9'h 0;
  parameter logic [BlockAw-1:0] RS_ENCODE_STATE_SIGNALS_OFFSET = 9'h 4;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_0_OFFSET = 9'h 8;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_1_OFFSET = 9'h c;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_2_OFFSET = 9'h 10;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_3_OFFSET = 9'h 14;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_4_OFFSET = 9'h 18;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_5_OFFSET = 9'h 1c;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_6_OFFSET = 9'h 20;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_7_OFFSET = 9'h 24;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_8_OFFSET = 9'h 28;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_9_OFFSET = 9'h 2c;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_10_OFFSET = 9'h 30;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_11_OFFSET = 9'h 34;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_12_OFFSET = 9'h 38;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_13_OFFSET = 9'h 3c;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_14_OFFSET = 9'h 40;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_15_OFFSET = 9'h 44;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_16_OFFSET = 9'h 48;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_17_OFFSET = 9'h 4c;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_18_OFFSET = 9'h 50;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_19_OFFSET = 9'h 54;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_20_OFFSET = 9'h 58;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_21_OFFSET = 9'h 5c;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_22_OFFSET = 9'h 60;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_23_OFFSET = 9'h 64;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_24_OFFSET = 9'h 68;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_25_OFFSET = 9'h 6c;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_26_OFFSET = 9'h 70;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_27_OFFSET = 9'h 74;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_28_OFFSET = 9'h 78;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_29_OFFSET = 9'h 7c;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_30_OFFSET = 9'h 80;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_31_OFFSET = 9'h 84;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_32_OFFSET = 9'h 88;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_33_OFFSET = 9'h 8c;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_34_OFFSET = 9'h 90;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_35_OFFSET = 9'h 94;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_36_OFFSET = 9'h 98;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_37_OFFSET = 9'h 9c;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_38_OFFSET = 9'h a0;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_39_OFFSET = 9'h a4;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_40_OFFSET = 9'h a8;
  parameter logic [BlockAw-1:0] RS_ENCODE_DATA_IN_41_OFFSET = 9'h ac;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_0_OFFSET = 9'h b0;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_1_OFFSET = 9'h b4;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_2_OFFSET = 9'h b8;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_3_OFFSET = 9'h bc;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_4_OFFSET = 9'h c0;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_5_OFFSET = 9'h c4;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_6_OFFSET = 9'h c8;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_7_OFFSET = 9'h cc;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_8_OFFSET = 9'h d0;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_9_OFFSET = 9'h d4;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_10_OFFSET = 9'h d8;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_11_OFFSET = 9'h dc;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_12_OFFSET = 9'h e0;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_13_OFFSET = 9'h e4;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_14_OFFSET = 9'h e8;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_15_OFFSET = 9'h ec;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_16_OFFSET = 9'h f0;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_17_OFFSET = 9'h f4;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_18_OFFSET = 9'h f8;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_19_OFFSET = 9'h fc;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_20_OFFSET = 9'h 100;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_21_OFFSET = 9'h 104;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_22_OFFSET = 9'h 108;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_23_OFFSET = 9'h 10c;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_24_OFFSET = 9'h 110;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_25_OFFSET = 9'h 114;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_26_OFFSET = 9'h 118;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_27_OFFSET = 9'h 11c;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_28_OFFSET = 9'h 120;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_29_OFFSET = 9'h 124;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_30_OFFSET = 9'h 128;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_31_OFFSET = 9'h 12c;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_32_OFFSET = 9'h 130;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_33_OFFSET = 9'h 134;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_34_OFFSET = 9'h 138;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_35_OFFSET = 9'h 13c;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_36_OFFSET = 9'h 140;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_37_OFFSET = 9'h 144;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_38_OFFSET = 9'h 148;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_39_OFFSET = 9'h 14c;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_40_OFFSET = 9'h 150;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_41_OFFSET = 9'h 154;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_42_OFFSET = 9'h 158;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_43_OFFSET = 9'h 15c;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_44_OFFSET = 9'h 160;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_45_OFFSET = 9'h 164;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_46_OFFSET = 9'h 168;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_47_OFFSET = 9'h 16c;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_48_OFFSET = 9'h 170;
  parameter logic [BlockAw-1:0] RS_ENCODE_ENCODED_DATA_OUT_49_OFFSET = 9'h 174;

  // Register index
  typedef enum int {
    RS_ENCODE_CTRL_SIGNALS,
    RS_ENCODE_STATE_SIGNALS,
    RS_ENCODE_DATA_IN_0,
    RS_ENCODE_DATA_IN_1,
    RS_ENCODE_DATA_IN_2,
    RS_ENCODE_DATA_IN_3,
    RS_ENCODE_DATA_IN_4,
    RS_ENCODE_DATA_IN_5,
    RS_ENCODE_DATA_IN_6,
    RS_ENCODE_DATA_IN_7,
    RS_ENCODE_DATA_IN_8,
    RS_ENCODE_DATA_IN_9,
    RS_ENCODE_DATA_IN_10,
    RS_ENCODE_DATA_IN_11,
    RS_ENCODE_DATA_IN_12,
    RS_ENCODE_DATA_IN_13,
    RS_ENCODE_DATA_IN_14,
    RS_ENCODE_DATA_IN_15,
    RS_ENCODE_DATA_IN_16,
    RS_ENCODE_DATA_IN_17,
    RS_ENCODE_DATA_IN_18,
    RS_ENCODE_DATA_IN_19,
    RS_ENCODE_DATA_IN_20,
    RS_ENCODE_DATA_IN_21,
    RS_ENCODE_DATA_IN_22,
    RS_ENCODE_DATA_IN_23,
    RS_ENCODE_DATA_IN_24,
    RS_ENCODE_DATA_IN_25,
    RS_ENCODE_DATA_IN_26,
    RS_ENCODE_DATA_IN_27,
    RS_ENCODE_DATA_IN_28,
    RS_ENCODE_DATA_IN_29,
    RS_ENCODE_DATA_IN_30,
    RS_ENCODE_DATA_IN_31,
    RS_ENCODE_DATA_IN_32,
    RS_ENCODE_DATA_IN_33,
    RS_ENCODE_DATA_IN_34,
    RS_ENCODE_DATA_IN_35,
    RS_ENCODE_DATA_IN_36,
    RS_ENCODE_DATA_IN_37,
    RS_ENCODE_DATA_IN_38,
    RS_ENCODE_DATA_IN_39,
    RS_ENCODE_DATA_IN_40,
    RS_ENCODE_DATA_IN_41,
    RS_ENCODE_ENCODED_DATA_OUT_0,
    RS_ENCODE_ENCODED_DATA_OUT_1,
    RS_ENCODE_ENCODED_DATA_OUT_2,
    RS_ENCODE_ENCODED_DATA_OUT_3,
    RS_ENCODE_ENCODED_DATA_OUT_4,
    RS_ENCODE_ENCODED_DATA_OUT_5,
    RS_ENCODE_ENCODED_DATA_OUT_6,
    RS_ENCODE_ENCODED_DATA_OUT_7,
    RS_ENCODE_ENCODED_DATA_OUT_8,
    RS_ENCODE_ENCODED_DATA_OUT_9,
    RS_ENCODE_ENCODED_DATA_OUT_10,
    RS_ENCODE_ENCODED_DATA_OUT_11,
    RS_ENCODE_ENCODED_DATA_OUT_12,
    RS_ENCODE_ENCODED_DATA_OUT_13,
    RS_ENCODE_ENCODED_DATA_OUT_14,
    RS_ENCODE_ENCODED_DATA_OUT_15,
    RS_ENCODE_ENCODED_DATA_OUT_16,
    RS_ENCODE_ENCODED_DATA_OUT_17,
    RS_ENCODE_ENCODED_DATA_OUT_18,
    RS_ENCODE_ENCODED_DATA_OUT_19,
    RS_ENCODE_ENCODED_DATA_OUT_20,
    RS_ENCODE_ENCODED_DATA_OUT_21,
    RS_ENCODE_ENCODED_DATA_OUT_22,
    RS_ENCODE_ENCODED_DATA_OUT_23,
    RS_ENCODE_ENCODED_DATA_OUT_24,
    RS_ENCODE_ENCODED_DATA_OUT_25,
    RS_ENCODE_ENCODED_DATA_OUT_26,
    RS_ENCODE_ENCODED_DATA_OUT_27,
    RS_ENCODE_ENCODED_DATA_OUT_28,
    RS_ENCODE_ENCODED_DATA_OUT_29,
    RS_ENCODE_ENCODED_DATA_OUT_30,
    RS_ENCODE_ENCODED_DATA_OUT_31,
    RS_ENCODE_ENCODED_DATA_OUT_32,
    RS_ENCODE_ENCODED_DATA_OUT_33,
    RS_ENCODE_ENCODED_DATA_OUT_34,
    RS_ENCODE_ENCODED_DATA_OUT_35,
    RS_ENCODE_ENCODED_DATA_OUT_36,
    RS_ENCODE_ENCODED_DATA_OUT_37,
    RS_ENCODE_ENCODED_DATA_OUT_38,
    RS_ENCODE_ENCODED_DATA_OUT_39,
    RS_ENCODE_ENCODED_DATA_OUT_40,
    RS_ENCODE_ENCODED_DATA_OUT_41,
    RS_ENCODE_ENCODED_DATA_OUT_42,
    RS_ENCODE_ENCODED_DATA_OUT_43,
    RS_ENCODE_ENCODED_DATA_OUT_44,
    RS_ENCODE_ENCODED_DATA_OUT_45,
    RS_ENCODE_ENCODED_DATA_OUT_46,
    RS_ENCODE_ENCODED_DATA_OUT_47,
    RS_ENCODE_ENCODED_DATA_OUT_48,
    RS_ENCODE_ENCODED_DATA_OUT_49
  } rs_encode_id_e;

  // Register width information to check illegal writes
  parameter logic [3:0] RS_ENCODE_PERMIT [94] = '{
    4'b 0001, // index[ 0] RS_ENCODE_CTRL_SIGNALS
    4'b 0001, // index[ 1] RS_ENCODE_STATE_SIGNALS
    4'b 1111, // index[ 2] RS_ENCODE_DATA_IN_0
    4'b 1111, // index[ 3] RS_ENCODE_DATA_IN_1
    4'b 1111, // index[ 4] RS_ENCODE_DATA_IN_2
    4'b 1111, // index[ 5] RS_ENCODE_DATA_IN_3
    4'b 1111, // index[ 6] RS_ENCODE_DATA_IN_4
    4'b 1111, // index[ 7] RS_ENCODE_DATA_IN_5
    4'b 1111, // index[ 8] RS_ENCODE_DATA_IN_6
    4'b 1111, // index[ 9] RS_ENCODE_DATA_IN_7
    4'b 1111, // index[10] RS_ENCODE_DATA_IN_8
    4'b 1111, // index[11] RS_ENCODE_DATA_IN_9
    4'b 1111, // index[12] RS_ENCODE_DATA_IN_10
    4'b 1111, // index[13] RS_ENCODE_DATA_IN_11
    4'b 1111, // index[14] RS_ENCODE_DATA_IN_12
    4'b 1111, // index[15] RS_ENCODE_DATA_IN_13
    4'b 1111, // index[16] RS_ENCODE_DATA_IN_14
    4'b 1111, // index[17] RS_ENCODE_DATA_IN_15
    4'b 1111, // index[18] RS_ENCODE_DATA_IN_16
    4'b 1111, // index[19] RS_ENCODE_DATA_IN_17
    4'b 1111, // index[20] RS_ENCODE_DATA_IN_18
    4'b 1111, // index[21] RS_ENCODE_DATA_IN_19
    4'b 1111, // index[22] RS_ENCODE_DATA_IN_20
    4'b 1111, // index[23] RS_ENCODE_DATA_IN_21
    4'b 1111, // index[24] RS_ENCODE_DATA_IN_22
    4'b 1111, // index[25] RS_ENCODE_DATA_IN_23
    4'b 1111, // index[26] RS_ENCODE_DATA_IN_24
    4'b 1111, // index[27] RS_ENCODE_DATA_IN_25
    4'b 1111, // index[28] RS_ENCODE_DATA_IN_26
    4'b 1111, // index[29] RS_ENCODE_DATA_IN_27
    4'b 1111, // index[30] RS_ENCODE_DATA_IN_28
    4'b 1111, // index[31] RS_ENCODE_DATA_IN_29
    4'b 1111, // index[32] RS_ENCODE_DATA_IN_30
    4'b 1111, // index[33] RS_ENCODE_DATA_IN_31
    4'b 1111, // index[34] RS_ENCODE_DATA_IN_32
    4'b 1111, // index[35] RS_ENCODE_DATA_IN_33
    4'b 1111, // index[36] RS_ENCODE_DATA_IN_34
    4'b 1111, // index[37] RS_ENCODE_DATA_IN_35
    4'b 1111, // index[38] RS_ENCODE_DATA_IN_36
    4'b 1111, // index[39] RS_ENCODE_DATA_IN_37
    4'b 1111, // index[40] RS_ENCODE_DATA_IN_38
    4'b 1111, // index[41] RS_ENCODE_DATA_IN_39
    4'b 1111, // index[42] RS_ENCODE_DATA_IN_40
    4'b 1111, // index[43] RS_ENCODE_DATA_IN_41
    4'b 1111, // index[44] RS_ENCODE_ENCODED_DATA_OUT_0
    4'b 1111, // index[45] RS_ENCODE_ENCODED_DATA_OUT_1
    4'b 1111, // index[46] RS_ENCODE_ENCODED_DATA_OUT_2
    4'b 1111, // index[47] RS_ENCODE_ENCODED_DATA_OUT_3
    4'b 1111, // index[48] RS_ENCODE_ENCODED_DATA_OUT_4
    4'b 1111, // index[49] RS_ENCODE_ENCODED_DATA_OUT_5
    4'b 1111, // index[50] RS_ENCODE_ENCODED_DATA_OUT_6
    4'b 1111, // index[51] RS_ENCODE_ENCODED_DATA_OUT_7
    4'b 1111, // index[52] RS_ENCODE_ENCODED_DATA_OUT_8
    4'b 1111, // index[53] RS_ENCODE_ENCODED_DATA_OUT_9
    4'b 1111, // index[54] RS_ENCODE_ENCODED_DATA_OUT_10
    4'b 1111, // index[55] RS_ENCODE_ENCODED_DATA_OUT_11
    4'b 1111, // index[56] RS_ENCODE_ENCODED_DATA_OUT_12
    4'b 1111, // index[57] RS_ENCODE_ENCODED_DATA_OUT_13
    4'b 1111, // index[58] RS_ENCODE_ENCODED_DATA_OUT_14
    4'b 1111, // index[59] RS_ENCODE_ENCODED_DATA_OUT_15
    4'b 1111, // index[60] RS_ENCODE_ENCODED_DATA_OUT_16
    4'b 1111, // index[61] RS_ENCODE_ENCODED_DATA_OUT_17
    4'b 1111, // index[62] RS_ENCODE_ENCODED_DATA_OUT_18
    4'b 1111, // index[63] RS_ENCODE_ENCODED_DATA_OUT_19
    4'b 1111, // index[64] RS_ENCODE_ENCODED_DATA_OUT_20
    4'b 1111, // index[65] RS_ENCODE_ENCODED_DATA_OUT_21
    4'b 1111, // index[66] RS_ENCODE_ENCODED_DATA_OUT_22
    4'b 1111, // index[67] RS_ENCODE_ENCODED_DATA_OUT_23
    4'b 1111, // index[68] RS_ENCODE_ENCODED_DATA_OUT_24
    4'b 1111, // index[69] RS_ENCODE_ENCODED_DATA_OUT_25
    4'b 1111, // index[70] RS_ENCODE_ENCODED_DATA_OUT_26
    4'b 1111, // index[71] RS_ENCODE_ENCODED_DATA_OUT_27
    4'b 1111, // index[72] RS_ENCODE_ENCODED_DATA_OUT_28
    4'b 1111, // index[73] RS_ENCODE_ENCODED_DATA_OUT_29
    4'b 1111, // index[74] RS_ENCODE_ENCODED_DATA_OUT_30
    4'b 1111, // index[75] RS_ENCODE_ENCODED_DATA_OUT_31
    4'b 1111, // index[76] RS_ENCODE_ENCODED_DATA_OUT_32
    4'b 1111, // index[77] RS_ENCODE_ENCODED_DATA_OUT_33
    4'b 1111, // index[78] RS_ENCODE_ENCODED_DATA_OUT_34
    4'b 1111, // index[79] RS_ENCODE_ENCODED_DATA_OUT_35
    4'b 1111, // index[80] RS_ENCODE_ENCODED_DATA_OUT_36
    4'b 1111, // index[81] RS_ENCODE_ENCODED_DATA_OUT_37
    4'b 1111, // index[82] RS_ENCODE_ENCODED_DATA_OUT_38
    4'b 1111, // index[83] RS_ENCODE_ENCODED_DATA_OUT_39
    4'b 1111, // index[84] RS_ENCODE_ENCODED_DATA_OUT_40
    4'b 1111, // index[85] RS_ENCODE_ENCODED_DATA_OUT_41
    4'b 1111, // index[86] RS_ENCODE_ENCODED_DATA_OUT_42
    4'b 1111, // index[87] RS_ENCODE_ENCODED_DATA_OUT_43
    4'b 1111, // index[88] RS_ENCODE_ENCODED_DATA_OUT_44
    4'b 1111, // index[89] RS_ENCODE_ENCODED_DATA_OUT_45
    4'b 1111, // index[90] RS_ENCODE_ENCODED_DATA_OUT_46
    4'b 1111, // index[91] RS_ENCODE_ENCODED_DATA_OUT_47
    4'b 1111, // index[92] RS_ENCODE_ENCODED_DATA_OUT_48
    4'b 1111  // index[93] RS_ENCODE_ENCODED_DATA_OUT_49
  };

endpackage

