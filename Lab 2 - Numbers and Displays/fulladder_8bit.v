/*
____________ LAB 2 - Fulladder 8 bit ____________
Module Fulladder with:
	- Input: x2 binary (8 bit) - a, b
	- Output: x1 binary (8 bit) - s
	- 2 carry: carry_in & carry_out
*/
module fulladder_8bit (a, b, c_in, s, c_out);
  input [7:0] a, b;
  input c_in;
  output [7:0] s;
  output [8:1] c_out;
  //Simple Sum module 8 bit from basic Sum module:
  fulladder A0 (a[0], b[0], c_in, s[0], c_out[1]);
  fulladder A1 (a[1], b[1], c_out[1], s[1], c_out[2]);
  fulladder A2 (a[2], b[2], c_out[2], s[2], c_out[3]);
  fulladder A3 (a[3], b[3], c_out[3], s[3], c_out[4]);
  fulladder A4 (a[4], b[4], c_out[4], s[4], c_out[5]);
  fulladder A5 (a[5], b[5], c_out[5], s[5], c_out[6]);
  fulladder A6 (a[6], b[6], c_out[6], s[6], c_out[7]);
  fulladder A7 (a[7], b[7], c_out[7], s[7], c_out[8]);
endmodule
