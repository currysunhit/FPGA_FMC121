vlib work
vlib activehdl

vlib activehdl/xil_defaultlib
vlib activehdl/xpm
vlib activehdl/jesd204_v7_2_4

vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm
vmap jesd204_v7_2_4 activehdl/jesd204_v7_2_4

vlog -work xil_defaultlib  -sv2k12 \
"D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work jesd204_v7_2_4  -v2k5 \
"../../../ipstatic/hdl/jesd204_v7_2_rfs.v" \

vlog -work xil_defaultlib  -v2k5 \
"../../../../FMC121_AD.srcs/sources_1/ip/jesd204b_ad/synth/jesd204b_ad_block.v" \
"../../../../FMC121_AD.srcs/sources_1/ip/jesd204b_ad/synth/axi_ipif/jesd204b_ad_address_decoder.v" \
"../../../../FMC121_AD.srcs/sources_1/ip/jesd204b_ad/synth/jesd204b_ad_register_decode.v" \
"../../../../FMC121_AD.srcs/sources_1/ip/jesd204b_ad/synth/axi_ipif/jesd204b_ad_axi_lite_ipif.v" \
"../../../../FMC121_AD.srcs/sources_1/ip/jesd204b_ad/synth/axi_ipif/jesd204b_ad_counter_f.v" \
"../../../../FMC121_AD.srcs/sources_1/ip/jesd204b_ad/synth/axi_ipif/jesd204b_ad_pselect_f.v" \
"../../../../FMC121_AD.srcs/sources_1/ip/jesd204b_ad/synth/axi_ipif/jesd204b_ad_slave_attachment.v" \
"../../../../FMC121_AD.srcs/sources_1/ip/jesd204b_ad/synth/jesd204b_ad_count_err.v" \
"../../../../FMC121_AD.srcs/sources_1/ip/jesd204b_ad/synth/jesd204b_ad_reset_block.v" \
"../../../../FMC121_AD.srcs/sources_1/ip/jesd204b_ad/synth/jesd204b_ad.v" \

vlog -work xil_defaultlib \
"glbl.v"

