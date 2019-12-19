/*
____________ LAB 1 ____________
Module Lab 1 - Part 5: "DE1 display on HEX when change SW[9] and SW[8] - Presetable"
	- Input: x9 SW - SW[9] & SW[8] to run - SW[7] ... SW[0] to preset
	- Output: x4 HEX
*/
module lab1_part5(SW,HEX3,HEX2,HEX1,HEX0);
	input [9:0]SW;
	output [6:0]HEX3;
	output [6:0]HEX2;
	output [6:0]HEX1;
	output [6:0]HEX0;
	wire F7,F6,F5,F4,F3,F2,F1,F0;
	//Preset
	wire T7=SW[7],T6=SW[6],T5=SW[5],T4=SW[4],T3=SW[3],T2=SW[2],T1=SW[1],T0=SW[0];
	//Change all of value when change 2 bit (SW[8] and SW[9])
	mux4to1_2bit(T7,T6,T5,T4,T3,T2,T1,T0,SW[8],SW[9],F7,F6);
	mux4to1_2bit(T5,T4,T3,T2,T1,T0,T7,T6,SW[8],SW[9],F5,F4);
	mux4to1_2bit(T3,T2,T1,T0,T7,T6,T5,T4,SW[8],SW[9],F3,F2);
	mux4to1_2bit(T1,T0,T7,T6,T5,T4,T3,T2,SW[8],SW[9],F1,F0);
	//Put the output of mux4to1 to get symbol onto HEX
	display_HEX_DE1(F7,F6,HEX3[6],HEX3[5],HEX3[4],HEX3[3],HEX3[2],HEX3[1],HEX3[0]);
	display_HEX_DE1(F5,F4,HEX2[6],HEX2[5],HEX2[4],HEX2[3],HEX2[2],HEX2[1],HEX2[0]);
	display_HEX_DE1(F3,F2,HEX1[6],HEX1[5],HEX1[4],HEX1[3],HEX1[2],HEX1[1],HEX1[0]);
	display_HEX_DE1(F1,F0,HEX0[6],HEX0[5],HEX0[4],HEX0[3],HEX0[2],HEX0[1],HEX0[0]);	
endmodule
