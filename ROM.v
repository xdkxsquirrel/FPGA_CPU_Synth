`timescale 1ns / 1ps
// Quartus Prime Verilog Template
// Single port RAM with single read/write address 

module ROM
(
	input [15:0] addr,
	input clk,
	output reg [15:0] q
);

	// Declare the RAM variable
	reg [15:0] rom[2**5:0];
	
	initial begin
	$readmemb("synth.mem", rom);
	end

	always @ (posedge clk)
	begin
		q = rom[addr];
	end

endmodule



