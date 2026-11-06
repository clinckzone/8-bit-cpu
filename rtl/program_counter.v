module program_counter (
	input wire clk,
	input wire reset,
	input wire write_enable,
	input wire [7:0] instruction_addr_in,
	output reg [7:0] instruction_addr_out
);
	
	always @(posedge clk) begin
		if (reset)
			instruction_addr_out <= '0;
		else if (write_enable)
			instruction_addr_out <= instruction_addr_in;
	end
	
endmodule
