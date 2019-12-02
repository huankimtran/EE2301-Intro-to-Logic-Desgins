-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Mon Nov  4 09:52:02 2019
-- Host        : ECE-LAB108 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/tran0966/Lab4/Lab4.srcs/sources_1/bd/InlabGlitch/ip/InlabGlitch_xup_inv_0_0/InlabGlitch_xup_inv_0_0_stub.vhdl
-- Design      : InlabGlitch_xup_inv_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity InlabGlitch_xup_inv_0_0 is
  Port ( 
    a : in STD_LOGIC;
    y : out STD_LOGIC
  );

end InlabGlitch_xup_inv_0_0;

architecture stub of InlabGlitch_xup_inv_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "a,y";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "xup_inv,Vivado 2019.1";
begin
end;
