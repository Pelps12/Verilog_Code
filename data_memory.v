
module DATA_MEM (input write_enable, read_enable, Sclk, Frame, input_ready,
					input [7:0] Write_Address, Read_Address,
					input [15:0] data_in,
					output [15:0] data_stored,
					output reg allzeros);

	`ifdef SYNTHESIS
		reg [11:0] count_zero;
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
		assign RW0_wdata = data_in;
		assign data_stored = read_enable ? RW0_rdata: 16'd0;
		
		wire [7:0] mem_0_0_A;
		wire  mem_0_0_CE;
		wire [7:0] mem_0_0_I;
		wire [7:0] mem_0_0_O;
		wire  mem_0_0_CSB;
		wire  mem_0_0_OEB;
		wire  mem_0_0_WEB;
		wire [7:0] mem_0_1_A;
		wire  mem_0_1_CE;
		wire [7:0] mem_0_1_I;
		wire [7:0] mem_0_1_O;
		wire  mem_0_1_CSB;
		wire  mem_0_1_OEB;
		wire  mem_0_1_WEB;
		SRAM1RW256x8 mem_0_0 (
			.A(mem_0_0_A),
			.CE(mem_0_0_CE),
			.I(mem_0_0_I),
			.O(mem_0_0_O),
			.CSB(mem_0_0_CSB),
			.OEB(mem_0_0_OEB),
			.WEB(mem_0_0_WEB)
		);
		SRAM1RW256x8 mem_0_1 (
			.A(mem_0_1_A),
			.CE(mem_0_1_CE),
			.I(mem_0_1_I),
			.O(mem_0_1_O),
			.CSB(mem_0_1_CSB),
			.OEB(mem_0_1_OEB),
			.WEB(mem_0_1_WEB)
		);

		assign RW0_rdata = {mem_0_1_O,mem_0_0_O};
		assign mem_0_0_A = RW0_addr;
		assign mem_0_0_CE = RW0_clk;
		assign mem_0_0_I = RW0_wdata[7:0];
		assign mem_0_0_CSB = ~RW0_en;
		assign mem_0_0_OEB = ~(~RW0_wmode & RW0_en);
		assign mem_0_0_WEB = ~RW0_wmode;
		assign mem_0_1_A = RW0_addr;
		assign mem_0_1_CE = RW0_clk;
		assign mem_0_1_I = RW0_wdata[15:8];
		assign mem_0_1_CSB = ~RW0_en;
		assign mem_0_1_OEB = ~(~RW0_wmode & RW0_en);
		assign mem_0_1_WEB = ~RW0_wmode;
	`else
		reg [15:0] datamemory [0:255];
		reg [11:0] count_zero;
		
		always @(negedge Sclk)
		begin
			if(write_enable && Frame)
				datamemory[Write_Address] = data_in;
			else
				datamemory[Write_Address] = datamemory[Write_Address];
		end
		assign data_stored = (read_enable) ? datamemory[Read_Address] : 16'd0;
	`endif

	always @(posedge input_ready)
		begin
			if (data_in == 16'd0)
			begin
				count_zero = count_zero + 1'b1;
				if (count_zero == 12'd800)
					allzeros = 1'b1;
				else if (count_zero > 12'd800)
				begin
					count_zero = 12'd800;
					allzeros = 1'b1;
				end
			end		
			else if (data_in != 16'd0)
			begin
				count_zero = 12'd0;
				allzeros = 1'b0;
			end
	end
endmodule
