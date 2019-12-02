vlib work
vlib activehdl

vlib activehdl/xil_defaultlib

vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../bd/prelabGlitch/ipshared/778c/xup_and2.srcs/sources_1/new/xup_and2.v" \
"../../../bd/prelabGlitch/ip/prelabGlitch_xup_and2_0_0/sim/prelabGlitch_xup_and2_0_0.v" \
"../../../bd/prelabGlitch/ipshared/e3e7/xup_inv.srcs/sources_1/new/xup_inv.v" \
"../../../bd/prelabGlitch/ip/prelabGlitch_xup_inv_0_0/sim/prelabGlitch_xup_inv_0_0.v" \
"../../../bd/prelabGlitch/ip/prelabGlitch_xup_and2_0_1/sim/prelabGlitch_xup_and2_0_1.v" \
"../../../bd/prelabGlitch/ipshared/1ec9/xup_or2.srcs/sources_1/new/xup_or2.v" \
"../../../bd/prelabGlitch/ip/prelabGlitch_xup_or2_0_0/sim/prelabGlitch_xup_or2_0_0.v" \
"../../../bd/prelabGlitch/sim/prelabGlitch.v" \


vlog -work xil_defaultlib \
"glbl.v"

