-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Mon Nov  4 09:52:02 2019
-- Host        : ECE-LAB108 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/tran0966/Lab4/Lab4.srcs/sources_1/bd/InlabGlitch/ip/InlabGlitch_xup_or2_1_0/InlabGlitch_xup_or2_1_0_sim_netlist.vhdl
-- Design      : InlabGlitch_xup_or2_1_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity InlabGlitch_xup_or2_1_0 is
  port (
    a : in STD_LOGIC;
    b : in STD_LOGIC;
    y : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of InlabGlitch_xup_or2_1_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of InlabGlitch_xup_or2_1_0 : entity is "InlabGlitch_xup_or2_1_0,xup_or2,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of InlabGlitch_xup_or2_1_0 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of InlabGlitch_xup_or2_1_0 : entity is "xup_or2,Vivado 2019.1";
end InlabGlitch_xup_or2_1_0;

architecture STRUCTURE of InlabGlitch_xup_or2_1_0 is
begin
y_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => a,
      I1 => b,
      O => y
    );
end STRUCTURE;
