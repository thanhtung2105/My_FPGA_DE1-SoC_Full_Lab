/*
____________ LAB 3 ____________
Module Lab 3 - Part 5: "Fulladder 8 bit and display result to HEX (hexa) and DEC (decimal)"
	- Input: [8:0]SW - Data; KEY[1] - Input num 1; KEY[2] - Input num 2.
	- Output: [7:0]LEDR - Num 1; [7:0]LEDG - Num 2; HEX3210 - Result.
	- Clear: KEY[0].
	- Change type of display: SW[9].
*/
module lab3_part5(SW,KEY,LEDG,LEDR,HEX3,HEX2,HEX1,HEX0);
	input [9:0]SW;
	input [3:0]KEY;
	output [0:6]HEX0;
	output [0:6]HEX1;
	output [0:6]HEX2;
	output [0:6]HEX3;
	output [7:0]LEDG;
	output [7:0]LEDR;
	wire [7:0]O;
	wire [7:0]C;
	wire [8:0]R;

	flipflopD_8bit(KEY[0],SW[7],SW[6],SW[5],SW[4],SW[3],SW[2],SW[1],SW[0],KEY[2],O[7],O[6],O[5],O[4],O[3],O[2],O[1],O[0]);
	flipflopD_8bit(KEY[0],SW[7],SW[6],SW[5],SW[4],SW[3],SW[2],SW[1],SW[0],KEY[1],C[7],C[6],C[5],C[4],C[3],C[2],C[1],C[0]);
	assign LEDR=O;
	assign LEDG=C;
	full_adder_8bit_bcd(SW[8],C[7],C[6],C[5],C[4],C[3],C[2],C[1],C[0],O[7],O[6],O[5],O[4],O[3],O[2],O[1],O[0],R[8],R[7],R[6],R[5],R[4],R[3],R[2],R[1],R[0]);
	
	wire [15:0]displayHEX, displayDEC, displayR;
	assign displayHEX = {7'b0,R[8:0]};
	decode_bin2BCDx4(displayHEX,displayDEC[15:12],displayDEC[11:8],displayDEC[7:4],displayDEC[3:0]);
	mux2to1_nbit select_TypeOfDisplay(displayHEX,displayDEC,SW[9],displayR);
		defparam select_TypeOfDisplay.n = 16;
	
	display_HEX_Bin2HexorDec(displayR[15:12],HEX3);
	display_HEX_Bin2HexorDec(displayR[11:8],HEX2);			
	display_HEX_Bin2HexorDec(displayR[7:4],HEX1);
	display_HEX_Bin2HexorDec(displayR[3:0],HEX0);
endmodule
