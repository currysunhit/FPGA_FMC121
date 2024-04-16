onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+GLB_dcm -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.GLB_dcm xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {GLB_dcm.udo}

run -all

endsim

quit -force
