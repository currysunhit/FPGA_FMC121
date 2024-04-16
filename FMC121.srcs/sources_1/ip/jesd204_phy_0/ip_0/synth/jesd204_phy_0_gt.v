// (c) Copyright 1995-2023 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:ip:gtwizard_ultrascale:1.7
// IP Revision: 5

(* X_CORE_INFO = "jesd204_phy_0_gt_gtwizard_top,Vivado 2018.3" *)
(* CHECK_LICENSE_TYPE = "jesd204_phy_0_gt,jesd204_phy_0_gt_gtwizard_top,{}" *)
(* CORE_GENERATION_INFO = "jesd204_phy_0_gt,jesd204_phy_0_gt_gtwizard_top,{x_ipProduct=Vivado 2018.3,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=gtwizard_ultrascale,x_ipVersion=1.7,x_ipCoreRevision=5,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_CHANNEL_ENABLE=000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000111111110000,C_PCIE_ENABLE=0,C_PCIE_CORECLK_FREQ=250,C_COMMON_SCALING_FACTOR=2,C_CPLL\
_VCO_FREQUENCY=2500.0,C_FORCE_COMMONS=0,C_FREERUN_FREQUENCY=100.0,C_GT_TYPE=2,C_GT_REV=57,C_INCLUDE_CPLL_CAL=1,C_ENABLE_COMMON_USRCLK=0,C_USER_GTPOWERGOOD_DELAY_EN=1,C_SIM_CPLL_CAL_BYPASS=1,C_LOCATE_COMMON=1,C_LOCATE_RESET_CONTROLLER=1,C_LOCATE_USER_DATA_WIDTH_SIZING=1,C_LOCATE_RX_BUFFER_BYPASS_CONTROLLER=0,C_LOCATE_IN_SYSTEM_IBERT_CORE=2,C_LOCATE_RX_USER_CLOCKING=1,C_LOCATE_TX_BUFFER_BYPASS_CONTROLLER=0,C_LOCATE_TX_USER_CLOCKING=1,C_RESET_CONTROLLER_INSTANCE_CTRL=0,C_RX_BUFFBYPASS_MODE=0,C_RX_B\
UFFER_BYPASS_INSTANCE_CTRL=0,C_RX_BUFFER_MODE=1,C_RX_CB_DISP=00000000,C_RX_CB_K=00000000,C_RX_CB_MAX_LEVEL=4,C_RX_CB_LEN_SEQ=1,C_RX_CB_NUM_SEQ=0,C_RX_CB_VAL=00000000000000000000000000000000000000000000000000000000000000000000000000000000,C_RX_CC_DISP=00000000,C_RX_CC_ENABLE=0,C_RESET_SEQUENCE_INTERVAL=0,C_RX_CC_K=00000000,C_RX_CC_LEN_SEQ=1,C_RX_CC_NUM_SEQ=0,C_RX_CC_PERIODICITY=5000,C_RX_CC_VAL=00000000000000000000000000000000000000000000000000000000000000000000000000000000,C_RX_COMMA_M_ENABLE=1,\
C_RX_COMMA_M_VAL=1010000011,C_RX_COMMA_P_ENABLE=1,C_RX_COMMA_P_VAL=0101111100,C_RX_DATA_DECODING=1,C_RX_ENABLE=1,C_RX_INT_DATA_WIDTH=40,C_RX_LINE_RATE=10,C_RX_MASTER_CHANNEL_IDX=4,C_RX_OUTCLK_BUFG_GT_DIV=1,C_RX_OUTCLK_FREQUENCY=250.0000000,C_RX_OUTCLK_SOURCE=1,C_RX_PLL_TYPE=0,C_RX_RECCLK_OUTPUT=0x000000000000000000000000000000000000000000000000,C_RX_REFCLK_FREQUENCY=250,C_RX_SLIDE_MODE=0,C_RX_USER_CLOCKING_CONTENTS=0,C_RX_USER_CLOCKING_INSTANCE_CTRL=0,C_RX_USER_CLOCKING_RATIO_FSRC_FUSRCLK=1,C_RX\
_USER_CLOCKING_RATIO_FUSRCLK_FUSRCLK2=1,C_RX_USER_CLOCKING_SOURCE=0,C_RX_USER_DATA_WIDTH=32,C_RX_USRCLK_FREQUENCY=250.0000000,C_RX_USRCLK2_FREQUENCY=250.0000000,C_SECONDARY_QPLL_ENABLE=1,C_SECONDARY_QPLL_REFCLK_FREQUENCY=64.453125,C_TOTAL_NUM_CHANNELS=8,C_TOTAL_NUM_COMMONS=0,C_TOTAL_NUM_COMMONS_EXAMPLE=2,C_TXPROGDIV_FREQ_ENABLE=0,C_TXPROGDIV_FREQ_SOURCE=2,C_TXPROGDIV_FREQ_VAL=125,C_TX_BUFFBYPASS_MODE=0,C_TX_BUFFER_BYPASS_INSTANCE_CTRL=0,C_TX_BUFFER_MODE=1,C_TX_DATA_ENCODING=1,C_TX_ENABLE=1,C_TX_\
INT_DATA_WIDTH=40,C_TX_LINE_RATE=5,C_TX_MASTER_CHANNEL_IDX=4,C_TX_OUTCLK_BUFG_GT_DIV=1,C_TX_OUTCLK_FREQUENCY=125.0000000,C_TX_OUTCLK_SOURCE=1,C_TX_PLL_TYPE=2,C_TX_REFCLK_FREQUENCY=250,C_TX_USER_CLOCKING_CONTENTS=0,C_TX_USER_CLOCKING_INSTANCE_CTRL=0,C_TX_USER_CLOCKING_RATIO_FSRC_FUSRCLK=1,C_TX_USER_CLOCKING_RATIO_FUSRCLK_FUSRCLK2=1,C_TX_USER_CLOCKING_SOURCE=0,C_TX_USER_DATA_WIDTH=32,C_TX_USRCLK_FREQUENCY=125.0000000,C_TX_USRCLK2_FREQUENCY=125.0000000}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module jesd204_phy_0_gt (
  gtwiz_userclk_tx_reset_in,
  gtwiz_userclk_tx_active_in,
  gtwiz_userclk_rx_reset_in,
  gtwiz_userclk_rx_active_in,
  gtwiz_reset_tx_done_in,
  gtwiz_reset_rx_done_in,
  gtwiz_gthe4_cpll_cal_txoutclk_period_in,
  gtwiz_gthe4_cpll_cal_cnt_tol_in,
  gtwiz_gthe4_cpll_cal_bufg_ce_in,
  cpllpd_in,
  cpllreset_in,
  dmonitorclk_in,
  drpaddr_in,
  drpclk_in,
  drpdi_in,
  drpen_in,
  drpwe_in,
  eyescanreset_in,
  eyescantrigger_in,
  gthrxn_in,
  gthrxp_in,
  gtrefclk0_in,
  gtrxreset_in,
  gttxreset_in,
  loopback_in,
  pcsrsvdin_in,
  qpll0clk_in,
  qpll0refclk_in,
  qpll1clk_in,
  qpll1refclk_in,
  rx8b10ben_in,
  rxbufreset_in,
  rxcdrhold_in,
  rxcommadeten_in,
  rxdfeagchold_in,
  rxdfelfhold_in,
  rxdfelpmreset_in,
  rxdfetap10hold_in,
  rxdfetap11hold_in,
  rxdfetap12hold_in,
  rxdfetap13hold_in,
  rxdfetap14hold_in,
  rxdfetap15hold_in,
  rxdfetap2hold_in,
  rxdfetap3hold_in,
  rxdfetap4hold_in,
  rxdfetap5hold_in,
  rxdfetap6hold_in,
  rxdfetap7hold_in,
  rxdfetap8hold_in,
  rxdfetap9hold_in,
  rxdfeuthold_in,
  rxdfevphold_in,
  rxlpmen_in,
  rxmcommaalignen_in,
  rxoshold_in,
  rxpcommaalignen_in,
  rxpcsreset_in,
  rxpd_in,
  rxpllclksel_in,
  rxpmareset_in,
  rxpolarity_in,
  rxprbscntreset_in,
  rxprbssel_in,
  rxprogdivreset_in,
  rxrate_in,
  rxsysclksel_in,
  rxuserrdy_in,
  rxusrclk_in,
  rxusrclk2_in,
  tx8b10ben_in,
  txctrl0_in,
  txctrl1_in,
  txctrl2_in,
  txdata_in,
  txdiffctrl_in,
  txinhibit_in,
  txpcsreset_in,
  txpd_in,
  txpllclksel_in,
  txpmareset_in,
  txpolarity_in,
  txpostcursor_in,
  txprbsforceerr_in,
  txprbssel_in,
  txprecursor_in,
  txprogdivreset_in,
  txsysclksel_in,
  txuserrdy_in,
  txusrclk_in,
  txusrclk2_in,
  cplllock_out,
  dmonitorout_out,
  drpdo_out,
  drprdy_out,
  eyescandataerror_out,
  gthtxn_out,
  gthtxp_out,
  gtpowergood_out,
  rxbufstatus_out,
  rxbyteisaligned_out,
  rxbyterealign_out,
  rxcdrlock_out,
  rxcommadet_out,
  rxctrl0_out,
  rxctrl1_out,
  rxctrl2_out,
  rxctrl3_out,
  rxdata_out,
  rxoutclk_out,
  rxpmaresetdone_out,
  rxprbserr_out,
  rxresetdone_out,
  txbufstatus_out,
  txoutclk_out,
  txpmaresetdone_out,
  txresetdone_out
);

input wire [0 : 0] gtwiz_userclk_tx_reset_in;
input wire [0 : 0] gtwiz_userclk_tx_active_in;
input wire [0 : 0] gtwiz_userclk_rx_reset_in;
input wire [0 : 0] gtwiz_userclk_rx_active_in;
input wire [0 : 0] gtwiz_reset_tx_done_in;
input wire [0 : 0] gtwiz_reset_rx_done_in;
input wire [143 : 0] gtwiz_gthe4_cpll_cal_txoutclk_period_in;
input wire [143 : 0] gtwiz_gthe4_cpll_cal_cnt_tol_in;
input wire [7 : 0] gtwiz_gthe4_cpll_cal_bufg_ce_in;
input wire [7 : 0] cpllpd_in;
input wire [7 : 0] cpllreset_in;
input wire [7 : 0] dmonitorclk_in;
input wire [79 : 0] drpaddr_in;
input wire [7 : 0] drpclk_in;
input wire [127 : 0] drpdi_in;
input wire [7 : 0] drpen_in;
input wire [7 : 0] drpwe_in;
input wire [7 : 0] eyescanreset_in;
input wire [7 : 0] eyescantrigger_in;
input wire [7 : 0] gthrxn_in;
input wire [7 : 0] gthrxp_in;
input wire [7 : 0] gtrefclk0_in;
input wire [7 : 0] gtrxreset_in;
input wire [7 : 0] gttxreset_in;
input wire [23 : 0] loopback_in;
input wire [127 : 0] pcsrsvdin_in;
input wire [7 : 0] qpll0clk_in;
input wire [7 : 0] qpll0refclk_in;
input wire [7 : 0] qpll1clk_in;
input wire [7 : 0] qpll1refclk_in;
input wire [7 : 0] rx8b10ben_in;
input wire [7 : 0] rxbufreset_in;
input wire [7 : 0] rxcdrhold_in;
input wire [7 : 0] rxcommadeten_in;
input wire [7 : 0] rxdfeagchold_in;
input wire [7 : 0] rxdfelfhold_in;
input wire [7 : 0] rxdfelpmreset_in;
input wire [7 : 0] rxdfetap10hold_in;
input wire [7 : 0] rxdfetap11hold_in;
input wire [7 : 0] rxdfetap12hold_in;
input wire [7 : 0] rxdfetap13hold_in;
input wire [7 : 0] rxdfetap14hold_in;
input wire [7 : 0] rxdfetap15hold_in;
input wire [7 : 0] rxdfetap2hold_in;
input wire [7 : 0] rxdfetap3hold_in;
input wire [7 : 0] rxdfetap4hold_in;
input wire [7 : 0] rxdfetap5hold_in;
input wire [7 : 0] rxdfetap6hold_in;
input wire [7 : 0] rxdfetap7hold_in;
input wire [7 : 0] rxdfetap8hold_in;
input wire [7 : 0] rxdfetap9hold_in;
input wire [7 : 0] rxdfeuthold_in;
input wire [7 : 0] rxdfevphold_in;
input wire [7 : 0] rxlpmen_in;
input wire [7 : 0] rxmcommaalignen_in;
input wire [7 : 0] rxoshold_in;
input wire [7 : 0] rxpcommaalignen_in;
input wire [7 : 0] rxpcsreset_in;
input wire [15 : 0] rxpd_in;
input wire [15 : 0] rxpllclksel_in;
input wire [7 : 0] rxpmareset_in;
input wire [7 : 0] rxpolarity_in;
input wire [7 : 0] rxprbscntreset_in;
input wire [31 : 0] rxprbssel_in;
input wire [7 : 0] rxprogdivreset_in;
input wire [23 : 0] rxrate_in;
input wire [15 : 0] rxsysclksel_in;
input wire [7 : 0] rxuserrdy_in;
input wire [7 : 0] rxusrclk_in;
input wire [7 : 0] rxusrclk2_in;
input wire [7 : 0] tx8b10ben_in;
input wire [127 : 0] txctrl0_in;
input wire [127 : 0] txctrl1_in;
input wire [63 : 0] txctrl2_in;
input wire [1023 : 0] txdata_in;
input wire [39 : 0] txdiffctrl_in;
input wire [7 : 0] txinhibit_in;
input wire [7 : 0] txpcsreset_in;
input wire [15 : 0] txpd_in;
input wire [15 : 0] txpllclksel_in;
input wire [7 : 0] txpmareset_in;
input wire [7 : 0] txpolarity_in;
input wire [39 : 0] txpostcursor_in;
input wire [7 : 0] txprbsforceerr_in;
input wire [31 : 0] txprbssel_in;
input wire [39 : 0] txprecursor_in;
input wire [7 : 0] txprogdivreset_in;
input wire [15 : 0] txsysclksel_in;
input wire [7 : 0] txuserrdy_in;
input wire [7 : 0] txusrclk_in;
input wire [7 : 0] txusrclk2_in;
output wire [7 : 0] cplllock_out;
output wire [127 : 0] dmonitorout_out;
output wire [127 : 0] drpdo_out;
output wire [7 : 0] drprdy_out;
output wire [7 : 0] eyescandataerror_out;
output wire [7 : 0] gthtxn_out;
output wire [7 : 0] gthtxp_out;
output wire [7 : 0] gtpowergood_out;
output wire [23 : 0] rxbufstatus_out;
output wire [7 : 0] rxbyteisaligned_out;
output wire [7 : 0] rxbyterealign_out;
output wire [7 : 0] rxcdrlock_out;
output wire [7 : 0] rxcommadet_out;
output wire [127 : 0] rxctrl0_out;
output wire [127 : 0] rxctrl1_out;
output wire [63 : 0] rxctrl2_out;
output wire [63 : 0] rxctrl3_out;
output wire [1023 : 0] rxdata_out;
output wire [7 : 0] rxoutclk_out;
output wire [7 : 0] rxpmaresetdone_out;
output wire [7 : 0] rxprbserr_out;
output wire [7 : 0] rxresetdone_out;
output wire [15 : 0] txbufstatus_out;
output wire [7 : 0] txoutclk_out;
output wire [7 : 0] txpmaresetdone_out;
output wire [7 : 0] txresetdone_out;

  jesd204_phy_0_gt_gtwizard_top #(
    .C_CHANNEL_ENABLE(192'B000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000111111110000),
    .C_PCIE_ENABLE(0),
    .C_PCIE_CORECLK_FREQ(250),
    .C_COMMON_SCALING_FACTOR(2),
    .C_CPLL_VCO_FREQUENCY(2500.0),
    .C_FORCE_COMMONS(0),
    .C_FREERUN_FREQUENCY(100.0),
    .C_GT_TYPE(2),
    .C_GT_REV(57),
    .C_INCLUDE_CPLL_CAL(1),
    .C_ENABLE_COMMON_USRCLK(0),
    .C_USER_GTPOWERGOOD_DELAY_EN(1),
    .C_SIM_CPLL_CAL_BYPASS(1),
    .C_LOCATE_COMMON(1),
    .C_LOCATE_RESET_CONTROLLER(1),
    .C_LOCATE_USER_DATA_WIDTH_SIZING(1),
    .C_LOCATE_RX_BUFFER_BYPASS_CONTROLLER(0),
    .C_LOCATE_IN_SYSTEM_IBERT_CORE(2),
    .C_LOCATE_RX_USER_CLOCKING(1),
    .C_LOCATE_TX_BUFFER_BYPASS_CONTROLLER(0),
    .C_LOCATE_TX_USER_CLOCKING(1),
    .C_RESET_CONTROLLER_INSTANCE_CTRL(0),
    .C_RX_BUFFBYPASS_MODE(0),
    .C_RX_BUFFER_BYPASS_INSTANCE_CTRL(0),
    .C_RX_BUFFER_MODE(1),
    .C_RX_CB_DISP(8'B00000000),
    .C_RX_CB_K(8'B00000000),
    .C_RX_CB_MAX_LEVEL(4),
    .C_RX_CB_LEN_SEQ(1),
    .C_RX_CB_NUM_SEQ(0),
    .C_RX_CB_VAL(80'B00000000000000000000000000000000000000000000000000000000000000000000000000000000),
    .C_RX_CC_DISP(8'B00000000),
    .C_RX_CC_ENABLE(0),
    .C_RESET_SEQUENCE_INTERVAL(0),
    .C_RX_CC_K(8'B00000000),
    .C_RX_CC_LEN_SEQ(1),
    .C_RX_CC_NUM_SEQ(0),
    .C_RX_CC_PERIODICITY(5000),
    .C_RX_CC_VAL(80'B00000000000000000000000000000000000000000000000000000000000000000000000000000000),
    .C_RX_COMMA_M_ENABLE(1),
    .C_RX_COMMA_M_VAL(10'B1010000011),
    .C_RX_COMMA_P_ENABLE(1),
    .C_RX_COMMA_P_VAL(10'B0101111100),
    .C_RX_DATA_DECODING(1),
    .C_RX_ENABLE(1),
    .C_RX_INT_DATA_WIDTH(40),
    .C_RX_LINE_RATE(10),
    .C_RX_MASTER_CHANNEL_IDX(4),
    .C_RX_OUTCLK_BUFG_GT_DIV(1),
    .C_RX_OUTCLK_FREQUENCY(250.0000000),
    .C_RX_OUTCLK_SOURCE(1),
    .C_RX_PLL_TYPE(0),
    .C_RX_RECCLK_OUTPUT(192'H000000000000000000000000000000000000000000000000),
    .C_RX_REFCLK_FREQUENCY(250),
    .C_RX_SLIDE_MODE(0),
    .C_RX_USER_CLOCKING_CONTENTS(0),
    .C_RX_USER_CLOCKING_INSTANCE_CTRL(0),
    .C_RX_USER_CLOCKING_RATIO_FSRC_FUSRCLK(1),
    .C_RX_USER_CLOCKING_RATIO_FUSRCLK_FUSRCLK2(1),
    .C_RX_USER_CLOCKING_SOURCE(0),
    .C_RX_USER_DATA_WIDTH(32),
    .C_RX_USRCLK_FREQUENCY(250.0000000),
    .C_RX_USRCLK2_FREQUENCY(250.0000000),
    .C_SECONDARY_QPLL_ENABLE(1),
    .C_SECONDARY_QPLL_REFCLK_FREQUENCY(64.453125),
    .C_TOTAL_NUM_CHANNELS(8),
    .C_TOTAL_NUM_COMMONS(0),
    .C_TOTAL_NUM_COMMONS_EXAMPLE(2),
    .C_TXPROGDIV_FREQ_ENABLE(0),
    .C_TXPROGDIV_FREQ_SOURCE(2),
    .C_TXPROGDIV_FREQ_VAL(125),
    .C_TX_BUFFBYPASS_MODE(0),
    .C_TX_BUFFER_BYPASS_INSTANCE_CTRL(0),
    .C_TX_BUFFER_MODE(1),
    .C_TX_DATA_ENCODING(1),
    .C_TX_ENABLE(1),
    .C_TX_INT_DATA_WIDTH(40),
    .C_TX_LINE_RATE(5),
    .C_TX_MASTER_CHANNEL_IDX(4),
    .C_TX_OUTCLK_BUFG_GT_DIV(1),
    .C_TX_OUTCLK_FREQUENCY(125.0000000),
    .C_TX_OUTCLK_SOURCE(1),
    .C_TX_PLL_TYPE(2),
    .C_TX_REFCLK_FREQUENCY(250),
    .C_TX_USER_CLOCKING_CONTENTS(0),
    .C_TX_USER_CLOCKING_INSTANCE_CTRL(0),
    .C_TX_USER_CLOCKING_RATIO_FSRC_FUSRCLK(1),
    .C_TX_USER_CLOCKING_RATIO_FUSRCLK_FUSRCLK2(1),
    .C_TX_USER_CLOCKING_SOURCE(0),
    .C_TX_USER_DATA_WIDTH(32),
    .C_TX_USRCLK_FREQUENCY(125.0000000),
    .C_TX_USRCLK2_FREQUENCY(125.0000000)
  ) inst (
    .gtwiz_userclk_tx_reset_in(gtwiz_userclk_tx_reset_in),
    .gtwiz_userclk_tx_active_in(gtwiz_userclk_tx_active_in),
    .gtwiz_userclk_tx_srcclk_out(),
    .gtwiz_userclk_tx_usrclk_out(),
    .gtwiz_userclk_tx_usrclk2_out(),
    .gtwiz_userclk_tx_active_out(),
    .gtwiz_userclk_rx_reset_in(gtwiz_userclk_rx_reset_in),
    .gtwiz_userclk_rx_active_in(gtwiz_userclk_rx_active_in),
    .gtwiz_userclk_rx_srcclk_out(),
    .gtwiz_userclk_rx_usrclk_out(),
    .gtwiz_userclk_rx_usrclk2_out(),
    .gtwiz_userclk_rx_active_out(),
    .gtwiz_buffbypass_tx_reset_in(1'B0),
    .gtwiz_buffbypass_tx_start_user_in(1'B0),
    .gtwiz_buffbypass_tx_done_out(),
    .gtwiz_buffbypass_tx_error_out(),
    .gtwiz_buffbypass_rx_reset_in(1'B0),
    .gtwiz_buffbypass_rx_start_user_in(1'B0),
    .gtwiz_buffbypass_rx_done_out(),
    .gtwiz_buffbypass_rx_error_out(),
    .gtwiz_reset_clk_freerun_in(1'B0),
    .gtwiz_reset_all_in(1'B0),
    .gtwiz_reset_tx_pll_and_datapath_in(1'B0),
    .gtwiz_reset_tx_datapath_in(1'B0),
    .gtwiz_reset_rx_pll_and_datapath_in(1'B0),
    .gtwiz_reset_rx_datapath_in(1'B0),
    .gtwiz_reset_tx_done_in(gtwiz_reset_tx_done_in),
    .gtwiz_reset_rx_done_in(gtwiz_reset_rx_done_in),
    .gtwiz_reset_qpll0lock_in(2'B0),
    .gtwiz_reset_qpll1lock_in(2'B0),
    .gtwiz_reset_rx_cdr_stable_out(),
    .gtwiz_reset_tx_done_out(),
    .gtwiz_reset_rx_done_out(),
    .gtwiz_reset_qpll0reset_out(),
    .gtwiz_reset_qpll1reset_out(),
    .gtwiz_gthe3_cpll_cal_txoutclk_period_in(144'B0),
    .gtwiz_gthe3_cpll_cal_cnt_tol_in(144'B0),
    .gtwiz_gthe3_cpll_cal_bufg_ce_in(8'B0),
    .gtwiz_gthe4_cpll_cal_txoutclk_period_in(gtwiz_gthe4_cpll_cal_txoutclk_period_in),
    .gtwiz_gthe4_cpll_cal_cnt_tol_in(gtwiz_gthe4_cpll_cal_cnt_tol_in),
    .gtwiz_gthe4_cpll_cal_bufg_ce_in(gtwiz_gthe4_cpll_cal_bufg_ce_in),
    .gtwiz_gtye4_cpll_cal_txoutclk_period_in(144'B0),
    .gtwiz_gtye4_cpll_cal_cnt_tol_in(144'B0),
    .gtwiz_gtye4_cpll_cal_bufg_ce_in(8'B0),
    .gtwiz_userdata_tx_in(256'B0),
    .gtwiz_userdata_rx_out(),
    .bgbypassb_in(2'H3),
    .bgmonitorenb_in(2'H3),
    .bgpdb_in(2'H3),
    .bgrcalovrd_in(10'H3FF),
    .bgrcalovrdenb_in(2'H3),
    .drpaddr_common_in(32'H00000000),
    .drpclk_common_in(2'H0),
    .drpdi_common_in(32'H00000000),
    .drpen_common_in(2'H0),
    .drpwe_common_in(2'H0),
    .gtgrefclk0_in(2'H0),
    .gtgrefclk1_in(2'H0),
    .gtnorthrefclk00_in(2'H0),
    .gtnorthrefclk01_in(2'H0),
    .gtnorthrefclk10_in(2'H0),
    .gtnorthrefclk11_in(2'H0),
    .gtrefclk00_in(2'H0),
    .gtrefclk01_in(2'H0),
    .gtrefclk10_in(2'H0),
    .gtrefclk11_in(2'H0),
    .gtsouthrefclk00_in(2'H0),
    .gtsouthrefclk01_in(2'H0),
    .gtsouthrefclk10_in(2'H0),
    .gtsouthrefclk11_in(2'H0),
    .pcierateqpll0_in(6'H00),
    .pcierateqpll1_in(6'H00),
    .pmarsvd0_in(16'H0000),
    .pmarsvd1_in(16'H0000),
    .qpll0clkrsvd0_in(2'H0),
    .qpll0clkrsvd1_in(2'H0),
    .qpll0fbdiv_in(16'H0000),
    .qpll0lockdetclk_in(2'H0),
    .qpll0locken_in(2'H3),
    .qpll0pd_in(2'H0),
    .qpll0refclksel_in(6'H09),
    .qpll0reset_in(2'H0),
    .qpll1clkrsvd0_in(2'H0),
    .qpll1clkrsvd1_in(2'H0),
    .qpll1fbdiv_in(16'H0000),
    .qpll1lockdetclk_in(2'H0),
    .qpll1locken_in(2'H3),
    .qpll1pd_in(2'H0),
    .qpll1refclksel_in(6'H09),
    .qpll1reset_in(2'H0),
    .qpllrsvd1_in(16'H0000),
    .qpllrsvd2_in(10'H000),
    .qpllrsvd3_in(10'H000),
    .qpllrsvd4_in(16'H0000),
    .rcalenb_in(2'H3),
    .sdm0data_in(50'H0000000000000),
    .sdm0reset_in(2'H0),
    .sdm0toggle_in(2'H0),
    .sdm0width_in(4'H0),
    .sdm1data_in(50'H0000000000000),
    .sdm1reset_in(2'H0),
    .sdm1toggle_in(2'H0),
    .sdm1width_in(4'H0),
    .tcongpi_in(20'H00000),
    .tconpowerup_in(2'H0),
    .tconreset_in(4'H0),
    .tconrsvdin1_in(4'H0),
    .ubcfgstreamen_in(1'B0),
    .ubdo_in(1'B0),
    .ubdrdy_in(1'B0),
    .ubenable_in(1'B0),
    .ubgpi_in(1'B0),
    .ubintr_in(1'B0),
    .ubiolmbrst_in(1'B0),
    .ubmbrst_in(1'B0),
    .ubmdmcapture_in(1'B0),
    .ubmdmdbgrst_in(1'B0),
    .ubmdmdbgupdate_in(1'B0),
    .ubmdmregen_in(1'B0),
    .ubmdmshift_in(1'B0),
    .ubmdmsysrst_in(1'B0),
    .ubmdmtck_in(1'B0),
    .ubmdmtdi_in(1'B0),
    .drpdo_common_out(),
    .drprdy_common_out(),
    .pmarsvdout0_out(),
    .pmarsvdout1_out(),
    .qpll0fbclklost_out(),
    .qpll0lock_out(),
    .qpll0outclk_out(),
    .qpll0outrefclk_out(),
    .qpll0refclklost_out(),
    .qpll1fbclklost_out(),
    .qpll1lock_out(),
    .qpll1outclk_out(),
    .qpll1outrefclk_out(),
    .qpll1refclklost_out(),
    .qplldmonitor0_out(),
    .qplldmonitor1_out(),
    .refclkoutmonitor0_out(),
    .refclkoutmonitor1_out(),
    .rxrecclk0_sel_out(),
    .rxrecclk1_sel_out(),
    .rxrecclk0sel_out(),
    .rxrecclk1sel_out(),
    .sdm0finalout_out(),
    .sdm0testdata_out(),
    .sdm1finalout_out(),
    .sdm1testdata_out(),
    .tcongpo_out(),
    .tconrsvdout0_out(),
    .ubdaddr_out(),
    .ubden_out(),
    .ubdi_out(),
    .ubdwe_out(),
    .ubmdmtdo_out(),
    .ubrsvdout_out(),
    .ubtxuart_out(),
    .cdrstepdir_in(8'H00),
    .cdrstepsq_in(8'H00),
    .cdrstepsx_in(8'H00),
    .cfgreset_in(8'H00),
    .clkrsvd0_in(8'H00),
    .clkrsvd1_in(8'H00),
    .cpllfreqlock_in(8'H00),
    .cplllockdetclk_in(8'H00),
    .cplllocken_in(8'HFF),
    .cpllpd_in(cpllpd_in),
    .cpllrefclksel_in(24'H249249),
    .cpllreset_in(cpllreset_in),
    .dmonfiforeset_in(8'H00),
    .dmonitorclk_in(dmonitorclk_in),
    .drpaddr_in(drpaddr_in),
    .drpclk_in(drpclk_in),
    .drpdi_in(drpdi_in),
    .drpen_in(drpen_in),
    .drprst_in(8'H00),
    .drpwe_in(drpwe_in),
    .elpcaldvorwren_in(1'B0),
    .elpcalpaorwren_in(1'B0),
    .evoddphicaldone_in(1'B0),
    .evoddphicalstart_in(1'B0),
    .evoddphidrden_in(1'B0),
    .evoddphidwren_in(1'B0),
    .evoddphixrden_in(1'B0),
    .evoddphixwren_in(1'B0),
    .eyescanmode_in(1'B0),
    .eyescanreset_in(eyescanreset_in),
    .eyescantrigger_in(eyescantrigger_in),
    .freqos_in(8'H00),
    .gtgrefclk_in(8'H00),
    .gthrxn_in(gthrxn_in),
    .gthrxp_in(gthrxp_in),
    .gtnorthrefclk0_in(8'H00),
    .gtnorthrefclk1_in(8'H00),
    .gtrefclk0_in(gtrefclk0_in),
    .gtrefclk1_in(8'H00),
    .gtresetsel_in(1'B0),
    .gtrsvd_in(128'H00000000000000000000000000000000),
    .gtrxreset_in(gtrxreset_in),
    .gtrxresetsel_in(8'H00),
    .gtsouthrefclk0_in(8'H00),
    .gtsouthrefclk1_in(8'H00),
    .gttxreset_in(gttxreset_in),
    .gttxresetsel_in(8'H00),
    .incpctrl_in(8'H00),
    .gtyrxn_in(1'B0),
    .gtyrxp_in(1'B0),
    .loopback_in(loopback_in),
    .looprsvd_in(1'B0),
    .lpbkrxtxseren_in(1'B0),
    .lpbktxrxseren_in(1'B0),
    .pcieeqrxeqadaptdone_in(8'H00),
    .pcierstidle_in(8'H00),
    .pciersttxsyncstart_in(8'H00),
    .pcieuserratedone_in(8'H00),
    .pcsrsvdin_in(pcsrsvdin_in),
    .pcsrsvdin2_in(1'B0),
    .pmarsvdin_in(1'B0),
    .qpll0clk_in(qpll0clk_in),
    .qpll0freqlock_in(8'H00),
    .qpll0refclk_in(qpll0refclk_in),
    .qpll1clk_in(qpll1clk_in),
    .qpll1freqlock_in(8'H00),
    .qpll1refclk_in(qpll1refclk_in),
    .resetovrd_in(8'H00),
    .rstclkentx_in(1'B0),
    .rx8b10ben_in(rx8b10ben_in),
    .rxafecfoken_in(8'HFF),
    .rxbufreset_in(rxbufreset_in),
    .rxcdrfreqreset_in(8'H00),
    .rxcdrhold_in(rxcdrhold_in),
    .rxcdrovrden_in(8'H00),
    .rxcdrreset_in(8'H00),
    .rxcdrresetrsv_in(1'B0),
    .rxchbonden_in(8'H00),
    .rxchbondi_in(40'H0000000000),
    .rxchbondlevel_in(24'H000000),
    .rxchbondmaster_in(8'H00),
    .rxchbondslave_in(8'H00),
    .rxckcalreset_in(8'H00),
    .rxckcalstart_in(56'H00000000000000),
    .rxcommadeten_in(rxcommadeten_in),
    .rxdfeagcctrl_in(16'H5555),
    .rxdccforcestart_in(1'B0),
    .rxdfeagchold_in(rxdfeagchold_in),
    .rxdfeagcovrden_in(8'H00),
    .rxdfecfokfcnum_in(32'HDDDDDDDD),
    .rxdfecfokfen_in(8'H00),
    .rxdfecfokfpulse_in(8'H00),
    .rxdfecfokhold_in(8'H00),
    .rxdfecfokovren_in(8'H00),
    .rxdfekhhold_in(8'H00),
    .rxdfekhovrden_in(8'H00),
    .rxdfelfhold_in(rxdfelfhold_in),
    .rxdfelfovrden_in(8'H00),
    .rxdfelpmreset_in(rxdfelpmreset_in),
    .rxdfetap10hold_in(rxdfetap10hold_in),
    .rxdfetap10ovrden_in(8'H00),
    .rxdfetap11hold_in(rxdfetap11hold_in),
    .rxdfetap11ovrden_in(8'H00),
    .rxdfetap12hold_in(rxdfetap12hold_in),
    .rxdfetap12ovrden_in(8'H00),
    .rxdfetap13hold_in(rxdfetap13hold_in),
    .rxdfetap13ovrden_in(8'H00),
    .rxdfetap14hold_in(rxdfetap14hold_in),
    .rxdfetap14ovrden_in(8'H00),
    .rxdfetap15hold_in(rxdfetap15hold_in),
    .rxdfetap15ovrden_in(8'H00),
    .rxdfetap2hold_in(rxdfetap2hold_in),
    .rxdfetap2ovrden_in(8'H00),
    .rxdfetap3hold_in(rxdfetap3hold_in),
    .rxdfetap3ovrden_in(8'H00),
    .rxdfetap4hold_in(rxdfetap4hold_in),
    .rxdfetap4ovrden_in(8'H00),
    .rxdfetap5hold_in(rxdfetap5hold_in),
    .rxdfetap5ovrden_in(8'H00),
    .rxdfetap6hold_in(rxdfetap6hold_in),
    .rxdfetap6ovrden_in(8'H00),
    .rxdfetap7hold_in(rxdfetap7hold_in),
    .rxdfetap7ovrden_in(8'H00),
    .rxdfetap8hold_in(rxdfetap8hold_in),
    .rxdfetap8ovrden_in(8'H00),
    .rxdfetap9hold_in(rxdfetap9hold_in),
    .rxdfetap9ovrden_in(8'H00),
    .rxdfeuthold_in(rxdfeuthold_in),
    .rxdfeutovrden_in(8'H00),
    .rxdfevphold_in(rxdfevphold_in),
    .rxdfevpovrden_in(8'H00),
    .rxdfevsen_in(1'B0),
    .rxdfexyden_in(8'HFF),
    .rxdlybypass_in(8'HFF),
    .rxdlyen_in(8'H00),
    .rxdlyovrden_in(8'H00),
    .rxdlysreset_in(8'H00),
    .rxelecidlemode_in(16'HFFFF),
    .rxeqtraining_in(8'H00),
    .rxgearboxslip_in(8'H00),
    .rxlatclk_in(8'H00),
    .rxlpmen_in(rxlpmen_in),
    .rxlpmgchold_in(8'H00),
    .rxlpmgcovrden_in(8'H00),
    .rxlpmhfhold_in(8'H00),
    .rxlpmhfovrden_in(8'H00),
    .rxlpmlfhold_in(8'H00),
    .rxlpmlfklovrden_in(8'H00),
    .rxlpmoshold_in(8'H00),
    .rxlpmosovrden_in(8'H00),
    .rxmcommaalignen_in(rxmcommaalignen_in),
    .rxmonitorsel_in(16'H0000),
    .rxoobreset_in(8'H00),
    .rxoscalreset_in(8'H00),
    .rxoshold_in(rxoshold_in),
    .rxosintcfg_in(1'B0),
    .rxosinten_in(1'B0),
    .rxosinthold_in(1'B0),
    .rxosintovrden_in(1'B0),
    .rxosintstrobe_in(1'B0),
    .rxosinttestovrden_in(1'B0),
    .rxosovrden_in(8'H00),
    .rxoutclksel_in(24'H492492),
    .rxpcommaalignen_in(rxpcommaalignen_in),
    .rxpcsreset_in(rxpcsreset_in),
    .rxpd_in(rxpd_in),
    .rxphalign_in(8'H00),
    .rxphalignen_in(8'H00),
    .rxphdlypd_in(8'HFF),
    .rxphdlyreset_in(8'H00),
    .rxphovrden_in(8'H00),
    .rxpllclksel_in(rxpllclksel_in),
    .rxpmareset_in(rxpmareset_in),
    .rxpolarity_in(rxpolarity_in),
    .rxprbscntreset_in(rxprbscntreset_in),
    .rxprbssel_in(rxprbssel_in),
    .rxprogdivreset_in(rxprogdivreset_in),
    .rxqpien_in(8'H00),
    .rxrate_in(rxrate_in),
    .rxratemode_in(8'H00),
    .rxslide_in(8'H00),
    .rxslipoutclk_in(8'H00),
    .rxslippma_in(8'H00),
    .rxsyncallin_in(8'H00),
    .rxsyncin_in(8'H00),
    .rxsyncmode_in(8'H00),
    .rxsysclksel_in(rxsysclksel_in),
    .rxtermination_in(8'H00),
    .rxuserrdy_in(rxuserrdy_in),
    .rxusrclk_in(rxusrclk_in),
    .rxusrclk2_in(rxusrclk2_in),
    .sigvalidclk_in(8'H00),
    .tstin_in(160'H0000000000000000000000000000000000000000),
    .tx8b10bbypass_in(64'H0000000000000000),
    .tx8b10ben_in(tx8b10ben_in),
    .txbufdiffctrl_in(1'B0),
    .txcominit_in(8'H00),
    .txcomsas_in(8'H00),
    .txcomwake_in(8'H00),
    .txctrl0_in(txctrl0_in),
    .txctrl1_in(txctrl1_in),
    .txctrl2_in(txctrl2_in),
    .txdata_in(txdata_in),
    .txdataextendrsvd_in(64'H0000000000000000),
    .txdccforcestart_in(8'H00),
    .txdccreset_in(8'H00),
    .txdeemph_in(16'H00),
    .txdetectrx_in(8'H00),
    .txdiffctrl_in(txdiffctrl_in),
    .txdiffpd_in(1'B0),
    .txdlybypass_in(8'HFF),
    .txdlyen_in(8'H00),
    .txdlyhold_in(8'H00),
    .txdlyovrden_in(8'H00),
    .txdlysreset_in(8'H00),
    .txdlyupdown_in(8'H00),
    .txelecidle_in(8'H00),
    .txelforcestart_in(1'B0),
    .txheader_in(48'H000000000000),
    .txinhibit_in(txinhibit_in),
    .txlatclk_in(8'H00),
    .txlfpstreset_in(8'H00),
    .txlfpsu2lpexit_in(8'H00),
    .txlfpsu3wake_in(8'H00),
    .txmaincursor_in(56'H00000000000000),
    .txmargin_in(24'H000000),
    .txmuxdcdexhold_in(8'H00),
    .txmuxdcdorwren_in(8'H00),
    .txoneszeros_in(8'H00),
    .txoutclksel_in(24'H492492),
    .txpcsreset_in(txpcsreset_in),
    .txpd_in(txpd_in),
    .txpdelecidlemode_in(8'H00),
    .txphalign_in(8'H00),
    .txphalignen_in(8'H00),
    .txphdlypd_in(8'HFF),
    .txphdlyreset_in(8'H00),
    .txphdlytstclk_in(8'H00),
    .txphinit_in(8'H00),
    .txphovrden_in(8'H00),
    .txpippmen_in(8'H00),
    .txpippmovrden_in(8'H00),
    .txpippmpd_in(8'H00),
    .txpippmsel_in(8'H00),
    .txpippmstepsize_in(40'H0000000000),
    .txpisopd_in(8'H00),
    .txpllclksel_in(txpllclksel_in),
    .txpmareset_in(txpmareset_in),
    .txpolarity_in(txpolarity_in),
    .txpostcursor_in(txpostcursor_in),
    .txpostcursorinv_in(1'B0),
    .txprbsforceerr_in(txprbsforceerr_in),
    .txprbssel_in(txprbssel_in),
    .txprecursor_in(txprecursor_in),
    .txprecursorinv_in(1'B0),
    .txprogdivreset_in(txprogdivreset_in),
    .txqpibiasen_in(8'H00),
    .txqpistrongpdown_in(1'B0),
    .txqpiweakpup_in(8'H00),
    .txrate_in(24'H000000),
    .txratemode_in(8'H00),
    .txsequence_in(56'H00000000000000),
    .txswing_in(8'H00),
    .txsyncallin_in(8'H00),
    .txsyncin_in(8'H00),
    .txsyncmode_in(8'H00),
    .txsysclksel_in(txsysclksel_in),
    .txuserrdy_in(txuserrdy_in),
    .txusrclk_in(txusrclk_in),
    .txusrclk2_in(txusrclk2_in),
    .bufgtce_out(),
    .bufgtcemask_out(),
    .bufgtdiv_out(),
    .bufgtreset_out(),
    .bufgtrstmask_out(),
    .cpllfbclklost_out(),
    .cplllock_out(cplllock_out),
    .cpllrefclklost_out(),
    .dmonitorout_out(dmonitorout_out),
    .dmonitoroutclk_out(),
    .drpdo_out(drpdo_out),
    .drprdy_out(drprdy_out),
    .eyescandataerror_out(eyescandataerror_out),
    .gthtxn_out(gthtxn_out),
    .gthtxp_out(gthtxp_out),
    .gtpowergood_out(gtpowergood_out),
    .gtrefclkmonitor_out(),
    .gtytxn_out(),
    .gtytxp_out(),
    .pcierategen3_out(),
    .pcierateidle_out(),
    .pcierateqpllpd_out(),
    .pcierateqpllreset_out(),
    .pciesynctxsyncdone_out(),
    .pcieusergen3rdy_out(),
    .pcieuserphystatusrst_out(),
    .pcieuserratestart_out(),
    .pcsrsvdout_out(),
    .phystatus_out(),
    .pinrsrvdas_out(),
    .powerpresent_out(),
    .resetexception_out(),
    .rxbufstatus_out(rxbufstatus_out),
    .rxbyteisaligned_out(rxbyteisaligned_out),
    .rxbyterealign_out(rxbyterealign_out),
    .rxcdrlock_out(rxcdrlock_out),
    .rxcdrphdone_out(),
    .rxchanbondseq_out(),
    .rxchanisaligned_out(),
    .rxchanrealign_out(),
    .rxchbondo_out(),
    .rxckcaldone_out(),
    .rxclkcorcnt_out(),
    .rxcominitdet_out(),
    .rxcommadet_out(rxcommadet_out),
    .rxcomsasdet_out(),
    .rxcomwakedet_out(),
    .rxctrl0_out(rxctrl0_out),
    .rxctrl1_out(rxctrl1_out),
    .rxctrl2_out(rxctrl2_out),
    .rxctrl3_out(rxctrl3_out),
    .rxdata_out(rxdata_out),
    .rxdataextendrsvd_out(),
    .rxdatavalid_out(),
    .rxdlysresetdone_out(),
    .rxelecidle_out(),
    .rxheader_out(),
    .rxheadervalid_out(),
    .rxlfpstresetdet_out(),
    .rxlfpsu2lpexitdet_out(),
    .rxlfpsu3wakedet_out(),
    .rxmonitorout_out(),
    .rxosintdone_out(),
    .rxosintstarted_out(),
    .rxosintstrobedone_out(),
    .rxosintstrobestarted_out(),
    .rxoutclk_out(rxoutclk_out),
    .rxoutclkfabric_out(),
    .rxoutclkpcs_out(),
    .rxphaligndone_out(),
    .rxphalignerr_out(),
    .rxpmaresetdone_out(rxpmaresetdone_out),
    .rxprbserr_out(rxprbserr_out),
    .rxprbslocked_out(),
    .rxprgdivresetdone_out(),
    .rxqpisenn_out(),
    .rxqpisenp_out(),
    .rxratedone_out(),
    .rxrecclkout_out(),
    .rxresetdone_out(rxresetdone_out),
    .rxsliderdy_out(),
    .rxslipdone_out(),
    .rxslipoutclkrdy_out(),
    .rxslippmardy_out(),
    .rxstartofseq_out(),
    .rxstatus_out(),
    .rxsyncdone_out(),
    .rxsyncout_out(),
    .rxvalid_out(),
    .txbufstatus_out(txbufstatus_out),
    .txcomfinish_out(),
    .txdccdone_out(),
    .txdlysresetdone_out(),
    .txoutclk_out(txoutclk_out),
    .txoutclkfabric_out(),
    .txoutclkpcs_out(),
    .txphaligndone_out(),
    .txphinitdone_out(),
    .txpmaresetdone_out(txpmaresetdone_out),
    .txprgdivresetdone_out(),
    .txqpisenn_out(),
    .txqpisenp_out(),
    .txratedone_out(),
    .txresetdone_out(txresetdone_out),
    .txsyncdone_out(),
    .txsyncout_out()
  );
endmodule
