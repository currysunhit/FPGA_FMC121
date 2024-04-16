//----------------------------------------------------------------------------
// Title : JESD204 Wrapper
// Project : JESD204
//----------------------------------------------------------------------------
// File : jesd204b_ad.v
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

(* CORE_GENERATION_INFO = "jesd204b_ad,jesd204_v7_2_4,{x_ipProduct=Vivado 2018.3,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=jesd204,x_ipVersion=7.2,x_ipCoreRevision=4,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,x_ipLicense=jesd204@2017.10(bought),C_COMPONENT_NAME=jesd204b_ad,C_FAMILY=zynquplus,C_NODE_IS_TRANSMIT=0,C_LANES=4,C_SPEEDGRADE=-2,C_LMFC_BUFFER_SIZE=6,C_SupportLevel=0,C_USE_RPAT=false,C_USE_JSPAT=false,C_TransceiverControl=false,c_sub_core_name=jesd204b_ad_phy,C_GT_Line_Rate=10,C_GT_REFCLK_FREQ=250,C_DRPCLK_FREQ=100,C_SYSREF_SAMPLING_EDGE=0,C_PLL_SELECTION=1,C_Global_clk_sel=true,C_DEFAULT_SCR=0,C_DEFAULT_F=1,C_DEFAULT_K=20,C_DEFAULT_SYSREF_ALWAYS=1,C_DEFAULT_SYSREF_REQUIRED=1,C_AXICLK_FREQ=100.0,C_Transceiver=GTHE4}" *)
(* X_CORE_INFO = "jesd204_v7_2_4,Vivado 2018.3" *)

(* DowngradeIPIdentifiedWarnings = "yes" *)
module jesd204b_ad
(



  // Rx
  input          rx_reset,
  input          rx_core_clk,

  input          rx_sysref,
  output         rx_sync,


  // Rx AXI-S interface for each lane
  output         rx_aresetn,

  output  [3:0]  rx_start_of_frame,
  output  [3:0]  rx_end_of_frame,
  output  [3:0]  rx_start_of_multiframe,
  output  [3:0]  rx_end_of_multiframe,
  output [15:0]  rx_frame_error,

  output         rx_tvalid,
  output [127:0] rx_tdata,


  // Ports Required for GT
  output         rx_reset_gt,
  output         rxencommaalign_out,
  input          rx_reset_done,

  // Lane 0
  input [31:0]   gt0_rxdata,
  input [3:0]    gt0_rxcharisk,
  input [3:0]    gt0_rxdisperr,
  input [3:0]    gt0_rxnotintable,

  // Lane 1
  input [31:0]   gt1_rxdata,
  input [3:0]    gt1_rxcharisk,
  input [3:0]    gt1_rxdisperr,
  input [3:0]    gt1_rxnotintable,

  // Lane 2
  input [31:0]   gt2_rxdata,
  input [3:0]    gt2_rxcharisk,
  input [3:0]    gt2_rxdisperr,
  input [3:0]    gt2_rxnotintable,

  // Lane 3
  input [31:0]   gt3_rxdata,
  input [3:0]    gt3_rxcharisk,
  input [3:0]    gt3_rxdisperr,
  input [3:0]    gt3_rxnotintable,



  // AXI-Lite Control/Status
  input          s_axi_aclk,
  input          s_axi_aresetn,
  input  [11:0]  s_axi_awaddr,
  input          s_axi_awvalid,
  output         s_axi_awready,
  input  [31:0]  s_axi_wdata,
  input   [3:0]  s_axi_wstrb,
  input          s_axi_wvalid,
  output         s_axi_wready,
  output  [1:0]  s_axi_bresp,
  output         s_axi_bvalid,
  input          s_axi_bready,
  input  [11:0]  s_axi_araddr,
  input          s_axi_arvalid,
  output         s_axi_arready,
  output [31:0]  s_axi_rdata,
  output  [1:0]  s_axi_rresp,
  output         s_axi_rvalid,
  input          s_axi_rready
  );

  //------------------------------------------------------------
  // Instantiate the JESD204 core
  //------------------------------------------------------------
jesd204b_ad_block #(
  .C_COMPONENT_NAME            ("jesd204b_ad"),
  .C_FAMILY                    ("zynquplus"),
  .C_NODE_IS_TRANSMIT          (0),
  .C_LMFC_BUFFER_SIZE          (6),
  .C_LANES                     (4)
  )
  inst(

  // Rx
  .rx_reset              (rx_reset),
  .rx_core_clk           (rx_core_clk),

  .rx_sysref              (rx_sysref),
  .rx_sync                (rx_sync),


  .rx_aresetn             (rx_aresetn),

  .rx_frame_error         (rx_frame_error),
  .rx_start_of_frame      (rx_start_of_frame),
  .rx_start_of_multiframe (rx_start_of_multiframe),
  .rx_end_of_multiframe   (rx_end_of_multiframe),
  .rx_end_of_frame        (rx_end_of_frame),

  .rx_tdata               (rx_tdata),
  .rx_tvalid              (rx_tvalid),


  // Ports Required for GT
  .rx_reset_gt            (rx_reset_gt),
  .rxencommaalign_out     (rxencommaalign_out),
  .rx_reset_done          (rx_reset_done),

  // Lane 0
  .gt0_rxdata              (gt0_rxdata),
  .gt0_rxcharisk           (gt0_rxcharisk),
  .gt0_rxdisperr           (gt0_rxdisperr),
  .gt0_rxnotintable        (gt0_rxnotintable),

  // Lane 1
  .gt1_rxdata              (gt1_rxdata),
  .gt1_rxcharisk           (gt1_rxcharisk),
  .gt1_rxdisperr           (gt1_rxdisperr),
  .gt1_rxnotintable        (gt1_rxnotintable),

  // Lane 2
  .gt2_rxdata              (gt2_rxdata),
  .gt2_rxcharisk           (gt2_rxcharisk),
  .gt2_rxdisperr           (gt2_rxdisperr),
  .gt2_rxnotintable        (gt2_rxnotintable),

  // Lane 3
  .gt3_rxdata              (gt3_rxdata),
  .gt3_rxcharisk           (gt3_rxcharisk),
  .gt3_rxdisperr           (gt3_rxdisperr),
  .gt3_rxnotintable        (gt3_rxnotintable),


  // AXI-Lite Control/Status
  .s_axi_aclk             (s_axi_aclk),
  .s_axi_aresetn          (s_axi_aresetn),
  .s_axi_awaddr           (s_axi_awaddr),
  .s_axi_awvalid          (s_axi_awvalid),
  .s_axi_awready          (s_axi_awready),
  .s_axi_wdata            (s_axi_wdata),
  .s_axi_wstrb            (s_axi_wstrb),
  .s_axi_wvalid           (s_axi_wvalid),
  .s_axi_wready           (s_axi_wready),
  .s_axi_bresp            (s_axi_bresp),
  .s_axi_bvalid           (s_axi_bvalid),
  .s_axi_bready           (s_axi_bready),
  .s_axi_araddr           (s_axi_araddr),
  .s_axi_arvalid          (s_axi_arvalid),
  .s_axi_arready          (s_axi_arready),
  .s_axi_rdata            (s_axi_rdata),
  .s_axi_rresp            (s_axi_rresp),
  .s_axi_rvalid           (s_axi_rvalid),
  .s_axi_rready           (s_axi_rready)
  );

endmodule
