module instruction_decoder (
	input wire [15:0] instruction,
	output reg [3:0] opcode,
	output reg [1:0] rd_addr,
	output reg [1:0] rs_addr,
	output reg [7:0] imm,
	output reg [7:0] jmp_addr
);

	always @(*) begin
		opcode = instruction[15:12];
		rd_addr  = instruction[11:10]; // Destination
		rs_addr  = instruction[9:8];   // Source
		imm = instruction[7:0];
		jmp_addr = instruction[7:0];
	end

endmodule
