/*
____________ LAB 1 ____________
Module Multiplexer with:
	- Input: x2 binary (4 bit) - M7 ... M0
	- Output: x1 binary (4 bit) - W3 ... W0
	- 1 select - S
*/
module mux2to1_4bit(M7,M6,M5,M4,M3,M2,M1,M0,S,W3,W2,W1,W0);
	input M7,M6,M5,M4,M3,M2,M1,M0,S;
	output W3,W2,W1,W0;
	mux2to1 F0(M0,M4,S,W0);
	mux2to1 F1(M1,M5,S,W1);
	mux2to1 F2(M2,M6,S,W2);
	mux2to1 F3(M3,M7,S,W3);
endmodule
