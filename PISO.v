
module PISO (input Sclk, Clear, Frame, enable_PISO,
				input [39:0] InputParallel, output reg  OutputSerial, OutReady);

reg [5:0] count_bit; 

reg ready_out, frame_flag;
reg [39:0] register_dataout;

	always @(posedge Sclk)
	begin
		if(Clear == 1'b1)
		begin
			count_bit = 6'd40;
			register_dataout = 40'd0;
			ready_out = 1'b0;
			frame_flag = 1'b0;
			OutReady = 1'b0;
			OutputSerial = 1'b0;
		end
		else if (enable_PISO == 1'b1)
		begin
			register_dataout = InputParallel;
			ready_out = 1'b1;
		end
		else if (Frame == 1'b1 && ready_out == 1'b1 && frame_flag == 1'b0)
		begin
			frame_flag = 1'b1;
			ready_out = 1'b0;
			OutputSerial = register_dataout[count_bit-1];
			count_bit = count_bit - 1;
			OutReady = 1'b1;
		end
		else if (frame_flag == 1'b1)
		begin
			if(count_bit > 6'd00) begin
				OutputSerial = register_dataout[count_bit-1];
				count_bit = count_bit - 1;
			   OutReady = 1'b1;
			end
			else begin
				frame_flag = 1'b0;
				OutReady = 1'b0;
			end
		end 
		else
		begin
			count_bit = 6'd40;
			OutputSerial = 1'b00;
			OutReady = 1'b0;
		end
	end
endmodule