module cpu(
	input wire clk,
	input wire reset,
	output wire [7:0] out,
	output wire [3:0] status
);

	wire [7:0] rd;
	wire [7:0] rs;
	wire [7:0] imm;
	
	wire [1:0] rd_addr;
	wire [1:0] rs_addr;
	wire [7:0] jmp_addr;
	
	wire [3:0] opcode;
	wire is_zero;
	wire pc_sel;
	wire [3:0] alu_op_sel;
	wire reg_sel;
	wire pc_write_enable;
	wire ir_write_enable;
	wire reg_write_enable;
	wire status_write_enable;
	wire output_write_enable;

	wire [7:0] pc_addr_in;
	wire [7:0] pc_addr_out;

	wire [15:0] instruction_in;
	wire [15:0] instruction_out;

	wire [7:0] alu_out;
	wire [3:0] zncv;

	wire [7:0] reg_write_value;
	
	// Muxes
	assign pc_addr_in = pc_sel ? (pc_addr_out + 1) : jmp_addr; 
	assign reg_write_value = reg_sel ? alu_out : imm;
	assign is_zero = (rd == 0);

	control_unit u_control_unt(
		.clk(clk),
		.reset(reset),
		.opcode(opcode),
		.is_zero(is_zero),
		.pc_sel(pc_sel),
		.alu_op_sel(alu_op_sel),
		.reg_sel(reg_sel),
		.pc_write_enable(pc_write_enable),
		.ir_write_enable(ir_write_enable),
		.reg_write_enable(reg_write_enable),
		.status_write_enable(status_write_enable),
		.output_write_enable(output_write_enable)
	);

	program_counter u_program_counter(
		.clk(clk),
		.reset(reset),
		.write_enable(pc_write_enable),
		.instruction_addr_in(pc_addr_in),
		.instruction_addr_out(pc_addr_out)
	);

	instruction_memory u_instruction_memory(
		.addr(pc_addr_out),
		.instruction(instruction_in)
	);

	instruction_register u_instruction_register(
		.clk(clk),
		.reset(reset),
		.write_enable(ir_write_enable),
		.instruction_in(instruction_in),
		.instruction_out(instruction_out)
	);

	instruction_decoder u_instruction_decoder(
		.instruction(instruction_out),
		.opcode(opcode),
		.rd_addr(rd_addr),
		.rs_addr(rs_addr),
		.imm(imm),
		.jmp_addr(jmp_addr)
	);

	alu u_alu(
		.op(alu_op_sel),
		.in1(rd),
		.in2(rs),
		.out(alu_out),
		.zncv(zncv)
	);

	register_file u_register_file(
		.clk(clk),
		.reset(reset),
		.write_enable(reg_write_enable),
		.write_addr(rd_addr),
		.write_value(reg_write_value),
		.port_a_addr(rd_addr),
		.port_b_addr(rs_addr),
		.port_a_value(rd),
		.port_b_value(rs)
	);
	
	output_register u_output_register(
		.clk(clk),
		.reset(reset),
		.write_enable(output_write_enable),
		.value(reg_write_value),
		.out(out)
	);

	status_register u_status_register(
		.clk(clk),
		.reset(reset),
		.write_enable(status_write_enable),
		.value(zncv),
		.status(status)
	);

endmodule
