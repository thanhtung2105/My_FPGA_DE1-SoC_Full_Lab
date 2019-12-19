/*
____________ LAB 4 ____________
Module T-count up 8 bit with:
	- Input: En, Clk, Clrn, Prs, Qs.
	- Output: Q.
	- Carry Out.
*/
module T_countup8bit(En,Clk,Clrn,Prs,Qs,Q,Cout);
input En,Clk,Clrn,Prs;
input [7:0]Qs;	
output reg [7:0]Q;
output Cout;

assign Cout = En&Q[0]&Q[1]&Q[2]&Q[3]&Q[4]&Q[5]&Q[6]&Q[7];
always@(negedge Clrn, posedge Clk, negedge Prs)
begin
	if(!Clrn)
		Q<=0;
	else if(!Prs)
		Q=Qs;  
	else if(En)
		Q<=Q+1;
end
endmodule
