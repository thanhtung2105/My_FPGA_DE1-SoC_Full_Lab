/*
____________ LAB 2 ____________
Module Lab 2 - Fulladder 4 bit: "Display result to HEX10 from data of HEX3 & HEX2"
	- Input: 2 binary (4 bit) - SW[7] ... SW[0].
	- Output: x4 HEX (HEX3 - num 1; HEX2 - num 2; HEX10 - result).
	- Carry: SW[8].
*/
module lab2_fulladder_4bit_display(SW,HEX3,HEX2,HEX1,HEX0);
input [8:0]SW;
output [6:0]HEX3;
output [6:0]HEX2;
output [6:0]HEX1;
output [6:0]HEX0;
wire S3,S2,S1,S0,C0,C1,C2,C3,C4;
	fulladder(SW[0],SW[4],S0,SW[8],C1);
	fulladder(SW[1],SW[5],S1,C1,C2);
	fulladder(SW[2],SW[6],S2,C2,C3);
	fulladder(SW[3],SW[7],S3,C3,C4);
	BCD_9(SW[3],SW[2],SW[1],SW[0],HEX2);
	BCD_9(SW[7],SW[6],SW[5],SW[4],HEX3);
	BCD_19(C4,S3,S2,S1,S0,HEX0,HEX1);
endmodule

module BCD_9(W3,W2,W1,W0,HEX);
input W3,W2,W1,W0;
output [6:0]HEX;
	assign HEX[0]=(~W3&~W2&~W1&W0)|(W2&~W1&~W0);
	assign HEX[1]=(W2&~W1&W0)|(W2&W1&~W0);
	assign HEX[2]=~W2&W1&~W0;
	assign HEX[3]=(~W3&~W2&~W1&W0)|(W2&~W1&~W0)|(W2&W1&W0);
	assign HEX[4]=(W2&~W1)|W0;
	assign HEX[5]=(~W3&~W2&W0)|(~W2&W1)|(W1&W0);
	assign HEX[6]=(~W3&~W2&~W1)|(W2&W1&W0);
endmodule

module BCD_19(S4,S3,S2,S1,S0,HEX0,HEX1);
input S4,S3,S2,S1,S0;
output [6:0]HEX1;
output [6:0]HEX0;
	collectA_upto19(S4,S3,S2,S1,S0,O_A3,O_A2,O_A1,O_A0);
	collectB_upto19(S4,S3,S2,S1,S0,O_B);
	mux2to1_4bit(O_A3,O_A2,O_A1,O_A0,S3,S2,S1,S0,O_B,O3,O2,O1,O0);
	BCD_1(O_B,HEX1[6],HEX1[5],HEX1[4],HEX1[3],HEX1[2],HEX1[1],HEX1[0]);
	BCD_0(O3,O2,O1,O0,HEX0[6],HEX0[5],HEX0[4],HEX0[3],HEX0[2],HEX0[1],HEX0[0]);		
endmodule
	
module BCD_0(I3,I2,I1,I0,O6,O5,O4,O3,O2,O1,O0);
input I3,I2,I1,I0;
output O6,O5,O4,O3,O2,O1,O0;
	assign O0=(~I3&~I2&~I1&I0)|(I2&~I1&~I0);
	assign O1=(I2&~I1&I0)|(I2&I1&~I0);
	assign O2=~I2&I1&~I0;
	assign O3=(~I3&~I2&~I1&I0)|(I2&~I1&~I0)|(I2&I1&I0);
	assign O4=(I2&~I1)|I0;
	assign O5=(~I3&~I2&I0)|(~I2&I1)|(I1&I0);
	assign O6=(~I3&~I2&~I1)|(I2&I1&I0);	
endmodule

module BCD_1(IN,H6,H5,H4,H3,H2,H1,H0);
input IN;
output H6,H5,H4,H3,H2,H1,H0;
	assign H6=1;
	assign H5=IN;
	assign H4=IN;
	assign H3=IN;
	assign H2=0;
	assign H1=0;
	assign H0=IN;
endmodule 
