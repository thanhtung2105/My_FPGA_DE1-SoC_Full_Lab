// Counter (EN,Clock,Reset_n,UpDown,Q,Cout);
// Mux2_1_nbit(a,b,s,f); defparam n 
// regnX(R,Enable,CLR,Clock,Q); defparam n
// Fulladder (a, b, c_in, result, c_out);
// Multiplier_n_bit(A, B, P);
// swap(Reset,Clock,w,Data,Extern,RinExt1,RinExt2,RinExt3,BusWire,Done,R1,R2);
// CounterX (EN,Clock,Reset_n,Q,Cout,Pre,IN);


// BCD_9(binary_input,hex_output);
// Hex_display(binary_input, hex_output);
// Bin2bcd(binary_input,bcd3,bcd2,bcd1,bcd0);
// DE1_(S,H);


module exam(LEDR,LEDG,SW,KEY,CLOCK_50,HEX3,HEX2,HEX1,HEX0);
	input [9:0]SW;
	input [3:0]KEY;
	input CLOCK_50;
	output [7:0]LEDG;
	output [9:0]LEDR;
	output [6:0]HEX3,HEX2,HEX1,HEX0;
	
	wire Enable, Reset, Preset, Clock, Co;
	wire [25:0]C;
	wire [3:0]bcd3,bcd2,bcd1,bcd0;
	
	//assign Input	assign Clock = C[21];
	assign Enable = SW[9];
	assign Reset = KEY[0];
	//assign Preset = SW[8];
	//assign UpDown = SW[0];
	
	//assign Output
	//assign LEDG[0] = Clock;
	
	
	Counter CLK(1'b1, CLOCK_50, 1'b1, 1'b0, C);
		defparam CLK.n = 26;
	
	wire kout, sout, pout, hout;
	wire [7:0]SentiSencond, Second, Minute, Hour; 
	wire [15:0]playSS, playMH, play;
	
	CounterX counterk(Enable,C[20],Reset,SentiSencond,kout,KEY[2],SW[8],SW[7:0]);
		defparam counterk.n = 8;
		defparam counterk.k = 100;
	
	
	CounterX counters(Enable,kout,Reset,Second,sout,KEY[3],SW[8],SW[7:0]);
		defparam counters.n = 8;
		defparam counters.k = 60;
	 
	Bin2bcd(SentiSencond,Q1,O2,playSS[7:4],playSS[3:0]);
	Bin2bcd(Second,O3,O4,playSS[15:12],playSS[11:8]);
	

//------------------------------------------------------------------------------------------------
	
	CounterX counterp(Enable,sout,Reset,Minute,pout,KEY[2],~SW[8],SW[7:0]);
		defparam counterp.n = 8;
		defparam counterp.k = 60;

	CounterX counterh(Enable,pout,Reset,Hour,hout,KEY[3],~SW[8],SW[7:0]);
		defparam counterh.n = 8;
		defparam counterh.k = 12;
		
	Bin2bcd(Minute,O5,O6,playMH[7:4],playMH[3:0]);
	Bin2bcd(Hour,O7,O8,playMH[15:12],playMH[11:8]);

	assign LEDG[7:0] = Hour; 
	
	Mux2_1_nbit playHex(playMH,playSS,SW[8],play);
		defparam playHex.n = 16;
		
	Hex_display(play[15:12],HEX3);
	Hex_display(play[11:8],HEX2);
	Hex_display(play[7:4],HEX1);
	Hex_display(play[3:0],HEX0);

	
	/*
	reg [7:0]Sum;
	reg Carry;
	
	wire [7:0]A,B;
	
	regnX addA(SW[7:0],~KEY[3],Reset,Clock,A);
	regnX addB(SW[7:0],~KEY[2],Reset,Clock,B);

	always@(posedge CLK)
	begin
		{Carry,Sum} = A + B;
		if(SW[8]) {Sum} = Sum + 1'b1;
	end
	
	wire [15:0]playHex,playDec,play;
	
	assign playHex = {7'b0,Carry,Sum};
	
	Bin2bcd(playHex,playDec[15:12],playDec[11:8],playDec[7:4],playDec[3:0]);
	
	Mux2_1_nbit selectHEX(playHex,playDec,SW[9],play);
		defparam selectHEX.n = 16;
		
	Hex_display(play[3:0],HEX0);
	Hex_display(play[7:4],HEX1);
	Hex_display(play[11:8],HEX2);
	Hex_display(play[15:12],HEX3);
	*/
	
endmodule
