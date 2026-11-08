module instruction_memory (
	input wire [7:0] addr,
	output wire [15:0] instruction
);

	reg [15:0] memory [0:255];
	assign instruction = memory[addr];

	initial begin
        $readmemh("program.hex", memory);
    end

endmodule
