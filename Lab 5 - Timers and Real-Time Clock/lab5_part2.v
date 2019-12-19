/*
____________ LAB 5 ____________
Module Lab 5 - Part 2: "Count up DECIMAL 0 - 999"
	- Input: KEY[0] - Reset, SW[9] - EN.
 	- Output: Run 0 - 999 HEX210 when EN.
*/
module lab5_part2(CLOCK_50, SW, KEY, LEDR, LEDG, HEX2, HEX1, HEX0);
  input CLOCK_50;
  input [3:0] KEY;
  input [9:0] SW;
  output [9:0] LEDR;
  output [9:0] LEDG;
  output [0:6] HEX2, HEX1, HEX0;

  wire [25:0] CYCLES;
  reg ones, tens, hundreds;
  wire x2, y2, z2;
  wire [3:0]Cout;
  reg x1, y1, z1;

  assign x2 = x1 && KEY[0];
  assign y2 = y1 && KEY[0];
  assign z2 = z1 && KEY[0];
  
  counter C0(SW[9], CLOCK_50, KEY[0], CYCLES, Cout[0]);
 // counter_modk C0 (CLOCK_50, KEY[0], CYCLES);
  defparam C0.n = 26;
  defparam C0.k = 50000000;

  counter C1 (SW[9], ones, x2, LEDR[3:0], Cout[1]);
  defparam C1.n = 4;
  defparam C1.k = 11;

  counter C2 (SW[9], tens, y2, LEDR[7:4], Cout[2]);
  defparam C2.n = 4;
  defparam C2.k = 11;

  counter C3 (SW[9], hundreds, z2, LEDG[7:4], Cout[3]);
  defparam C3.n = 4;
  defparam C3.k = 10;

  always @ (negedge CLOCK_50) begin
    if (CYCLES == 49999999)
      ones = 1;
    else
      ones = 0;

    if (LEDR[3:0] == 10) begin
      tens = 1;
      x1 = 0;
    end else begin
      tens = 0;
      x1 = 1;
    end

    if (LEDR[7:4] == 10) begin
      hundreds = 1;
      y1 = 0;
    end else begin
      hundreds = 0;
      y1 = 1;
    end
    z1 = 1;
  end

  display_HEX_Bin2HexorDec H2 (LEDG[7:4], HEX2);
  display_HEX_Bin2HexorDec H1 (LEDR[7:4], HEX1);
  display_HEX_Bin2HexorDec H0 (LEDR[3:0], HEX0);
/*
  assign LEDG[3] = z1;
  assign LEDG[2] = z2;
  assign LEDG[1] = y1;
  */
  assign LEDG[0] = y2;
endmodule
