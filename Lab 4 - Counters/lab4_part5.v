/*
____________ LAB 4 ____________
Module Lab 4 - Part 5: "Run DE1 shift on HEX3210 with Presetable"
	- Input: SW[7] ... SW[0] - Preset DE1_ on HEX.
				SW[9] - EN
				KEY[0] - Reset
	- Output: Run DE1 shift on HEX3210 when EN.
*/
module lab4_part5(SW,KEY,HEX3,HEX2,HEX1,HEX0,LEDR,LEDG,CLOCK_50);
input [9:0]SW;
input [3:0]KEY;
input CLOCK_50;
output [6:0]HEX3;
output [6:0]HEX2;
output [6:0]HEX1;
output [6:0]HEX0;
output [9:0]LEDR;
output [9:0]LEDG;
wire [25:0]Qc;
wire [7:0]Q;
wire SPEED=Qc[23];
wire Tnt;
	counter_26bit(SW[9],CLOCK_50,KEY[0],Qc);
	T_countup2bit(SW[9],Qc[25],KEY[0],KEY[2],SW[7:0],Q[1:0],Tnt);
	DE1_set(Q,SW,HEX3,HEX2,HEX1,HEX0);
	assign LEDR[9]=SPEED;
	assign LEDR[8]=~SPEED;
	assign LEDG[7]=SPEED;
	assign LEDR[7]=SPEED;
	assign LEDG[6]=~SPEED;
	assign LEDR[6]=~SPEED;
	assign LEDG[5]=SPEED;
	assign LEDR[5]=SPEED;
	assign LEDG[4]=~SPEED;
	assign LEDR[4]=~SPEED;
	assign LEDG[3]=SPEED;
	assign LEDR[3]=SPEED;
	assign LEDG[2]=~SPEED;
	assign LEDR[2]=~SPEED;
	assign LEDG[1]=SPEED;
	assign LEDR[1]=SPEED;
	assign LEDG[0]=~SPEED;
	assign LEDR[0]=~SPEED;
endmodule

module DE1_set(BIN,SW,HEX3,HEX2,HEX1,HEX0);
	input [7:0]SW;
	input [1:0]BIN;
	output [6:0]HEX3;
	output [6:0]HEX2;
	output [6:0]HEX1;
	output [6:0]HEX0;
	wire F7,F6,F5,F4,F3,F2,F1,F0;
	wire T7=SW[7],T6=SW[6],T5=SW[5],T4=SW[4],T3=SW[3],T2=SW[2],T1=SW[1],T0=SW[0];
	
	mux4to1_2bit(T7,T6,T5,T4,T3,T2,T1,T0,BIN[0],BIN[1],F7,F6);
	mux4to1_2bit(T5,T4,T3,T2,T1,T0,T7,T6,BIN[0],BIN[1],F5,F4);
	mux4to1_2bit(T3,T2,T1,T0,T7,T6,T5,T4,BIN[0],BIN[1],F3,F2);
	mux4to1_2bit(T1,T0,T7,T6,T5,T4,T3,T2,BIN[0],BIN[1],F1,F0);
	
	display_HEX_DE1(F7,F6,HEX3[6],HEX3[5],HEX3[4],HEX3[3],HEX3[2],HEX3[1],HEX3[0]);
	display_HEX_DE1(F5,F4,HEX2[6],HEX2[5],HEX2[4],HEX2[3],HEX2[2],HEX2[1],HEX2[0]);
	display_HEX_DE1(F3,F2,HEX1[6],HEX1[5],HEX1[4],HEX1[3],HEX1[2],HEX1[1],HEX1[0]);
	display_HEX_DE1(F1,F0,HEX0[6],HEX0[5],HEX0[4],HEX0[3],HEX0[2],HEX0[1],HEX0[0]);
endmodule
	
module T_countup2bit(En,Clk,Clrn,Prs,Qs,Q,Cout);
input En,Clk,Clrn,Prs;
input [1:0]Qs;	
output reg [1:0]Q;
output Cout;
assign Cout = En&Q[0]&Q[1];
always@(negedge Clrn, posedge Clk, negedge Prs)
begin
	if(!Clrn)
		Q<=0;
	else if(!Prs)
		Q=Qs;  
	else if(En)
		Q<=Q+1;
end
endmodule
