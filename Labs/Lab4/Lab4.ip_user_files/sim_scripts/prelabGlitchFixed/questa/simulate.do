onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib prelabGlitchFixed_opt

do {wave.do}

view wave
view structure
view signals

do {prelabGlitchFixed.udo}

run -all

quit -force
