//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
//Date        : Mon Nov  4 08:38:57 2019
//Host        : ECE-LAB108 running 64-bit major release  (build 9200)
//Command     : generate_target prelabGlitchFixed.bd
//Design      : prelabGlitchFixed
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "prelabGlitchFixed,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=prelabGlitchFixed,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=6,numReposBlks=6,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "prelabGlitchFixed.hwdef" *) 
module prelabGlitchFixed
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
  wire xup_and2_2_y;
  wire xup_inv_0_y;
  wire xup_or2_0_y;
  wire xup_or2_1_y;

  assign F = xup_or2_1_y;
  assign Net = B;
  assign a_0_1 = A;
  assign b_0_1 = C;
  prelabGlitchFixed_xup_and2_0_0 xup_and2_0
       (.a(a_0_1),
        .b(xup_inv_0_y),
        .y(xup_and2_0_y));
  prelabGlitchFixed_xup_and2_1_0 xup_and2_1
       (.a(Net),
        .b(b_0_1),
        .y(xup_and2_1_y));
  prelabGlitchFixed_xup_and2_0_1 xup_and2_2
       (.a(a_0_1),
        .b(b_0_1),
        .y(xup_and2_2_y));
  prelabGlitchFixed_xup_inv_0_0 xup_inv_0
       (.a(Net),
        .y(xup_inv_0_y));
  prelabGlitchFixed_xup_or2_0_0 xup_or2_0
       (.a(xup_and2_0_y),
        .b(xup_and2_1_y),
        .y(xup_or2_0_y));
  prelabGlitchFixed_xup_or2_0_1 xup_or2_1
       (.a(xup_or2_0_y),
        .b(xup_and2_2_y),
        .y(xup_or2_1_y));
endmodule
