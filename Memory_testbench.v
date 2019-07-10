`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Donovan Bidlack
//
// Create Date:   14:25:01 09/01/2018
// Design Name:   Memory_Testbench
// Project Name:  CPU
// Target Device:  
// Tool versions:  
// Description: 
//
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Memory_testbench;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;
	reg [7:0] Opcode;
	reg Cin;

	// Outputs
	wire [15:0] C;
	wire [4:0] Flags;
	
	reg signed [15:0] SignedA;
	reg signed [15:0] SignedB;
	reg signed [15:0] SignedC;

	integer i;
	// Instantiate the Unit Under Test (UUT)
	Memory mem (
		.A(A), 
		.B(B), 
		.C(C),
		.Cin(Cin),
		.Opcode(Opcode), 
		.Flags(Flags)
	);


//////////////////////////////////////////////////////////////////////
// Main Testbench Procedure
//////////////////////////////////////////////////////////////////////
initial
begin
	FIBONACCI();
	//ADD1();
	$stop;
end



//////////////////////////////////////////////////////////////////////
// Fibonacci Sequence
////////////////////////////////////////////////////////////////////// 
task FIBONACCI;
begin

		// Initialize Inputs
		A = 0;
		B = 0;
		Opcode = 8'b00000101;
	
		// Wait 100 ns for global reset to finish
		#100
		//6 + 12 = 18
		A = 16'h0006; B = 16'h000C; #10;
		$display("TESTING ADD");
		if (C !== 16'h0012) $display("A: %0d, B: %0d, C: %0d, Flags[4:0]: %b, Failed", A, B, C, Flags[4:0]); #10;
		
		//FFFF + 0002 = 1 0001
		A = 16'hFFFF; B = 16'h0002; #10;
		if (C !== 16'h0001 && Flags[4:0] !== 5'b01000) $display("A: %0d, B: %0d, C: %0d, Flags[4:0]: %b, Failed", A, B, C, Flags[4:0]); #10;		
		
end
endtask      
endmodule



