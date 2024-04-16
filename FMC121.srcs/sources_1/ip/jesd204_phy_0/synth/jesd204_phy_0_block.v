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


`timescale 1ns / 1ps
`define DLY #1

//***********************************Entity Declaration************************
(* DowngradeIPIdentifiedWarnings="yes" *)
module jesd204_phy_0_block (
  // System Reset Inputs for each direction
  input               tx_sys_reset,
  input               rx_sys_reset,

  // Reset Inputs for each direction
  input               tx_reset_gt,
  input               rx_reset_gt,

  // Reset Done for each direction
  output              tx_reset_done,
  output              rx_reset_done,

  output              gt_powergood,

  // Reset Done for each GT Channel
  output     [7:0]    gt_txresetdone,
  output     [7:0]    gt_rxresetdone,

  input               cpll_refclk,
  
  output              qpll0_reset_out,

  // GT Common I/O
  input               common0_qpll0_lock_in,
  input               common0_qpll0_refclk_in,
  input               common0_qpll0_clk_in,
  input               common1_qpll0_lock_in,
  input               common1_qpll0_refclk_in,
  input               common1_qpll0_clk_in,

  input               rxencommaalign,
  // Clocks
  input               tx_core_clk,
  output              txoutclk,

  input               rx_core_clk,
  output              rxoutclk,

  input               drpclk,

  // CPLL Lock
  output     [7:0]    gt_cplllock,

  // Loopback
  input      [23:0]    gt_loopback,

  // Power Down Ports
  input      [15:0]    gt_rxpd,
  input      [15:0]    gt_txpd,

  // Transmit Control
  input      [39:0]    gt_txpostcursor,
  input      [39:0]    gt_txprecursor,
  input      [39:0]    gt_txdiffctrl,

  input      [7:0]     gt_txpolarity,
  input      [7:0]     gt_rxpolarity,

  input      [127: 0]  gt_pcsrsvdin,

  input      [7:0]     gt_txinhibit,

  // DRP Ports
  input  [9:0]        gt0_drpaddr,
  input  [15:0]       gt0_drpdi,
  input               gt0_drpen,
  input               gt0_drpwe,
  output [15:0]       gt0_drpdo,
  output              gt0_drprdy,

  input  [9:0]        gt1_drpaddr,
  input  [15:0]       gt1_drpdi,
  input               gt1_drpen,
  input               gt1_drpwe,
  output [15:0]       gt1_drpdo,
  output              gt1_drprdy,

  input  [9:0]        gt2_drpaddr,
  input  [15:0]       gt2_drpdi,
  input               gt2_drpen,
  input               gt2_drpwe,
  output [15:0]       gt2_drpdo,
  output              gt2_drprdy,

  input  [9:0]        gt3_drpaddr,
  input  [15:0]       gt3_drpdi,
  input               gt3_drpen,
  input               gt3_drpwe,
  output [15:0]       gt3_drpdo,
  output              gt3_drprdy,

  input  [9:0]        gt4_drpaddr,
  input  [15:0]       gt4_drpdi,
  input               gt4_drpen,
  input               gt4_drpwe,
  output [15:0]       gt4_drpdo,
  output              gt4_drprdy,

  input  [9:0]        gt5_drpaddr,
  input  [15:0]       gt5_drpdi,
  input               gt5_drpen,
  input               gt5_drpwe,
  output [15:0]       gt5_drpdo,
  output              gt5_drprdy,

  input  [9:0]        gt6_drpaddr,
  input  [15:0]       gt6_drpdi,
  input               gt6_drpen,
  input               gt6_drpwe,
  output [15:0]       gt6_drpdo,
  output              gt6_drprdy,

  input  [9:0]        gt7_drpaddr,
  input  [15:0]       gt7_drpdi,
  input               gt7_drpen,
  input               gt7_drpwe,
  output [15:0]       gt7_drpdo,
  output              gt7_drprdy,

  // Pattern Checker ports
  input  [3:0]        gt_prbssel,
  input      [7:0]    gt_txprbsforceerr,

  input      [31:0]    gt_rxprbssel,
  input      [7:0]    gt_rxprbscntreset,
  output     [7:0]    gt_rxprbserr,

  // TX Reset and Initialization
  input      [7:0]     gt_txpmareset,
  input      [7:0]     gt_txpcsreset,

  // RX Reset and Initialization
  input      [7:0]     gt_rxpmareset,
  input      [7:0]     gt_rxpcsreset,
  input      [7:0]     gt_rxbufreset,
  output     [7:0]     gt_rxpmaresetdone,

  // TX Buffer Ports
  output     [15:0]    gt_txbufstatus,

  // RX Buffer Ports
  output     [23:0]    gt_rxbufstatus,

  // PCI Express Ports
  input      [23:0]    gt_rxrate,

  // RX Margin Analysis Ports
  input      [7:0]     gt_eyescantrigger,
  input      [7:0]     gt_eyescanreset,
  output     [7:0]     gt_eyescandataerror,

  // RX Equalizer Ports
  input      [7:0]     gt_rxdfelpmreset,
  input      [7:0]     gt_rxlpmen,

  // RX CDR Ports
  input      [7:0]     gt_rxcdrhold,

  // RX Digital Monitor Ports
  input      [7 :0]    gt_dmonitorclk,
  output     [127:0]   gt_dmonitorout,

  // RX Byte and Word Alignment Ports
  output      [7:0]    gt_rxcommadet,

  // Tx Ports
  // Lane 0
  input     [3:0]     gt0_txcharisk,
  input    [31:0]     gt0_txdata,
  // Lane 1
  input     [3:0]     gt1_txcharisk,
  input    [31:0]     gt1_txdata,
  // Lane 2
  input     [3:0]     gt2_txcharisk,
  input    [31:0]     gt2_txdata,
  // Lane 3
  input     [3:0]     gt3_txcharisk,
  input    [31:0]     gt3_txdata,
  // Lane 4
  input     [3:0]     gt4_txcharisk,
  input    [31:0]     gt4_txdata,
  // Lane 5
  input     [3:0]     gt5_txcharisk,
  input    [31:0]     gt5_txdata,
  // Lane 6
  input     [3:0]     gt6_txcharisk,
  input    [31:0]     gt6_txdata,
  // Lane 7
  input     [3:0]     gt7_txcharisk,
  input    [31:0]     gt7_txdata,
  // Rx Ports
  // Lane 0
  output    [3:0]     gt0_rxcharisk,
  output    [3:0]     gt0_rxdisperr,
  output    [3:0]     gt0_rxnotintable,  
  output   [31:0]     gt0_rxdata,
  // Lane 1
  output    [3:0]     gt1_rxcharisk,
  output    [3:0]     gt1_rxdisperr,
  output    [3:0]     gt1_rxnotintable,  
  output   [31:0]     gt1_rxdata,
  // Lane 2
  output    [3:0]     gt2_rxcharisk,
  output    [3:0]     gt2_rxdisperr,
  output    [3:0]     gt2_rxnotintable,  
  output   [31:0]     gt2_rxdata,
  // Lane 3
  output    [3:0]     gt3_rxcharisk,
  output    [3:0]     gt3_rxdisperr,
  output    [3:0]     gt3_rxnotintable,  
  output   [31:0]     gt3_rxdata,
  // Lane 4
  output    [3:0]     gt4_rxcharisk,
  output    [3:0]     gt4_rxdisperr,
  output    [3:0]     gt4_rxnotintable,  
  output   [31:0]     gt4_rxdata,
  // Lane 5
  output    [3:0]     gt5_rxcharisk,
  output    [3:0]     gt5_rxdisperr,
  output    [3:0]     gt5_rxnotintable,  
  output   [31:0]     gt5_rxdata,
  // Lane 6
  output    [3:0]     gt6_rxcharisk,
  output    [3:0]     gt6_rxdisperr,
  output    [3:0]     gt6_rxnotintable,  
  output   [31:0]     gt6_rxdata,
  // Lane 7
  output    [3:0]     gt7_rxcharisk,
  output    [3:0]     gt7_rxdisperr,
  output    [3:0]     gt7_rxnotintable,  
  output   [31:0]     gt7_rxdata,
  // Serial ports
  input     [7:0]   rxn_in,
  input     [7:0]   rxp_in,
  output    [7:0]   txn_out,
  output    [7:0]   txp_out
);

  //pll_sel = 0: CPLL is in use
  //pll_sel = 1: QPLL0 is in use
  //pll_sel = 2: QPLL1 is in use
  localparam tx_pll_sel = 0;
  localparam rx_pll_sel = 1;

//************************** Register Declarations ****************************
  wire            gtpowergood_i;
  reg             txresetdone_i2;
  reg             rxresetdone_i2;
  wire            gt_txresetdone_sync;
  wire            gt_rxresetdone_sync;
  wire            txresetdone_sync;
  wire            rxresetdone_sync;

  wire            tx_rst_all;
  wire            rx_rst_all;
  wire            tx_rst_data;
  wire            rx_rst_data;
  wire            txreset_good;     // Datapath only reset
  wire            rxreset_good;
  wire            txreset_good_all; // PLL & data path resets
  wire            rxreset_good_all;
  wire            gtwiz_userclk_tx_reset_int;
  wire            gtwiz_userclk_rx_reset_int;
  wire            gtwiz_userclk_tx_active_sync;
  wire            gtwiz_userclk_tx_active_out;
  wire            gtwiz_userclk_rx_active_sync;
  wire            gtwiz_userclk_rx_active_out;

  wire   [17 : 0] cpll_cal_cnt_per;
  wire   [17 : 0] cpll_cal_cnt_tol;
  //----------------------------- Global Signals -----------------------------
  reg             tx_pll_lock;
  wire            tx_pll_lock_i;
  reg             rx_pll_lock;
  wire            rx_pll_lock_i;

  wire            tx_sys_reset_sync;
  wire            rx_sys_reset_sync;

  // GT Reset block signals
  wire            rxcdrlock_in;
  wire            pllreset_tx_out;
  wire            txprogdivreset_out;
  wire            gttxreset_out;
  wire            txuserrdy_out;
  wire            pllreset_rx_out;
  wire            rxprogdivreset_out;
  wire            gtrxreset_out;
  wire            rxuserrdy_out;
  wire  [1:0]     rxsysclksel_i;
  wire  [1:0]     txsysclksel_i;
  wire  [1:0]     rxpllclksel_i;
  wire  [1:0]     txpllclksel_i;
  wire            tx_reset_gt_sync;
  wire            rx_reset_gt_sync;
  // Register resetdone straight from transceiver. This is a non critical path and
  // net delays on 8-12 designs can become critical
  reg   [7:0]     rxresetdone_r;
  reg   [7:0]     txresetdone_r;



  wire  [7:0]     gt_rxoshold       = 8'b0; 
  wire  [7:0]     gt_rxdfeagchold   = 8'b0;
  wire  [7:0]     gt_rxdfelfhold    = 8'b0;
  wire  [7:0]     gt_rxdfeuthold    = 8'b0;
  wire  [7:0]     gt_rxdfevphold    = 8'b0;
  wire  [7:0]     gt_rxdfetap2hold  = 8'b0;
  wire  [7:0]     gt_rxdfetap3hold  = 8'b0;
  wire  [7:0]     gt_rxdfetap4hold  = 8'b0;
  wire  [7:0]     gt_rxdfetap5hold  = 8'b0;
  wire  [7:0]     gt_rxdfetap6hold  = 8'b0;
  wire  [7:0]     gt_rxdfetap7hold  = 8'b0;
  wire  [7:0]     gt_rxdfetap8hold  = 8'b0;
  wire  [7:0]     gt_rxdfetap9hold  = 8'b0;
  wire  [7:0]     gt_rxdfetap10hold = 8'b0;
  wire  [7:0]     gt_rxdfetap11hold = 8'b0;
  wire  [7:0]     gt_rxdfetap12hold = 8'b0;
  wire  [7:0]     gt_rxdfetap13hold = 8'b0;
  wire  [7:0]     gt_rxdfetap14hold = 8'b0;
  wire  [7:0]     gt_rxdfetap15hold = 8'b0;


  //Wire declaration for GTHE3
    wire [7 : 0] cplllock_out;
  wire [7 : 0] cpllpd_in;
  wire [7 : 0] cpllreset_in;
  wire [7 : 0] dmonitorclk_in;
  wire [127 : 0] dmonitorout_out;
  wire [79 : 0] drpaddr_in;
  wire [7 : 0] drpclk_in;
  wire [127 : 0] drpdi_in;
  wire [127 : 0] drpdo_out;
  wire [7 : 0] drpen_in;
  wire [7 : 0] drprdy_out;
  wire [7 : 0] drpwe_in;
  wire [7 : 0] eyescandataerror_out;
  wire [7 : 0] eyescanreset_in;
  wire [7 : 0] eyescantrigger_in;
  wire [7 : 0] gthrxn_in;
  wire [7 : 0] gthrxp_in;
  wire [7 : 0] gthtxn_out;
  wire [7 : 0] gthtxp_out;
  wire [7 : 0] gtpowergood_out;
  wire [7 : 0] gtrefclk0_in;
  wire [7 : 0] gtrxreset_in;
  wire [7 : 0] gttxreset_in;
  wire [7 : 0] gtwiz_gthe4_cpll_cal_bufg_ce_in;
  wire [143 : 0] gtwiz_gthe4_cpll_cal_cnt_tol_in;
  wire [143 : 0] gtwiz_gthe4_cpll_cal_txoutclk_period_in;
  wire [0 : 0] gtwiz_reset_rx_done_in;
  wire [0 : 0] gtwiz_reset_tx_done_in;
  wire [0 : 0] gtwiz_userclk_rx_active_in;
  wire [0 : 0] gtwiz_userclk_rx_reset_in;
  wire [0 : 0] gtwiz_userclk_tx_active_in;
  wire [0 : 0] gtwiz_userclk_tx_reset_in;
  wire [23 : 0] loopback_in;
  wire [127 : 0] pcsrsvdin_in;
  wire [7 : 0] qpll0clk_in;
  wire [7 : 0] qpll0refclk_in;
  wire [7 : 0] qpll1clk_in;
  wire [7 : 0] qpll1refclk_in;
  wire [7 : 0] rx8b10ben_in;
  wire [7 : 0] rxbufreset_in;
  wire [23 : 0] rxbufstatus_out;
  wire [7 : 0] rxbyteisaligned_out;
  wire [7 : 0] rxbyterealign_out;
  wire [7 : 0] rxcdrhold_in;
  wire [7 : 0] rxcdrlock_out;
  wire [7 : 0] rxcommadet_out;
  wire [7 : 0] rxcommadeten_in;
  wire [127 : 0] rxctrl0_out;
  wire [127 : 0] rxctrl1_out;
  wire [63 : 0] rxctrl2_out;
  wire [63 : 0] rxctrl3_out;
  wire [1023 : 0] rxdata_out;
  wire [7 : 0] rxdfeagchold_in;
  wire [7 : 0] rxdfelfhold_in;
  wire [7 : 0] rxdfelpmreset_in;
  wire [7 : 0] rxdfetap10hold_in;
  wire [7 : 0] rxdfetap11hold_in;
  wire [7 : 0] rxdfetap12hold_in;
  wire [7 : 0] rxdfetap13hold_in;
  wire [7 : 0] rxdfetap14hold_in;
  wire [7 : 0] rxdfetap15hold_in;
  wire [7 : 0] rxdfetap2hold_in;
  wire [7 : 0] rxdfetap3hold_in;
  wire [7 : 0] rxdfetap4hold_in;
  wire [7 : 0] rxdfetap5hold_in;
  wire [7 : 0] rxdfetap6hold_in;
  wire [7 : 0] rxdfetap7hold_in;
  wire [7 : 0] rxdfetap8hold_in;
  wire [7 : 0] rxdfetap9hold_in;
  wire [7 : 0] rxdfeuthold_in;
  wire [7 : 0] rxdfevphold_in;
  wire [7 : 0] rxlpmen_in;
  wire [7 : 0] rxmcommaalignen_in;
  wire [7 : 0] rxoshold_in;
  wire [7 : 0] rxoutclk_out;
  wire [7 : 0] rxpcommaalignen_in;
  wire [7 : 0] rxpcsreset_in;
  wire [15 : 0] rxpd_in;
  wire [15 : 0] rxpllclksel_in;
  wire [7 : 0] rxpmareset_in;
  wire [7 : 0] rxpmaresetdone_out;
  wire [7 : 0] rxpolarity_in;
  wire [7 : 0] rxprbscntreset_in;
  wire [7 : 0] rxprbserr_out;
  wire [31 : 0] rxprbssel_in;
  wire [7 : 0] rxprogdivreset_in;
  wire [23 : 0] rxrate_in;
  wire [7 : 0] rxresetdone_out;
  wire [15 : 0] rxsysclksel_in;
  wire [7 : 0] rxuserrdy_in;
  wire [7 : 0] rxusrclk2_in;
  wire [7 : 0] rxusrclk_in;
  wire [7 : 0] tx8b10ben_in;
  wire [15 : 0] txbufstatus_out;
  wire [127 : 0] txctrl0_in;
  wire [127 : 0] txctrl1_in;
  wire [63 : 0] txctrl2_in;
  wire [1023 : 0] txdata_in;
  wire [39 : 0] txdiffctrl_in;
  wire [7 : 0] txinhibit_in;
  wire [7 : 0] txoutclk_out;
  wire [7 : 0] txpcsreset_in;
  wire [15 : 0] txpd_in;
  wire [15 : 0] txpllclksel_in;
  wire [7 : 0] txpmareset_in;
  wire [7 : 0] txpmaresetdone_out;
  wire [7 : 0] txpolarity_in;
  wire [39 : 0] txpostcursor_in;
  wire [7 : 0] txprbsforceerr_in;
  wire [31 : 0] txprbssel_in;
  wire [39 : 0] txprecursor_in;
  wire [7 : 0] txprogdivreset_in;
  wire [7 : 0] txresetdone_out;
  wire [15 : 0] txsysclksel_in;
  wire [7 : 0] txuserrdy_in;
  wire [7 : 0] txusrclk2_in;
  wire [7 : 0] txusrclk_in;

  // Connect the TX data and control inputs to the GT wizard block.
  // Tie unused GT wizard inputs to 0.
  assign txctrl2_in[3:0]    = gt0_txcharisk;
  assign txdata_in[31:0]    = gt0_txdata;
  assign txctrl2_in[7:4]    = 0;
  assign txdata_in[127:32]  = 0;
  assign txctrl2_in[11:8]   = gt1_txcharisk;
  assign txdata_in[159:128] = gt1_txdata;
  assign txctrl2_in[15:12]  = 0;
  assign txdata_in[255:160] = 0;
  assign txctrl2_in[19:16]  = gt2_txcharisk;
  assign txdata_in[287:256] = gt2_txdata;
  assign txctrl2_in[23:20]  = 0;
  assign txdata_in[383:288] = 0;
  assign txctrl2_in[27:24]  = gt3_txcharisk;
  assign txdata_in[415:384] = gt3_txdata;
  assign txctrl2_in[31:28]  = 0;
  assign txdata_in[511:416] = 0;
  assign txctrl2_in[35:32]  = gt4_txcharisk;
  assign txdata_in[543:512] = gt4_txdata;
  assign txctrl2_in[39:36]  = 0;
  assign txdata_in[639:544] = 0;
  assign txctrl2_in[43:40]  = gt5_txcharisk;
  assign txdata_in[671:640] = gt5_txdata;
  assign txctrl2_in[47:44]  = 0;
  assign txdata_in[767:672] = 0;
  assign txctrl2_in[51:48]  = gt6_txcharisk;
  assign txdata_in[799:768] = gt6_txdata;
  assign txctrl2_in[55:52]  = 0;
  assign txdata_in[895:800] = 0;
  assign txctrl2_in[59:56]   = gt7_txcharisk;
  assign txdata_in[927:896]  = gt7_txdata;
  assign txctrl2_in[63:60]   = 0;
  assign txdata_in[1023:928] = 0;

  // Connect up the GT outputs to the received data and control outputs
  assign gt0_rxdata       = rxdata_out[31:0];
  assign gt0_rxcharisk    = rxctrl0_out[3:0];
  assign gt0_rxdisperr    = rxctrl1_out[3:0];
  assign gt0_rxnotintable = rxctrl3_out[3:0];
  assign gt1_rxdata       = rxdata_out[159:128];
  assign gt1_rxcharisk    = rxctrl0_out[19:16];
  assign gt1_rxdisperr    = rxctrl1_out[19:16];
  assign gt1_rxnotintable = rxctrl3_out[11:8];
  assign gt2_rxdata       = rxdata_out[287:256];
  assign gt2_rxcharisk    = rxctrl0_out[35:32];
  assign gt2_rxdisperr    = rxctrl1_out[35:32];
  assign gt2_rxnotintable = rxctrl3_out[19:16];
  assign gt3_rxdata       = rxdata_out[415:384];
  assign gt3_rxcharisk    = rxctrl0_out[51:48];
  assign gt3_rxdisperr    = rxctrl1_out[51:48];
  assign gt3_rxnotintable = rxctrl3_out[27:24];
  assign gt4_rxdata       = rxdata_out[543:512];
  assign gt4_rxcharisk    = rxctrl0_out[67:64];
  assign gt4_rxdisperr    = rxctrl1_out[67:64];
  assign gt4_rxnotintable = rxctrl3_out[35:32];
  assign gt5_rxdata       = rxdata_out[671:640];
  assign gt5_rxcharisk    = rxctrl0_out[83:80];
  assign gt5_rxdisperr    = rxctrl1_out[83:80];
  assign gt5_rxnotintable = rxctrl3_out[43:40];
  assign gt6_rxdata       = rxdata_out[799:768];
  assign gt6_rxcharisk    = rxctrl0_out[99:96];
  assign gt6_rxdisperr    = rxctrl1_out[99:96];
  assign gt6_rxnotintable = rxctrl3_out[51:48];
  assign gt7_rxdata       = rxdata_out[927:896];
  assign gt7_rxcharisk    = rxctrl0_out[115:112];
  assign gt7_rxdisperr    = rxctrl1_out[115:112];
  assign gt7_rxnotintable = rxctrl3_out[59:56];

  // Connect up the GT DRP bus to the DRP inputs and outputs.
  // Tie unused GT wizard inputs to 0.
  assign drpclk_in        = {8{drpclk}};

  assign drpaddr_in        = {gt7_drpaddr,gt6_drpaddr,gt5_drpaddr,gt4_drpaddr,gt3_drpaddr,gt2_drpaddr,gt1_drpaddr,gt0_drpaddr};
  assign drpdi_in          = {gt7_drpdi,gt6_drpdi,gt5_drpdi,gt4_drpdi,gt3_drpdi,gt2_drpdi,gt1_drpdi,gt0_drpdi};
  assign drpen_in          = {gt7_drpen,gt6_drpen,gt5_drpen,gt4_drpen,gt3_drpen,gt2_drpen,gt1_drpen,gt0_drpen};
  assign drpwe_in          = {gt7_drpwe,gt6_drpwe,gt5_drpwe,gt4_drpwe,gt3_drpwe,gt2_drpwe,gt1_drpwe,gt0_drpwe};

  assign gt0_drpdo         = drpdo_out[15:0];
  assign gt1_drpdo         = drpdo_out[31:16];
  assign gt2_drpdo         = drpdo_out[47:32];
  assign gt3_drpdo         = drpdo_out[63:48];
  assign gt4_drpdo         = drpdo_out[79:64];
  assign gt5_drpdo         = drpdo_out[95:80];
  assign gt6_drpdo         = drpdo_out[111:96];
  assign gt7_drpdo         = drpdo_out[127:112];

  assign gt0_drprdy        = drprdy_out[0:0];
  assign gt1_drprdy        = drprdy_out[1:1];
  assign gt2_drprdy        = drprdy_out[2:2];
  assign gt3_drprdy        = drprdy_out[3:3];
  assign gt4_drprdy        = drprdy_out[4:4];
  assign gt5_drprdy        = drprdy_out[5:5];
  assign gt6_drprdy        = drprdy_out[6:6];
  assign gt7_drprdy        = drprdy_out[7:7];

  //***********************************************************************//
  //                                                                       //
  //--------------------------- The GT Wrapper ----------------------------//
  //                                                                       //
  //***********************************************************************//

  jesd204_phy_0_gt jesd204_phy_0_gt_i
  (
   .cplllock_out(cplllock_out),
   .cpllpd_in(cpllpd_in),
   .cpllreset_in(cpllreset_in),
   .dmonitorclk_in(dmonitorclk_in),
   .dmonitorout_out(dmonitorout_out),
   .drpaddr_in(drpaddr_in),
   .drpclk_in(drpclk_in),
   .drpdi_in(drpdi_in),
   .drpdo_out(drpdo_out),
   .drpen_in(drpen_in),
   .drprdy_out(drprdy_out),
   .drpwe_in(drpwe_in),
   .eyescandataerror_out(eyescandataerror_out),
   .eyescanreset_in(eyescanreset_in),
   .eyescantrigger_in(eyescantrigger_in),
   .gthrxn_in(gthrxn_in),
   .gthrxp_in(gthrxp_in),
   .gthtxn_out(gthtxn_out),
   .gthtxp_out(gthtxp_out),
   .gtpowergood_out(gtpowergood_out),
   .gtrefclk0_in(gtrefclk0_in),
   .gtrxreset_in(gtrxreset_in),
   .gttxreset_in(gttxreset_in),
   .gtwiz_gthe4_cpll_cal_bufg_ce_in(gtwiz_gthe4_cpll_cal_bufg_ce_in),
   .gtwiz_gthe4_cpll_cal_cnt_tol_in(gtwiz_gthe4_cpll_cal_cnt_tol_in),
   .gtwiz_gthe4_cpll_cal_txoutclk_period_in(gtwiz_gthe4_cpll_cal_txoutclk_period_in),
   .gtwiz_reset_rx_done_in(gtwiz_reset_rx_done_in),
   .gtwiz_reset_tx_done_in(gtwiz_reset_tx_done_in),
   .gtwiz_userclk_rx_active_in(gtwiz_userclk_rx_active_in),
   .gtwiz_userclk_rx_reset_in(gtwiz_userclk_rx_reset_in),
   .gtwiz_userclk_tx_active_in(gtwiz_userclk_tx_active_in),
   .gtwiz_userclk_tx_reset_in(gtwiz_userclk_tx_reset_in),
   .loopback_in(loopback_in),
   .pcsrsvdin_in(pcsrsvdin_in),
   .qpll0clk_in(qpll0clk_in),
   .qpll0refclk_in(qpll0refclk_in),
   .qpll1clk_in(qpll1clk_in),
   .qpll1refclk_in(qpll1refclk_in),
   .rx8b10ben_in(rx8b10ben_in),
   .rxbufreset_in(rxbufreset_in),
   .rxbufstatus_out(rxbufstatus_out),
   .rxbyteisaligned_out(rxbyteisaligned_out),
   .rxbyterealign_out(rxbyterealign_out),
   .rxcdrhold_in(rxcdrhold_in),
   .rxcdrlock_out(rxcdrlock_out),
   .rxcommadet_out(rxcommadet_out),
   .rxcommadeten_in(rxcommadeten_in),
   .rxctrl0_out(rxctrl0_out),
   .rxctrl1_out(rxctrl1_out),
   .rxctrl2_out(rxctrl2_out),
   .rxctrl3_out(rxctrl3_out),
   .rxdata_out(rxdata_out),
   .rxdfeagchold_in(rxdfeagchold_in),
   .rxdfelfhold_in(rxdfelfhold_in),
   .rxdfelpmreset_in(rxdfelpmreset_in),
   .rxdfetap10hold_in(rxdfetap10hold_in),
   .rxdfetap11hold_in(rxdfetap11hold_in),
   .rxdfetap12hold_in(rxdfetap12hold_in),
   .rxdfetap13hold_in(rxdfetap13hold_in),
   .rxdfetap14hold_in(rxdfetap14hold_in),
   .rxdfetap15hold_in(rxdfetap15hold_in),
   .rxdfetap2hold_in(rxdfetap2hold_in),
   .rxdfetap3hold_in(rxdfetap3hold_in),
   .rxdfetap4hold_in(rxdfetap4hold_in),
   .rxdfetap5hold_in(rxdfetap5hold_in),
   .rxdfetap6hold_in(rxdfetap6hold_in),
   .rxdfetap7hold_in(rxdfetap7hold_in),
   .rxdfetap8hold_in(rxdfetap8hold_in),
   .rxdfetap9hold_in(rxdfetap9hold_in),
   .rxdfeuthold_in(rxdfeuthold_in),
   .rxdfevphold_in(rxdfevphold_in),
   .rxlpmen_in(rxlpmen_in),
   .rxmcommaalignen_in(rxmcommaalignen_in),
   .rxoshold_in(rxoshold_in),
   .rxoutclk_out(rxoutclk_out),
   .rxpcommaalignen_in(rxpcommaalignen_in),
   .rxpcsreset_in(rxpcsreset_in),
   .rxpd_in(rxpd_in),
   .rxpllclksel_in(rxpllclksel_in),
   .rxpmareset_in(rxpmareset_in),
   .rxpmaresetdone_out(rxpmaresetdone_out),
   .rxpolarity_in(rxpolarity_in),
   .rxprbscntreset_in(rxprbscntreset_in),
   .rxprbserr_out(rxprbserr_out),
   .rxprbssel_in(rxprbssel_in),
   .rxprogdivreset_in(rxprogdivreset_in),
   .rxrate_in(rxrate_in),
   .rxresetdone_out(rxresetdone_out),
   .rxsysclksel_in(rxsysclksel_in),
   .rxuserrdy_in(rxuserrdy_in),
   .rxusrclk2_in(rxusrclk2_in),
   .rxusrclk_in(rxusrclk_in),
   .tx8b10ben_in(tx8b10ben_in),
   .txbufstatus_out(txbufstatus_out),
   .txctrl0_in(txctrl0_in),
   .txctrl1_in(txctrl1_in),
   .txctrl2_in(txctrl2_in),
   .txdata_in(txdata_in),
   .txdiffctrl_in(txdiffctrl_in),
   .txinhibit_in(txinhibit_in),
   .txoutclk_out(txoutclk_out),
   .txpcsreset_in(txpcsreset_in),
   .txpd_in(txpd_in),
   .txpllclksel_in(txpllclksel_in),
   .txpmareset_in(txpmareset_in),
   .txpmaresetdone_out(txpmaresetdone_out),
   .txpolarity_in(txpolarity_in),
   .txpostcursor_in(txpostcursor_in),
   .txprbsforceerr_in(txprbsforceerr_in),
   .txprbssel_in(txprbssel_in),
   .txprecursor_in(txprecursor_in),
   .txprogdivreset_in(txprogdivreset_in),
   .txresetdone_out(txresetdone_out),
   .txsysclksel_in(txsysclksel_in),
   .txuserrdy_in(txuserrdy_in),
   .txusrclk2_in(txusrclk2_in),
   .txusrclk_in(txusrclk_in)
  );


  assign rxoutclk                           = rxoutclk_out[0];
  assign gtwiz_userclk_rx_active_in[0]      = 1'b1;
  assign rx8b10ben_in                       = {8{1'b1}};
  assign rxcommadeten_in                    = {8{1'b1}};

  assign txoutclk                           = txoutclk_out[0];
  assign txctrl0_in                         = {128{1'b0}};
  assign txctrl1_in                         = {128{1'b0}};
  assign tx8b10ben_in                       = {8{1'b1}};
  assign gtwiz_userclk_tx_active_in[0]      = 1'b1;
  assign gtwiz_userclk_tx_reset_in          = 1'b0;
  
  assign cpll_cal_cnt_tol   = 50;
  assign cpll_cal_cnt_per   = 5000;


  assign gtwiz_gthe4_cpll_cal_bufg_ce_in    = 1'b1;
  assign gtwiz_gthe4_cpll_cal_cnt_tol_in    = {8{cpll_cal_cnt_tol}};
  assign gtwiz_gthe4_cpll_cal_txoutclk_period_in = {8{cpll_cal_cnt_per}};
  

  assign  cpllpd_in[7:0]                    = (tx_pll_sel == 0 && rx_pll_sel == 0) ? {8{(pllreset_tx_out | pllreset_rx_out)}} :
                                              (tx_pll_sel == 0)                    ? {8{(pllreset_tx_out)}} :
                                              (rx_pll_sel == 0)                    ? {8{(pllreset_rx_out)}} :  8'b0;
  assign  cpllreset_in[7:0]                 = 8'b0;

  // Assign pllclksel and sysclksel based on PLL selection
  // pllclksel = 2'b00 : CPLL
  // pllclksel = 2'b11 : QPLL0
  // pllclksel = 2'b10 : QPLL1
  assign txsysclksel_i                      = 2'b00;
  assign txpllclksel_i                      = 2'b00;
  assign rxsysclksel_i                      = 2'b10;
  assign rxpllclksel_i                      = 2'b11;

  //AND all powergood signals
  assign gtpowergood_i  = &gtpowergood_out;
  assign gt_powergood   = gtpowergood_i;

  // Gate all user reset until gtpowergood_out goes high
  assign txreset_good   = (gtpowergood_i) ? tx_rst_data : 1'b0;
  assign rxreset_good   = (gtpowergood_i) ? rx_rst_data : 1'b0;

  assign txreset_good_all   = (gtpowergood_i) ? tx_rst_all : 1'b0;
  assign rxreset_good_all   = (gtpowergood_i) ? rx_rst_all : 1'b0;

  // Drive gtwiz_userclk_tx_active_out based on PMA Reset done 
  // to ensure clock is stable before coming out of reset.
  assign gtwiz_userclk_tx_reset_int = ~(&txpmaresetdone_out);

  jesd204_phy_0_sync_block #(
    .TYPE (1)
  ) sync_gtwiz_userclk_tx_active
  (
    .clk             (tx_core_clk),
    .data_in         (gtwiz_userclk_tx_reset_int),
    .data_out        (gtwiz_userclk_tx_active_sync)
  );
  
  assign gtwiz_userclk_tx_active_out = !gtwiz_userclk_tx_active_sync;

  // Drive gtwiz_userclk_rx_active_out based on PMA Reset done to ensure clock
  // is stable before coming out of reset.
  assign gtwiz_userclk_rx_reset_int = ~(&rxpmaresetdone_out);

  jesd204_phy_0_sync_block #(
    .TYPE (1)
  ) sync_gtwiz_userclk_rx_active
  (
    .clk             (rx_core_clk),
    .data_in         (gtwiz_userclk_rx_reset_int),
    .data_out        (gtwiz_userclk_rx_active_sync)
  );

  assign gtwiz_userclk_rx_active_out = !gtwiz_userclk_rx_active_sync;

  // Instantiate reset block from the GT wizard
  gtwizard_ultrascale_v1_7_5_gtwiz_reset #(
   .P_FREERUN_FREQUENCY       (100.0),
   .P_USE_CPLL_CAL            (0),
   .P_TX_PLL_TYPE             (2),
   .P_RX_PLL_TYPE             (0),
   .P_RX_LINE_RATE            (5),
   .P_CDR_TIMEOUT_FREERUN_CYC ((37000 * 100.0) / 5)
  ) gtwiz_reset_block_i (

    .gtwiz_reset_clk_freerun_in          (drpclk),
    .gtwiz_reset_all_in                  (1'b0),
    .gtwiz_reset_tx_pll_and_datapath_in  (txreset_good_all),
    .gtwiz_reset_tx_datapath_in          (txreset_good),
    .gtwiz_reset_rx_pll_and_datapath_in  (rxreset_good_all),
    .gtwiz_reset_rx_datapath_in          (rxreset_good),
    .gtwiz_reset_rx_cdr_stable_out       (),
    .gtwiz_reset_tx_done_out             (gtwiz_reset_tx_done_in[0]),
    .gtwiz_reset_rx_done_out             (gtwiz_reset_rx_done_in[0]),
    .gtwiz_reset_userclk_tx_active_in    (gtwiz_userclk_tx_active_out),
    .gtwiz_reset_userclk_rx_active_in    (gtwiz_userclk_rx_active_out),
    .gtpowergood_in                      (gtpowergood_i),
    .txusrclk2_in                        (tx_core_clk),
    .plllock_tx_in                       (tx_pll_lock),
    .txresetdone_in                      (gt_txresetdone_sync),
    .rxusrclk2_in                        (rx_core_clk),
    .plllock_rx_in                       (rx_pll_lock),
    .rxcdrlock_in                        (rxcdrlock_in),
    .rxresetdone_in                      (gt_rxresetdone_sync),
    .pllreset_tx_out                     (pllreset_tx_out),
    .txprogdivreset_out                  (txprogdivreset_out),
    .gttxreset_out                       (gttxreset_out),
    .txuserrdy_out                       (txuserrdy_out),
    .pllreset_rx_out                     (pllreset_rx_out),
    .rxprogdivreset_out                  (rxprogdivreset_out),
    .gtrxreset_out                       (gtrxreset_out),
    .rxuserrdy_out                       (rxuserrdy_out),
    .tx_enabled_tie_in                   (1'b0),
    .rx_enabled_tie_in                   (1'b0),
    .shared_pll_tie_in                   (1'b1)
  );

  //Synchronize Transceiver Resets to drpclk domain
  jesd204_phy_0_sync_block #(
    .TYPE (1)
  ) sync_tx_reset_data 
  (
    .clk             (drpclk),
    .data_in         (tx_reset_gt),
    .data_out        (tx_reset_gt_sync)
  );

  jesd204_phy_0_sync_block #(
    .TYPE (1)
  ) sync_rx_reset_data 
  (
    .clk             (drpclk),
    .data_in         (rx_reset_gt),
    .data_out        (rx_reset_gt_sync)
  );

  jesd204_phy_0_sync_block #(
    .TYPE (1)
  ) sync_tx_reset_all
  (
    .clk             (drpclk),
    .data_in         (tx_sys_reset),
    .data_out        (tx_sys_reset_sync)
  );

  jesd204_phy_0_sync_block #(
    .TYPE (1)
  ) sync_rx_reset_all
  (
    .clk             (drpclk),
    .data_in         (rx_sys_reset),
    .data_out        (rx_sys_reset_sync)
  );

  // State machine module that controls reset inputs to transceiver
  jesd204_phy_0_reset_control jesd204_phy_reset_control_i (
    .clk             (drpclk),
    .tx_sys_rst      (tx_sys_reset_sync),
    .rx_sys_rst      (rx_sys_reset_sync),
    .tx_data_rst     (tx_reset_gt_sync),
    .rx_data_rst     (rx_reset_gt_sync),
    .tx_rst_done     (txresetdone_sync),
    .rx_rst_done     (rxresetdone_sync),
    .tx_rst_all      (tx_rst_all),
    .rx_rst_all      (rx_rst_all),
    .tx_rst_data     (tx_rst_data),
    .rx_rst_data     (rx_rst_data)
  );
  
  // Connect the clocking and control inputs and outputs to the
  // GT ports. Tie unused inputs to the GT low.
  assign  loopback_in[23:0]       = gt_loopback[23:0];
  assign  txprbssel_in[31:0]      = {8{gt_prbssel}};
  assign  txprbsforceerr_in[7:0]  = gt_txprbsforceerr;
  assign  rxprbssel_in[31:0]      = gt_rxprbssel[31:0];
  assign  rxprbscntreset_in[7:0]  = gt_rxprbscntreset;
  assign  gt_rxprbserr            = rxprbserr_out[7:0];
  assign  rxpolarity_in[7:0]      = gt_rxpolarity[7:0];
  assign  txpolarity_in[7:0]      = gt_txpolarity[7:0];
  assign  txinhibit_in[7:0]       = gt_txinhibit[7:0];
  assign  txn_out[7:0]            = gthtxn_out[7:0];
  assign  txp_out[7:0]            = gthtxp_out[7:0];
  assign  txdiffctrl_in           = gt_txdiffctrl;
  assign  txpostcursor_in[39:0]   = gt_txpostcursor;
  assign  txprecursor_in[39:0]    = gt_txprecursor;
  assign  gt_txresetdone          = txresetdone_out[7:0];
  assign  gt_rxresetdone          = rxresetdone_out[7:0];
  assign  gthrxn_in[7:0]          = rxn_in[7:0];
  assign  gthrxp_in[7:0]          = rxp_in[7:0];
  assign  txusrclk_in[7:0]        = {8{tx_core_clk}};
  assign  txusrclk2_in[7:0]       = {8{tx_core_clk}};
  assign  rxusrclk_in[7:0]        = {8{rx_core_clk}};
  assign  rxusrclk2_in[7:0]       = {8{rx_core_clk}};
  assign  rxmcommaalignen_in[7:0] = {8{rxencommaalign}};
  assign  rxpcommaalignen_in[7:0] = {8{rxencommaalign}};
  assign  rxcdrlock_in            = rxcdrlock_out[7] & rxcdrlock_out[6] & rxcdrlock_out[5] & rxcdrlock_out[4] &
                                    rxcdrlock_out[3] & rxcdrlock_out[2] & rxcdrlock_out[1] & rxcdrlock_out[0];
  assign  txprogdivreset_in[7:0]  = {8{txprogdivreset_out}};
  assign  rxprogdivreset_in[7:0]  = {8{rxprogdivreset_out}};
  assign  gttxreset_in[7:0]       = {8{gttxreset_out}};
  assign  gtrxreset_in[7:0]       = {8{gtrxreset_out}};
  assign  txuserrdy_in[7:0]       = {8{txuserrdy_out}};
  assign  rxuserrdy_in[7:0]       = {8{rxuserrdy_out}};
  assign  rx_pll_lock_i           = (cplllock_out[7] & cplllock_out[6] & cplllock_out[5] & cplllock_out[4] & cplllock_out[3] & cplllock_out[2] & cplllock_out[1] & cplllock_out[0]);
  assign  tx_pll_lock_i           = (cplllock_out[7] & cplllock_out[6] & cplllock_out[5] & cplllock_out[4] & cplllock_out[3] & cplllock_out[2] & cplllock_out[1] & cplllock_out[0]);
  assign  gt_cplllock             = cplllock_out[7:0];
  assign  gtrefclk0_in[7:0]       = {8{cpll_refclk}};
  assign  txsysclksel_in[15:0]    = {8{txsysclksel_i}};
  assign  rxsysclksel_in[15:0]    = {8{rxsysclksel_i}};
  assign  txpllclksel_in[15:0]    = {8{txpllclksel_i}};
  assign  rxpllclksel_in[15:0]    = {8{rxpllclksel_i}};
  assign  rxpd_in[15:0]           = gt_rxpd;
  assign  txpd_in[15:0]           = gt_txpd;
  assign  txpcsreset_in[7:0]      = gt_txpcsreset;
  assign  txpmareset_in[7:0]      = gt_txpmareset;
  assign  rxpcsreset_in[7:0]      = gt_rxpcsreset;
  assign  rxpmareset_in[7:0]      = gt_rxpmareset;
  assign  rxbufreset_in[7:0]      = gt_rxbufreset;
  assign  gt_rxpmaresetdone       = rxpmaresetdone_out[7:0];
  assign  gt_txbufstatus          = txbufstatus_out[15:0];
  assign  gt_rxbufstatus          = rxbufstatus_out[23:0];
  assign  rxrate_in[23:0]         = gt_rxrate;
  assign  eyescantrigger_in[7:0]  = gt_eyescantrigger;
  assign  eyescanreset_in[7:0]    = gt_eyescanreset;
  assign  gt_eyescandataerror     = eyescandataerror_out[7:0];
  assign  rxdfelpmreset_in[7:0]   = gt_rxdfelpmreset;
  assign  rxlpmen_in[7:0]         = gt_rxlpmen;
  assign  rxcdrhold_in[7:0]       = gt_rxcdrhold;
  assign  rxoshold_in[7:0]        = gt_rxoshold;
  assign  rxdfeagchold_in[7:0]    = gt_rxdfeagchold;
  assign  rxdfelfhold_in[7:0]     = gt_rxdfelfhold;
  assign  rxdfeuthold_in[7:0]     = gt_rxdfeuthold;
  assign  rxdfevphold_in[7:0]     = gt_rxdfevphold;
  assign  rxdfetap2hold_in[7:0]   = gt_rxdfetap2hold;
  assign  rxdfetap3hold_in[7:0]   = gt_rxdfetap3hold;
  assign  rxdfetap4hold_in[7:0]   = gt_rxdfetap4hold;
  assign  rxdfetap5hold_in[7:0]   = gt_rxdfetap5hold;
  assign  rxdfetap6hold_in[7:0]   = gt_rxdfetap6hold;
  assign  rxdfetap7hold_in[7:0]   = gt_rxdfetap7hold;
  assign  rxdfetap8hold_in[7:0]   = gt_rxdfetap8hold;
  assign  rxdfetap9hold_in[7:0]   = gt_rxdfetap9hold;
  assign  rxdfetap10hold_in[7:0]  = gt_rxdfetap10hold;
  assign  rxdfetap11hold_in[7:0]  = gt_rxdfetap11hold;
  assign  rxdfetap12hold_in[7:0]  = gt_rxdfetap12hold;
  assign  rxdfetap13hold_in[7:0]  = gt_rxdfetap13hold;
  assign  rxdfetap14hold_in[7:0]  = gt_rxdfetap14hold;
  assign  rxdfetap15hold_in[7:0]  = gt_rxdfetap15hold;
  assign  dmonitorclk_in          = gt_dmonitorclk; 
  assign  gt_dmonitorout          = dmonitorout_out;
  assign  gt_rxcommadet           = rxcommadet_out[7:0];
  assign  pcsrsvdin_in            = gt_pcsrsvdin;

  assign  qpll0clk_in[7:0]        = {{4{common1_qpll0_clk_in}}, {4{common0_qpll0_clk_in}}};
  assign  qpll0refclk_in[7:0]     = {{4{common1_qpll0_refclk_in}}, {4{common0_qpll0_refclk_in}}};
  assign  qpll1clk_in[7:0]        = 8'b0;
  assign  qpll1refclk_in[7:0]     = 8'b0;

  // PLL lock input to GT Reset Module
  always@(posedge drpclk)
    tx_pll_lock              <= tx_pll_lock_i;

  always@(posedge drpclk)
    rx_pll_lock              <= common0_qpll0_lock_in & common1_qpll0_lock_in;

  //Output to reset QPLL0 located in Support Block
  assign qpll0_reset_out           = (txpllclksel_i == 2'b11 && rxpllclksel_i == 2'b11) ? pllreset_tx_out || pllreset_rx_out:
                                     (txpllclksel_i == 2'b11) ? pllreset_tx_out :
                                     (rxpllclksel_i == 2'b11) ? pllreset_rx_out : 1'b0;
  always@(posedge rx_core_clk)
    rxresetdone_i2   <=  &rxresetdone_out;

  always@(posedge tx_core_clk)
    txresetdone_i2   <=  &txresetdone_out;

  jesd204_phy_0_sync_block #(
    .TYPE (0)
  ) sync_gt_txresetdone 
  (
    .clk             (drpclk),
    .data_in         (txresetdone_i2),
    .data_out        (gt_txresetdone_sync)
  );

  jesd204_phy_0_sync_block #(
    .TYPE (0)
  ) sync_gt_rxresetdone 
  (
    .clk             (drpclk),
    .data_in         (rxresetdone_i2),
    .data_out        (gt_rxresetdone_sync)
  );

  jesd204_phy_0_sync_block #(
    .TYPE (0)
  ) sync_rxresetdone 
  (
    .clk             (drpclk),
    .data_in         (gtwiz_reset_rx_done_in[0]),
    .data_out        (rxresetdone_sync)
  );
  assign rx_reset_done = rxresetdone_sync;

  jesd204_phy_0_sync_block #(
    .TYPE (0)
  ) sync_txresetdone 
  (
    .clk             (drpclk),
    .data_in         (gtwiz_reset_tx_done_in[0]),
    .data_out        (txresetdone_sync)
  );
  assign tx_reset_done = txresetdone_sync;

endmodule
