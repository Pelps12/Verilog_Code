module adder(
	input [39:0] input1,input2,
    input op,
    output [39:0] out
    );
		assign out = (op == 1'b0) ? (input2 + input1) : ((op == 1'b1) ? (input2 - input1) : out);
		
endmodule
