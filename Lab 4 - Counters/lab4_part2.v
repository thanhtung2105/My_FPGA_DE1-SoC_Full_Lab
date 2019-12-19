/*
____________ LAB 4 ____________
Module Lab 4 - Part 2: "Count up 0 - FF by KEY[1] (Clk) - Display to HEX01 - Presetable"
	- Input: 2 binary (4 bit) - SW[7] ... SW[0] -> Preset first data.
				KEY[2] - Preset data to HEX01.
				KEY[1] - Clock.
				SW[9] - EN.
	- Output: HEX01 display 0 - FF (255) when EN and press KEY[1].
*/
module lab4_part2(SW,KEY,HEX1,HEX0,LEDR,LEDG);
input [9:0]SW;
input [3:0]KEY;
output [9:0]LEDR;
output [7:0]LEDG;
output [0:6]HEX0;
output [0:6]HEX1;
wire [7:0]Q;
wire Tnt;
/*
	SW[9] - Enable
	KEY[0] - Reset
	KEY[1] - Count - Clk
	KEY[2] - Input 8 bit SW for LEDR and display on HEX10
	LEDR[8] - Carry
*/
	assign LEDR[9]=SW[9];
	assign LEDG[2:0]=KEY[2:0];
	//T_countup8bit(En,Clock,Clear,Preset,Qs,Q,Cout);
	T_countup8bit(SW[9],KEY[1],KEY[0],KEY[2],SW[7:0],Q[7:0],Tnt);
	
	assign LEDR[7:0]=Q;
	display_HEX_Bin2HexorDec(Q[3:0],HEX0);
	display_HEX_Bin2HexorDec(Q[7:4],HEX1);
endmodule
