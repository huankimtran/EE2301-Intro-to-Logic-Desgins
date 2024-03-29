onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib InlabGlitch_opt

do {wave.do}

view wave
view structure
view signals

do {InlabGlitch.udo}

run -all

quit -force
