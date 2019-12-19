module Multiplier_n_bit(A, B, P);
	parameter n = 4;
	input [n-1:0] A;
	input [n-1:0] B;
	output reg [n+n-1:0] P;
	reg [n+n-1:0] pp;
	integer i,k;
	
	always@(A, B, pp, P)
	begin
		P = 0;
		for(k = 0; k < n; k=k+1)
		begin
			pp = 0;
			for (i = 0 ; i < n ; i = i+1)
			begin
				pp[i+k] = A[i]&B[k];
			end
			P = P + pp;
		end
	end

endmodule