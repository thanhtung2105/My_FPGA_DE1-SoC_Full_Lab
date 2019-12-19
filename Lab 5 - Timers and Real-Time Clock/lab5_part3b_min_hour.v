/*
____________ LAB 5 ____________
Module Lab 5 - Part 3: "Counting up of HH:MM - HH->23 & MM->59"
	- Input: KEY[0] - Reset, SW[9] - EN.
 	- Output: Run HH:MM from 00:00 to 23:59 onto HEX3210 when EN.
*/
module lab5_part3b_min_hour(CLOCK_50, KEY, LEDR, LEDG, HEX3, HEX2, HEX1, HEX0, SW);
/* min & hour counting up with CLK - dieu chinh lai xung CLK voi C0.k = 3000000000 va C1.k = 18000000000*/
 input CLOCK_50;
  input [3:0] KEY;
  input [9:0] SW;
  output [9:0] LEDR;
  output [7:0] LEDG;
  output [0:6] HEX3, HEX2, HEX1, HEX0;

  wire [31:0] PERMIN;
  wire [37:0] PERHOUR;

  wire [5:0] MINUTES;
  wire [4:0] HOURS;
  reg min,hour;
  wire [3:0]Cout;
  
  counter C0 (SW[9], CLOCK_50, KEY[0], PERMIN, Cout[0]);
  defparam C0.n = 32;
  defparam C0.k = 833333;

  counter C1 (SW[9], CLOCK_50, KEY[0], PERHOUR, Cout[1]);
  defparam C1.n = 38;
  defparam C1.k = 50000000;

  counter C2 (SW[9], min, KEY[0], MINUTES, Cout[2]);
  defparam C2.n = 6;
  defparam C2.k = 60;

  counter C3 (SW[9], hour, KEY[0], HOURS, Cout[3]);
  defparam C3.n = 5;
  defparam C3.k = 24;
  
  assign LEDG[0] = ~KEY[0];

  always @ (negedge CLOCK_50)
	 begin	 
	 if (PERMIN == 833332)
		min = 1;
	 else
		min = 0;
  
    if (PERHOUR == 49999999)
      hour = 1;
    else
      hour = 0;
	end
  
  display_TwodigitClock_HEX D1 (HOURS, HEX3, HEX2);
  display_TwodigitClock_HEX D0 (MINUTES, HEX1, HEX0);
endmodule
