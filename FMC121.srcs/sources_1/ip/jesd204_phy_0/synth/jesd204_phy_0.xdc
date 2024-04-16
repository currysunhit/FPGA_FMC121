#----------------------------------------------------------------------
# Title      : Constraints for JESD204 PHY
# Project    : jesd204_phy_v4_0_4
#----------------------------------------------------------------------
# File       : jesd204_phy_0_block.xdc
# Author     : Xilinx
#----------------------------------------------------------------------
# Description: Xilinx Constraint file for JESD204 PHY core
#---------------------------------------------------------------------
# (c) Copyright 2004-2014 Xilinx, Inc. All rights reserved.
#
# This file contains confidential and proprietary information
# of Xilinx, Inc. and is protected under U.S. and
# international copyright and other intellectual property
# laws.
#
# DISCLAIMER
# This disclaimer is not a license and does not grant any
# rights to the materials distributed herewith. Except as
# otherwise provided in a valid license issued to you by
# Xilinx, and to the maximum extent permitted by applicable
# law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
# WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
# AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
# BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
# INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
# (2) Xilinx shall not be liable (whether in contract or tort,
# including negligence, or under any other theory of
# liability) for any loss or damage of any kind or nature
# related to, arising under or in connection with these
# materials, including for any direct, or any indirect,
# special, incidental, or consequential loss or damage
# (including loss of data, profits, goodwill, or any type of
# loss or damage suffered as a result of any action brought
# by a third party) even if such damage or loss was
# reasonably foreseeable or Xilinx had been advised of the
# possibility of the same.
#
# CRITICAL APPLICATIONS
# Xilinx products are not designed or intended to be fail-
# safe, or for use in any application requiring fail-safe
# performance, such as life-support or safety devices or
# systems, Class III medical devices, nuclear facilities,
# applications related to the deployment of airbags, or any
# other applications that could lead to death, personal
# injury, or severe property or environmental damage
# (individually and collectively, "Critical
# Applications"). Customer assumes the sole risk and
# liability of any use of Xilinx products in Critical
# Applications, subject only to applicable laws and
# regulations governing limitations on product liability.
#
# THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
# PART OF THIS FILE AT ALL TIMES.
#

# To see constaint endpoints use
# foreach {tempVar} [ get_pins -hier -regexp -filter {name =~ {.*jesd204_phy_0.*sync_[rt]x_reset_(?:data|all)\/data_sync_reg0/D} }] { puts $tempVar }
# To see timing
# report_timing -to  [ get_pins -hier -regexp -filter {name =~ {.*jesd204_phy_0.*sync_[rt]x_reset_(?:data|all)\/data_sync_reg0/D} }] -path_type summary -unique_pins -setup -max_paths 1000
# Example
# set_false_path -to [get_cells -hier -regexp -filter {name =~ {.*jesd204_phy_0.*sync_[rt]x_reset_(?:data|all)\/data_sync_reg.*} && IS_SEQUENTIAL}]

##############################################################################################################################################################
# TIMING CONSTRAINTS
##############################################################################################################################################################
set_false_path -from [get_cells -hier -filter {name =~ *jesd204_phy_block_i/gtwiz_reset_block_i/gtwiz_reset_*x_done_int_reg* && IS_SEQUENTIAL}]
set_false_path -to [get_cells -hier -filter {name =~ *jesd204_phy_block_i/gtwiz_reset_block_i/bit_synchronizer_gtwiz_reset_userclk_*x_active_inst/i_in_meta_reg* && IS_SEQUENTIAL}]




########################
# Waivers
########################
#
# CDC-1
#
create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-1 -description {Safe RW control registers} \
  -from [get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*_transDbgCtrl_*x_i/*_reg*}] ] \
  -to   [get_pins -filter {REF_PIN_NAME=~D} -of [get_cells -hier -filter {name=~*_transDbgCtrl_*x_i/slv_rdata_reg[*]}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-1 -description {Safe RW control registers} \
  -from [get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*axi_register_if_i/slv_addr_reg*}] ] \
  -to   [get_pins -filter {REF_PIN_NAME=~CE} -of [get_cells -hier -filter {name=~*_transDbgCtrl_*x_i/*_reg*}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-1 -description {Safe RX RW control registers} \
  -from [get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*axi_register_if_i/slv_addr_reg*}] ] \
  -to   [get_pins -filter {REF_PIN_NAME=~D} -of [get_cells -hier -filter {name=~*_transDbgCtrl_*x_i/*_reg*}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-1 -description {Safe RW control registers} \
  -from [get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*_transDbgCtrl_*x_i/slv_rden_r_reg*}] ] \
  -to   [get_pins -filter {REF_PIN_NAME=~CE} -of [get_cells -hier -filter {name=~*_transDbgCtrl_*x_i/*_reg*}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-1 -description {Safe RX RW control registers} \
  -from [get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*_transDbgCtrl_*x_i/slv_rden_r_reg*}] ] \
  -to   [get_pins -filter {REF_PIN_NAME=~D} -of [get_cells -hier -filter {name=~*_transDbgCtrl_*x_i/*_reg*}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-1 -description {GT_WIZ cpll cal block is safe} \
  -from [get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*_transDbgCtrl_async_i/*_reg*}] ] \
  -to   [get_pins -filter {REF_PIN_NAME=~D} -of [get_cells -hier -filter {name=~*_cpll_cal_*x_i/*cpll_cal_state_reg*}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-1 -description {GT_WIZ cpll cal block is safe} \
  -from [get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*_transDbgCtrl_async_i/*_reg*}] ] \
  -to   [get_pins -filter {REF_PIN_NAME=~D} -of [get_cells -hier -filter {name=~*_cpll_cal_*x_i/cal_fail_store_reg*}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-1 -description {GT_WIZ cpll cal block is safe} \
  -from [get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*_transDbgCtrl_async_i/*_reg*}] ] \
  -to   [get_pins -filter {REF_PIN_NAME=~CE} -of [get_cells -hier -filter {name=~*_cpll_cal_*x_i/*repeat_ctr_reg*}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-1 -description {GT_WIZ cpll cal block is safe} \
  -from [get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*_transDbgCtrl_async_i/*_reg*}] ] \
  -to   [get_pins -filter {REF_PIN_NAME=~D} -of [get_cells -hier -filter {name=~*_gt*e4_cpll_cal_*x_i/gen_cal_*x_en.cal_fail_store_reg*}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-1 -description {DRP mailbox control is safe} \
  -from [get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*Mailbox_i/drp_if_select_reg*}] ] \
  -to   [get_pins -filter {REF_PIN_NAME=~CE} -of [get_cells -hier -filter {name=~*_drp_arb_i*}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-1 -description {DRP mailbox control is safe} \
  -from [get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*Mailbox_i/drp_if_select_reg*}] ] \
  -to   [get_pins -filter {REF_PIN_NAME=~CE} -of [get_cells -hier -filter {name=~*Mailbox_i/drp_read_data_reg*}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-1 -description {DRP mailbox control is safe} \
  -from [get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*Mailbox_i/access_type_reg*}] ] \
  -to   [get_pins -filter {REF_PIN_NAME=~CE} -of [get_cells -hier -filter {name=~*Mailbox_i/drp_read_data_reg*}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-1 -description {DRP mailbox control is safe} \
  -from [get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*Mailbox_i/drp_if_select_reg*}] ] \
  -to   [get_pins -filter {REF_PIN_NAME=~D} -of [get_cells -hier -filter {name=~*Mailbox_i/clk2clk_handshake_pulse_gen_i/clk2_ready_reg}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-1 -description {DRP mailbox selector is safe} \
  -from [ get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~Mailbox_i/drp_if_select_reg*}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-1 -description {GT channel control select is safe} \
  -from [get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*_phyAxiConfig_i/gt_interface_sel_reg*}] ] \
  -to   [get_pins -filter {REF_PIN_NAME=~D} -of [get_cells -hier -filter {name=~*_transDbgCtrl_*x_i/*_reg*}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-1 -description {GT channel control select is safe} \
  -from [get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*_phyAxiConfig_i/gt_interface_sel_reg*}] ] \
  -to   [get_pins -filter {REF_PIN_NAME=~CE} -of [get_cells -hier -filter {name=~*_transDbgCtrl_*x_i/*_reg*}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-1 -description {XPLLCLKSEL is safe} \
  -from [ get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*_transDbgCtrl_async_i/*xpllclksel_reg[*]}] ] \
  -to   [ get_pins -filter {REF_PIN_NAME=~D} -of [get_cells -hier -filter {name=~*_block_i/*x_pll_lock_reg*}] ]

#
# CDC-2
#
create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-2 -description {RXPLLCLKSEL is safe} \
  -from [ get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*_transDbgCtrl_async_i/*xpllclksel_reg*}] ] \
  -to   [ get_pins -filter {REF_PIN_NAME=~D} -of [get_cells -hier -filter {name=~*x_pll_lock_reg}] ]


#
# CDC-10
#
create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-10 -description {GT_WIZ reset_smc TX reset done synchroniser is safe} \
  -from [ get_pins -hier -filter {REF_PIN_NAME=~RXUSRCLK2} ] \
  -to   [ get_pins -filter {REF_PIN_NAME=~D} -of [get_cells -hier -filter {name=~*RXRESETDONE/data_sync_reg1}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-10 -description {GT_WIZ reset_smc TX reset done synchroniser is safe} \
  -from [ get_pins -hier -filter {REF_PIN_NAME=~TXUSRCLK2} ] \
  -to   [ get_pins -filter {REF_PIN_NAME=~D} -of [get_cells -hier -filter {name=~*TXRESETDONE/data_sync_reg1}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-10 -description {GT_WIZ cpll cal block is safe} \
  -from [ get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*USER_CPLLLOCK_OUT_reg}] ] \
  -to   [ get_pins -filter {REF_PIN_NAME=~D} -of [get_cells -hier -filter {name=~*syncstages_ff_reg[0]}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-10 -description {GT_WIZ cpll cal block is safe} \
  -from [ get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*_transDbgCtrl_async_i/*xpllclksel_reg[*]}] ] \
  -to   [ get_pins -filter {REF_PIN_NAME=~PRE} -of [get_cells -hier -filter {name=~*_cpll_cal_inst/reset_synchronizer_resetin_*x_inst/rst_in_meta_reg}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-10 -description {GT_WIZ cpll cal block is safe} \
  -from [ get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*_transDbgCtrl_async_i/cpll_pd_*_reg}] ] \
  -to   [ get_pins -filter {REF_PIN_NAME=~PRE} -of [get_cells -hier -filter {name=~*_cpll_cal_inst/reset_synchronizer_resetin_*x_inst/rst_in_meta_reg}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-10 -description {GT_WIZ cpll cal block is safe} \
  -from [ get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*cpll_cal_*x_i/gen_cal_*x_en.mask_user_in_reg}] ] \
  -to   [ get_pins -filter {REF_PIN_NAME=~PRE} -of [get_cells -hier -filter {name=~*xpm_cdc_async_rst_inst/arststages_ff_reg[0]}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-10 -description {Block is safe} \
  -from [ get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*_transDbgCtrl_async_i/*x_sys_reset_axi_reg}] ] \
  -to   [ get_pins -filter {REF_PIN_NAME=~PRE} -of [get_cells -hier -filter {name=~*_reset_all/xpm_cdc_async_rst_inst/arststages_ff_reg[0]}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-10 -description {RXRESETDONE synchroniser is safe} \
  -to   [ get_pins -filter {REF_PIN_NAME=~D} -of [get_cells -hier -filter {name=~*sync_RXRESETDONE/data_sync_reg1}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-10 -description {XPLLCLKSEL is safe} \
  -from [ get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*_transDbgCtrl_async_i/*xpllclksel_reg*}] ] \
  -to   [ get_pins -filter {REF_PIN_NAME=~D} -of [get_cells -hier -filter {name=~*x_pll_lock_reg}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-10 -description {GT_WIZ cpll cal block is safe} \
  -to   [ get_pins -filter {REF_PIN_NAME=~PRE} -of [get_cells -hier -filter {name=~*sync_gtwiz_userclk_tx_active/xpm_cdc_async_rst_inst/arststages_ff_reg[0]}] ]

#
# CDC-11
#
create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-11 -description {GT_WIZ cpll call block is safe} \
  -from [ get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*OUTCLK_FREQ_COUNTER/state_reg[0]}] ] \
  -to   [ get_pins -filter {REF_PIN_NAME=~PRE} -of [get_cells -hier -filter {name=~*rst_in_meta_reg}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-11 -description {GT_WIZ cpll call block is safe} \
  -from [ get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*OUTCLK_FREQ_COUNTER/state_reg[0]}] ] \
  -to   [ get_pins -filter {REF_PIN_NAME=~D} -of [get_cells -hier -filter {name=~*OUTCLK_FREQ_COUNTER/tstclk_rst_dly1_reg}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-11 -description {Safe Synchroniser} \
  -from [ get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*x_pll_lock_i_reg}] ] \
  -to   [ get_pins -filter {REF_PIN_NAME=~D} -of [get_cells -hier -filter {name=~*cdc_i/syncstages_ff_reg[0]}] ]

#
# CDC-12
#
create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-12 -description {RXRESETDONE synchroniser is safe} \
  -to   [ get_pins -filter {REF_PIN_NAME=~D} -of [get_cells -hier -filter {name=~*sync_RXRESETDONE/data_sync_reg1}] ]

#
# CDC-13
#
create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-13 -description {DRP mailbox selector is safe} \
  -from [ get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*Mailbox_i/drp_if_select_reg*}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-13 -description {DRP mailbox selector is safe} \
  -from [ get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*Mailbox_i/access_type_reg*}] ]

#
# CDC-14
#
create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-14 -description {DRP mailbox is safe} \
  -from [ get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*drpChannelMailbox_i/drp_int_addr_reg*}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-14 -description {DRP mailbox is safe} \
  -from [ get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*drpChannelMailbox_i/drp_write_data_reg*}] ]

#
# CDC-15 Only warnings so just hide
#
create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-15 -description {Safe, warning only} \
  -from [ get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*Mailbox_i/drp_read_data_reg*}] ] \
  -to   [ get_pins -filter {REF_PIN_NAME=~D} -of [get_cells -hier -filter {name=~*axi_register_if_i/axi_rdata_reg*}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-15 -description {Safe, warning only} \
  -from [ get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*Mailbox_i/drp_if_select_reg*}] ] \
  -to   [ get_pins -filter {REF_PIN_NAME=~D} -of [get_cells -hier -filter {name=~*Mailbox_i/drp_read_data_reg*}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-15 -description {Safe, warning only} \
  -from [ get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*transDbgCtrl_rx_i/slv_wdata_r_internal_reg*}] ] \
  -to   [ get_pins -filter {REF_PIN_NAME=~D} -of [get_cells -hier -filter {name=~*hold_reg*}] ]

create_waiver -internal -quiet -user JESD204_PHY -type CDC -id CDC-15 -description {Safe, warning only} \
  -from [ get_pins -filter {REF_PIN_NAME=~C} -of [get_cells -hier -filter {name=~*transDbgCtrl_tx_i/slv_wdata_r_internal_reg*}] ] \
  -to   [ get_pins -filter {REF_PIN_NAME=~D} -of [get_cells -hier -filter {name=~*transDbgCtrl_tx_i/txdiffctrl*}] ]
