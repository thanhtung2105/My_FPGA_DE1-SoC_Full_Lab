module lab6_part12 (SW, LEDG, LEDR, KEY, HEX3, HEX2, HEX1, HEX0);		//Part 1 - Part 2
  input [9:0] SW;
  input [3:0] KEY;
  output [7:0] LEDG;
  output [9:0] LEDR;
  output [0:6] HEX3, HEX2, HEX1, HEX0;

  wire [7:0] C_out, wireS;

  reg [7:0] A, B, S;
  reg overflow;		// Biến lưu bit tràn
  
/*	- Lưu ý -
  SW[9]: Lưu giá trị vào biến A/B (0/1).
  SW[8]: Chuyển chức năng - Sum/Sub (0/1).
  SW[7:0]= Dữ liệu.
  KEY[0]= Reset.
  KEY[1]= Xung CLK - gán giá trị A và B vào các LEDR và LEDG.
*/

  always @ (negedge KEY[1] or negedge KEY[0]) 
  begin
  
    if (KEY[1] == 0) 
	 begin			// Xung CLK để thực hiện lưu giá trị từ SW vào LED
		if(SW[9] == 0) 
		begin			// Xác định xem lưu giá trị của A hay B? A thì lưu LEDR - B thì lưu LEDG
			A = SW[7:0];			
		end 
		else 
		begin
			B = SW[7:0];
		end
      S = wireS;
/*		
Gán vào biến kết quả - xuất ra LED từ biến wireS - kết quả tính này là mảng 8 bit, 
sau khi tính thì tách từng 4 bit để hiển thị lên LED-7seg
*/
      overflow = C_out[7] ^ C_out[6];		// Gán bit tràn
    end
	 
    if (KEY[0] == 0) 
	 begin
      A = 8'b00000000;
      B = 8'b00000000;
      S = 8'b00000000;
      overflow = 0;
    end
  end
  
  fulladder_8bit FA_8bit (A, B^{8{SW[8]}}, SW[8], wireS, C_out); // Thực hiện cộng 2 số 8 bit - hoặc trừ
  
  assign LEDR[7:0] = A;		// Ghi giá trị A vào LEDR
  assign LEDG[7:0] = B;		// Ghi giá trị B vào LEDG

  // Hiển thị giá trị kết quả phép tính vào 2 LED đầu
  hex_display H1 (S[7:4], HEX1);		// Kết quả hàng chục
  hex_display H0 (S[3:0], HEX0);		// Kết quả hàng đơn vị
  
  // 2 LED không sử dụng tới thì để tắt hết:
  assign HEX3 = 7'b1111111;
  assign HEX2 = 7'b1111111;
  
  assign LEDR[9] = overflow;
endmodule
