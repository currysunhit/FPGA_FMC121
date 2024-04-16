vlib work
vlib activehdl

vlib activehdl/xil_defaultlib
vlib activehdl/xpm
vlib activehdl/gtwizard_ultrascale_v1_7_5

vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm
vmap gtwizard_ultrascale_v1_7_5 activehdl/gtwizard_ultrascale_v1_7_5

vlog -work xil_defaultlib  -sv2k12 \
"D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work gtwizard_ultrascale_v1_7_5  -v2k5 \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_bit_sync.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gte4_drp_arb.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gthe4_delay_powergood.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gtye4_delay_powergood.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gthe3_cpll_cal.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gthe3_cal_freqcnt.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gthe4_cpll_cal.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gthe4_cpll_cal_rx.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gthe4_cpll_cal_tx.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gthe4_cal_freqcnt.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gtye4_cpll_cal.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gtye4_cpll_cal_rx.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gtye4_cpll_cal_tx.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gtye4_cal_freqcnt.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gtwiz_buffbypass_rx.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gtwiz_buffbypass_tx.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gtwiz_reset.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gtwiz_userclk_rx.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gtwiz_userclk_tx.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gtwiz_userdata_rx.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gtwiz_userdata_tx.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_reset_sync.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_reset_inv_sync.v" \

vlog -work xil_defaultlib  -v2k5 \
"../../../../FMC121_AD.srcs/sources_1/ip/jesd204_phy_0/ip_0/sim/gtwizard_ultrascale_v1_7_gthe4_channel.v" \
"../../../../FMC121_AD.srcs/sources_1/ip/jesd204_phy_0/ip_0/sim/jesd204_phy_0_gt_gthe4_channel_wrapper.v" \
"../../../../FMC121_AD.srcs/sources_1/ip/jesd204_phy_0/ip_0/sim/jesd204_phy_0_gt_gtwizard_gthe4.v" \
"../../../../FMC121_AD.srcs/sources_1/ip/jesd204_phy_0/ip_0/sim/jesd204_phy_0_gt_gtwizard_top.v" \
"../../../../FMC121_AD.srcs/sources_1/ip/jesd204_phy_0/ip_0/sim/jesd204_phy_0_gt.v" \
"../../../../FMC121_AD.srcs/sources_1/ip/jesd204_phy_0/synth/jesd204_phy_0_block.v" \
"../../../../FMC121_AD.srcs/sources_1/ip/jesd204_phy_0/synth/jesd204_phy_0_sync_block.v" \
"../../../../FMC121_AD.srcs/sources_1/ip/jesd204_phy_0/synth/jesd204_phy_0_support.v" \
"../../../../FMC121_AD.srcs/sources_1/ip/jesd204_phy_0/synth/jesd204_phy_0_gt_common_wrapper.v" \
"../../../../FMC121_AD.srcs/sources_1/ip/jesd204_phy_0/synth/gtwizard_ultrascale_v1_7_gthe4_common.v" \
"../../../../FMC121_AD.srcs/sources_1/ip/jesd204_phy_0/synth/jesd204_phy_0_gt_common.v" \
"../../../../FMC121_AD.srcs/sources_1/ip/jesd204_phy_0/synth/jesd204_phy_0_reset_control.v" \
"../../../../FMC121_AD.srcs/sources_1/ip/jesd204_phy_0/synth/jesd204_phy_0.v" \

vlog -work xil_defaultlib \
"glbl.v"
