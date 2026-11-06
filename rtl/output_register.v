module output_register(
	input wire clk,
	input wire reset,
	input wire write_enable,
	input wire [7:0] value,
	output reg [7:0] out
);

	always @(posedge clk) begin
		if (reset)
			out <= '0;
		else if (write_enable)
			out <= value;
	end

endmodule
