-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Mon Nov  4 08:22:42 2019
-- Host        : ECE-LAB108 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim -rename_top prelabGlitch_xup_and2_0_1 -prefix
--               prelabGlitch_xup_and2_0_1_ prelabGlitch_xup_and2_0_0_sim_netlist.vhdl
-- Design      : prelabGlitch_xup_and2_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity prelabGlitch_xup_and2_0_1 is
  port (
    a : in STD_LOGIC;
    b : in STD_LOGIC;
    y : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of prelabGlitch_xup_and2_0_1 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of prelabGlitch_xup_and2_0_1 : entity is "prelabGlitch_xup_and2_0_0,xup_and2,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of prelabGlitch_xup_and2_0_1 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of prelabGlitch_xup_and2_0_1 : entity is "xup_and2,Vivado 2019.1";
end prelabGlitch_xup_and2_0_1;

architecture STRUCTURE of prelabGlitch_xup_and2_0_1 is
begin
y_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => a,
      I1 => b,
      O => y
    );
end STRUCTURE;
