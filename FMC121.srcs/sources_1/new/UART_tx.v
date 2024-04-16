module UART_tx(
	input 					clk,
	input 					rst_n,
	input 					fifo_rd_en,
	input 			[7:0] 	fifo_rd_data,
	
	output reg 				uart_txd
    );

parameter CLK_FREQ = 50_000_000;
parameter UART_BPS = 115200;
parameter BPS_CNT = CLK_FREQ/UART_BPS;
 
reg 	   [3:0] 	tx_cnt;
reg 	   [15:0]   clk_cnt;
reg 				tx_flag;
reg 				fifo_rd_en_d0;
reg 				fifo_rd_en_d1;
reg 	   [7:0] 	fifo_rd_data_d0;
reg 	   [7:0] 	fifo_rd_data_d1;

//跨时钟同步
always @(posedge clk, negedge rst_n) begin
	if(!rst_n) begin
		fifo_rd_en_d0 <= 1'b0;
		fifo_rd_en_d1 <= 1'b0; 
	end
	else begin
		fifo_rd_en_d0 <= fifo_rd_en;
		fifo_rd_en_d1 <= fifo_rd_en_d0;
	end
end		        
    
always @(posedge clk, negedge rst_n) begin
	if(!rst_n) begin
		fifo_rd_data_d0 <= 8'd0;
		fifo_rd_data_d1 <= 8'd0; 
	end
	else begin
		fifo_rd_data_d0 <= fifo_rd_data;
		fifo_rd_data_d1 <= fifo_rd_data_d0;
	end
end		    

//115200计数   
always @(posedge clk, negedge rst_n) begin
	if(!rst_n) 
		clk_cnt <= 16'd0;
	else if(fifo_rd_en_d1) begin
		if(clk_cnt < BPS_CNT - 1'b1)
			clk_cnt <= clk_cnt + 1'b1;
		else
			clk_cnt <= 16'd0;
	end
	else
		clk_cnt <= 16'd0;	
end

//串口一次发送10位计数    
always @(posedge clk, negedge rst_n) begin
	if(!rst_n)
		tx_cnt <= 4'd0;
  	else if(fifo_rd_en_d1) begin
  		if(clk_cnt == BPS_CNT - 1'b1) begin
  			if(tx_cnt < 9)
  				tx_cnt <= tx_cnt + 1'b1;
  			else
  				tx_cnt <= 4'd0;
  		end
  		else
  			tx_cnt <= tx_cnt;
  	end
  	else
  		tx_cnt <= 4'd0;
end    

//发送一组数据有效标志位
always @(posedge clk, negedge rst_n) begin
	if(!rst_n)
		tx_flag <= 1'b0;
	else if(fifo_rd_en_d1) begin 
		if((clk_cnt == 16'd0) && (tx_cnt == 4'd0))
			tx_flag <= 1'b1;
		else if((tx_cnt == 4'd9)&&(clk_cnt == BPS_CNT - BPS_CNT/10))
    		tx_flag <= 1'b0;   	
    end
    else
    	tx_flag <= 1'b0;
end
    
//发送数据
always @(posedge clk, negedge rst_n) begin
	if(!rst_n)
		uart_txd <= 1'b1;
	else if(fifo_rd_en_d1) begin 
		if(tx_flag) begin
			case(tx_cnt)
				4'd0: uart_txd <= 1'b0;
				4'd1: uart_txd <= fifo_rd_data_d1[0];
				4'd2: uart_txd <= fifo_rd_data_d1[1];
				4'd3: uart_txd <= fifo_rd_data_d1[2];
				4'd4: uart_txd <= fifo_rd_data_d1[3];
				4'd5: uart_txd <= fifo_rd_data_d1[4];
				4'd6: uart_txd <= fifo_rd_data_d1[5];
				4'd7: uart_txd <= fifo_rd_data_d1[6];
				4'd8: uart_txd <= fifo_rd_data_d1[7];	
				4'd9: uart_txd <= 1'b1;
			default:;
			endcase
		end
		else
			uart_txd <= 1'b1;
	end		
	else
		uart_txd <= 1'b1;
end
    
endmodule
