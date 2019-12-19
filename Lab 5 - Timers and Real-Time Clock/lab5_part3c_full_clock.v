/*
____________ LAB 5 - Thanh Tung's Clock ____________
Module Lab 5 - Part 4c : "Real-time Clock - Presetable"
	- Input: KEY[0] - Reset.
				SW[7] ... SW[0]: Input Data (Time HH:MM:SS:CS).
				SW[8] - Change display and preset - 1 -> HH:MM; 0 -> SS:CS.
				SW[9] - Enable.
				KEY[2] - Preset for HEX10.
				KEY[3] - Preset for HEX32.
				KEY[1] - Start checking time and Preset for clock.
				
 	- Output: LEDG[0] - Reset.
				 LEDR[9:8] - Preset HH.
				 LEDR[7:6] - Preset MM.
				 LEDG[7:6] - Preset SS.
				 LEDG[5:4] - Preset CS.
				 LEDR[1:0] - Centisecond pulse.
				 LEDR[3:2] - Second pulse.
				 LEDR[5:4] - Minutes pulse.
*/

module lab5_part3c_full_clock(SW ,CLOCK_50, KEY, LEDR, LEDG, HEX3, HEX2, HEX1, HEX0);
  input CLOCK_50;
  input [3:0] KEY;
  input [9:0] SW;
  
  output [9:0] LEDR;
  output [7:0] LEDG;
  output [0:6] HEX3, HEX2, HEX1, HEX0;
  
  wire [19:0] PERMICROSEC;
  wire [25:0] PERSEC;
  wire [31:0] PERMIN;
  wire [37:0] PERHOUR;
  
  wire [6:0] MSEC;
  wire [5:0] SECONDS;
  wire [5:0] MINUTES;
  wire [4:0] HOURS;
  
  wire [7:0] Display_HH, Display_MM, Display_SS, Display_CS, Display_32, Display_10;
  wire [7:0] FH;
  wire [7:0] FM;
  wire [7:0] FS;
  wire [7:0] FCS;
  
  reg [4:0] FFH;
  reg [5:0] FFM;
  reg [5:0] FFS;
  reg [6:0] FFCS;
  
  reg hour = 0, min = 0, sec = 0, microsec = 0;
  
  wire [7:0] HH, MM, SS, CS;	// HH:MM - Preset for HH:MM; SS:CS - Preset for SS:CS;
  
   // Preset:
   flipflopD_8bit(KEY[0],SW[7],SW[6],SW[5],SW[4],SW[3],SW[2],SW[1],SW[0],SW[8]&~KEY[3],HH[7],HH[6],HH[5],HH[4],HH[3],HH[2],HH[1],HH[0]);
	flipflopD_8bit(KEY[0],SW[7],SW[6],SW[5],SW[4],SW[3],SW[2],SW[1],SW[0],SW[8]&~KEY[2],MM[7],MM[6],MM[5],MM[4],MM[3],MM[2],MM[1],MM[0]);
	flipflopD_8bit(KEY[0],SW[7],SW[6],SW[5],SW[4],SW[3],SW[2],SW[1],SW[0],~SW[8]&~KEY[3],SS[7],SS[6],SS[5],SS[4],SS[3],SS[2],SS[1],SS[0]);
	flipflopD_8bit(KEY[0],SW[7],SW[6],SW[5],SW[4],SW[3],SW[2],SW[1],SW[0],~SW[8]&~KEY[2],CS[7],CS[6],CS[5],CS[4],CS[3],CS[2],CS[1],CS[0]);
	
	// Signal:
	assign LEDG[0] = KEY[0];
	
	assign LEDR[9] = SW[8]&~KEY[3];
	assign LEDR[8] = SW[8]&~KEY[3];
	assign LEDR[7] = SW[8]&~KEY[2];
	assign LEDR[6] = SW[8]&~KEY[2];
	assign LEDG[7] = ~SW[8]&~KEY[3];
	assign LEDG[6] = ~SW[8]&~KEY[3];
	assign LEDG[5] = ~SW[8]&~KEY[2];
	assign LEDG[4] = ~SW[8]&~KEY[2];	
	
	// BCD to Binary - SW to data:
	bcd2bin ChangeHH (HH[7:4],HH[3:0],FH);
	bcd2bin ChangeMM (MM[7:4],MM[3:0],FM);
	bcd2bin ChangeSS (SS[7:4],SS[3:0],FS);
	bcd2bin ChangeCS (CS[7:4],CS[3:0],FCS);
	
	// Check time format:
	always
	begin
		if(FH > 5'b10111)
			FFH = 5'b10111;
		else
			FFH = FH;
		
		if(FM > 6'b111011)
			FFM = 6'b111011;
		else
			FFM = FM;
		
		if(FS > 6'b6111011)
			FFS = 6'b6111011;
		else
			FFS = FS;
			
		if(FCS > 7'b1100011)
			FFCS = 7'b1100011;
		else
			FFCS = FCS;
	end
		
	/*--------------------------------------------------------*/ 
	// Counter pulse for every type in one cycle: 
	
  counter C0 (SW[9], CLOCK_50, KEY[0], PERMICROSEC, Cout);
  defparam C0.n = 20;
  defparam C0.k = 500000;

  counter C1 (SW[9], CLOCK_50, KEY[0], PERSEC, Cout);
  defparam C1.n = 26;
  defparam C1.k = 50000000;

  counter C2 (SW[9], CLOCK_50, KEY[0], PERMIN, Cout);
  defparam C2.n = 32;
  defparam C2.k = 3000000000;

  counter C3 (SW[9], CLOCK_50, KEY[0], PERHOUR, Cout);
  defparam C3.n = 38;
  defparam C3.k = 18000000000;
  
  /*--------------------------------------------------------*/
  // Counter_nbit(En,Clk,Clrn,Prs,Qs,Q);
  // Counter time for every type:
  
  Counter_nbit C4 (SW[9], microsec, KEY[0], KEY[1], FFCS, MSEC);
  defparam C4.n = 7;
  defparam C4.k = 100;

  Counter_nbit C5 (SW[9], sec, KEY[0], KEY[1], FFS, SECONDS);
  defparam C5.n = 6;
  defparam C5.k = 60;
  
  Counter_nbit C6 (SW[9], min, KEY[0], KEY[1], FFM, MINUTES);
  defparam C6.n = 6;
  defparam C6.k = 60;
  
  Counter_nbit C7 (SW[9], hour, KEY[0], KEY[1], FFH, HOURS);
  defparam C7.n = 5;
  defparam C7.k = 24;

  // Condition for every cycle:
  always @ (negedge CLOCK_50)
	 begin
	 if (PERMICROSEC == 499999)
		microsec = 1;
	 else
		microsec = 0;
		
	 if (MSEC == 7'b0000000)
      sec = 1;
    else
      sec = 0;
	 
	 if (SECONDS == 6'b000000)
		min = 1;
	 else
		min = 0;
  
    if (MINUTES == 6'b000000)
      hour = 1;
    else
      hour = 0;
	end
	
	// Signal:
	assign LEDR[1:0] = MSEC;
	assign LEDR[3] = sec;
	assign LEDR[2] = sec;
	assign LEDR[4] = min;
	assign LEDR[5] = min;	
	
/*-____________ DISPLAY for HEX ____________________-*/
	
	assign Display_HH = {3'b0,HOURS};
	assign Display_MM = {2'b0,MINUTES};
	assign Display_SS = {2'b0,SECONDS};
	assign Display_CS = MSEC;
	
	mux2to1_nbit select_TypeOfDisplay32(Display_SS,Display_HH,SW[8],Display_32);
		defparam select_TypeOfDisplay32.n = 8;
	mux2to1_nbit select_TypeOfDisplay10(Display_CS,Display_MM,SW[8],Display_10);
		defparam select_TypeOfDisplay10.n = 8;
	
  display_TwodigitClock_HEX D1 (Display_32, HEX3, HEX2);
  display_TwodigitClock_HEX D2 (Display_10, HEX1, HEX0);
  
endmodule

module Counter_nbit(En,Clk,Clrn,Prs,Qs,Q);
	parameter n = 4;
	parameter k = 5000000000000;
	input En,Clk,Clrn,Prs;
	input [n-1:0]Qs;
	output reg [n-1:0]Q;
always@(negedge Clrn, posedge Clk, negedge Prs)
begin
	if(!Clrn)
		Q<=1'd0;
	else if(!Prs)
		Q=Qs;
	else if(Q == k-1)
		Q<=1'd0;
	else if(En)
		Q<=Q+1'b1;
end
endmodule

module bcd2bin(bcd1, bcd0, bin);
	input wire [3:0] bcd1;
	input wire [3:0] bcd0;
	output [7:0] bin;
   assign bin = (bcd1*4'd10) + bcd0;
endmodule
