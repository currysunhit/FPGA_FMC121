module Fifo_cache(
	input                 		clk    ,  //时钟
	input 						clk_11520   ,
    input                 		rst_n       , 
 	input						full		,
	input						empty		, 
    input			[15:0]		tx_data 	,
    input 						flag_send	,
    
    output 	 				fifo_wr_en  ,
    output 	reg 				fifo_rd_en	,
    output	reg		[7:0]		fifo_wr_data	
    );

reg			cnt4;

reg         full_d0  ;  // fifo_full 延迟一拍
reg  		full_syn ;  // fifo_full 延迟两拍

	always@( posedge clk ) begin
	if( !rst_n ) begin
		full_d0  <= 1'b0 ;
		full_syn <= 1'b0 ;
	end
	else begin
		full_d0  <= full ;
		full_syn <= full_d0 ;
	end
end	

//写fifo数据
/*always @(posedge clk, negedge rst_n) begin
	if(!rst_n) 
		fifo_wr_en <= 1'b0;
	else if((flag_send == 1'b1) && (full == 1'b0))
		fifo_wr_en <= 1'b1;
	else
		fifo_wr_en <= 1'b0;
end*/

    reg flag_send_d0;
    reg flag_send_sync;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            flag_send_d0 <= 1'b0;
            flag_send_sync <= 1'b0;
        end
        else begin
            flag_send_d0 <= flag_send;
            flag_send_sync <= flag_send_d0;
        end
    end
    
    assign fifo_wr_en = flag_send_sync & (~full);

always @(posedge clk, negedge rst_n) begin
	if(!rst_n) 
		cnt4 <= 1'b0;
	else if(fifo_wr_en)
		cnt4 <= cnt4 + 1'b1;
	else
		cnt4 <= 1'b0;
end

reg [15:0] tx_data_d0;
reg [15:0] tx_data_sync;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        tx_data_d0 <= 16'd0;
        tx_data_sync <= 16'd0;
    end
    else begin
        tx_data_d0 <= tx_data;
        tx_data_sync <= tx_data_d0;
    end
end

always @(posedge clk, negedge rst_n) begin
	if(!rst_n) 
		fifo_wr_data <= 8'd0;
	else if(fifo_wr_en) begin
		case(cnt4)
			1'b0: fifo_wr_data <= tx_data_sync [7:0];
			1'b1: fifo_wr_data <= tx_data_sync [15:8];
			
		endcase
	end
	else
		fifo_wr_data <= 8'd0;
end

reg   state           ;  // 动作状态

//读出FIFO的数据
always @(posedge clk_11520 or negedge rst_n ) begin
    if(!rst_n) begin
        fifo_rd_en <= 1'b0;
		state      <= 1'b0;
    end
    else begin
        case(state)
            1'b0: begin
                if(full_syn)      //如果检测到FIFO将被写满
                    state <= 1'b1;       //就进入延时状态
                else
                    state <= state;
            end 
		    1'b1: begin
                if(empty) begin     //等待FIFO将被读空
                    fifo_rd_en <= 1'b0;    //关闭读使能
                    state      <= 1'b0;    //回到第一个状态
                end
                else                       //如果FIFO没有被读空
                    fifo_rd_en <= 1'b1;    //则持续打开读使能
            end 
			default : state <= 1'b0;
        endcase
    end
end


endmodule
