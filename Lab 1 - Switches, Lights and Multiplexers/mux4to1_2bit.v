/*
____________ LAB 1 ____________
Module Multiplexer with:
	- Input: x4 binary (2 bit) - M7 ... M0
	- Output: x1 binary (2 bit) - W1, W0
	- 2 select - S1, S0
*/
module mux4to1_2bit(M7,M6,M5,M4,M3,M2,M1,M0,S1,S0,W1,W0);
	input M7,M6,M5,M4,M3,M2,M1,M0,S1,S0;
	output W1,W0;
	mux4to1(M7,M5,M3,M1,S1,S0,F1);
	mux4to1(M6,M4,M2,M0,S1,S0,F0);
	assign W1=F1, W0=F0;
endmodule
