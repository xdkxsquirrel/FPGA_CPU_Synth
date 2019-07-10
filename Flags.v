`timescale 1ns / 1ps
/*
PARAMETERS:
*/
module Flags(
	input [4:0]flags,
	input clock,
	output reg carry,
	output reg [4:0]flag_output
);


always @(posedge clock)
begin
	case (flags[3])
		1: carry = 1;
		0: carry = 0;
	endcase
	flag_output <= flags;
end
endmodule

