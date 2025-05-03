
`timescale 1ns / 1ps

module MSDAP_tb;

	reg Dclk;
	reg Sclk;
	reg Reset_n;
	reg Frame;
	reg Start;
	reg[15:0] InputL;
	reg[15:0] InputR;
	wire regInReady;
	wire regOutReady;
	wire regSerialOutputL;
	wire regSerialOutputR;
	
	MSDAP UUT (
		.Dclk(Dclk), 
		.Sclk(Sclk), 
		.Reset_n(Reset_n), 
		.Frame(Frame), 
		.Start(Start), 
		.InputL(InputL), 
		.InputR(InputR), 
		.InReady(regInReady), 
		.OutReady(regOutReady), 
		.OutputL(regSerialOutputL), 
		.OutputR(regSerialOutputR)
	);

	
	integer dataindex = 0, input_bitpos = 15, outputrowcount=0;;
	integer outputL_bitpos = 40,outputR_bitpos = 40;
	integer output_file;
	reg [39:0] reg_OutR = 40'b0, reg_OutL = 40'b0;
	reg reg_resetflag = 1'b0;
	reg [15:0] data [0:15055];
	reg [39:0] OutputL, OutputR;
	wire InReady, OutReady;
	
	assign OutReady = regOutReady;
	assign InReady = regInReady;
		
	//Clocks
	parameter Dclk_Time = 1302; 
	parameter Sclk_Time = 30; 
	
	always
	begin
		#(Dclk_Time) Dclk = ~Dclk;
	end
	
	always
	begin
		#(Sclk_Time) Sclk = ~Sclk;
	end
	
	initial begin
	output_file = $fopen ("./data.out", "w");
	end
	
	initial begin
		Dclk = 1;
		Sclk = 1;
		Frame = 0;
		InputL = 16'b0;
		InputR = 16'b0;
		Reset_n = 1;
		$display("HMMMMMMMMMMMM");
		
		$readmemh ("data.in", data);
		$display("HMMMMMMMMMMMM_2");
		
    	Start = 1'b0;
		#2;
		Start = 1'b1;
		
		if (outputrowcount==6394)
		$finish;
	end
	
	always @(posedge Dclk)
	begin
		if ((((dataindex == 9458) || (dataindex == 13058)) && reg_resetflag == 1'b0))
		begin
			Reset_n = 1'b0;
			reg_resetflag = 1'b1;
		end
		else if (InReady || reg_resetflag)
		begin
			if (dataindex < 15056)
			begin
				Reset_n = 1'b1;
				if (input_bitpos == 15 )
					Frame = 1'b1;
				else
					Frame = 1'b0;
				if (input_bitpos == 15)
				begin
					InputL = data[dataindex];
					InputR = data[dataindex+1];
					input_bitpos = input_bitpos - 1;
				end
				else if (input_bitpos >= 0)
				begin
					input_bitpos = input_bitpos - 1;
				end
				else
				begin
					input_bitpos = 15;
					dataindex = dataindex + 2;
					if (reg_resetflag)
						reg_resetflag = 1'b0;
				end
			end
		end
	end
	
	always @(negedge Sclk)
	begin
		if (OutReady)
		begin
			if(outputL_bitpos == 40)
				Frame = 1;
			
			if(outputL_bitpos > 0)
			begin
				reg_OutL[outputL_bitpos-1] = regSerialOutputL;
				reg_OutR[outputR_bitpos-1] = regSerialOutputR;
				outputL_bitpos = outputL_bitpos - 1;
				outputR_bitpos = outputR_bitpos - 1;
			end
			if(outputL_bitpos == 0)
			begin
				$fwrite (output_file, "%H      %H\n", reg_OutL[39:0], reg_OutR[39:0]);
				$display("%d  %H      %H\n",outputrowcount, reg_OutL, reg_OutR);
				outputrowcount=outputrowcount+1;	
			end
		end
		else begin
			outputL_bitpos = 40;
	      outputR_bitpos = 40;
	      reg_OutL = 40'b0;
	      reg_OutR = 40'b0;
		end
						
		if (outputrowcount > 6394 )
		begin
			$fclose(output_file);		
			$finish;	
			end
		//end
	end

endmodule 
