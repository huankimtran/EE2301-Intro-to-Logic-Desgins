//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
//Date        : Mon Nov  4 09:59:00 2019
//Host        : ECE-LAB108 running 64-bit major release  (build 9200)
//Command     : generate_target InlabGlitch_wrapper.bd
//Design      : InlabGlitch_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module InlabGlitch_wrapper
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

  wire A;
  wire B;
  wire C;
  wire D;
  wire F;

  InlabGlitch InlabGlitch_i
       (.A(A),
        .B(B),
        .C(C),
        .D(D),
        .F(F));
endmodule
