onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib prelabGlitch_opt

do {wave.do}

view wave
view structure
view signals

do {prelabGlitch.udo}

run -all

quit -force
