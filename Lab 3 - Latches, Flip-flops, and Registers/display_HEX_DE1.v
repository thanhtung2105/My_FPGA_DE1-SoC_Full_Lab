/*
____________ LAB 1 - MODULE DISPLAY ____________
Module Display DE1: "Display DE1 to HEX"
	- Input: x2 binary (2 bit) - S1, S0
	- Output: x1 HEX_display - O6 ... O0
*/
module display_HEX_DE1(S1,S0,O6,O5,O4,O3,O2,O1,O0);
	input S1,S0;
	output O6,O5,O4,O3,O2,O1,O0;
	assign O0 = S1|(~S0);
	assign O1 = S0;
	assign O2 = S0;
	assign O3 = S1&(~S0);
	assign O4 = S1;
	assign O5 = (~S0)|S1;
	assign O6 = S1;
endmodule
