vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm
vlib questa_lib/msim/jesd204_v7_2_4

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm
vmap jesd204_v7_2_4 questa_lib/msim/jesd204_v7_2_4

vlog -work xil_defaultlib -64 -sv \
"D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work jesd204_v7_2_4 -64 \
"../../../ipstatic/hdl/jesd204_v7_2_rfs.v" \

vlog -work xil_defaultlib -64 \
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

