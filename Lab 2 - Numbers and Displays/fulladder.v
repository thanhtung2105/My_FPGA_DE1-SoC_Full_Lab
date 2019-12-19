/*
____________ LAB 2 - Fulladder ____________
Module Fulladder with:
	- Input: x2 components - a, b
	- Output: x1 component - result
	- 2 carry: carry_in & carry_out
*/
module fulladder(a, b, result, c_in, c_out);
  input a, b, c_in;
  output c_out, result;

  wire d;
  // Simple sum module:
  assign d = a ^ b;
  assign result = d ^ c_in;
  assign c_out = (b & ~d) | (d & c_in);
endmodule
