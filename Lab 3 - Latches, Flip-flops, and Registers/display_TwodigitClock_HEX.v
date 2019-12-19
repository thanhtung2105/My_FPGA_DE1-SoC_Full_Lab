module display_TwodigitClock_HEX(X, D_HEX1, D_HEX0);
  input [6:0]X;
  output [0:6]D_HEX1, D_HEX0;
  reg [3:0]FIRST_DEGIT,SECOND_DEGIT;
  always begin
    FIRST_DEGIT=X%10;
    SECOND_DEGIT=(X-FIRST_DEGIT)/10;
  end
  display_HEX_Bin2HexorDec B1 (SECOND_DEGIT, D_HEX1);
  display_HEX_Bin2HexorDec B0 (FIRST_DEGIT, D_HEX0);
endmodule
