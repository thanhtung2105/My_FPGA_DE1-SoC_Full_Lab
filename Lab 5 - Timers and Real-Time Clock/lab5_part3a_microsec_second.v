/*
____________ LAB 5 ____________
Module Lab 5 - Part 3: "Counting up of SS:MSMS - MS->99 & SS->59"
	- Input: KEY[0] - Reset, SW[9] - EN.
 	- Output: Run SS:MSMS from 00:00 to 59:99 onto HEX3210 when EN.
*/
module lab5_part3a_microsec_second(SW ,CLOCK_50, KEY, LEDR, LEDG, HEX3, HEX2, HEX1, HEX0);
/* Microsec & Second counting up with CLK - Enable*/
  input CLOCK_50;
  input [3:0] KEY;
  input [9:0] SW;
  output [9:0] LEDR;
  output [7:0] LEDG;
  output [0:6] HEX3, HEX2, HEX1, HEX0;

  wire [19:0] PERMICROSEC;
  wire [25:0] PERSEC;

  wire [7:0] MSEC;
  wire [5:0] SECONDS;
  reg microsec ,sec;
  wire [3:0] Cout;
  
  counter C0 (SW[9], CLOCK_50, KEY[0], PERMICROSEC, Cout[0]);
  defparam C0.n = 20;
  defparam C0.k = 555555;

  counter C1 (SW[9], CLOCK_50, KEY[0], PERSEC, Cout[1]);
  defparam C1.n = 26;
  defparam C1.k = 50000000;
  
  counter C2 (SW[9], microsec, KEY[0], MSEC, Cout[2]);
  defparam C2.n = 7;
  defparam C2.k = 100;

  counter C3 (SW[9], sec, KEY[0], SECONDS, Cout[3]);
  defparam C3.n = 6;
  defparam C3.k = 60;

  assign LEDG[0] = ~KEY[0];
  always @ (negedge CLOCK_50) begin
	 if (PERMICROSEC == 555554)
		microsec = 1;
	 else
		microsec = 0;
  
    if (PERSEC == 49999999)
      sec = 1;
    else
      sec = 0;
  end

  display_TwodigitClock_HEX D1 (SECONDS, HEX3, HEX2);
  display_TwodigitClock_HEX D0 (MSEC, HEX1, HEX0);
endmodule
