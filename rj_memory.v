/*module rj_memory (input write_enable, read_enable, Sclk,Frame,
						input [3:0] Write_Address, Read_Address,	
						input [15:0] data_in,
						output [15:0] Rj);
	reg [15:0] rjmemory [0:15];
	always @(negedge Sclk)
	begin
		if(write_enable && Frame)
			rjmemory[Write_Address] = data_in;
		else
			rjmemory[Write_Address] = rjmemory[Write_Address];		
	end

	assign Rj = (read_enable) ? rjmemory[Read_Address] : 16'd0;
endmodule
*/

module R_MEM (input write_enable, read_enable, Sclk,Frame,
						input [3:0] Write_Address, Read_Address,	
						input [15:0] data_in,
						output [15:0] Rj);

	`ifdef SYNTHESIS
		wire [3:0] RW0_addr;
		wire RW0_clk;
		wire [8:0] RW0_wdata;
		wire [8:0] RW0_rdata;
		wire Rw0_en;
		wire RW0_mode;
		assign RW0_addr = write_enable ? Write_Address : Read_Address;
		assign RW0_clk = Sclk;
		assign RW0_wmode = Frame && write_enable;
		assign RW0_en = read_enable || write_enable;
		assign RW0_wdata = data_in[7:0];
		assign Rj = RW0_rdata[7:0];

		wire [3:0] mem_0_0_A1;
		wire  mem_0_0_CE1;
		wire [7:0] mem_0_0_I1;
		wire [7:0] mem_0_0_O1;
		wire  mem_0_0_CSB1;
		wire  mem_0_0_OEB1;
		wire  mem_0_0_WEB1;
		wire [3:0] mem_0_0_A2;
		wire  mem_0_0_CE2;
		wire [7:0] mem_0_0_I2;
		wire [7:0] mem_0_0_O2;
		wire  mem_0_0_CSB2;
		wire  mem_0_0_OEB2;
		wire  mem_0_0_WEB2;
		SRAM2RW16x8 mem_0_0 (
			.A1(mem_0_0_A1),
			.CE1(mem_0_0_CE1),
			.I1(mem_0_0_I1),
			.O1(mem_0_0_O1),
			.CSB1(mem_0_0_CSB1),
			.OEB1(mem_0_0_OEB1),
			.WEB1(mem_0_0_WEB1),
			.A2(mem_0_0_A2),
			.CE2(mem_0_0_CE2),
			.I2(mem_0_0_I2),
			.O2(mem_0_0_O2),
			.CSB2(mem_0_0_CSB2),
			.OEB2(mem_0_0_OEB2),
			.WEB2(mem_0_0_WEB2)
		);
		assign RW0_rdata = mem_0_0_O1;
		assign mem_0_0_A1 = RW0_addr;
		assign mem_0_0_CE1 = RW0_clk;
		assign mem_0_0_I1 = RW0_wdata[7:0];
		assign mem_0_0_CSB1 = ~RW0_en;
		assign mem_0_0_OEB1 = ~(~RW0_wmode & RW0_en);
		assign mem_0_0_WEB1 = ~RW0_wmode;
		assign mem_0_0_A2 = RW0_addr;
		assign mem_0_0_CE2 = 'b1;
		assign mem_0_0_I2 = RW0_wdata[7:0];
		assign mem_0_0_CSB2 = 'b1;
		assign mem_0_0_OEB2 = 'b1;
		assign mem_0_0_WEB2 = 'b1;
	`else
		// Statements
		reg [15:0] rjmemory [0:15];
		always @(negedge Sclk)
		begin
			if(write_enable && Frame)
				rjmemory[Write_Address] = data_in;
			else
				rjmemory[Write_Address] = rjmemory[Write_Address];		
		end

		assign Rj = (read_enable) ? rjmemory[Read_Address] : 16'd0;

	`endif

  
endmodule