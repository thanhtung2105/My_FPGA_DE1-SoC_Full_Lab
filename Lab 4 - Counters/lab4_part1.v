/*
____________ LAB 4 ____________
Module Lab 4 - Part 1: "Count up 0 - 15 by KEY[0] (Clk) - Display to HEX01"
	- Input: KEY[0] - Clock; SW[0] - EN; SW[1] - Clear.
	- Output: HEX01 display 0 - 15 when EN and press KEY[0].
*/
module lab4_part1(SW,LEDR,HEX0,HEX1,KEY);
input [9:0]SW;
input [2:0]KEY;
output [4:0]LEDR;
output [6:0]HEX0;
output [6:0]HEX1;
wire Q4,Q3,Q2,Q1;
wire IN2,IN1,IN0;
wire Q5=0;
	/*
	SW[1] clear
	SW[0] enable
	KEY[0] CLK
	*/
	flip_flop_T(Q1,SW[1],SW[0],KEY[0]);	//(Q, Clear, T, CLK)
	assign LEDR[0]=Q1;
	and(IN2,SW[1],Q1);
	flip_flop_T(Q2,SW[1],IN2,KEY[0]);
	assign LEDR[1]=Q2;
	and(IN1,IN2,Q2);
	flip_flop_T(Q3,SW[1],IN1,KEY[0]);
	assign LEDR[2]=Q3;
	and(IN0,IN1,Q3);
	flip_flop_T(Q4,SW[1],IN0,KEY[0]);
	assign LEDR[3]=Q4;
	bcd_hex_upto19(Q5,Q4,Q3,Q2,Q1,HEX1,HEX0);
endmodule

module flip_flop_T(Q,Clear,T,clk); 
 input clk;
 input T;
 input Clear;
 output reg Q;
  always @ (posedge clk) begin
    if (!Clear) 
      Q <= 0;
    else
      if (T)
          Q <= ~Q;
      else
          Q <= Q;
  end
endmodule

//and(OUT,A,B)
//module BCD-HEX-COUNTER->19
module bcd_hex_upto19(S4,S3,S2,S1,S0,HEX_B,HEX_A);
input S4,S3,S2,S1,S0;
output [6:0]HEX_A;
output [6:0]HEX_B;
	collectA_upto19(S4,S3,S2,S1,S0,O_A3,O_A2,O_A1,O_A0);
	collectB_upto19(S4,S3,S2,S1,S0,O_B);
	mux2to1_4bit(O_A3,O_A2,O_A1,O_A0,S3,S2,S1,S0,O_B,O3,O2,O1,O0);
	display_HEX1_upto19(O_B,HEX_B[6],HEX_B[5],HEX_B[4],HEX_B[3],HEX_B[2],HEX_B[1],HEX_B[0]);
	display_HEX0_upto19(O3,O2,O1,O0,HEX_A[6],HEX_A[5],HEX_A[4],HEX_A[3],HEX_A[2],HEX_A[1],HEX_A[0]);	
endmodule
