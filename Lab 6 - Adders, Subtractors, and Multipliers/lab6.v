module lab6(SW, CLOCK_50, LEDG, LEDR, KEY, HEX3, HEX2, HEX1, HEX0);
	input [9:0] SW;
	input [3:0] KEY;
	input CLOCK_50;
	output [7:0] LEDG;
	output [9:0] LEDR;
	output [0:6] HEX3, HEX2, HEX1, HEX0;

	wire [25:0]C;
	wire K;
	counter counter26bit(SW[9],CLOCK_50,KEY[0],C,K);
		defparam counter26bit.n = 26;
  
	wire [7:0]Q;
	FF_D_8bit(SW[7:0],C[25],KEY[0],Q);
	
	wire [7:0]M;
	wire [7:0]Qo;
	fulladder_8bit(Q,Qo,SW[8],M,LEDR[9]);
	
	FF_D_8bit(M,C[25],KEY[0],Qo);
	assign LEDR[7:0] = Q;
	assign LEDG[7:0] = Qo;
	
	// Hiển thị giá trị kết quả phép tính vào 2 LED đầu
  hex_display H1 (Qo[7:4], HEX1);		// Kết quả hàng chục
  hex_display H0 (Qo[3:0], HEX0);		// Kết quả hàng đơn vị
  
  // 2 LED không sử dụng tới thì để tắt hết:
  assign HEX3 = 7'b1111111;
  assign HEX2 = 7'b1111111;	
endmodule
