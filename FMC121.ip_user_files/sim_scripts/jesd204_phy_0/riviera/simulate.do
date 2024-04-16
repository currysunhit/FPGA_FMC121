onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+jesd204_phy_0 -L xil_defaultlib -L xpm -L gtwizard_ultrascale_v1_7_5 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.jesd204_phy_0 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {jesd204_phy_0.udo}

run -all

endsim

quit -force
