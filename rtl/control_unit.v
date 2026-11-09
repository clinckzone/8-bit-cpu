module control_unit (
	input wire clk,
	input wire reset,
	input wire [3:0] opcode,
	input wire is_zero,
	output reg pc_sel,
	output reg [3:0] alu_op_sel,
	output reg reg_sel,
	output reg pc_write_enable,
	output reg ir_write_enable,
	output reg reg_write_enable,
	output reg status_write_enable,
	output reg output_write_enable
);

	reg [3:0] state;
	reg [3:0] next_state;

	localparam FETCH = 2'b00;
	localparam DECODE = 2'b01;
	localparam EXECUTE = 2'b10;
	localparam HALT = 2'b11;
	
	task reset_control_signals;
		begin
			pc_sel = 1;
			reg_sel = 0;
			alu_op_sel = 0 ;

			pc_write_enable = 0;
			ir_write_enable = 0;
			reg_write_enable = 0;
			status_write_enable = 0;
			output_write_enable = 0;
		end
	endtask

	always @(posedge clk) begin
		if (reset)
			state <= FETCH;
		else
			state <= next_state;
	end	

	always @(*) begin

		case (state)
			FETCH: begin
				reset_control_signals();
				
				ir_write_enable = 1;
				next_state = DECODE;
			end

			DECODE: begin
				ir_write_enable = 0;

				case (opcode)
					// LOAD
					4'b0000: begin
						pc_sel = 1;
						reg_sel = 0;
					end 

					// ALU
					4'b0001, 4'b0010, 4'b0011, 4'b0100, 4'b0101, 4'b0110: begin
						pc_sel = 1;
						reg_sel = 1;
						alu_op_sel = opcode;
					end 
					
					// OUT
					4'b1001: begin
						pc_sel = 1;
					end 

					// JMP
					4'b0111: begin
						pc_sel = 0;
					end 

					// JZ
					4'b1000: begin
						if(is_zero)
							pc_sel = 0;
					end

					// Invalid
					default: begin
						// Do Nothing
					end
				endcase

				next_state = EXECUTE;
			end
			
			EXECUTE: begin
				case (opcode)
					// LOAD and ALU
					4'b0000: begin
						reg_write_enable = 1;
						pc_write_enable = 1;
						next_state = FETCH;						
					end
					
					4'b0001, 4'b0010, 4'b0011, 4'b0100, 4'b0101, 4'b0110: begin
						status_write_enable = 1;
						reg_write_enable = 1;
						pc_write_enable = 1;
						next_state = FETCH;
					end
					
					// OUT
					4'b1001: begin	
						pc_write_enable = 1;
						output_write_enable = 1;
						next_state = FETCH;
					end

					// HALT
					4'b1010: begin
						next_state = HALT;
					end 
					
					// JMP, JZ, Invalid
					default: begin
						pc_write_enable = 1;
						next_state = FETCH;
					end
				endcase
			end
			
			// Reset control signals
			HALT: begin
				reset_control_signals();
			end
		endcase
	end

endmodule
