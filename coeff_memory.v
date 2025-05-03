/*module coeff_memory (input write_enable, read_enable, Sclk,Frame,
							input [8:0] Write_Address, Read_Address,							
							input [15:0] data_in,
							output [15:0] Coeff);
	reg [15:0] coeffmemory [0:511];

	always @(negedge Sclk)
	begin
		if(write_enable && Frame)
			coeffmemory[Write_Address] = data_in;
		else
			coeffmemory[Write_Address] = coeffmemory[Write_Address];		
	end

	assign Coeff = (read_enable) ? coeffmemory[Read_Address] : 16'd0;
endmodule
*/
module CO_MEM (input write_enable, read_enable, Sclk,Frame,
							input [8:0] Write_Address, Read_Address,							
							input [15:0] data_in,
							output [15:0] Coeff);

	`ifdef SYNTHESIS
		wire [8:0] RW0_addr;
		wire RW0_clk;
		wire [8:0] RW0_wdata;
		reg [8:0] RW0_rdata;
		wire Rw0_en;
		wire RW0_mode;
		assign RW0_addr = write_enable ? Write_Address : Read_Address;
		assign RW0_clk = Sclk;
		assign RW0_wmode = Frame && write_enable;
		assign RW0_en = read_enable || write_enable;
		assign RW0_wdata = data_in[8:0];
		assign Coeff = RW0_rdata[8:0];


		wire [11:0] mem_0_O,mem_1_O,mem_2_O,mem_3_O;
		wire mem_OEB;
		wire mem_WEB;
		wire mem_0_CSB, mem_1_CSB, mem_2_CSB, mem_3_CSB;
		reg [1:0] cs_vec;
		
		SRAM1RW128x12 mem_0_0 (
			.A(RW0_addr[6:0]),
			.CE(RW0_clk),
			.I( {3'b000, RW0_wdata} ),
			.O(mem_0_O),
			.CSB(mem_0_CSB),
			.OEB(mem_OEB),
			.WEB(mem_WEB)
		);
		SRAM1RW128x12 mem_0_1 (
			.A(RW0_addr[6:0]),
			.CE(RW0_clk),
			.I( {3'b000, RW0_wdata} ),
			.O(mem_1_O),
			.CSB(mem_1_CSB),
			.OEB(mem_OEB),
			.WEB(mem_WEB)
		);
		SRAM1RW128x12 mem_0_2 (
			.A(RW0_addr[6:0]),
			.CE(RW0_clk),
			.I( {3'b000, RW0_wdata} ),
			.O(mem_2_O),
			.CSB(mem_2_CSB),
			.OEB(mem_OEB),
			.WEB(mem_WEB)
		);
		SRAM1RW128x12 mem_0_3 (
			.A(RW0_addr[6:0]),
			.CE(RW0_clk),
			.I( {3'b000, RW0_wdata} ),
			.O(mem_3_O),
			.CSB(mem_3_CSB),
			.OEB(mem_OEB),
			.WEB(mem_WEB)
		);
		/*assign RW0_rdata = {9{~mem_OEB}} & (
			({9{~mem_0_CSB}} & mem_0_O[8:0]) | 
			({9{~mem_1_CSB}} & mem_1_O[8:0]) | 
			({9{~mem_2_CSB}} & mem_2_O[8:0]) | 
			({9{~mem_3_CSB}} & mem_3_O[8:0])  );
		*/
		always@(mem_OEB,cs_vec,mem_0_CSB,mem_0_O,mem_1_CSB,mem_1_O,mem_2_CSB,mem_2_O,mem_3_CSB,mem_3_O) begin
			if(~mem_OEB) begin
			case(cs_vec)
				2'd0: RW0_rdata = mem_0_O[8:0];
				2'd1: RW0_rdata = mem_1_O[8:0];
				2'd2: RW0_rdata = mem_2_O[8:0];
				2'd3: RW0_rdata = mem_3_O[8:0];
			endcase
			end
		end

		always@(posedge RW0_clk) begin
			cs_vec <= RW0_addr[8:7];
		end

		assign mem_OEB = ~(RW0_en & ~RW0_wmode);
		assign mem_WEB = ~(RW0_en & RW0_wmode);
		assign mem_0_CSB = ~(RW0_addr[8:7] == 2'd0);
		assign mem_1_CSB = ~(RW0_addr[8:7] == 2'd1);
		assign mem_2_CSB = ~(RW0_addr[8:7] == 2'd2);
		assign mem_3_CSB = ~(RW0_addr[8:7] == 2'd3);
	`else
		reg [15:0] coeffmemory [0:511];

		always @(negedge Sclk)
		begin
			if(write_enable && Frame)
				coeffmemory[Write_Address] = data_in;
			else
				coeffmemory[Write_Address] = coeffmemory[Write_Address];		
		end

		assign Coeff = (read_enable) ? coeffmemory[Read_Address] : 16'd0;
	`endif
endmodule