module rs_enc_m11 (y, x);
	input [7:0] x;
	output [7:0] y;
	reg [7:0] y;
	always @ (x)
	begin
		y[0] = x[2] ^ x[3] ^ x[4] ^ x[6] ^ x[7];
		y[1] = x[2] ^ x[5] ^ x[6];
		y[2] = x[0] ^ x[2] ^ x[4];
		y[3] = x[0] ^ x[1] ^ x[3] ^ x[5];
		y[4] = x[1] ^ x[2] ^ x[4] ^ x[6];
		y[5] = x[2] ^ x[3] ^ x[5] ^ x[7];
		y[6] = x[0] ^ x[3] ^ x[4] ^ x[6];
		y[7] = x[1] ^ x[2] ^ x[3] ^ x[5] ^ x[6];
	end
endmodule
