//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
//Date        : Mon Nov  4 08:27:34 2019
//Host        : ECE-LAB108 running 64-bit major release  (build 9200)
//Command     : generate_target prelabGlitch.bd
//Design      : prelabGlitch
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "prelabGlitch,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=prelabGlitch,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=4,numReposBlks=4,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "prelabGlitch.hwdef" *) 
module prelabGlitch
   (A,
    B,
    C,
    F);
  input A;
  input B;
  input C;
  output F;

  wire Net;
  wire a_0_1;
  wire b_0_1;
  wire xup_and2_0_y;
  wire xup_and2_1_y;
  wire xup_inv_0_y;
  wire xup_or2_0_y;

  assign F = xup_or2_0_y;
  assign Net = B;
  assign a_0_1 = A;
  assign b_0_1 = C;
  prelabGlitch_xup_and2_0_0 xup_and2_0
       (.a(a_0_1),
        .b(xup_inv_0_y),
        .y(xup_and2_0_y));
  prelabGlitch_xup_and2_0_1 xup_and2_1
       (.a(Net),
        .b(b_0_1),
        .y(xup_and2_1_y));
  prelabGlitch_xup_inv_0_0 xup_inv_0
       (.a(Net),
        .y(xup_inv_0_y));
  prelabGlitch_xup_or2_0_0 xup_or2_0
       (.a(xup_and2_0_y),
        .b(xup_and2_1_y),
        .y(xup_or2_0_y));
endmodule
