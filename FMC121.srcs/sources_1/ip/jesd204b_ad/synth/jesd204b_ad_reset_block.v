
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
module jesd204b_ad_reset_block (
  input        axi_clk,
  input        core_clk,
  input        reset,           //async reset
  input        cfg_reset, 
  input        gt_reset_done,
  output reg   core_reset_reg,      // Used to drive AXI register
  output       core_reset_sync, // Used to drive JESD204 reset input
  output       gt_reset

);

  localparam  stretch_len   = 11;
  reg  [stretch_len-1:0]  stretch;      
 
  
  // Declare local parameters used to represent both static and variable state machine state values
  localparam  RELEASE_RST   = 1'b0;
  localparam  HOLD_RST      = 1'b1;
  reg         state         = RELEASE_RST;
  
  wire        gt_reset_done_r;

  // Clock Domain Synchronizers
  xpm_cdc_single #(
  .DEST_SYNC_FF  (5), // Number of registers in the destination clock domain to account for MTBF
  .SRC_INPUT_REG (0)  // Determines whether there is an input register in src_clk domain.  
                      // SRC_INPUT_REG = 0, input register is not present
  ) sync_gt_resetdone  (
  .dest_clk (axi_clk),	
  .src_clk  (1'd0),	
  .src_in   (gt_reset_done),
  .dest_out (gt_reset_done_r)
  );
  
  xpm_cdc_async_rst #(
    //Common module parameters
    .DEST_SYNC_FF    (5), // integer; range: 2-10
    .RST_ACTIVE_HIGH (1)  // integer; 0=active low reset, 1=active high reset
  ) sync_core_rst (
    .src_arst  (core_reset_reg),
    .dest_clk  (core_clk),
    .dest_arst (core_reset_sync)
  );  
  
  // Generate reset
  always @(posedge axi_clk or posedge reset)
  begin
    if (reset) begin
      state <= HOLD_RST;
      core_reset_reg <= 1'b1;
    end
    else begin
      if (cfg_reset) begin
        state <= HOLD_RST;
        core_reset_reg <= 1'b1;    
      end
      else begin    
        case (state)     
        
          HOLD_RST: begin
            if (~gt_reset_done_r)
              state <= RELEASE_RST;
          end
          
          RELEASE_RST: begin
            if (gt_reset_done_r == 1'b1) begin
              state <= RELEASE_RST;
              core_reset_reg <= 1'b0;
            end
            else begin
              state <= RELEASE_RST;
              core_reset_reg <= 1'b1;
            end
          end
          
          default: begin
            core_reset_reg <= 1'b0;
            state <= RELEASE_RST;
          end        
        endcase
      end
    end      
  end 
  
  // Stretch gt_reset 
  always @(posedge axi_clk or posedge reset)
  begin
    if (reset)
      stretch <= {stretch_len{1'b1}}; 
    else begin
      if (cfg_reset)  
        stretch <= {stretch_len{1'b1}};  
      else
        stretch <= {stretch[stretch_len-2:0], 1'b0};
    end      
  end  
  
  assign gt_reset = stretch[stretch_len-1];
  
endmodule
