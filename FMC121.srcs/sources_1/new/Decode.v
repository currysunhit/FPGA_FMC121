module Decode(
	input 					clk,
	input 					rst_n,
	input	  	[7:0] 		uart_data,
	
	output 		reg			PC_clear,
	output 		reg			Data_send
	);

//命令解析
always @(posedge clk, negedge rst_n) begin
	if(!rst_n) begin	
		PC_clear <= 1'b0;
		Data_send <= 1'b0;
	end
	else begin
	case(uart_data)
		8'd85: 
			PC_clear <= 1'b1;
		8'd128:
			Data_send <= 1'b1;
		default: begin
			PC_clear <= 1'b0;
			Data_send <= 1'b0;
		end
	endcase
	end
end
	
endmodule
