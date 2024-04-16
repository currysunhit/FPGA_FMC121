//----------------------------------------------------------------------------
// Title : Link Error Counter
// Project : JESD204
//----------------------------------------------------------------------------
// File : jesd204b_ad_count_err.v
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
module jesd204b_ad_count_err (
  input         clk,
  input         rst,
  input         enable,
  input  [3:0]  disp_err,
  input  [3:0]  notintable_err,
  output [31:0] data_out
);

reg   [3:0] disp_errs;
reg   [3:0] notb_errs;

reg  [31:0] error_count;
wire  [3:0] error_bit; //1 bit per byte
reg   [2:0] error_add; //0-4

//register incoming singals because they come straight from the GT.
always @(posedge clk)
begin
  disp_errs <= disp_err;
  notb_errs <= notintable_err;
end

//count the number of error bytes.  
assign error_bit = disp_errs | notb_errs;

//help the synthesis tool. We just need a 4 IP LUT for this.
always @*
begin
  case(error_bit)
    4'b0001, 4'b0010, 4'b0100, 4'b1000:
      error_add <= 3'd1;
    4'b0011, 4'b0101, 4'b1001, 4'b0110, 4'b1010, 4'b1100:
      error_add <= 3'd2;
    4'b1110, 4'b1101, 4'b1011, 4'b0111:
      error_add <= 3'd3;
    4'b1111:
      error_add <= 3'd4;
    default:
      error_add <= 3'd0;
  endcase
end//always
 
always @ (posedge clk) begin
  if (rst | !enable)
    error_count<=32'd0; //clear counter.
  else 
  begin
    if(error_count!=32'hFFFFFFFF)
    begin
      error_count <= error_count + error_add;
    end
  end 
end   

// Assign total number of errors to output
assign data_out = error_count;

endmodule
