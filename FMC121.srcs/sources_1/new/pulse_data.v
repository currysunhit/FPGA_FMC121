`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/28 09:15:25
// Design Name: 
// Module Name: pulse_data
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


module pulse_data(
    input    [15:0] ad_n0,
    input    [15:0] ad_n1,
    input    [15:0] ad_n2,
    input    [15:0] ad_n3,
    input           clk_250m,
    input           clk_50m,
    input           clk_125m,
    input           rst_n,
    input           uart_rxd,
    output          uart_txd
    );
    
    
    reg 	 [12:0]	uart_cnt;
    reg	 			clk_11520_d0;
    reg	 			clk_11520_d1;
    reg 			clk_11520;

//11520Hz
always @(posedge clk_50m, negedge rst_n) begin
	if(!rst_n) 
		uart_cnt     <= 13'd0;
	else if(uart_cnt < 2169)
		uart_cnt     <= uart_cnt + 1'b1;
	else             
		uart_cnt     <= 13'd0;
end

always @(posedge clk_50m, negedge rst_n) begin
	if(!rst_n)
		clk_11520_d0 <= 1'b0;
	else if(uart_cnt == 2169)
		clk_11520_d0 <= ~clk_11520_d0;
end    

always @(posedge clk_50m, negedge rst_n) begin
	if(!rst_n) begin
		clk_11520_d1 <= 1'b0;
		clk_11520    <= 1'b0;
	end
	else begin
		clk_11520_d1 <= clk_11520_d0;
		clk_11520    <= clk_11520_d1;
	end
end
    
   
    wire [39:0] ad_n0_filter;
    wire [39:0] ad_n1_filter;
    wire [39:0] ad_n2_filter;
    wire [39:0] ad_n3_filter;
    wire        I0_fdata_valid;
    wire        I1_fdata_valid;
    wire        I2_fdata_valid;
    wire        I3_fdata_valid;
    
    FIR_filter u_FIR_filter(
    .ad_I0          (ad_n0),
    .ad_I1          (ad_n1),
    .ad_I2          (ad_n2),
    .ad_I3          (ad_n3),
    .aclk           (clk_250m),
    .data_tvalid    (1'b1),
    .I0_data_tready (),
    .I1_data_tready (),
    .I2_data_tready (),
    .I3_data_tready (),
    .I0_data_tvalid (I0_fdata_valid),
    .I1_data_tvalid (I1_fdata_valid),
    .I2_data_tvalid (I2_fdata_valid),
    .I3_data_tvalid (I3_fdata_valid),
    .I0_data_tdata  (ad_n0_filter),
    .I1_data_tdata  (ad_n1_filter),
    .I2_data_tdata  (ad_n2_filter),
    .I3_data_tdata  (ad_n3_filter)
    
    );
    
    wire [19:0] pulse_sum;
    wire        real_pulse;
    wire        signal_en;
    wire [23:0] cnt;

    pulse_sum_module u_pulse_sum(
    .clk            (clk_250m),
    .rst_n          (rst_n),
    .data_in0       (ad_n0_filter[32:17]),  //AD I0
    .data_in1       (ad_n1_filter[32:17]),  //AD I1
    .data_in2       (ad_n2_filter[32:17]),  //AD I2
    .data_in3       (ad_n3_filter[32:17]),  //AD I3
    .pulse_sum      (pulse_sum), //脉冲积分
    .real_pulse     (real_pulse),  //脉冲有效标志信号
    .signal_en      (signal_en),  //脉冲到来标志信号
    .cnt            (cnt)
    );
    
 /*   ila_2 filterdata (
	.clk(clk_250m), // input wire clk
	.probe0(ad_n0_filter[31:0]), // input wire [31:0]  probe0  
	.probe1(I0_fdata_valid), // input wire [0:0]  probe1 
	.probe2(ad_n1_filter[31:0]), // input wire [31:0]  probe2 
	.probe3(I1_fdata_valid), // input wire [0:0]  probe3 
	.probe4(ad_n2_filter[31:0]), // input wire [31:0]  probe4 
	.probe5(I2_fdata_valid), // input wire [0:0]  probe5 
	.probe6(ad_n3_filter[31:0]), // input wire [31:0]  probe6 
	.probe7(I3_fdata_valid) // input wire [0:0]  probe7
);*/
    wire        rw;
    wire [15:0] ram_addr;
    wire [31:0] ram_in_data;
    wire [31:0] ram_out_data;
    //blk ram
    wire [15:0] tx_data;
    wire        PC_clear;
    wire        Data_send;

    wire [15:0] addrb;   
    wire        data_rd_en;
    wire        data_rd;
    assign data_rd = data_rd_en & (~rw);
    
    blk_mem_gen_0 u_blk_mem_gen_0 (
  .clka        (clk_250m),    // input wire clka
  .wea         (rw),      // input wire [0 : 0] wea
  .addra       (ram_addr),  // input wire [15 : 0] addra
  .dina        (ram_in_data),    // input wire [15 : 0] dina
  .douta       (ram_out_data),  // output wire [15 : 0] douta
  .clkb        (clk_125m),    // input wire clkb
  .enb         (data_rd),      // input wire enb
  .web         (1'b0),      // input wire [0 : 0] web
  .addrb       (addrb),  // input wire [15 : 0] addrb
  .dinb        (16'd0),    // input wire [15 : 0] dinb
  .doutb       (tx_data)  // output wire [15 : 0] doutb
);

    //RAM_RW
RAM_rw u_RAM_RW(
	.clk 					(clk_250m),                 
	.rst_n 					(rst_n),                                           
	.pulse_sum              (pulse_sum),
	.real_pulse              (real_pulse),
	.PC_clear               (PC_clear),

	.rw						(rw), 
	.ram_addr				(ram_addr),   
	.ram_in_data            (ram_in_data),
	.ram_out_data           (ram_out_data)
);

    data_send u_data_send(
    .clk                    (clk_125m),
    .rst_n                  (rst_n),
    .Data_send              (Data_send),
    .data_rd_en             (data_rd_en),
    .addrb                  (addrb)
    );                      
    
    /*ila_3 ram_rw_ila (
	.clk(clk_250m), // input wire clk


	.probe0(pulse_sum), // input wire [19:0]  probe0  
	.probe1(real_pulse), // input wire [0:0]  probe1 
	.probe2(PC_clear), // input wire [0:0]  probe2 
	.probe3(Data_send), // input wire [0:0]  probe3 
	.probe4(rw), // input wire [0:0]  probe4 
	.probe5(ram_addr), // input wire [15:0]  probe5 
	.probe6(ram_in_data), // input wire [15:0]  probe6 
	.probe7(addrb), // input wire [15:0]  probe7 
	.probe8(data_rd), // input wire [0:0]  probe8 
	.probe9(tx_data), // input wire [15:0]  probe9
	.probe10(signal_en)
);*/

    wire [7:0] uart_data;
    wire uart_done;
    //上位机数据接收
UART_rx u_UART_rx(
	.clk					(clk_50m),
	.rst_n					(rst_n),
	                              
	.uart_rxd				(uart_rxd),
	.uart_data				(uart_data),
	.uart_done              (uart_done)
    );

//命令解析
Decode u_Decode(
	.clk					(clk_50m),
	.rst_n					(rst_n),
	.uart_data				(uart_data),
	.PC_clear				(PC_clear),
	.Data_send      		(Data_send)
	);
    
    wire [7:0]  fifo_wr_data;
    wire [7:0]  fifo_rd_data;
    wire        fifo_wr_en;
    wire        fifo_rd_en;
    wire        full;
    wire        empty;
    wire [16:0] rd_data_count;
    wire [16:0] wr_data_count;
    //fifo
fifo_generator_0 u_fifo_generator_0 (
  .wr_clk                   (clk_250m),        // input wire wr_clk
  .rd_clk                   (clk_11520),        // input wire rd_clk
  .din                      (fifo_wr_data),              // input wire [7 : 0] din
  .wr_en                    (fifo_wr_en),          // input wire wr_en
  .rd_en                    (fifo_rd_en),          // input wire rd_en
  .dout                     (fifo_rd_data),            // output wire [7 : 0] dout
  .full                     (full),            // output wire full
  .empty                    (empty),          // output wire empty
  .rd_data_count            (rd_data_count),  // output wire [16 : 0] rd_data_count
  .wr_data_count            (wr_data_count)  // output wire [16 : 0] wr_data_count
);
    
    //数据缓存模块fifo
Fifo_cache u_Fifo_cache(
	.clk   			        (clk_250m),  
	.clk_11520        		(clk_11520),
    .rst_n      			(rst_n), 
 	.full					(full),
	.empty					(empty), 
    .tx_data 				(tx_data),
    .flag_send				(data_rd_en),                       
    .fifo_wr_en 			(fifo_wr_en),
    .fifo_rd_en				(fifo_rd_en),
    .fifo_wr_data 			(fifo_wr_data)
    );
    
    /*ila_2 fifo_cache_ila (
	.clk(clk_250m), // input wire clk
	.probe0(clk_11520), // input wire [0:0]  probe0  
	.probe1(full), // input wire [0:0]  probe1 
	.probe2(empty), // input wire [0:0]  probe2 
	.probe3(tx_data), // input wire [15:0]  probe3 
	.probe4(data_rd_en), // input wire [0:0]  probe4 
	.probe5(fifo_wr_en), // input wire [0:0]  probe5 
	.probe6(fifo_rd_en), // input wire [0:0]  probe6 
	.probe7(fifo_wr_data), // input wire [7:0]  probe7
	.probe8(rd_data_count),
	.probe9(wr_data_count)
);*/
    
    //发送数据到上位机
UART_tx u_UART_tx(
	.clk					(clk_50m),
	.rst_n					(rst_n),
	.fifo_rd_en				(fifo_rd_en),
	.fifo_rd_data			(fifo_rd_data),                      
	.uart_txd               (uart_txd)
	);
    
    
    ila_3 u_pulse_sum_ila (
	.clk                    (clk_250m), // input wire clk
                            
                            
	.probe0                 (ad_n0_filter[32:17]), // input wire [15:0]  probe0  
	.probe1                 (ad_n1_filter[32:17]), // input wire [15:0]  probe1 
	.probe2                 (ad_n2_filter[32:17]), // input wire [15:0]  probe2 
	.probe3                 (ad_n3_filter[32:17]), // input wire [15:0]  probe3 
	.probe4                 (signal_en), // input wire [0:0]  probe4 
	.probe5                 (cnt), // input wire [23:0]  probe5 
	.probe6                 (real_pulse), // input wire [0:0]  probe6 
	.probe7                 (pulse_sum), // input wire [19:0]  probe7 
	.probe8                 (ram_addr), // input wire [15:0]  probe8 
	.probe9                 (ram_in_data), // input wire [15:0]  probe9 
	.probe10                (rw), // input wire [0:0]  probe10 
	.probe11                (ram_out_data) // input wire [15:0]  probe11
);
    
    

endmodule
