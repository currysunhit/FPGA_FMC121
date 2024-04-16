onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib GLB_dcm_opt

do {wave.do}

view wave
view structure
view signals

do {GLB_dcm.udo}

run -all

quit -force
