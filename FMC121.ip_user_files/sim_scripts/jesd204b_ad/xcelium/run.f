-makelib xcelium_lib/xil_defaultlib -sv \
  "D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/jesd204_v7_2_4 \
  "../../../ipstatic/hdl/jesd204_v7_2_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
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
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

