module main_controller (input Sclk, Dclk, Start, Reset_n, Frame, input_ready, allzeros_L, allzeros_R,
								 output reg [3:0] Rj_Read_Address,
						       output reg [8:0] Coefficient_Read_Address,
						       output reg [7:0] Input_Read_Address,
						       output reg en_FIR, sleep_flag, InReady, Rj_Read_Enable, Coefficient_Read_Enable, Data_Read_Enable, Clear,
						       output Frame_out, Dclk_out, Sclk_out);
	
	parameter [3:0] Initialization = 4'd0, Wait_for_Rj = 4'd1, Reading_Rj = 4'd2,
					    Wait_for_Coefficient = 4'd3, Reading_Coeff = 4'd4, Waiting_for_Input = 4'd5,
					    Working_mode = 4'd6, Clearing_mode = 4'd7, Sleeping_mode = 4'd8;
   
	reg [3:0] state_present, state_next;
	reg [15:0] count;

	reg [4:0] count_rj;
	reg [9:0] count_coeff;
	reg [7:0] count_data;
	
	reg tk;
	
	assign Frame_out = Frame;
	assign Dclk_out = Dclk;
	assign Sclk_out = Sclk;
	
	always @(posedge Sclk or negedge Reset_n)
	begin
		if (!Reset_n)
		begin
			if (state_present > 4'd4)
				state_present = Clearing_mode;
			else
				state_present = state_next;
		end
		else
		state_present = state_next;
	end
	
	always @(posedge Sclk or negedge Start)
	begin
		if (Start == 1'b0) begin
			state_next = Initialization;
			$display("MO TI RI");
		end

		else
		begin
		case (state_present)
			Initialization:	begin
							Rj_Read_Address = 4'd0;
							Coefficient_Read_Address = 9'd0;
							Input_Read_Address = 8'd0;
							Rj_Read_Enable = 1'b0;
							Coefficient_Read_Enable = 1'b0;
							Data_Read_Enable = 1'b0;
							Clear = 1'b1;
							en_FIR = 1'b0;
							InReady = 1'b0;
							sleep_flag = 1'b0;
							state_next = Wait_for_Rj;
							count = 16'd0;
							count_rj = 4'd0;
							count_coeff = 9'd0;
							count_data = 8'd0;
						end
			
			Wait_for_Rj:	begin
							Rj_Read_Address = 4'd0;
							Coefficient_Read_Address = 9'd0;
							Input_Read_Address = 8'd0;
							Rj_Read_Enable = 1'b0;
							Coefficient_Read_Enable = 1'b0;
							Data_Read_Enable = 1'b0;
							Clear = 1'b0;
							en_FIR = 1'b0;
							InReady = 1'b1;
							sleep_flag = 1'b0;
							count_rj = 4'd0;
							count_coeff = 9'd0;
							count_data = 8'd0;
							tk = 1'b0;
							if (Frame == 1'b1)
								state_next = Reading_Rj;
							else
								state_next = Wait_for_Rj;
						end
						
			Reading_Rj:	begin
							Coefficient_Read_Address = 9'd0;
							Input_Read_Address = 8'd0;
							Coefficient_Read_Enable = 1'b0;
							Data_Read_Enable = 1'b0;
							Clear = 1'b0;
							en_FIR = 1'b0;
							InReady = 1'b1;
							sleep_flag = 1'b0;
							count_coeff = 9'd0;
							count_data = 8'd0;
							if (input_ready == 1'b1 && tk == 1'b0)
							begin
								if (count_rj < 5'd16)
								begin
									Rj_Read_Enable = 1'b1;
									Rj_Read_Address = count_rj;
									count_rj = count_rj + 1'b1;
									state_next = Reading_Rj;
									tk = 1'b1;
								end
								if (count_rj == 5'd16)
								begin
									state_next = Wait_for_Coefficient;
								end
								else
									state_next = Reading_Rj;
							end
							else if (input_ready == 1'b0)
							begin
								tk = 1'b0;
								Rj_Read_Enable = 1'b0;
								Rj_Read_Address = Rj_Read_Address;
								state_next = Reading_Rj;
							end
							else
								state_next = Reading_Rj;
						end
			
			Wait_for_Coefficient: 
							begin
								Rj_Read_Address = 4'd0;
								Coefficient_Read_Address = 9'd0;
								Input_Read_Address = 8'd0;
								Rj_Read_Enable = 1'b0;
								Coefficient_Read_Enable = 1'b0;
								Data_Read_Enable = 1'b0;
								Clear = 1'b0;
								en_FIR = 1'b0;
								InReady = 1'b1;
								sleep_flag = 1'b0;
								count_coeff = 9'd0;
								count_data = 8'd0;
								if (Frame == 1'b1)
									state_next = Reading_Coeff;
								else
									state_next = Wait_for_Coefficient;
							end
						
			Reading_Coeff: begin
								Rj_Read_Address = 4'd0;
								Input_Read_Address = 8'd0;
								Rj_Read_Enable = 1'b0;
								Data_Read_Enable = 1'b0;
								Clear = 1'b0;
								en_FIR = 1'b0;
								InReady = 1'b1;
								sleep_flag = 1'b0;
								count_data = 8'd0;
								if (input_ready == 1'b1 && tk == 1'b0)
								begin
									if (count_coeff < 10'h200)
									begin
										Coefficient_Read_Enable = 1'b1;
										Coefficient_Read_Address = count_coeff;
										count_coeff = count_coeff + 1'b1;
										state_next = Reading_Coeff;
										tk = 1'b1;
									end
									if (count_coeff == 10'h200)
										state_next = Waiting_for_Input;
									else
										state_next = Reading_Coeff;
								end
								else if (input_ready == 1'b0)
								begin
									tk = 1'b0;
									Coefficient_Read_Enable = 1'b0;
									Coefficient_Read_Address = Coefficient_Read_Address;
									state_next = Reading_Coeff;
								end
								else
									state_next = Reading_Coeff;
							end

			Waiting_for_Input: begin
								Rj_Read_Address = 4'd0;
								Coefficient_Read_Address = 9'd0;
								Input_Read_Address = 8'd0;
								Rj_Read_Enable = 1'b0;
								Coefficient_Read_Enable = 1'b0;
								Data_Read_Enable = 1'b0;
								Clear = 1'b0;
								en_FIR = 1'b0;
								InReady = 1'b1;
								sleep_flag = 1'b0;
								count_data = 8'd0;
								if (Reset_n == 1'b0)
									state_next = Clearing_mode;
								else if (Frame == 1'b1)
									state_next = Working_mode;
								else
									state_next = Waiting_for_Input;
							end
		
			Working_mode:	begin
							Rj_Read_Address = 4'd0;
							Coefficient_Read_Address = 9'd0;
							Rj_Read_Enable = 1'b0;
							Coefficient_Read_Enable = 1'b0;
							Clear = 1'b0;
							InReady = 1'b1;
							sleep_flag = 1'b0;
							if (Reset_n == 1'b0)
							begin
								Clear = 1'b1;
								state_next = Clearing_mode;								
							end
							else if (input_ready == 1'b1 && tk == 1'b0)
							begin
								if (allzeros_L && allzeros_R)
								begin
									state_next = Sleeping_mode;
									sleep_flag = 1'b1;
								end
								else
								begin
									Data_Read_Enable = 1'b1;
									Input_Read_Address = count_data;
									count_data = count_data + 1'b1;
									count = count + 1'b1;
									state_next = Working_mode;
									en_FIR = 1'b1;
									tk = 1'b1;
								end
							end
							else if (input_ready == 1'b0)
							begin
								tk = 1'b0;
								Data_Read_Enable = 1'b0;
								Input_Read_Address = Input_Read_Address;
								en_FIR = 1'b0;
								state_next = Working_mode;
							end
							else
							begin
								Data_Read_Enable = 1'b0;
								Input_Read_Address = Input_Read_Address;
								state_next = Working_mode;
								en_FIR = 1'b0;
							end
						end
			
			Clearing_mode:	begin
							Rj_Read_Address = 4'd0;
							Coefficient_Read_Address = 9'd0;
							Input_Read_Address = 8'd0;
							Rj_Read_Enable = 1'b0;
							Coefficient_Read_Enable = 1'b0;
							Data_Read_Enable = 1'b0;
							Clear = 1'b1;
							en_FIR = 1'b0;
							InReady = 1'b0;
							sleep_flag = 1'b0;
							count_data = 8'd0;
							tk = 1'b0;
							if (Reset_n == 1'b0)
								state_next = Clearing_mode;
							else
								state_next = Waiting_for_Input;
						end
			
			Sleeping_mode:	begin
							Rj_Read_Address = 4'd0;
							Coefficient_Read_Address = 9'd0;
							Input_Read_Address = Input_Read_Address;
							Rj_Read_Enable = 1'b0;
							Coefficient_Read_Enable = 1'b0;
							Data_Read_Enable = 1'b0;
							Clear = 1'b0;
							en_FIR = 1'b0;
							InReady = 1'b1;
							sleep_flag = 1'b1;
							if (Reset_n == 1'b0)
								state_next = Clearing_mode;
							else if (input_ready == 1'b1 && tk == 1'b0)
							begin
								if (allzeros_L && allzeros_R)
									state_next = Sleeping_mode;
								else
								begin
									tk = 1'b1;
									Data_Read_Enable = 1'b1;
									en_FIR = 1'b1;
									sleep_flag = 1'b0;
									Input_Read_Address = count_data;
									count_data = count_data + 1'b1;
									count = count + 1'b1;
									state_next = Working_mode;
								end
							end
							else
								state_next = Sleeping_mode;
						end
					
		endcase
		end
	end
endmodule
