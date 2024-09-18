// Copyright lowRISC contributors (OpenTitan project).
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Register Package auto-generated by `reggen` containing data structure

package puf_reg_reg_pkg;

  // Address widths within the block
  parameter int BlockAw = 7;

  ////////////////////////////
  // Typedefs for registers //
  ////////////////////////////

  typedef struct packed {
    struct packed {
      logic        q;
    } rd_en;
    struct packed {
      logic        q;
    } wr_en;
    struct packed {
      logic [4:0]  q;
    } select;
  } puf_reg_reg2hw_ctrl_reg_t;

  typedef struct packed {
    logic [31:0] q;
  } puf_reg_reg2hw_puf_reg_wr_mreg_t;

  typedef struct packed {
    logic [31:0] d;
    logic        de;
  } puf_reg_hw2reg_puf_reg_rd_mreg_t;

  // Register -> HW type
  typedef struct packed {
    puf_reg_reg2hw_ctrl_reg_t ctrl; // [262:256]
    puf_reg_reg2hw_puf_reg_wr_mreg_t [7:0] puf_reg_wr; // [255:0]
  } puf_reg_reg2hw_t;

  // HW -> register type
  typedef struct packed {
    puf_reg_hw2reg_puf_reg_rd_mreg_t [7:0] puf_reg_rd; // [263:0]
  } puf_reg_hw2reg_t;

  // Register offsets
  parameter logic [BlockAw-1:0] PUF_REG_CTRL_OFFSET = 7'h 0;
  parameter logic [BlockAw-1:0] PUF_REG_PUF_REG_WR_0_OFFSET = 7'h 4;
  parameter logic [BlockAw-1:0] PUF_REG_PUF_REG_WR_1_OFFSET = 7'h 8;
  parameter logic [BlockAw-1:0] PUF_REG_PUF_REG_WR_2_OFFSET = 7'h c;
  parameter logic [BlockAw-1:0] PUF_REG_PUF_REG_WR_3_OFFSET = 7'h 10;
  parameter logic [BlockAw-1:0] PUF_REG_PUF_REG_WR_4_OFFSET = 7'h 14;
  parameter logic [BlockAw-1:0] PUF_REG_PUF_REG_WR_5_OFFSET = 7'h 18;
  parameter logic [BlockAw-1:0] PUF_REG_PUF_REG_WR_6_OFFSET = 7'h 1c;
  parameter logic [BlockAw-1:0] PUF_REG_PUF_REG_WR_7_OFFSET = 7'h 20;
  parameter logic [BlockAw-1:0] PUF_REG_PUF_REG_RD_0_OFFSET = 7'h 24;
  parameter logic [BlockAw-1:0] PUF_REG_PUF_REG_RD_1_OFFSET = 7'h 28;
  parameter logic [BlockAw-1:0] PUF_REG_PUF_REG_RD_2_OFFSET = 7'h 2c;
  parameter logic [BlockAw-1:0] PUF_REG_PUF_REG_RD_3_OFFSET = 7'h 30;
  parameter logic [BlockAw-1:0] PUF_REG_PUF_REG_RD_4_OFFSET = 7'h 34;
  parameter logic [BlockAw-1:0] PUF_REG_PUF_REG_RD_5_OFFSET = 7'h 38;
  parameter logic [BlockAw-1:0] PUF_REG_PUF_REG_RD_6_OFFSET = 7'h 3c;
  parameter logic [BlockAw-1:0] PUF_REG_PUF_REG_RD_7_OFFSET = 7'h 40;

  // Register index
  typedef enum int {
    PUF_REG_CTRL,
    PUF_REG_PUF_REG_WR_0,
    PUF_REG_PUF_REG_WR_1,
    PUF_REG_PUF_REG_WR_2,
    PUF_REG_PUF_REG_WR_3,
    PUF_REG_PUF_REG_WR_4,
    PUF_REG_PUF_REG_WR_5,
    PUF_REG_PUF_REG_WR_6,
    PUF_REG_PUF_REG_WR_7,
    PUF_REG_PUF_REG_RD_0,
    PUF_REG_PUF_REG_RD_1,
    PUF_REG_PUF_REG_RD_2,
    PUF_REG_PUF_REG_RD_3,
    PUF_REG_PUF_REG_RD_4,
    PUF_REG_PUF_REG_RD_5,
    PUF_REG_PUF_REG_RD_6,
    PUF_REG_PUF_REG_RD_7
  } puf_reg_id_e;

  // Register width information to check illegal writes
  parameter logic [3:0] PUF_REG_PERMIT [17] = '{
    4'b 0001, // index[ 0] PUF_REG_CTRL
    4'b 1111, // index[ 1] PUF_REG_PUF_REG_WR_0
    4'b 1111, // index[ 2] PUF_REG_PUF_REG_WR_1
    4'b 1111, // index[ 3] PUF_REG_PUF_REG_WR_2
    4'b 1111, // index[ 4] PUF_REG_PUF_REG_WR_3
    4'b 1111, // index[ 5] PUF_REG_PUF_REG_WR_4
    4'b 1111, // index[ 6] PUF_REG_PUF_REG_WR_5
    4'b 1111, // index[ 7] PUF_REG_PUF_REG_WR_6
    4'b 1111, // index[ 8] PUF_REG_PUF_REG_WR_7
    4'b 1111, // index[ 9] PUF_REG_PUF_REG_RD_0
    4'b 1111, // index[10] PUF_REG_PUF_REG_RD_1
    4'b 1111, // index[11] PUF_REG_PUF_REG_RD_2
    4'b 1111, // index[12] PUF_REG_PUF_REG_RD_3
    4'b 1111, // index[13] PUF_REG_PUF_REG_RD_4
    4'b 1111, // index[14] PUF_REG_PUF_REG_RD_5
    4'b 1111, // index[15] PUF_REG_PUF_REG_RD_6
    4'b 1111  // index[16] PUF_REG_PUF_REG_RD_7
  };

endpackage
