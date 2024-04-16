#----------------------------------------------------------------------
# Title      : External Clock Constraints for JESD204
# Project    : jesd204_phy_v4_0_4
#----------------------------------------------------------------------
# File       : jesd204_phy_0_clocks.xdc
# Author     : Xilinx
#----------------------------------------------------------------------
# Description: Xilinx Constraint file for JESD204 PHY core
#---------------------------------------------------------------------
# (c) Copyright 2004-2013 Xilinx, Inc. All rights reserved.

# Set Rx Core Clock
set rx_coreclk [get_clocks -of_objects [get_ports rx_core_clk]]
# Set Tx Core Clock
set tx_coreclk [get_clocks -of_objects [get_ports tx_core_clk]]

