module status_register(
	input wire clk,
	input wire reset,
	input wire write_enable,
	input wire [3:0] value,
	output reg [3:0] status
);
	
	// value_in has format ZNCV
	always @(posedge clk) begin
		if (reset)
			status <= '0;
		else if (write_enable)
			status <= value;
	end

endmodule
