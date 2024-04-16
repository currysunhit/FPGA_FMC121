`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/02 09:46:44
// Design Name: 
// Module Name: FIR_filter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FIR_filter(
    input [15:0] ad_I0,
    input [15:0] ad_I1,
    input [15:0] ad_I2,
    input [15:0] ad_I3,
    input aclk,
    input data_tvalid,
    output I0_data_tready,
    output I1_data_tready,
    output I2_data_tready,
    output I3_data_tready,
    output I0_data_tvalid,
    output I1_data_tvalid,
    output I2_data_tvalid,
    output I3_data_tvalid,
    output [31:0] I0_data_tdata,
    output [31:0] I1_data_tdata,
    output [31:0] I2_data_tdata,
    output [31:0] I3_data_tdata
    );
    
    fir_compiler_0 u0_FIR_LP_100M (
  .aclk(aclk),                              // input wire aclk
  .s_axis_data_tvalid(data_tvalid),  // input wire s_axis_data_tvalid
  .s_axis_data_tready(I0_data_tready),  // output wire s_axis_data_tready
  .s_axis_data_tdata(ad_I0),    // input wire [15 : 0] s_axis_data_tdata
  .m_axis_data_tvalid(I0_data_tvalid),  // output wire m_axis_data_tvalid
  .m_axis_data_tdata(I0_data_tdata)    // output wire [31 : 0] m_axis_data_tdata
);

    fir_compiler_0 u1_FIR_LP_100M (
  .aclk(aclk),                              // input wire aclk
  .s_axis_data_tvalid(data_tvalid),  // input wire s_axis_data_tvalid
  .s_axis_data_tready(I1_data_tready),  // output wire s_axis_data_tready
  .s_axis_data_tdata(ad_I1),    // input wire [15 : 0] s_axis_data_tdata
  .m_axis_data_tvalid(I1_data_tvalid),  // output wire m_axis_data_tvalid
  .m_axis_data_tdata(I1_data_tdata)    // output wire [31 : 0] m_axis_data_tdata
);
    
    fir_compiler_0 u2_FIR_LP_100M (
  .aclk(aclk),                              // input wire aclk
  .s_axis_data_tvalid(data_tvalid),  // input wire s_axis_data_tvalid
  .s_axis_data_tready(I2_data_tready),  // output wire s_axis_data_tready
  .s_axis_data_tdata(ad_I2),    // input wire [15 : 0] s_axis_data_tdata
  .m_axis_data_tvalid(I2_data_tvalid),  // output wire m_axis_data_tvalid
  .m_axis_data_tdata(I2_data_tdata)    // output wire [31 : 0] m_axis_data_tdata
);

    fir_compiler_0 u3_FIR_LP_100M (
  .aclk(aclk),                              // input wire aclk
  .s_axis_data_tvalid(data_tvalid),  // input wire s_axis_data_tvalid
  .s_axis_data_tready(I3_data_tready),  // output wire s_axis_data_tready
  .s_axis_data_tdata(ad_I3),    // input wire [15 : 0] s_axis_data_tdata
  .m_axis_data_tvalid(I3_data_tvalid),  // output wire m_axis_data_tvalid
  .m_axis_data_tdata(I3_data_tdata)    // output wire [31 : 0] m_axis_data_tdata
);

endmodule
