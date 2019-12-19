// Thanh ghi R data_in, L enable
module regnX(R,Enable,CLR,Clock,Q);
	parameter n = 8;
	input [n-1:0]R;
	input Enable,CLR,Clock;
	output reg [n-1:0]Q;
	
	always@(posedge Clock)
		if(~CLR)	Q <= 1'd0;
		else if(Enable)
			Q <= R;
endmodule
