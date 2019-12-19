/*
____________ LAB 5 ____________
Module Lab 5 - Part 4: "Morse Encoder - Decoder"
	- Input: KEY[0] - Reset, SW[9] - EN, KEY[1] - Start Decoding ...
 	- Output: HEX0 display A,B,C,D,E,F,G,H; LEDR0 perform decoding; LEDG7 perform pulse 1s.
*/
module lab5_part4(CLOCK_50, KEY, SW, LEDR, LEDG, HEX0);
  input CLOCK_50;
  input [3:0] KEY;
  input [9:0] SW;
  output reg [1:0] LEDR;
  output reg [7:0] LEDG;
  output [0:6] HEX0;

  wire [25:0] half_sec;	// Nửa giây
  wire half_pulse;			// Nửa xung
  wire [3:0] Counter_time_last;
  wire reset;
  wire [1:0] Cout;

  reg half;
  reg [13:0] time_last;	// Mảng biểu thị thời gian kéo dài của từng tín hiệu Morse
  reg [13:0] ruler;		// Thước đo 0.5s
  // Tạo một nửa xung đồng hồ:
  counter C0 (SW[9], CLOCK_50, KEY[0], half_sec, Cout[0]);
  defparam C0.n = 26;
  defparam C0.k = 12500000;

  // Tạo nửa xung đồng hồ (từ 1/2 xung clock ở trên:
  counter C1 (SW[9], half, KEY[0], half_pulse, Cout[1]);
  defparam C1.n = 1;
  defparam C1.k = 2;
	
  // Cứ được nửa xung (1s) thì bắt đầu tăng half lên 1:
  always @ (negedge CLOCK_50) begin
    if (half_sec == 12499999)
      half = 1;
    else
      half = 0;
  end

  // Tạo khoảng thời gian trễ cho từng mã Morse từ A - H với 000 -> case 0 -> A
  always @ (negedge KEY[1]) begin
    case (SW[2:0])
      0: time_last = 14'b00101110000000; // A
      1: time_last = 14'b00111010101000; 
      2: time_last = 14'b00111010111010; 
      3: time_last = 14'b00111010100000; 
      4: time_last = 14'b00100000000000; // E
      5: time_last = 14'b00101011101000; 
      6: time_last = 14'b00111011101000; 
      7: time_last = 14'b00101010100000; // H
    endcase
	 
	 case (SW[5])
		0: ruler = 14'b10101010101010;  // Ruler
	 endcase
  end

  assign reset = SW[9]&KEY[0];	// Enable & Reset (chỉ khi SW9 kéo lên mới chạy)
  counter_modk C2 (half_pulse, reset, Counter_time_last);
  defparam C2.n = 4;
  defparam C2.k = 14;
  
  // Hoạt động xảy ra trong mỗi lần xung CLK
  always begin
    case (Counter_time_last)
      0:begin LEDR[0] = time_last[13];
		  LEDG[7] = ruler[13];
		  end
      1:begin LEDR[0] = time_last[12];
		  LEDG[7] = ruler[12];
		  end
      2:begin LEDR[0] = time_last[11];
		  LEDG[7] = ruler[11];
		  end
      3:begin LEDR[0] = time_last[10];
		  LEDG[7] = ruler[10];
		  end
      4:begin LEDR[0] = time_last[9];
		  LEDG[7] = ruler[9];
		  end
      5:begin LEDR[0] = time_last[8];
		  LEDG[7] = ruler[8];
		  end
      6:begin LEDR[0] = time_last[7];
		  LEDG[7] = ruler[7];
		  end
      7:begin LEDR[0] = time_last[6];
		  LEDG[7] = ruler[6];
		  end
      8:begin LEDR[0] = time_last[5];
		  LEDG[7] = ruler[5];
		  end
      9:begin LEDR[0] = time_last[4];
		  LEDG[7] = ruler[4];
		  end
      10:begin LEDR[0] = time_last[3];
		  LEDG[7] = ruler[3];
		  end
      11:begin LEDR[0] = time_last[2];
		  LEDG[7] = ruler[2];
		  end
      12:begin LEDR[0] = time_last[1];
		  LEDG[7] = ruler[1];
		  end
      13:begin LEDR[0] = time_last[0];
		  LEDG[7] = ruler[0];
		  end
    endcase
  end
  b2alphabet(SW[2:0],HEX0);
endmodule

module b2alphabet (X, SSD);
  input [2:0] X;
  output reg [0:6] SSD;
  always begin
    case(X)
      0:SSD=7'b0001000;
      1:SSD=7'b1100000;
      2:SSD=7'b0110001;
      3:SSD=7'b1000010;
      4:SSD=7'b0110000;
      5:SSD=7'b0111000;
      6:SSD=7'b0100001;
      7:SSD=7'b1001000;
    endcase
  end
endmodule

// Bảng nhận biết độ trễ cho từng kí tự 
// A    -_--        101110000000
// B    --_-_-_-    111010101000
// C    --_-_--_-   111010111010
// D    --_-_-      111010100000
// E    -           100000000000
// F    -_-_--_-    101011101000
// G    --_--_-     111011101000
// H    -_-_-_-     101010100000