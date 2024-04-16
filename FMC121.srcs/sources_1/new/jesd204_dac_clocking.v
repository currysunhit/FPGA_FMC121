`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/20 21:56:18
// Design Name: 
// Module Name: jesd204_dac_clocking
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


module jesd204_dac_clocking
(
  input  wire     refclk_pad_n,
  input  wire     refclk_pad_p,
  output wire     refclk,
  input  wire     gt_pg,
  input  wire     glblclk_pad_n,
  input  wire     glblclk_pad_p,
  

  output          coreclk,
  output          coreclk2
);

//*********************************Wire Declarations**********************************
  wire            tied_to_ground_i;
  wire            tied_to_vcc_i;
  wire            refclk_i;
  wire            coreclk_i;
  wire            refclk_1;
  wire            glblclk_i;
  wire            glblclk_buf;
  wire refclk_2;
  //*********************************** Beginning of Code *******************************

  //  Static signal Assigments
  assign tied_to_ground_i    = 1'b0;
  assign tied_to_vcc_i       = 1'b1;

  //IBUFDS_GTE4
  IBUFDS_GTE4 ibufds_refclk0
  (
    .O               (refclk_i),
    .ODIV2           (refclk_1),
    .CEB             (tied_to_ground_i),
    .I               (refclk_pad_p),
    .IB              (refclk_pad_n)
  );
  

    BUFG_GT refclk_bufg_gt_i(
        .I(refclk_1),
        .CE(gt_pg),
        .CEMASK(tied_to_ground_i),
        .CLR(tied_to_ground_i),
        .CLRMASK(tied_to_ground_i),
        .DIV(3'b000),
        .O(refclk_2)
    );

  //IBUFDS i_glblclk_ibufds (
    //.I  (glblclk_pad_p),
    //.IB (glblclk_pad_n),
    //.O  (glblclk_i)
  //);
  wire glblclk_buf2;
GLB_dcm DCMINST 
 (
   //Clock out ports
  .clk_out1(glblclk_buf),
   //Status and control signals
  .reset(0),
  .locked(),
  //Clock in ports
  .clk_in1(refclk_2)
 );

//  BUFG glbl_bufg_i
//  (
//    .O (glblclk_buf),
//    .I (glblclk_i)
//  );

  assign refclk  = refclk_i;
 assign coreclk = glblclk_buf;
assign coreclk2 = glblclk_buf2;

endmodule
