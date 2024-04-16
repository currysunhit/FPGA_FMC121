`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/02 15:25:27
// Design Name: 
// Module Name: pulse_sum_module
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


module pulse_sum_module(
    input clk,
    input rst_n,
    input [15:0] data_in0,  //AD I0
    input [15:0] data_in1,  //AD I1
    input [15:0] data_in2,  //AD I2
    input [15:0] data_in3,  //AD I3
    output reg [19:0] pulse_sum, //脉冲积分
    output reg real_pulse,  //脉冲有效标志信号
    output reg signal_en,  //脉冲到来标志信号
    output reg [23:0] cnt
    );
    
    wire [11:0] CNT_low;
    wire [11:0] CNT_high;
    wire [15:0] signal_ref;
    
    vio_1 u_pulse_parameter (
  .clk(clk),                // input wire clk
  .probe_out0(CNT_low),  // output wire [11 : 0] probe_out0
  .probe_out1(CNT_high),  // output wire [11 : 0] probe_out1
  .probe_out2(signal_ref)  // output wire [15 : 0] probe_out2
);
    
    reg signal_en_d0;
    reg signal_en_d1;
    reg real_pulse1;
    
    wire pulse_en;
    wire pulse_en1;
    
    reg [23:0] pulse_cnt;
    
    reg [19:0] data_sum; //脉冲积分
    reg [19:0] data_sum1;
    
    
    //I0+I1+I2+I3-4*baseline
    reg [17:0] ad_data_in;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            ad_data_in <= 18'd0;
        else
            ad_data_in <= data_in0 + data_in1 + data_in2 + data_in3 - 4*signal_ref;
    end
    
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            signal_en <= 1'b0;
        else if(data_in0>signal_ref && data_in1>signal_ref && data_in2>signal_ref && data_in3>signal_ref)
            signal_en <= 1'b1;
        else
            signal_en <= 1'b0;
    end
    
    //脉冲积分完成
always @(posedge clk, negedge rst_n) begin
	if(!rst_n) begin
		signal_en_d0 <= 1'b0;
		signal_en_d1 <= 1'b0;
	end
	else begin
		signal_en_d0 <= signal_en;
		signal_en_d1 <= signal_en_d0;
	end
end

assign pulse_en = signal_en_d0 & (~signal_en);
assign pulse_en1 = signal_en_d1 & (~signal_en_d0);
    
    //求脉冲面积
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            data_sum <= 20'd0;
            cnt <= 24'd0;
        end
        else if(signal_en) begin
            cnt <= cnt + 1'b1;
            data_sum <= data_sum + ad_data_in;
        end
        else begin
            cnt <= 24'd0;
            data_sum <= 20'd0;
        end
    end
    
    //
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            pulse_cnt <= 24'd0;
            data_sum1 <= 20'd0;
        end
        else if(pulse_en) begin
            pulse_cnt <= cnt;
            data_sum1 <= data_sum;
        end
    end
    
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            real_pulse1 <= 1'b0;
        else if(pulse_en1) begin
            if((pulse_cnt > CNT_low) &&(pulse_cnt < CNT_high))
                real_pulse1 <= 1'b1;
        end
        else
            real_pulse1 <= 1'b0;
    end
    
    
    //保存峰值与计数
always @(posedge clk, negedge rst_n) begin
	if(!rst_n) begin
		real_pulse <= 1'b0;
		pulse_sum <= 20'd0;
	end
	else if(real_pulse1) begin
		real_pulse <= 1'b1;
		pulse_sum <= data_sum1;
	end
	else begin
		real_pulse <= 1'b0;
		pulse_sum <= pulse_sum;
	end
end
    
endmodule
