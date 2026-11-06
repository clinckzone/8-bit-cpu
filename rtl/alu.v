module alu (
	input wire [3:0] op,
	input wire [7:0] in1,
	input wire [7:0] in2,
	output reg [7:0] out,
	output wire [3:0] zncv
);

	reg [8:0] temp;
	reg invalid;
	
	reg Z, N, C, V;
	assign zncv = {Z, N, C, V};

	always @(*) begin
		out = '0;
		{Z, N, C, V} = '0;

		temp = '0;
		invalid = 1'b0;
		
		case (op)
			4'b0001: begin
				temp = in1 + in2;
				out = temp[7:0];
				C = temp[8];
				
				if ((in1[7] == 0 && in2[7] == 0 && out[7] == 1) ||
					  (in1[7] == 1 && in2[7] == 1 && out[7] == 0))
					V = 1;
				else 
					V = 0;
			end

			4'b0010: begin
				temp = in1 - in2;
				out = temp[7:0];
				C = ~temp[8];
				
				if ((in1[7] == 0 && in2[7] == 1 && out[7] == 1) ||
						(in1[7] == 1 && in2[7] == 0 && out[7] == 0))
					V = 1;
				else
					V = 0;
			end

			4'b0011: begin
				out = in1 & in2;
			end

			4'b0100: begin
				out = in1 | in2;
			end
			
			4'b0101: begin
				out = in1 ^ in2;
			end

			4'b0110: begin
				out = ~in1;
			end

			default: invalid = 1'b1;
		endcase
		
		// Compute Z and N flags for valid operations only
		// Invalid operation should return neutral flags
		if (!invalid) begin
			if (out == '0)
				Z = 1;
			if (out[7] == 1)
				N = 1;
		end else begin
			Z = 0;
			N = 0;
		end
	end

endmodule
