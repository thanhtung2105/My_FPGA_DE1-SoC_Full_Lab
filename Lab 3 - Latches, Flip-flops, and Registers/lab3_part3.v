/*
____________ LAB 3 ____________
Module Lab 1 - Part 3: "Create FF-D"
	- Input: SW[0] SW[1].
	- Output: LEDG[0].
	- Clear: KEY[0].
*/
module lab3_part3(SW[1:0],LEDG[1:0],KEY[0]);
output [1:0]LEDG;
input	[1:0]SW;
input [1:0]KEY;
wire Qm;
	dpedg_wClear(KEY[0], ~SW[1], SW[0], Qm);
	dpedg_wClear(KEY[0], SW[1], Qm, LEDG[0]);
endmodule
