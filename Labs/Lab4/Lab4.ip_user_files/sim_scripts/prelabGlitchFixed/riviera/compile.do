vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../bd/prelabGlitchFixed/ipshared/778c/xup_and2.srcs/sources_1/new/xup_and2.v" \
"../../../bd/prelabGlitchFixed/ip/prelabGlitchFixed_xup_and2_0_0/sim/prelabGlitchFixed_xup_and2_0_0.v" \
"../../../bd/prelabGlitchFixed/ip/prelabGlitchFixed_xup_and2_1_0/sim/prelabGlitchFixed_xup_and2_1_0.v" \
"../../../bd/prelabGlitchFixed/ipshared/e3e7/xup_inv.srcs/sources_1/new/xup_inv.v" \
"../../../bd/prelabGlitchFixed/ip/prelabGlitchFixed_xup_inv_0_0/sim/prelabGlitchFixed_xup_inv_0_0.v" \
"../../../bd/prelabGlitchFixed/ipshared/1ec9/xup_or2.srcs/sources_1/new/xup_or2.v" \
"../../../bd/prelabGlitchFixed/ip/prelabGlitchFixed_xup_or2_0_0/sim/prelabGlitchFixed_xup_or2_0_0.v" \
"../../../bd/prelabGlitchFixed/ip/prelabGlitchFixed_xup_and2_0_1/sim/prelabGlitchFixed_xup_and2_0_1.v" \
"../../../bd/prelabGlitchFixed/ip/prelabGlitchFixed_xup_or2_0_1/sim/prelabGlitchFixed_xup_or2_0_1.v" \
"../../../bd/prelabGlitchFixed/sim/prelabGlitchFixed.v" \


vlog -work xil_defaultlib \
"glbl.v"

