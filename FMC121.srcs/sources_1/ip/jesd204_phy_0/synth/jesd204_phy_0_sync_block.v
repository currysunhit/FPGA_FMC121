////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Filename : jesd204_phy_0_sync_block.v
//  \   \         
//  /   /         
// /___/   /\     
// \   \  /  \ 
//  \___\/\___\ 
//
//
// Description: Used on signals crossing from one clock domain to
//              another. Thus the routing delay between the two 
//              is minimum to safe-guard against metastability issues.
//                     
//
//
// Module jesd204_phy_0_sync_block
// 
// 
// 
// (c) Copyright 2010-2012 Xilinx, Inc. All rights reserved.
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



//------------------------------------------------------------------------------

`timescale 1ps / 1ps
`define USE_XPM_CDC

//(* dont_touch = "yes" *)
module jesd204_phy_0_sync_block #(
  parameter INITIALISE = 1'b0,
  parameter TYPE = 1'b0   //Set to 1 only for reset synchronizer 
)
(
  input        clk,              // clock to be sync'ed to
  input        data_in,          // Data to be 'synced'
  output       data_out          // synced data
);

`ifdef USE_XPM_CDC
  wire data_tmp;
  generate
  if (TYPE == 0)
  begin  
    // Use the new Xilinx CDC libraries. 
    xpm_cdc_single #(
      .DEST_SYNC_FF  (4), // Number of registers in the destination clock domain to account for MTBF
      .SRC_INPUT_REG (0)  // Determines whether there is an input register in src_clk domain.  
                        // SRC_INPUT_REG = 0, input register is not present
    ) cdc_i  (
      .src_clk  (1'd0     ),	
      .dest_clk (clk      ),	
      .src_in   (data_in  ),
      .dest_out (data_tmp )
    );

  end
  else begin
    xpm_cdc_async_rst #(
      //Common module parameters
      .DEST_SYNC_FF    (5), // integer; range: 2-10
      .RST_ACTIVE_HIGH (1)  // integer; 0=active low reset, 1=active high reset
    ) xpm_cdc_async_rst_inst (
      .src_arst  (data_in),
      .dest_clk  (clk),
      .dest_arst (data_tmp)
    );  
  end
  endgenerate
  
  (* ASYNC_REG = "TRUE", SHREG_EXTRACT = "NO" *)
  FD #(
    .INIT (INITIALISE[0])
  ) data_sync_reg_gsr (
    .C  (clk     ),
    .D  (data_tmp),
    .Q  (data_out)
  );

`else
  // Internal Signals
  wire   data_sync0;
  wire   data_sync1;
  wire   data_sync2;
  wire   data_sync3;
  wire   data_sync4;


  (* ASYNC_REG = "TRUE", SHREG_EXTRACT = "NO" *)
  FD #(
    .INIT (INITIALISE[0])
  ) data_sync_reg0 (
    .C  (clk),
    .D  (data_in),
    .Q  (data_sync0)
  );

  (* ASYNC_REG = "TRUE", SHREG_EXTRACT = "NO" *)
  FD #(
   .INIT (INITIALISE[0])
  ) data_sync_reg1 (
  .C  (clk),
  .D  (data_sync0),
  .Q  (data_sync1)
  );

  (* ASYNC_REG = "TRUE", SHREG_EXTRACT = "NO" *)
  FD #(
   .INIT (INITIALISE[0])
  ) data_sync_reg2 (
  .C  (clk),
  .D  (data_sync1),
  .Q  (data_sync2)
  );

  (* ASYNC_REG = "TRUE", SHREG_EXTRACT = "NO" *)
  FD #(
   .INIT (INITIALISE[0])
  ) data_sync_reg3 (
  .C  (clk),
  .D  (data_sync2),
  .Q  (data_sync3)
  );

  (* ASYNC_REG = "TRUE", SHREG_EXTRACT = "NO" *)
  FD #(
   .INIT (INITIALISE[0])
  ) data_sync_reg4 (
  .C  (clk),
  .D  (data_sync3),
  .Q  (data_sync4)
  );

  assign data_out = data_sync4;
`endif

endmodule
