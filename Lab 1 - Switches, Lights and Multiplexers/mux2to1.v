/*
____________ LAB 1 ____________
Module Multiplexer with:
	- Input: x2 components - a, b
	- Output: x1 component - F
	- 1 select - S
*/
module mux2to1(a,b,S,F);
	input a, b, S;
	output F;
	assign F=(~S&a)|(S&b);
endmodule
