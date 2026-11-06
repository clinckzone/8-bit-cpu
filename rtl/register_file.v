module register_file (
	input clk,
	input reset,
	input wire write_enable,
	input wire [1:0] write_addr,
	input wire [7:0] write_value,
	input wire [1:0] port_a_addr,
	input wire [1:0] port_b_addr,
	output reg [7:0] port_a_value,
	output reg [7:0] port_b_value
);

	integer i;
	reg [7:0] register [3:0];

	assign port_a_value = register[port_a_addr];
	assign port_b_value = register[port_b_addr];

	always @(posedge clk) begin
		if (reset) begin
			for(i = 0; i < 4; i++) begin
				register[i] <= '0;
			end
		end else begin
			if (write_enable) begin
				register[write_addr] <= write_value;
			end
		end
	end

endmodule
