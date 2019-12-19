/*
____________ MODULE DISPLAY - NOTE: Declare HEX[0 -> 6]____________
Module Display HEX with:
	- Input: x1 binary (3 bit).
	- Output: HEX display (hexa).
	- Note: Can use with func like bin2dec when binary_input[3] = 0; (just use 3 bit to display)
*/
module display_HEX_Bin2HexorDec(binary_input, hex_output);
  input [3:0] binary_input;
  output reg [0:6] hex_output;
  always begin
    case(binary_input)
      0:hex_output=7'b0000001;
      1:hex_output=7'b1001111;
      2:hex_output=7'b0010010;
      3:hex_output=7'b0000110;
      4:hex_output=7'b1001100;
      5:hex_output=7'b0100100;
      6:hex_output=7'b0100000;
      7:hex_output=7'b0001111;
      8:hex_output=7'b0000000;
      9:hex_output=7'b0001100;
      10:hex_output=7'b0001000;
      11:hex_output=7'b1100000;
      12:hex_output=7'b0110001;
      13:hex_output=7'b1000010;
      14:hex_output=7'b0110000;
      15:hex_output=7'b0111000;
    endcase
  end
endmodule
