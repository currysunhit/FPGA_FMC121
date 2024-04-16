onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib sysclk_opt

do {wave.do}

view wave
view structure
view signals

do {sysclk.udo}

run -all

quit -force
