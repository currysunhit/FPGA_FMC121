// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Fri Mar 17 21:31:35 2023
// Host        : DESKTOP-WORK-MY running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               H:/ZynqUltralScaleXCZU15EG/FMC121_AD/FMC121_AD.srcs/sources_1/ip/vio_1/vio_1_stub.v
// Design      : vio_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu15eg-ffvb1156-2-i
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "vio,Vivado 2018.3" *)
module vio_1(clk, probe_out0, probe_out1, probe_out2)
/* synthesis syn_black_box black_box_pad_pin="clk,probe_out0[11:0],probe_out1[11:0],probe_out2[15:0]" */;
  input clk;
  output [11:0]probe_out0;
  output [11:0]probe_out1;
  output [15:0]probe_out2;
endmodule
