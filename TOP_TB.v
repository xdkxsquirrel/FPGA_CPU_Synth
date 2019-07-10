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
	reg  clock;
	reg  [3:0] buttons;
	reg  [9:0]Sw;
	wire Output_Sound;
	
	TOP uut (
		.clock(clock),
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
	Sw[9] = 1;
	buttons = 4'h0;
	Sw[8:0] = 9'b000000000;
	#4
	Sw[8] = 0;
	Sw[9] = 0;
end 

always 
	#1 clock=!clock;

	
//initial 
//begin
	 //$monitor("%d,\t%b,\t%b,\t%b,\t%b",$time, reset, PC_en, PC_input, PC_output);
//end

initial
begin

	Synth();
	
	$stop;
end

task Synth;
begin
	Sw[0] = 1;
	#10
	Sw[1] = 1;
	#100
	Sw[0] = 0;
	#10
	Sw[1] = 0;
	#40
	Sw[0] = 1;
	#10
	Sw[1] = 1;
	#100
	Sw[0] = 0;
	#10
	Sw[1] = 0;
	#5000
	$display(" ");
end
endtask

endmodule



