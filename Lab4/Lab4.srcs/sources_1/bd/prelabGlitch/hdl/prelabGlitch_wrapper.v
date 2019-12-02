//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
//Date        : Mon Nov  4 08:27:34 2019
//Host        : ECE-LAB108 running 64-bit major release  (build 9200)
//Command     : generate_target prelabGlitch_wrapper.bd
//Design      : prelabGlitch_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module prelabGlitch_wrapper
   (A,
    B,
    C,
    F);
  input A;
  input B;
  input C;
  output F;

  wire A;
  wire B;
  wire C;
  wire F;

  prelabGlitch prelabGlitch_i
       (.A(A),
        .B(B),
        .C(C),
        .F(F));
endmodule
