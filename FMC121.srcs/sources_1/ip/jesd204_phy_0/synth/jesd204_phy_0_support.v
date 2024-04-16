//----------------------------------------------------------------------------
// Title : Support Level Module
// Project : JESD204 PHY
//----------------------------------------------------------------------------
// File : jesd204_phy_support.v
//----------------------------------------------------------------------------
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
//----------------------------------------------------------------------------

`timescale 1ns / 1ps

(* DowngradeIPIdentifiedWarnings = "yes" *)
module jesd204_phy_0_support (
  // Additional GT signals for debug
  // CPLL Lock
  output [7:0]         gt_cplllock,

  // Reset Done for each GT Channel
  output [7:0]         gt_txresetdone,
  output [7:0]         gt_rxresetdone,

  // Pattern Checker ports
  input  [7:0]         gt_txprbsforceerr,

  input  [31:0]       gt_rxprbssel,
  input  [7:0]         gt_rxprbscntreset,
  output [7:0]         gt_rxprbserr,

  // RX Margin Analysis Ports
  input   [7:0]        gt_eyescantrigger,
  input   [7:0]        gt_eyescanreset,
  output  [7:0]        gt_eyescandataerror,

  // TX Reset and Initialization
  input   [7:0]        gt_txpmareset,
  input   [7:0]        gt_txpcsreset,

  // TX Buffer Ports
  output  [15:0]       gt_txbufstatus,

  // RX Reset and Initialization
  input   [7:0]        gt_rxpmareset,
  input   [7:0]        gt_rxpcsreset,
  input   [7:0]        gt_rxbufreset,
  output  [7:0]        gt_rxpmaresetdone,

  // RX CDR Ports
  input   [7:0]        gt_rxcdrhold,

  
  // RX Byte and Word Alignment Ports
  output  [7:0]        gt_rxcommadet,
  
  // RX Equalizer Ports
  input   [7:0]        gt_rxdfelpmreset,
  input   [7:0]        gt_rxlpmen,

  // RX Buffer Ports
  output  [23:0]        gt_rxbufstatus,

  // PCI Express Ports
  input  [23:0]         gt_rxrate,

  // RX Digital Monitor Ports
  input   [7:0]        gt_dmonitorclk,
  output [127:0]       gt_dmonitorout,

  // Loopback
  input  [23:0]        gt_loopback,

  // Power Down Ports
  input   [15:0]      gt_rxpd,
  input   [15:0]      gt_txpd,

  // Transmit Control
  input  [39:0]      gt_txpostcursor,
  input  [39:0]      gt_txprecursor,
  input  [39:0]      gt_txdiffctrl,


  input  [7:0]        gt_txpolarity,
  input  [7:0]        gt_txinhibit,

 // GT Rx Control
  input  [7:0]        gt_rxpolarity,

  input  [127: 0]    gt_pcsrsvdin,

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

  input               cpll_refclk,
  // GT Common 0 I/O
  input               qpll0_refclk,
  output              common0_qpll0_lock_out,
  output              common0_qpll0_refclk_out,
  output              common0_qpll0_clk_out,
  output              common1_qpll0_lock_out,
  output              common1_qpll0_refclk_out,
  output              common1_qpll0_clk_out,
 
  input               rxencommaalign,
  

  // Clocks
  output              txoutclk,
  input               tx_core_clk,

  output              rxoutclk,
  input               rx_core_clk,

  input               drpclk,

  // PRBS mode
  input    [3:0]      gt_prbssel,

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
  input      [7:0]    rxn_in,
  input      [7:0]    rxp_in,
  output     [7:0]    txn_out,
  output     [7:0]    txp_out

);

//*******************************************
// Wire Declarations
//*******************************************
  // GT Common I/O
  wire          common0_qpll0_lock_i;
  wire          common0_qpll0_refclk_i;
  wire          common0_qpll0_clk_i;

  wire          common1_qpll0_lock_i;
  wire          common1_qpll0_refclk_i;
  wire          common1_qpll0_clk_i;

  wire          qpll0_reset_i;


  wire          txoutclk_i;
  assign txoutclk  = txoutclk_i;
  
  wire          rxoutclk_i;
  assign rxoutclk  =  rxoutclk_i;

//*******************************************
// JESD204 PHY Core
//*******************************************
jesd204_phy_0_block
jesd204_phy_block_i
 (
  // Reset Done for each GT Channel
  .gt_txresetdone          (gt_txresetdone),
  .gt_rxresetdone          (gt_rxresetdone),

  // CPLL Lock for each GT Channel
  .gt_cplllock             (gt_cplllock),

  // Pattern Checker ports
  .gt_txprbsforceerr       (gt_txprbsforceerr),

  .gt_rxprbssel            (gt_rxprbssel),
  .gt_rxprbscntreset       (gt_rxprbscntreset),
  .gt_rxprbserr            (gt_rxprbserr),

  // TX Reset and Initialization
  .gt_txpcsreset           (gt_txpcsreset),
  .gt_txpmareset           (gt_txpmareset),

  // RX Reset and Initialization
  .gt_rxpcsreset           (gt_rxpcsreset),
  .gt_rxpmareset           (gt_rxpmareset),
  .gt_rxbufreset           (gt_rxbufreset),
  .gt_rxpmaresetdone       (gt_rxpmaresetdone),

  // TX Buffer Ports
  .gt_txbufstatus          (gt_txbufstatus),

  // RX Buffer Ports
  .gt_rxbufstatus          (gt_rxbufstatus),

  // PCI Express Ports
  .gt_rxrate               (gt_rxrate),

  // RX Margin Analysis Ports
  .gt_eyescantrigger       (gt_eyescantrigger),
  .gt_eyescanreset         (gt_eyescanreset),
  .gt_eyescandataerror     (gt_eyescandataerror),

  // RX Equalizer Ports
  .gt_rxdfelpmreset        (gt_rxdfelpmreset),
  .gt_rxlpmen              (gt_rxlpmen),

  // RX CDR Ports
  .gt_rxcdrhold            (gt_rxcdrhold),

  // RX Digital Monitor Ports
  .gt_dmonitorclk          (gt_dmonitorclk),
  .gt_dmonitorout          (gt_dmonitorout),

  // RX Byte and Word Alignment Ports
  .gt_rxcommadet           (gt_rxcommadet),
  
  // Loopback
  .gt_loopback             (gt_loopback),

  // Power Down Ports
  .gt_rxpd                 (gt_rxpd),
  .gt_txpd                 (gt_txpd),

  // Transmit Control
  .gt_txpostcursor         (gt_txpostcursor),
  .gt_txprecursor          (gt_txprecursor),
  .gt_txdiffctrl           (gt_txdiffctrl),
  .gt_txpolarity           (gt_txpolarity),
  .gt_txinhibit            (gt_txinhibit),

  // GT Rx Control
  .gt_rxpolarity           (gt_rxpolarity),

  .gt_pcsrsvdin            (gt_pcsrsvdin),

  // DRP Ports
  .gt0_drpaddr             (gt0_drpaddr),
  .gt0_drpdi               (gt0_drpdi),
  .gt0_drpen               (gt0_drpen),
  .gt0_drpwe               (gt0_drpwe),
  .gt0_drpdo               (gt0_drpdo),
  .gt0_drprdy              (gt0_drprdy),

  .gt1_drpaddr             (gt1_drpaddr),
  .gt1_drpdi               (gt1_drpdi),
  .gt1_drpen               (gt1_drpen),
  .gt1_drpwe               (gt1_drpwe),
  .gt1_drpdo               (gt1_drpdo),
  .gt1_drprdy              (gt1_drprdy),

  .gt2_drpaddr             (gt2_drpaddr),
  .gt2_drpdi               (gt2_drpdi),
  .gt2_drpen               (gt2_drpen),
  .gt2_drpwe               (gt2_drpwe),
  .gt2_drpdo               (gt2_drpdo),
  .gt2_drprdy              (gt2_drprdy),

  .gt3_drpaddr             (gt3_drpaddr),
  .gt3_drpdi               (gt3_drpdi),
  .gt3_drpen               (gt3_drpen),
  .gt3_drpwe               (gt3_drpwe),
  .gt3_drpdo               (gt3_drpdo),
  .gt3_drprdy              (gt3_drprdy),

  .gt4_drpaddr             (gt4_drpaddr),
  .gt4_drpdi               (gt4_drpdi),
  .gt4_drpen               (gt4_drpen),
  .gt4_drpwe               (gt4_drpwe),
  .gt4_drpdo               (gt4_drpdo),
  .gt4_drprdy              (gt4_drprdy),

  .gt5_drpaddr             (gt5_drpaddr),
  .gt5_drpdi               (gt5_drpdi),
  .gt5_drpen               (gt5_drpen),
  .gt5_drpwe               (gt5_drpwe),
  .gt5_drpdo               (gt5_drpdo),
  .gt5_drprdy              (gt5_drprdy),

  .gt6_drpaddr             (gt6_drpaddr),
  .gt6_drpdi               (gt6_drpdi),
  .gt6_drpen               (gt6_drpen),
  .gt6_drpwe               (gt6_drpwe),
  .gt6_drpdo               (gt6_drpdo),
  .gt6_drprdy              (gt6_drprdy),

  .gt7_drpaddr             (gt7_drpaddr),
  .gt7_drpdi               (gt7_drpdi),
  .gt7_drpen               (gt7_drpen),
  .gt7_drpwe               (gt7_drpwe),
  .gt7_drpdo               (gt7_drpdo),
  .gt7_drprdy              (gt7_drprdy),

  // System Reset Inputs for each direction
  .tx_sys_reset            (tx_sys_reset),
  .rx_sys_reset            (rx_sys_reset),
  
  // Reset Inputs for each direction
  .tx_reset_gt             (tx_reset_gt),
  .rx_reset_gt             (rx_reset_gt),

  // Reset Done for each direction
  .tx_reset_done           (tx_reset_done),
  .rx_reset_done           (rx_reset_done),

  .gt_powergood            (gt_powergood),

  .cpll_refclk             (cpll_refclk),
  
  .qpll0_reset_out         (qpll0_reset_i),

  // GT Common I/O
  .common0_qpll0_lock_in   (common0_qpll0_lock_i),
  .common0_qpll0_refclk_in (common0_qpll0_refclk_i),
  .common0_qpll0_clk_in    (common0_qpll0_clk_i),
  .common1_qpll0_lock_in   (common1_qpll0_lock_i),
  .common1_qpll0_refclk_in (common1_qpll0_refclk_i),
  .common1_qpll0_clk_in    (common1_qpll0_clk_i),
 
  .rxencommaalign          (rxencommaalign),
  
  // Clocks
  .tx_core_clk             (tx_core_clk),
  .txoutclk                (txoutclk_i),

  .rx_core_clk             (rx_core_clk),  
  .rxoutclk                (rxoutclk_i),

  .drpclk                  (drpclk),

  .gt_prbssel              (gt_prbssel),

  // Tx Ports
  // Lane 0
  .gt0_txcharisk           (gt0_txcharisk),
  .gt0_txdata              (gt0_txdata),

  // Lane 1
  .gt1_txcharisk           (gt1_txcharisk),
  .gt1_txdata              (gt1_txdata),

  // Lane 2
  .gt2_txcharisk           (gt2_txcharisk),
  .gt2_txdata              (gt2_txdata),

  // Lane 3
  .gt3_txcharisk           (gt3_txcharisk),
  .gt3_txdata              (gt3_txdata),

  // Lane 4
  .gt4_txcharisk           (gt4_txcharisk),
  .gt4_txdata              (gt4_txdata),

  // Lane 5
  .gt5_txcharisk           (gt5_txcharisk),
  .gt5_txdata              (gt5_txdata),

  // Lane 6
  .gt6_txcharisk           (gt6_txcharisk),
  .gt6_txdata              (gt6_txdata),

  // Lane 7
  .gt7_txcharisk           (gt7_txcharisk),
  .gt7_txdata              (gt7_txdata),

  // Rx Ports
  // Lane 0
  .gt0_rxcharisk           (gt0_rxcharisk),
  .gt0_rxdisperr           (gt0_rxdisperr),
  .gt0_rxnotintable        (gt0_rxnotintable),
  .gt0_rxdata              (gt0_rxdata),

  // Lane 1
  .gt1_rxcharisk           (gt1_rxcharisk),
  .gt1_rxdisperr           (gt1_rxdisperr),
  .gt1_rxnotintable        (gt1_rxnotintable),
  .gt1_rxdata              (gt1_rxdata),

  // Lane 2
  .gt2_rxcharisk           (gt2_rxcharisk),
  .gt2_rxdisperr           (gt2_rxdisperr),
  .gt2_rxnotintable        (gt2_rxnotintable),
  .gt2_rxdata              (gt2_rxdata),

  // Lane 3
  .gt3_rxcharisk           (gt3_rxcharisk),
  .gt3_rxdisperr           (gt3_rxdisperr),
  .gt3_rxnotintable        (gt3_rxnotintable),
  .gt3_rxdata              (gt3_rxdata),

  // Lane 4
  .gt4_rxcharisk           (gt4_rxcharisk),
  .gt4_rxdisperr           (gt4_rxdisperr),
  .gt4_rxnotintable        (gt4_rxnotintable),
  .gt4_rxdata              (gt4_rxdata),

  // Lane 5
  .gt5_rxcharisk           (gt5_rxcharisk),
  .gt5_rxdisperr           (gt5_rxdisperr),
  .gt5_rxnotintable        (gt5_rxnotintable),
  .gt5_rxdata              (gt5_rxdata),

  // Lane 6
  .gt6_rxcharisk           (gt6_rxcharisk),
  .gt6_rxdisperr           (gt6_rxdisperr),
  .gt6_rxnotintable        (gt6_rxnotintable),
  .gt6_rxdata              (gt6_rxdata),

  // Lane 7
  .gt7_rxcharisk           (gt7_rxcharisk),
  .gt7_rxdisperr           (gt7_rxdisperr),
  .gt7_rxnotintable        (gt7_rxnotintable),
  .gt7_rxdata              (gt7_rxdata),

  // Serial ports
  .rxn_in                  (rxn_in),
  .rxp_in                  (rxp_in),
  .txn_out                 (txn_out),
  .txp_out                 (txp_out)
  );

//*******************************************
//Instantiate Common GT Module
//*******************************************
jesd204_phy_0_gt_common_wrapper
jesd204_phy_gt_common_0_i
  (
  //DRP Ports
  .common_drpclk           (1'b0),
  .common_drpaddr          (16'b0),
  .common_drpdi            (16'b0),
  .common_drpen            (1'b0),
  .common_drpwe            (1'b0),
  .common_drpdo            (),
  .common_drprdy           (),

  //QPLL0 Ports
  .common_gtrefclk0        (qpll0_refclk),
  .common_qpll0_reset      (qpll0_reset_i),
  .common_qpll0_lock       (common0_qpll0_lock_i),
  .common_qpll0_outrefclk  (common0_qpll0_refclk_i),
  .common_qpll0_outclk     (common0_qpll0_clk_i),
  .common_qpll0_pd         (1'b0),

  //QPLL1 Ports
  .common_gtrefclk1        (1'b0),
  .common_qpll1_reset      (1'b0),
  .common_qpll1_lock       (),
  .common_qpll1_outrefclk  (),
  .common_qpll1_outclk     (),
  .common_qpll1_pd         (1'b1)
  );

jesd204_phy_0_gt_common_wrapper
jesd204_phy_gt_common_1_i
  (
  //DRP Ports
  .common_drpclk           (1'b0),
  .common_drpaddr          (16'b0),
  .common_drpdi            (16'b0),
  .common_drpen            (1'b0),
  .common_drpwe            (1'b0),
  .common_drpdo            (),
  .common_drprdy           (),

  //QPLL0 Ports
  .common_gtrefclk0        (qpll0_refclk),
  .common_qpll0_reset      (qpll0_reset_i),
  .common_qpll0_lock       (common1_qpll0_lock_i),
  .common_qpll0_outrefclk  (common1_qpll0_refclk_i),
  .common_qpll0_outclk     (common1_qpll0_clk_i),
  .common_qpll0_pd         (1'b0),

  //QPLL1 Ports
  .common_gtrefclk1        (1'b0),
  .common_qpll1_reset      (1'b0),
  .common_qpll1_lock       (),
  .common_qpll1_outrefclk  (),
  .common_qpll1_outclk     (),
  .common_qpll1_pd         (1'b1)
  );

  // Assign QPLL0 Common Output Ports
  assign common0_qpll0_lock_out    =  common0_qpll0_lock_i;
  assign common0_qpll0_refclk_out  =  common0_qpll0_refclk_i;
  assign common0_qpll0_clk_out     =  common0_qpll0_clk_i;
  assign common1_qpll0_lock_out    =  common1_qpll0_lock_i;
  assign common1_qpll0_refclk_out  =  common1_qpll0_refclk_i;
  assign common1_qpll0_clk_out     =  common1_qpll0_clk_i;

endmodule
