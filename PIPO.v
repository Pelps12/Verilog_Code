
module PIPO (input Frame, Dclk, Clear, 
				input [15:0] InputL, InputR, 
				output reg [15:0]dataL, dataR, 
				output reg input_ready);
	reg [3:0] bitpos;
	reg continueFrame;

	always @(negedge Dclk or posedge Clear)
	begin
		if (Clear == 1'b1)
		begin
			bitpos = 4'd15;
			dataL = 16'd0;
			dataR = 16'd0;			
			input_ready = 1'b0;
			continueFrame = 1'b0;
		end
		else 
		begin
			if (Frame == 1'b1)
			begin
				bitpos = 4'd15;
				input_ready = 1'b1;
				dataL = InputL;
				dataR = InputR;
				continueFrame = 1'b1;
			end
			else if (continueFrame == 1'b1)
			begin
				bitpos = bitpos - 1'b1;
				//dataL [bitpos] = InputL;
				//dataR [bitpos] = InputR;
				if (bitpos == 4'd0)
				begin					
					input_ready = 1'b0;
					continueFrame = 1'b0;
				end
				else
				begin
					input_ready = 1'b0;
					continueFrame = 1'b1;
				end
			end
			else
			begin
				bitpos = 4'd15;
				dataL = 16'd0;
				dataR = 16'd0;			
				input_ready = 1'b0;
				continueFrame = 1'b0;
			end
		end
	end
endmodule
