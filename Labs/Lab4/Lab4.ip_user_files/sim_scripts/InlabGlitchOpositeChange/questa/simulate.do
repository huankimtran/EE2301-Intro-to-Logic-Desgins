onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib InlabGlitchOpositeChange_opt

do {wave.do}

view wave
view structure
view signals

do {InlabGlitchOpositeChange.udo}

run -all

quit -force
