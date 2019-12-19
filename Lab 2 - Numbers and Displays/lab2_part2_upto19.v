/*
____________ LAB 2 ____________
Module Lab 2 - Part 2 - Up to 19: "Display 0 - 19 to HEX from data of SW[4] ... SW[0]"
	- Input: 1 binary (5 bit) - SW[4] ... SW[0]
	- Output: x2 HEX (display 0 - 19)
*/
module lab2_part2_upto19(SW,HEX0,HEX1);
input [4:0]SW;
output [6:0]HEX0;
output [6:0]HEX1;
	collectA_upto19(SW[4],SW[3],SW[2],SW[1],SW[0],O_A3,O_A2,O_A1,O_A0);
	collectB_upto19(SW[4],SW[3],SW[2],SW[1],SW[0],O_B);
	mux2to1_4bit(O_A3,O_A2,O_A1,O_A0,SW[3],SW[2],SW[1],SW[0],O_B,O3,O2,O1,O0);
	display_HEX1_upto19(O_B,HEX1[6],HEX1[5],HEX1[4],HEX1[3],HEX1[2],HEX1[1],HEX1[0]);
	display_HEX0_upto19(O3,O2,O1,O0,HEX0[6],HEX0[5],HEX0[4],HEX0[3],HEX0[2],HEX0[1],HEX0[0]);	
endmodule

module display_HEX0_upto19(I3,I2,I1,I0,O6,O5,O4,O3,O2,O1,O0);
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

module display_HEX1_upto19(IN,H6,H5,H4,H3,H2,H1,H0);
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

//Collect B to process:
module collectB_upto19(IN4,IN3,IN2,IN1,IN0,O_B);
	input IN4,IN3,IN2,IN1,IN0;
	output O_B;
	assign O_B=(IN3&IN1)|(IN3&IN2)|IN4;
endmodule

//Collect A to process:
module collectA_upto19(SW4,SW3,SW2,SW1,SW0,O_A3,O_A2,O_A1,O_A0);
	input SW4,SW3,SW2,SW1,SW0;
	output O_A3, O_A2, O_A1, O_A0;
	assign O_A3=SW4&SW1;
	assign O_A2=(SW4&~SW1)|(SW2&SW1);
	assign O_A1=~SW1;
	assign O_A0=SW0;
endmodule
