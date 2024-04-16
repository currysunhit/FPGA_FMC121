module UART_rx(
	input 					clk,
	input 					rst_n,
	
	input 					uart_rxd,
	output reg   [7:0] 		uart_data,
	output reg      		uart_done
    );

parameter CLK_FREQ = 50_000_000;
parameter UART_BPS = 115200;
parameter BPS_CNT = CLK_FREQ/UART_BPS;
    
reg uart_rxd_d0;    
reg uart_rxd_d1;    
reg rx_flag;
reg [3:0] rx_cnt;
reg [15:0] clk_cnt;
reg [7:0] rx_data;

wire start_flag;

//数据起始位
assign start_flag = uart_rxd_d1 & (~uart_rxd_d0);
  
//串口数据跨时钟同步    
always @(posedge clk, negedge rst_n) begin
	if(!rst_n) begin
		uart_rxd_d0 <= 1'b1;
		uart_rxd_d1 <= 1'b1;
	end
	else begin
		uart_rxd_d0 <= uart_rxd;
		uart_rxd_d1 <= uart_rxd_d0;
	end
end

//数据有效标志位
always @(posedge clk, negedge rst_n) begin
	if(!rst_n)  
		rx_flag <= 1'b0;
    else if(start_flag)
    	rx_flag <= 1'b1;
    else if((rx_cnt == 4'd9)&&(clk_cnt == BPS_CNT/2 - 1'b1))
    	rx_flag <= 1'b0;   
end

always @(posedge clk, negedge rst_n) begin
	if(!rst_n)  
		clk_cnt <= 16'd0;
	else if(rx_flag) begin
		if(clk_cnt < BPS_CNT - 1'b1)
			clk_cnt <= clk_cnt + 1'b1;
		else
			clk_cnt <= 16'd0;
	end
	else
		clk_cnt <= 16'd0;	
end

always @(posedge clk, negedge rst_n) begin
	if(!rst_n) 
		rx_cnt <= 4'd0;
  	else if(rx_flag) begin
  		if(clk_cnt == BPS_CNT - 1'b1)
  			rx_cnt <= rx_cnt + 1'b1;
  		else
  			rx_cnt <= rx_cnt;
  	end
  	else
  		rx_cnt <= 4'd0;
end

//寄存接收数据串并转换
always @(posedge clk, negedge rst_n) begin
	if(!rst_n) 
		rx_data <= 8'd0;
	else if(rx_flag) begin
		if(clk_cnt == BPS_CNT/2) begin
			case(rx_cnt)
				4'd1: rx_data[0] <= uart_rxd_d1;
				4'd2: rx_data[1] <= uart_rxd_d1;
				4'd3: rx_data[2] <= uart_rxd_d1;
				4'd4: rx_data[3] <= uart_rxd_d1;
				4'd5: rx_data[4] <= uart_rxd_d1;
				4'd6: rx_data[5] <= uart_rxd_d1;
				4'd7: rx_data[6] <= uart_rxd_d1;
				4'd8: rx_data[7] <= uart_rxd_d1;	
			default:;
			endcase
		end
		else
			rx_data <= rx_data;
	end
	else
		rx_data <= 8'd0;
end		


//发送并行数据
always @(posedge clk, negedge rst_n) begin
	if(!rst_n) begin
		uart_done <= 1'b0;	
		uart_data <= 8'd0;
	end
	else if(rx_cnt == 4'd9) begin
		uart_done <= 1'b1;
		uart_data <= rx_data;
	end
	else begin
		uart_done <= 1'b0;	
		uart_data <= 8'd0;
	end		
end 
	
endmodule
