module control_unit (
	input wire clk,
	input wire reset,
	input wire [3:0] opcode,
	input wire is_zero,
	output wire pc_sel,
	output wire [3:0] alu_op_sel,
	output wire reg_sel,
	output wire pc_write_enable,
	output wire ir_write_enable,
	output wire reg_write_enable,
	output wire status_write_enable,
	output wire output_write_enable
);

	reg [3:0] state;

	always @(posedge clk) begin
		
	end

endmodule
