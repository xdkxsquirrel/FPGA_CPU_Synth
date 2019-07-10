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

module TOP_TB;

	// Inputs
	reg  clock,
	reg  [3:0] buttons,
	reg  [9:0]Sw,
	wire Output_Sound
	
	TOP uut (
		.clock(clock),
		.reset(reset),
		.buttons(buttons),
		.Sw(Sw),
		.Output_Sound(Output_Sound)
	);

//////////////////////////////////////////////////////////////////////
// Main Testbench Procedure
//////////////////////////////////////////////////////////////////////
initial
begin
	clock = 0;
	reset = 1;
	#4
	reset = 0;
end 

always 
	#1 clock=!clock;

	
initial 
begin
	 $monitor("%d,\t%b,\t%b,\t%b,\t%b",$time, reset, PC_en, PC_input, PC_output);
end

initial
begin

	Test_Instructions();
	
	$stop;
end

task Test_Instructions;
begin

	
end
endtask

endmodule



