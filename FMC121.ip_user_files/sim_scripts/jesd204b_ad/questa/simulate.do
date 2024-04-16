onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib jesd204b_ad_opt

do {wave.do}

view wave
view structure
view signals

do {jesd204b_ad.udo}

run -all

quit -force
