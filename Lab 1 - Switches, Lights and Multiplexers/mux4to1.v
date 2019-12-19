/*
____________ LAB 1 ____________
Module Multiplexer with:
	- Input: x4 components - a, b, c, d
	- Output: x1 component - F
	- 2 select - S1, S0
*/
module mux4to1(a,b,c,d,S1,S0,F);
	input a, b, c, d, S1, S0;
	output F;
	wire W1, W2;
	mux2to1(a,b,S1,W1);
	mux2to1(c,d,S1,W2);
	mux2to1(W1,W2,S0,F);
endmodule
