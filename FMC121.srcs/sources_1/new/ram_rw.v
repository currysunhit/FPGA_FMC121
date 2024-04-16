
module RAM_rw(
	input            	clk         , //时钟
    input        		rst_n       , //复位信号，低电平有效
	input		[19:0]	pulse_sum   , //脉冲积分
	input 				real_pulse  , //脉冲有效
	input				PC_clear    ,
	//input				Data_send   ,
	input		[15:0]	ram_out_data,
                
	output	reg 		rw			,
	output	reg [15:0]	ram_addr	,
	output	reg [15:0]	ram_in_data 
    );
    
parameter max_addr = 16'd65535;

reg 	        flag;
wire            flag3;
                
reg		[1:0]	state; 
reg 	[1:0]   n_state;
reg 	[15:0]	data;
reg 			flag_d0;
reg 			flag_d1;
reg             flag_d2;

		
//地址传送
always @(posedge clk, negedge rst_n) begin
	if(!rst_n)
		state <= 2'b00;
	else
		state <= n_state;
end

always @(posedge clk, negedge rst_n) begin
	if(!rst_n) begin
		ram_addr <= 16'd0;
		n_state  <= 2'b00;
	end
	else begin
	case(state)
		2'b00: begin
			if(ram_addr  <  max_addr) 
				ram_addr <= ram_addr + 1'b1;
			else begin
				//ram_addr <= pulse_sum[16:1];
				n_state  <= 2'b01;
		    end
		end
		2'b01: begin
			if(PC_clear) begin
				n_state        <= 2'b00;
				ram_addr       <= 16'd0;
			end
			else 
				ram_addr[15:0] <= pulse_sum[17:2];
		end
		2'b11: begin
			if(ram_addr  < max_addr) 
				ram_addr <= ram_addr + 1'b1;
			else begin
			    //ram_addr <= pulse_sum[16:1];
				n_state  <= 2'b01;
			end
		end
		default: n_state <= 2'b01;
	endcase
	end
end
			
//数据寄存
always @(posedge clk, negedge rst_n) begin
	if(!rst_n) begin
		data        <= 32'd0; 
		ram_in_data <= 32'd0;
	end
	else if(state   == 2'd0)
		ram_in_data <= 32'd0;
	else begin
		data        <= ram_out_data;
		ram_in_data <= data + 1'b1; 	
	end
end
	
//读写标志位
always @(posedge clk, negedge rst_n) begin
	if(!rst_n) begin
		flag_d0     <= 1'b0;
		flag_d1     <= 1'b0;
		flag_d2     <= 1'b0;
		flag <= 1'b0;
	end
	else begin
		flag        <= real_pulse;
		flag_d0     <= flag;
		flag_d1     <= flag_d0;
		flag_d2     <= flag_d1;
	end
end

assign flag3 = flag_d2 | flag_d0 | flag_d1;

		
//读写控制                              
always @(posedge clk, negedge rst_n) begin
	if(!rst_n) 
		rw <= 1'b1;
	else if(state == 2'b00)
		rw <= 1'b1;
	else if(state == 2'b11)
		rw <= 1'b0;
	else if(flag3)
		rw <= 1'b1;
	else
		rw <= 1'b0;
end                  // 一直到这
		
endmodule
