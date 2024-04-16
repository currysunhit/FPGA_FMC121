vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../FMC121_AD.srcs/sources_1/ip/ila_3/hdl/verilog" \
"D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../FMC121_AD.srcs/sources_1/ip/ila_3/hdl/verilog" \
"../../../../FMC121_AD.srcs/sources_1/ip/ila_3/sim/ila_3.v" \

vlog -work xil_defaultlib \
"glbl.v"

