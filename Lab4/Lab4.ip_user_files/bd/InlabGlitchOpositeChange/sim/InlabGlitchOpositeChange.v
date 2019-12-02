//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
//Date        : Mon Nov  4 09:58:53 2019
//Host        : ECE-LAB108 running 64-bit major release  (build 9200)
//Command     : generate_target InlabGlitchOpositeChange.bd
//Design      : InlabGlitchOpositeChange
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "InlabGlitchOpositeChange,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=InlabGlitchOpositeChange,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=7,numReposBlks=7,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "InlabGlitchOpositeChange.hwdef" *) 
module InlabGlitchOpositeChange
   (A,
    B,
    C,
    D,
    F);
  input A;
  input B;
  input C;
  input D;
  output F;

  wire a_0_1;
  wire a_0_2;
  wire a_0_3;
  wire a_1_1;
  wire xup_and2_0_y;
  wire xup_and2_1_y;
  wire xup_inv_0_y;
  wire xup_inv_1_y;
  wire xup_or2_0_y;
  wire xup_or2_1_y;
  wire xup_or2_2_y;

  assign F = xup_or2_1_y;
  assign a_0_1 = A;
  assign a_0_2 = B;
  assign a_0_3 = D;
  assign a_1_1 = C;
  InlabGlitchOpositeChange_xup_and2_0_0 xup_and2_0
       (.a(xup_inv_0_y),
        .b(xup_or2_0_y),
        .y(xup_and2_0_y));
  InlabGlitchOpositeChange_xup_and2_1_0 xup_and2_1
       (.a(a_0_3),
        .b(xup_or2_2_y),
        .y(xup_and2_1_y));
  InlabGlitchOpositeChange_xup_inv_0_0 xup_inv_0
       (.a(a_0_1),
        .y(xup_inv_0_y));
  InlabGlitchOpositeChange_xup_inv_1_0 xup_inv_1
       (.a(a_1_1),
        .y(xup_inv_1_y));
  InlabGlitchOpositeChange_xup_or2_0_0 xup_or2_0
       (.a(a_0_2),
        .b(xup_inv_1_y),
        .y(xup_or2_0_y));
  InlabGlitchOpositeChange_xup_or2_1_0 xup_or2_1
       (.a(xup_and2_1_y),
        .b(xup_and2_0_y),
        .y(xup_or2_1_y));
  InlabGlitchOpositeChange_xup_or2_2_0 xup_or2_2
       (.a(a_0_1),
        .b(a_0_2),
        .y(xup_or2_2_y));
endmodule
