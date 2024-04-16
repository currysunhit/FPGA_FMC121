
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
module jesd204_phy_0_reset_control (
  input        clk,
  input        tx_sys_rst,   // Complete Tx reset process
  input        rx_sys_rst,   // Complete Rx reset process
  input        tx_data_rst,  // Tx data path reset process
  input        rx_data_rst,  // Rx data path reset process
  input        tx_rst_done,  // Tx reset done signal from GT reset module
  input        rx_rst_done,  // Rx reset done signal from GT reset module
  output reg   tx_rst_all,
  output reg   rx_rst_all,
  output reg   tx_rst_data,
  output reg   rx_rst_data
);

  // Declare local parameters used to represent both static and variable state machine state values
  localparam  TX_START     = 1'd0;
  localparam  TX_IDLE      = 1'd1;
  reg         tx_state     = TX_START;
  
  localparam  RX_START     = 1'd0;
  localparam  RX_IDLE      = 1'd1;
  reg         rx_state     = RX_START;
  
  // The State Machines monitor the reset inputs and generate the correct reset required by the GT
  // They also check for a loss of PLL Lock when the rst_done signal goes low. In this case a complete
  // reset is performed.  
  
  always @(posedge clk) begin
    if (tx_sys_rst) begin
      tx_state           <= TX_START;
      tx_rst_all         <= 1'b1;
    end
    else if (tx_data_rst) begin
      tx_state           <= TX_START;
      tx_rst_data        <= 1'b1;
    end    
    else begin
      case (tx_state)  
      
        TX_START: begin
          tx_rst_all     <= 1'b0;
          tx_rst_data    <= 1'b0;
          if (tx_rst_done)
            tx_state     <= TX_IDLE;
          else
            tx_state     <= TX_START;
        end
        
        TX_IDLE: begin
          if (!tx_rst_done) begin
            tx_state     <= TX_START;
            tx_rst_all   <= 1'b1;
          end  
          else
            tx_state     <= TX_IDLE;
        end        
        
        default: begin
          tx_rst_data        <= 1'b0;
          tx_rst_all         <= 1'b0;
        end        
      endcase
    end
  end   

  always @(posedge clk) begin
    if (rx_sys_rst) begin
      rx_state           <= RX_START;
      rx_rst_all         <= 1'b1;
    end
    else if (rx_data_rst) begin
      rx_state           <= RX_START;
      rx_rst_data        <= 1'b1;
    end    
    else begin
      case (rx_state)  
      
        RX_START: begin
          rx_rst_all     <= 1'b0;
          rx_rst_data    <= 1'b0;
          if (rx_rst_done)
            rx_state     <= RX_IDLE;
          else
            rx_state     <= RX_START;
        end
        
        RX_IDLE: begin
          if (!rx_rst_done) begin
            rx_state     <= RX_START;
            rx_rst_all   <= 1'b1;
          end  
          else
            rx_state     <= RX_IDLE;
        end        
        
        default: begin
          rx_rst_data        <= 1'b0;
          rx_rst_all         <= 1'b0;
        end        
      endcase
    end
  end      
  
endmodule
