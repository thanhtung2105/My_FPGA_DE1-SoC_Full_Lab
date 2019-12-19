/*
____________ LAB 4 ____________
Module Lab 4 - Part 3: "Count up 0 - FF by automatic CLK - Display to HEX01 - Presetable"
	- Input: 2 binary (4 bit) - SW[7] ... SW[0] -> Preset first data.
				KEY[1] - Preset data to HEX01.
				SW[9] - EN.
	- Output: HEX01 display 0 - FF (255) when EN.
*/
module lab4_part3(SW,KEY,HEX1,HEX0,LEDR,LEDG,CLOCK_50);
input [9:0]SW;
input [1:0]KEY;
input CLOCK_50;
output [9:0]LEDR;
output [7:0]LEDG;
output [0:6]HEX0;
output [0:6]HEX1;
wire [25:0]Qc;
wire [7:0]Q;
wire Tnt;
	counter_26bit(SW[9], CLOCK_50, KEY[0], Qc);
	T_countup8bit(SW[9],Qc[25],KEY[0],KEY[1],SW[7:0],Q[7:0],Tnt);
	assign LEDR[9]=SW[9];
	assign LEDG[1:0]=KEY[1:0];
	assign LEDG[7]=Qc[25];
	assign LEDR[7:0]=Q;
	display_HEX_Bin2HexorDec(Q[3:0],HEX0);
	display_HEX_Bin2HexorDec(Q[7:4],HEX1);
endmodule

module counter_26bit (En, Clk, Clr, Q);
  input En,Clk,Clr;
  output reg [25:0]Q;
  
  always@(negedge Clr, posedge Clk)
  begin
		if(!Clr)
			Q<=0;
		else if(En)
			Q<=Q+1;
	end
endmodule
