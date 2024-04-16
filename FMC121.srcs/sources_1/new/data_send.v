`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/06 09:44:29
// Design Name: 
// Module Name: data_send
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


module data_send(
    input clk,
    input rst_n,
    input Data_send,
    output data_rd_en,
    output [15:0] addrb
    );
    
    reg     pulse_dly;
    reg [15:0]   cnt;
    reg     highleavel_reg;

always @(posedge clk)
    pulse_dly <= Data_send;

always @(posedge clk or negedge rst_n) begin
    if(rst_n == 1'b0)
        cnt <= 16'd0;
    else if(Data_send == 1'b1 && pulse_dly == 1'b0)
        cnt <= 16'd0;
    else
        cnt <= cnt + 1'b1;
end

wire [15:0] cnt_wire;
assign cnt_wire = cnt;
always @(posedge clk or negedge rst_n) begin
    if(rst_n == 1'b0)
        highleavel_reg <= 1'b0;
    else if(Data_send == 1'b1 && pulse_dly == 1'b0)
        highleavel_reg <= 1'b1;
    else if(cnt == 16'd65535)
        highleavel_reg <= 1'b0;
    else
        highleavel_reg <= highleavel_reg;
end
assign data_rd_en = highleavel_reg;
    reg [15:0] addrb_reg;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            addrb_reg <= 16'd0;
        else if(data_rd_en==1'b1)
            addrb_reg <= addrb_reg + 1'b1;
        else
            addrb_reg <= 16'd0;
    end
    
    assign addrb = addrb_reg;
    
   /* ila_4 data_send_ila (
	.clk(clk), // input wire clk


	.probe0(Data_send), // input wire [0:0]  probe0  
	.probe1(data_rd_en), // input wire [0:0]  probe1 
	.probe2(cnt_wire), // input wire [15:0]  probe2 
	.probe3(addrb) // input wire [15:0]  probe3
);*/
    
endmodule
