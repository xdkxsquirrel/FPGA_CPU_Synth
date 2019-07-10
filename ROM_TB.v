`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Engineer: Donovan Bidlack
//
// Create Date:   16:35:01 11/06/2018
// Design Name:   Controller
// Module Name:   Controller_testbench.v
// Project Name:  Controller_testbench
//
// Verilog Test Fixture created by ISE for module: Controller
////////////////////////////////////////////////////////////////////////////////

module ROM_TB;

	// Inputs
	reg [15:0] addr;
	reg clock;
	
	wire [15:0] q;

	
	ROM uut (
		.clk(clock),
		.addr(addr), 
		.q(q)
	);

//////////////////////////////////////////////////////////////////////
// Main Testbench Procedure
//////////////////////////////////////////////////////////////////////
initial
begin
	clock = 0;
end 

always 
	#1 clock=!clock;

	
initial 
begin
	 $monitor("%d,\t%b,\t%b", $time, addr, q);
end

initial
begin

	Test_Instructions();
	//Fibinocci();
	
	$stop;
end

task Test_Instructions;
begin   
	addr = 16'h0000;
	#4
	$display(" ");
	addr = 16'h0001;
	#4
	$display(" ");
	addr = 16'h0002;
	#4
	$display(" ");
	addr = 16'h0003;
	#4
	$display(" ");
	addr = 16'h0004;
	#4
	$display(" ");
	addr = 16'h0005;
	#4
	$display(" ");
	addr = 16'h0006;
	#4
	$display(" ");
	addr = 16'h0007;
	#4
	$display(" ");
	addr = 16'h0008;
	#4
	$display(" ");
	addr = 16'h0009;
	#4
	$display(" ");
	addr = 16'h000A;
	#4
	$display(" ");
	addr = 16'h000B;
	#4
	$display(" ");
	addr = 16'h000C;
	#4
	$display(" ");
	addr = 16'h000D;
	#4
	$display(" ");
	addr = 16'h000E;
	#4
	$display(" ");
	
end
endtask

endmodule



