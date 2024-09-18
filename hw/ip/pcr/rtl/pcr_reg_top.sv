// Copyright lowRISC contributors (OpenTitan project).
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Register Top module auto-generated by `reggen`

`include "prim_assert.sv"

module pcr_reg_top (
  input clk_i,
  input rst_ni,
  input  tlul_pkg::tl_h2d_t tl_i,
  output tlul_pkg::tl_d2h_t tl_o,
  // To HW
  output pcr_reg_pkg::pcr_reg2hw_t reg2hw, // Write
  input  pcr_reg_pkg::pcr_hw2reg_t hw2reg, // Read

  // Integrity check errors
  output logic intg_err_o
);

  import pcr_reg_pkg::* ;

  localparam int AW = 7;
  localparam int DW = 32;
  localparam int DBW = DW/8;                    // Byte Width

  // register signals
  logic           reg_we;
  logic           reg_re;
  logic [AW-1:0]  reg_addr;
  logic [DW-1:0]  reg_wdata;
  logic [DBW-1:0] reg_be;
  logic [DW-1:0]  reg_rdata;
  logic           reg_error;

  logic          addrmiss, wr_err;

  logic [DW-1:0] reg_rdata_next;
  logic reg_busy;

  tlul_pkg::tl_h2d_t tl_reg_h2d;
  tlul_pkg::tl_d2h_t tl_reg_d2h;


  // incoming payload check
  logic intg_err;
  tlul_cmd_intg_chk u_chk (
    .tl_i(tl_i),
    .err_o(intg_err)
  );

  // also check for spurious write enables
  logic reg_we_err;
  logic [16:0] reg_we_check;
  prim_reg_we_check #(
    .OneHotWidth(17)
  ) u_prim_reg_we_check (
    .clk_i(clk_i),
    .rst_ni(rst_ni),
    .oh_i  (reg_we_check),
    .en_i  (reg_we && !addrmiss),
    .err_o (reg_we_err)
  );

  logic err_q;
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      err_q <= '0;
    end else if (intg_err || reg_we_err) begin
      err_q <= 1'b1;
    end
  end

  // integrity error output is permanent and should be used for alert generation
  // register errors are transactional
  assign intg_err_o = err_q | intg_err | reg_we_err;

  // outgoing integrity generation
  tlul_pkg::tl_d2h_t tl_o_pre;
  tlul_rsp_intg_gen #(
    .EnableRspIntgGen(1),
    .EnableDataIntgGen(1)
  ) u_rsp_intg_gen (
    .tl_i(tl_o_pre),
    .tl_o(tl_o)
  );

  assign tl_reg_h2d = tl_i;
  assign tl_o_pre   = tl_reg_d2h;

  tlul_adapter_reg #(
    .RegAw(AW),
    .RegDw(DW),
    .EnableDataIntgGen(0)
  ) u_reg_if (
    .clk_i  (clk_i),
    .rst_ni (rst_ni),

    .tl_i (tl_reg_h2d),
    .tl_o (tl_reg_d2h),

    .en_ifetch_i(prim_mubi_pkg::MuBi4False),
    .intg_error_o(),

    .we_o    (reg_we),
    .re_o    (reg_re),
    .addr_o  (reg_addr),
    .wdata_o (reg_wdata),
    .be_o    (reg_be),
    .busy_i  (reg_busy),
    .rdata_i (reg_rdata),
    .error_i (reg_error)
  );

  // cdc oversampling signals

  assign reg_rdata = reg_rdata_next ;
  assign reg_error = addrmiss | wr_err | intg_err;

  // Define SW related signals
  // Format: <reg>_<field>_{wd|we|qs}
  //        or <reg>_{wd|we|qs} if field == 1 or 0
  logic ctrl_we;
  logic [4:0] ctrl_select_qs;
  logic [4:0] ctrl_select_wd;
  logic ctrl_wr_en_qs;
  logic ctrl_wr_en_wd;
  logic ctrl_rd_en_qs;
  logic ctrl_rd_en_wd;
  logic pcr_wr_0_we;
  logic [31:0] pcr_wr_0_wd;
  logic pcr_wr_1_we;
  logic [31:0] pcr_wr_1_wd;
  logic pcr_wr_2_we;
  logic [31:0] pcr_wr_2_wd;
  logic pcr_wr_3_we;
  logic [31:0] pcr_wr_3_wd;
  logic pcr_wr_4_we;
  logic [31:0] pcr_wr_4_wd;
  logic pcr_wr_5_we;
  logic [31:0] pcr_wr_5_wd;
  logic pcr_wr_6_we;
  logic [31:0] pcr_wr_6_wd;
  logic pcr_wr_7_we;
  logic [31:0] pcr_wr_7_wd;
  logic [31:0] pcr_rd_0_qs;
  logic [31:0] pcr_rd_1_qs;
  logic [31:0] pcr_rd_2_qs;
  logic [31:0] pcr_rd_3_qs;
  logic [31:0] pcr_rd_4_qs;
  logic [31:0] pcr_rd_5_qs;
  logic [31:0] pcr_rd_6_qs;
  logic [31:0] pcr_rd_7_qs;

  // Register instances
  // R[ctrl]: V(False)
  //   F[select]: 4:0
  prim_subreg #(
    .DW      (5),
    .SwAccess(prim_subreg_pkg::SwAccessRW),
    .RESVAL  (5'h0),
    .Mubi    (1'b0)
  ) u_ctrl_select (
    .clk_i   (clk_i),
    .rst_ni  (rst_ni),

    // from register interface
    .we     (ctrl_we),
    .wd     (ctrl_select_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.ctrl.select.q),
    .ds     (),

    // to register interface (read)
    .qs     (ctrl_select_qs)
  );

  //   F[wr_en]: 5:5
  prim_subreg #(
    .DW      (1),
    .SwAccess(prim_subreg_pkg::SwAccessRW),
    .RESVAL  (1'h0),
    .Mubi    (1'b0)
  ) u_ctrl_wr_en (
    .clk_i   (clk_i),
    .rst_ni  (rst_ni),

    // from register interface
    .we     (ctrl_we),
    .wd     (ctrl_wr_en_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.ctrl.wr_en.q),
    .ds     (),

    // to register interface (read)
    .qs     (ctrl_wr_en_qs)
  );

  //   F[rd_en]: 6:6
  prim_subreg #(
    .DW      (1),
    .SwAccess(prim_subreg_pkg::SwAccessRW),
    .RESVAL  (1'h0),
    .Mubi    (1'b0)
  ) u_ctrl_rd_en (
    .clk_i   (clk_i),
    .rst_ni  (rst_ni),

    // from register interface
    .we     (ctrl_we),
    .wd     (ctrl_rd_en_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.ctrl.rd_en.q),
    .ds     (),

    // to register interface (read)
    .qs     (ctrl_rd_en_qs)
  );


  // Subregister 0 of Multireg pcr_wr
  // R[pcr_wr_0]: V(False)
  prim_subreg #(
    .DW      (32),
    .SwAccess(prim_subreg_pkg::SwAccessWO),
    .RESVAL  (32'h0),
    .Mubi    (1'b0)
  ) u_pcr_wr_0 (
    .clk_i   (clk_i),
    .rst_ni  (rst_ni),

    // from register interface
    .we     (pcr_wr_0_we),
    .wd     (pcr_wr_0_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.pcr_wr[0].q),
    .ds     (),

    // to register interface (read)
    .qs     ()
  );


  // Subregister 1 of Multireg pcr_wr
  // R[pcr_wr_1]: V(False)
  prim_subreg #(
    .DW      (32),
    .SwAccess(prim_subreg_pkg::SwAccessWO),
    .RESVAL  (32'h0),
    .Mubi    (1'b0)
  ) u_pcr_wr_1 (
    .clk_i   (clk_i),
    .rst_ni  (rst_ni),

    // from register interface
    .we     (pcr_wr_1_we),
    .wd     (pcr_wr_1_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.pcr_wr[1].q),
    .ds     (),

    // to register interface (read)
    .qs     ()
  );


  // Subregister 2 of Multireg pcr_wr
  // R[pcr_wr_2]: V(False)
  prim_subreg #(
    .DW      (32),
    .SwAccess(prim_subreg_pkg::SwAccessWO),
    .RESVAL  (32'h0),
    .Mubi    (1'b0)
  ) u_pcr_wr_2 (
    .clk_i   (clk_i),
    .rst_ni  (rst_ni),

    // from register interface
    .we     (pcr_wr_2_we),
    .wd     (pcr_wr_2_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.pcr_wr[2].q),
    .ds     (),

    // to register interface (read)
    .qs     ()
  );


  // Subregister 3 of Multireg pcr_wr
  // R[pcr_wr_3]: V(False)
  prim_subreg #(
    .DW      (32),
    .SwAccess(prim_subreg_pkg::SwAccessWO),
    .RESVAL  (32'h0),
    .Mubi    (1'b0)
  ) u_pcr_wr_3 (
    .clk_i   (clk_i),
    .rst_ni  (rst_ni),

    // from register interface
    .we     (pcr_wr_3_we),
    .wd     (pcr_wr_3_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.pcr_wr[3].q),
    .ds     (),

    // to register interface (read)
    .qs     ()
  );


  // Subregister 4 of Multireg pcr_wr
  // R[pcr_wr_4]: V(False)
  prim_subreg #(
    .DW      (32),
    .SwAccess(prim_subreg_pkg::SwAccessWO),
    .RESVAL  (32'h0),
    .Mubi    (1'b0)
  ) u_pcr_wr_4 (
    .clk_i   (clk_i),
    .rst_ni  (rst_ni),

    // from register interface
    .we     (pcr_wr_4_we),
    .wd     (pcr_wr_4_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.pcr_wr[4].q),
    .ds     (),

    // to register interface (read)
    .qs     ()
  );


  // Subregister 5 of Multireg pcr_wr
  // R[pcr_wr_5]: V(False)
  prim_subreg #(
    .DW      (32),
    .SwAccess(prim_subreg_pkg::SwAccessWO),
    .RESVAL  (32'h0),
    .Mubi    (1'b0)
  ) u_pcr_wr_5 (
    .clk_i   (clk_i),
    .rst_ni  (rst_ni),

    // from register interface
    .we     (pcr_wr_5_we),
    .wd     (pcr_wr_5_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.pcr_wr[5].q),
    .ds     (),

    // to register interface (read)
    .qs     ()
  );


  // Subregister 6 of Multireg pcr_wr
  // R[pcr_wr_6]: V(False)
  prim_subreg #(
    .DW      (32),
    .SwAccess(prim_subreg_pkg::SwAccessWO),
    .RESVAL  (32'h0),
    .Mubi    (1'b0)
  ) u_pcr_wr_6 (
    .clk_i   (clk_i),
    .rst_ni  (rst_ni),

    // from register interface
    .we     (pcr_wr_6_we),
    .wd     (pcr_wr_6_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.pcr_wr[6].q),
    .ds     (),

    // to register interface (read)
    .qs     ()
  );


  // Subregister 7 of Multireg pcr_wr
  // R[pcr_wr_7]: V(False)
  prim_subreg #(
    .DW      (32),
    .SwAccess(prim_subreg_pkg::SwAccessWO),
    .RESVAL  (32'h0),
    .Mubi    (1'b0)
  ) u_pcr_wr_7 (
    .clk_i   (clk_i),
    .rst_ni  (rst_ni),

    // from register interface
    .we     (pcr_wr_7_we),
    .wd     (pcr_wr_7_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.pcr_wr[7].q),
    .ds     (),

    // to register interface (read)
    .qs     ()
  );


  // Subregister 0 of Multireg pcr_rd
  // R[pcr_rd_0]: V(False)
  prim_subreg #(
    .DW      (32),
    .SwAccess(prim_subreg_pkg::SwAccessRO),
    .RESVAL  (32'h0),
    .Mubi    (1'b0)
  ) u_pcr_rd_0 (
    .clk_i   (clk_i),
    .rst_ni  (rst_ni),

    // from register interface
    .we     (1'b0),
    .wd     ('0),

    // from internal hardware
    .de     (hw2reg.pcr_rd[0].de),
    .d      (hw2reg.pcr_rd[0].d),

    // to internal hardware
    .qe     (),
    .q      (),
    .ds     (),

    // to register interface (read)
    .qs     (pcr_rd_0_qs)
  );


  // Subregister 1 of Multireg pcr_rd
  // R[pcr_rd_1]: V(False)
  prim_subreg #(
    .DW      (32),
    .SwAccess(prim_subreg_pkg::SwAccessRO),
    .RESVAL  (32'h0),
    .Mubi    (1'b0)
  ) u_pcr_rd_1 (
    .clk_i   (clk_i),
    .rst_ni  (rst_ni),

    // from register interface
    .we     (1'b0),
    .wd     ('0),

    // from internal hardware
    .de     (hw2reg.pcr_rd[1].de),
    .d      (hw2reg.pcr_rd[1].d),

    // to internal hardware
    .qe     (),
    .q      (),
    .ds     (),

    // to register interface (read)
    .qs     (pcr_rd_1_qs)
  );


  // Subregister 2 of Multireg pcr_rd
  // R[pcr_rd_2]: V(False)
  prim_subreg #(
    .DW      (32),
    .SwAccess(prim_subreg_pkg::SwAccessRO),
    .RESVAL  (32'h0),
    .Mubi    (1'b0)
  ) u_pcr_rd_2 (
    .clk_i   (clk_i),
    .rst_ni  (rst_ni),

    // from register interface
    .we     (1'b0),
    .wd     ('0),

    // from internal hardware
    .de     (hw2reg.pcr_rd[2].de),
    .d      (hw2reg.pcr_rd[2].d),

    // to internal hardware
    .qe     (),
    .q      (),
    .ds     (),

    // to register interface (read)
    .qs     (pcr_rd_2_qs)
  );


  // Subregister 3 of Multireg pcr_rd
  // R[pcr_rd_3]: V(False)
  prim_subreg #(
    .DW      (32),
    .SwAccess(prim_subreg_pkg::SwAccessRO),
    .RESVAL  (32'h0),
    .Mubi    (1'b0)
  ) u_pcr_rd_3 (
    .clk_i   (clk_i),
    .rst_ni  (rst_ni),

    // from register interface
    .we     (1'b0),
    .wd     ('0),

    // from internal hardware
    .de     (hw2reg.pcr_rd[3].de),
    .d      (hw2reg.pcr_rd[3].d),

    // to internal hardware
    .qe     (),
    .q      (),
    .ds     (),

    // to register interface (read)
    .qs     (pcr_rd_3_qs)
  );


  // Subregister 4 of Multireg pcr_rd
  // R[pcr_rd_4]: V(False)
  prim_subreg #(
    .DW      (32),
    .SwAccess(prim_subreg_pkg::SwAccessRO),
    .RESVAL  (32'h0),
    .Mubi    (1'b0)
  ) u_pcr_rd_4 (
    .clk_i   (clk_i),
    .rst_ni  (rst_ni),

    // from register interface
    .we     (1'b0),
    .wd     ('0),

    // from internal hardware
    .de     (hw2reg.pcr_rd[4].de),
    .d      (hw2reg.pcr_rd[4].d),

    // to internal hardware
    .qe     (),
    .q      (),
    .ds     (),

    // to register interface (read)
    .qs     (pcr_rd_4_qs)
  );


  // Subregister 5 of Multireg pcr_rd
  // R[pcr_rd_5]: V(False)
  prim_subreg #(
    .DW      (32),
    .SwAccess(prim_subreg_pkg::SwAccessRO),
    .RESVAL  (32'h0),
    .Mubi    (1'b0)
  ) u_pcr_rd_5 (
    .clk_i   (clk_i),
    .rst_ni  (rst_ni),

    // from register interface
    .we     (1'b0),
    .wd     ('0),

    // from internal hardware
    .de     (hw2reg.pcr_rd[5].de),
    .d      (hw2reg.pcr_rd[5].d),

    // to internal hardware
    .qe     (),
    .q      (),
    .ds     (),

    // to register interface (read)
    .qs     (pcr_rd_5_qs)
  );


  // Subregister 6 of Multireg pcr_rd
  // R[pcr_rd_6]: V(False)
  prim_subreg #(
    .DW      (32),
    .SwAccess(prim_subreg_pkg::SwAccessRO),
    .RESVAL  (32'h0),
    .Mubi    (1'b0)
  ) u_pcr_rd_6 (
    .clk_i   (clk_i),
    .rst_ni  (rst_ni),

    // from register interface
    .we     (1'b0),
    .wd     ('0),

    // from internal hardware
    .de     (hw2reg.pcr_rd[6].de),
    .d      (hw2reg.pcr_rd[6].d),

    // to internal hardware
    .qe     (),
    .q      (),
    .ds     (),

    // to register interface (read)
    .qs     (pcr_rd_6_qs)
  );


  // Subregister 7 of Multireg pcr_rd
  // R[pcr_rd_7]: V(False)
  prim_subreg #(
    .DW      (32),
    .SwAccess(prim_subreg_pkg::SwAccessRO),
    .RESVAL  (32'h0),
    .Mubi    (1'b0)
  ) u_pcr_rd_7 (
    .clk_i   (clk_i),
    .rst_ni  (rst_ni),

    // from register interface
    .we     (1'b0),
    .wd     ('0),

    // from internal hardware
    .de     (hw2reg.pcr_rd[7].de),
    .d      (hw2reg.pcr_rd[7].d),

    // to internal hardware
    .qe     (),
    .q      (),
    .ds     (),

    // to register interface (read)
    .qs     (pcr_rd_7_qs)
  );



  logic [16:0] addr_hit;
  always_comb begin
    addr_hit = '0;
    addr_hit[ 0] = (reg_addr == PCR_CTRL_OFFSET);
    addr_hit[ 1] = (reg_addr == PCR_PCR_WR_0_OFFSET);
    addr_hit[ 2] = (reg_addr == PCR_PCR_WR_1_OFFSET);
    addr_hit[ 3] = (reg_addr == PCR_PCR_WR_2_OFFSET);
    addr_hit[ 4] = (reg_addr == PCR_PCR_WR_3_OFFSET);
    addr_hit[ 5] = (reg_addr == PCR_PCR_WR_4_OFFSET);
    addr_hit[ 6] = (reg_addr == PCR_PCR_WR_5_OFFSET);
    addr_hit[ 7] = (reg_addr == PCR_PCR_WR_6_OFFSET);
    addr_hit[ 8] = (reg_addr == PCR_PCR_WR_7_OFFSET);
    addr_hit[ 9] = (reg_addr == PCR_PCR_RD_0_OFFSET);
    addr_hit[10] = (reg_addr == PCR_PCR_RD_1_OFFSET);
    addr_hit[11] = (reg_addr == PCR_PCR_RD_2_OFFSET);
    addr_hit[12] = (reg_addr == PCR_PCR_RD_3_OFFSET);
    addr_hit[13] = (reg_addr == PCR_PCR_RD_4_OFFSET);
    addr_hit[14] = (reg_addr == PCR_PCR_RD_5_OFFSET);
    addr_hit[15] = (reg_addr == PCR_PCR_RD_6_OFFSET);
    addr_hit[16] = (reg_addr == PCR_PCR_RD_7_OFFSET);
  end

  assign addrmiss = (reg_re || reg_we) ? ~|addr_hit : 1'b0 ;

  // Check sub-word write is permitted
  always_comb begin
    wr_err = (reg_we &
              ((addr_hit[ 0] & (|(PCR_PERMIT[ 0] & ~reg_be))) |
               (addr_hit[ 1] & (|(PCR_PERMIT[ 1] & ~reg_be))) |
               (addr_hit[ 2] & (|(PCR_PERMIT[ 2] & ~reg_be))) |
               (addr_hit[ 3] & (|(PCR_PERMIT[ 3] & ~reg_be))) |
               (addr_hit[ 4] & (|(PCR_PERMIT[ 4] & ~reg_be))) |
               (addr_hit[ 5] & (|(PCR_PERMIT[ 5] & ~reg_be))) |
               (addr_hit[ 6] & (|(PCR_PERMIT[ 6] & ~reg_be))) |
               (addr_hit[ 7] & (|(PCR_PERMIT[ 7] & ~reg_be))) |
               (addr_hit[ 8] & (|(PCR_PERMIT[ 8] & ~reg_be))) |
               (addr_hit[ 9] & (|(PCR_PERMIT[ 9] & ~reg_be))) |
               (addr_hit[10] & (|(PCR_PERMIT[10] & ~reg_be))) |
               (addr_hit[11] & (|(PCR_PERMIT[11] & ~reg_be))) |
               (addr_hit[12] & (|(PCR_PERMIT[12] & ~reg_be))) |
               (addr_hit[13] & (|(PCR_PERMIT[13] & ~reg_be))) |
               (addr_hit[14] & (|(PCR_PERMIT[14] & ~reg_be))) |
               (addr_hit[15] & (|(PCR_PERMIT[15] & ~reg_be))) |
               (addr_hit[16] & (|(PCR_PERMIT[16] & ~reg_be)))));
  end

  // Generate write-enables
  assign ctrl_we = addr_hit[0] & reg_we & !reg_error;

  assign ctrl_select_wd = reg_wdata[4:0];

  assign ctrl_wr_en_wd = reg_wdata[5];

  assign ctrl_rd_en_wd = reg_wdata[6];
  assign pcr_wr_0_we = addr_hit[1] & reg_we & !reg_error;

  assign pcr_wr_0_wd = reg_wdata[31:0];
  assign pcr_wr_1_we = addr_hit[2] & reg_we & !reg_error;

  assign pcr_wr_1_wd = reg_wdata[31:0];
  assign pcr_wr_2_we = addr_hit[3] & reg_we & !reg_error;

  assign pcr_wr_2_wd = reg_wdata[31:0];
  assign pcr_wr_3_we = addr_hit[4] & reg_we & !reg_error;

  assign pcr_wr_3_wd = reg_wdata[31:0];
  assign pcr_wr_4_we = addr_hit[5] & reg_we & !reg_error;

  assign pcr_wr_4_wd = reg_wdata[31:0];
  assign pcr_wr_5_we = addr_hit[6] & reg_we & !reg_error;

  assign pcr_wr_5_wd = reg_wdata[31:0];
  assign pcr_wr_6_we = addr_hit[7] & reg_we & !reg_error;

  assign pcr_wr_6_wd = reg_wdata[31:0];
  assign pcr_wr_7_we = addr_hit[8] & reg_we & !reg_error;

  assign pcr_wr_7_wd = reg_wdata[31:0];

  // Assign write-enables to checker logic vector.
  always_comb begin
    reg_we_check = '0;
    reg_we_check[0] = ctrl_we;
    reg_we_check[1] = pcr_wr_0_we;
    reg_we_check[2] = pcr_wr_1_we;
    reg_we_check[3] = pcr_wr_2_we;
    reg_we_check[4] = pcr_wr_3_we;
    reg_we_check[5] = pcr_wr_4_we;
    reg_we_check[6] = pcr_wr_5_we;
    reg_we_check[7] = pcr_wr_6_we;
    reg_we_check[8] = pcr_wr_7_we;
    reg_we_check[9] = 1'b0;
    reg_we_check[10] = 1'b0;
    reg_we_check[11] = 1'b0;
    reg_we_check[12] = 1'b0;
    reg_we_check[13] = 1'b0;
    reg_we_check[14] = 1'b0;
    reg_we_check[15] = 1'b0;
    reg_we_check[16] = 1'b0;
  end

  // Read data return
  always_comb begin
    reg_rdata_next = '0;
    unique case (1'b1)
      addr_hit[0]: begin
        reg_rdata_next[4:0] = ctrl_select_qs;
        reg_rdata_next[5] = ctrl_wr_en_qs;
        reg_rdata_next[6] = ctrl_rd_en_qs;
      end

      addr_hit[1]: begin
        reg_rdata_next[31:0] = '0;
      end

      addr_hit[2]: begin
        reg_rdata_next[31:0] = '0;
      end

      addr_hit[3]: begin
        reg_rdata_next[31:0] = '0;
      end

      addr_hit[4]: begin
        reg_rdata_next[31:0] = '0;
      end

      addr_hit[5]: begin
        reg_rdata_next[31:0] = '0;
      end

      addr_hit[6]: begin
        reg_rdata_next[31:0] = '0;
      end

      addr_hit[7]: begin
        reg_rdata_next[31:0] = '0;
      end

      addr_hit[8]: begin
        reg_rdata_next[31:0] = '0;
      end

      addr_hit[9]: begin
        reg_rdata_next[31:0] = pcr_rd_0_qs;
      end

      addr_hit[10]: begin
        reg_rdata_next[31:0] = pcr_rd_1_qs;
      end

      addr_hit[11]: begin
        reg_rdata_next[31:0] = pcr_rd_2_qs;
      end

      addr_hit[12]: begin
        reg_rdata_next[31:0] = pcr_rd_3_qs;
      end

      addr_hit[13]: begin
        reg_rdata_next[31:0] = pcr_rd_4_qs;
      end

      addr_hit[14]: begin
        reg_rdata_next[31:0] = pcr_rd_5_qs;
      end

      addr_hit[15]: begin
        reg_rdata_next[31:0] = pcr_rd_6_qs;
      end

      addr_hit[16]: begin
        reg_rdata_next[31:0] = pcr_rd_7_qs;
      end

      default: begin
        reg_rdata_next = '1;
      end
    endcase
  end

  // shadow busy
  logic shadow_busy;
  assign shadow_busy = 1'b0;

  // register busy
  assign reg_busy = shadow_busy;

  // Unused signal tieoff

  // wdata / byte enable are not always fully used
  // add a blanket unused statement to handle lint waivers
  logic unused_wdata;
  logic unused_be;
  assign unused_wdata = ^reg_wdata;
  assign unused_be = ^reg_be;

  // Assertions for Register Interface
  `ASSERT_PULSE(wePulse, reg_we, clk_i, !rst_ni)
  `ASSERT_PULSE(rePulse, reg_re, clk_i, !rst_ni)

  `ASSERT(reAfterRv, $rose(reg_re || reg_we) |=> tl_o_pre.d_valid, clk_i, !rst_ni)

  `ASSERT(en2addrHit, (reg_we || reg_re) |-> $onehot0(addr_hit), clk_i, !rst_ni)

  // this is formulated as an assumption such that the FPV testbenches do disprove this
  // property by mistake
  //`ASSUME(reqParity, tl_reg_h2d.a_valid |-> tl_reg_h2d.a_user.chk_en == tlul_pkg::CheckDis)

endmodule
