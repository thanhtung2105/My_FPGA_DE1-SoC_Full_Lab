/*
____________ LAB 3 ____________
Module D Latch with Clear:
	- Input: D and Clock, or Clear - D, Clk or Clr
	- Output: Q
*/
module dpedg_wClear(Clr, Clk, D, Q);
	input D,Clk,Clr;
	output reg Q;
	reg Qm;
	always@(D,Clk,Clr)
	begin
		if(~Clr)
			begin
				Qm=0;
				Q=0;
			end
		else
			begin
				if(~Clk)
					Qm=D;
				else
					Q=Qm;
			end
	end
endmodule
