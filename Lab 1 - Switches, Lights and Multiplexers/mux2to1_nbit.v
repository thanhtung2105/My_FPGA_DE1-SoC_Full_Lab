/*
____________ MODULE ____________
Module Multiplexer 2 to 1 - n bit:
	- Input: x2 components - a, b
	- Output: x1 component - F
	- 1 select - S
	*** Parameter to change bit of component: n.
*/
module mux2to1_nbit(a,b,s,f);
	parameter n=4;
	input [n-1:0]a,b;
	input s;
	output reg [n-1:0]f;

	always@(s)
	begin
		if(s)	f = b;
		else	f = a;
	end
	
endmodule
