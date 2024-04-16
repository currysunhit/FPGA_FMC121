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

// IP VLNV: xilinx.com:ip:jesd204:7.2
// IP Revision: 4

// The following must be inserted into your Verilog file for this
// core to be instantiated. Change the instance name and port connections
// (in parentheses) to your own signal names.

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
jesd204b_ad your_instance_name (
  .gt0_rxdata(gt0_rxdata),                          // input wire [31 : 0] gt0_rxdata
  .gt0_rxcharisk(gt0_rxcharisk),                    // input wire [3 : 0] gt0_rxcharisk
  .gt0_rxdisperr(gt0_rxdisperr),                    // input wire [3 : 0] gt0_rxdisperr
  .gt0_rxnotintable(gt0_rxnotintable),              // input wire [3 : 0] gt0_rxnotintable
  .gt1_rxdata(gt1_rxdata),                          // input wire [31 : 0] gt1_rxdata
  .gt1_rxcharisk(gt1_rxcharisk),                    // input wire [3 : 0] gt1_rxcharisk
  .gt1_rxdisperr(gt1_rxdisperr),                    // input wire [3 : 0] gt1_rxdisperr
  .gt1_rxnotintable(gt1_rxnotintable),              // input wire [3 : 0] gt1_rxnotintable
  .gt2_rxdata(gt2_rxdata),                          // input wire [31 : 0] gt2_rxdata
  .gt2_rxcharisk(gt2_rxcharisk),                    // input wire [3 : 0] gt2_rxcharisk
  .gt2_rxdisperr(gt2_rxdisperr),                    // input wire [3 : 0] gt2_rxdisperr
  .gt2_rxnotintable(gt2_rxnotintable),              // input wire [3 : 0] gt2_rxnotintable
  .gt3_rxdata(gt3_rxdata),                          // input wire [31 : 0] gt3_rxdata
  .gt3_rxcharisk(gt3_rxcharisk),                    // input wire [3 : 0] gt3_rxcharisk
  .gt3_rxdisperr(gt3_rxdisperr),                    // input wire [3 : 0] gt3_rxdisperr
  .gt3_rxnotintable(gt3_rxnotintable),              // input wire [3 : 0] gt3_rxnotintable
  .rx_reset_done(rx_reset_done),                    // input wire rx_reset_done
  .rxencommaalign_out(rxencommaalign_out),          // output wire rxencommaalign_out
  .rx_reset_gt(rx_reset_gt),                        // output wire rx_reset_gt
  .rx_core_clk(rx_core_clk),                        // input wire rx_core_clk
  .s_axi_aclk(s_axi_aclk),                          // input wire s_axi_aclk
  .s_axi_aresetn(s_axi_aresetn),                    // input wire s_axi_aresetn
  .s_axi_awaddr(s_axi_awaddr),                      // input wire [11 : 0] s_axi_awaddr
  .s_axi_awvalid(s_axi_awvalid),                    // input wire s_axi_awvalid
  .s_axi_awready(s_axi_awready),                    // output wire s_axi_awready
  .s_axi_wdata(s_axi_wdata),                        // input wire [31 : 0] s_axi_wdata
  .s_axi_wstrb(s_axi_wstrb),                        // input wire [3 : 0] s_axi_wstrb
  .s_axi_wvalid(s_axi_wvalid),                      // input wire s_axi_wvalid
  .s_axi_wready(s_axi_wready),                      // output wire s_axi_wready
  .s_axi_bresp(s_axi_bresp),                        // output wire [1 : 0] s_axi_bresp
  .s_axi_bvalid(s_axi_bvalid),                      // output wire s_axi_bvalid
  .s_axi_bready(s_axi_bready),                      // input wire s_axi_bready
  .s_axi_araddr(s_axi_araddr),                      // input wire [11 : 0] s_axi_araddr
  .s_axi_arvalid(s_axi_arvalid),                    // input wire s_axi_arvalid
  .s_axi_arready(s_axi_arready),                    // output wire s_axi_arready
  .s_axi_rdata(s_axi_rdata),                        // output wire [31 : 0] s_axi_rdata
  .s_axi_rresp(s_axi_rresp),                        // output wire [1 : 0] s_axi_rresp
  .s_axi_rvalid(s_axi_rvalid),                      // output wire s_axi_rvalid
  .s_axi_rready(s_axi_rready),                      // input wire s_axi_rready
  .rx_reset(rx_reset),                              // input wire rx_reset
  .rx_aresetn(rx_aresetn),                          // output wire rx_aresetn
  .rx_tdata(rx_tdata),                              // output wire [127 : 0] rx_tdata
  .rx_tvalid(rx_tvalid),                            // output wire rx_tvalid
  .rx_start_of_frame(rx_start_of_frame),            // output wire [3 : 0] rx_start_of_frame
  .rx_end_of_frame(rx_end_of_frame),                // output wire [3 : 0] rx_end_of_frame
  .rx_start_of_multiframe(rx_start_of_multiframe),  // output wire [3 : 0] rx_start_of_multiframe
  .rx_end_of_multiframe(rx_end_of_multiframe),      // output wire [3 : 0] rx_end_of_multiframe
  .rx_frame_error(rx_frame_error),                  // output wire [15 : 0] rx_frame_error
  .rx_sysref(rx_sysref),                            // input wire rx_sysref
  .rx_sync(rx_sync)                                // output wire rx_sync
);
// INST_TAG_END ------ End INSTANTIATION Template ---------

// You must compile the wrapper file jesd204b_ad.v when simulating
// the core, jesd204b_ad. When compiling the wrapper file, be sure to
// reference the Verilog simulation library.

