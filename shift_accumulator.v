module shifter(
    input shift_en,load,clear,sclk,
    input [39:0] inputdata,
    output [39:0] outputdata
    );

	reg [39:0] tempreg;
	
	always @(negedge sclk)
	begin
		if (clear)
			tempreg = 40'd0;
		if (load && shift_en)
			tempreg = {inputdata[39], inputdata[39:1]};
		else if (load && !shift_en)
			tempreg = inputdata;
		else
			tempreg = tempreg;
	end

	assign outputdata = tempreg;
	
			
endmodule