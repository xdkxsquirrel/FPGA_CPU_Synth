`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Engineer: Donovan Bidlack
//
// Create Date:   14:25:01 09/01/2018
// Design Name:   CPU
// Module Name:   CPU_testbench.v
// Project Name:  CPU_testbench
//
// Verilog Test Fixture created by ISE for module: CPU
////////////////////////////////////////////////////////////////////////////////

module CPU_testbench;

	// Inputs
	reg reset;
	reg clock;
	reg [15:0] Address_B;
	reg Song_Select;
	reg [15:0] Key_Pressed;
	wire [15:0] data_b;
	wire [15:0] r1;
	
	//reset, clock, Address_B, Song_Select, Key_Pressed, data_b, r1

	 //Instantiate the Units Under Test (UUT)
	CPU uut (
		.reset(reset),
		.clock(clock),
		.Address_B(Address_B),
		.Song_Select(Song_Select),
		.Key_Pressed(Key_Pressed),
		.data_b(data_b),
		.r1(r1)
	);

//////////////////////////////////////////////////////////////////////
// Main Testbench Procedure
//////////////////////////////////////////////////////////////////////
initial
begin
	clock = 0;
	reset = 1;
	Address_B = 16'h0000;
	Key_Pressed = 16'b0000000000000000;
	Song_Select = 0;
	#5
	reset = 0;
	Song_Select = 1;
end 

always 
	#1 clock=!clock;

initial 
begin 
	 $monitor("%d,\t%b,\t%b,\t%b,\t%h,\t%d,\t%d,\t%b,\t%d,\t%d,\t%b,\t%b,\t%d,\t%d,\t%d,\t%d", $time, uut.instruction, uut.opcode, uut.regEnable, uut.Program_counter, uut.r1, uut.r2, uut.Address_A, uut.result, uut.PC_Input, uut.flags, uut.branch, uut.dest_reg, uut.imm_reg_output, uut.selectA, uut.selectB, uut.select_immediate);
end	

initial
begin

   Fibonacci();
	
	#1000
	Key_Pressed = 16'b0000000000000000;
	#600
	$stop;
end

 
task Fibonacci;
begin
	
	//Key_Pressed = 16'b0000000000000010;
	#4
	$display("###################################### ADDI 1, $r6 ##############################################");
	$display("      Headers: $time,      instruction,   opcode,       reg_enable,   PC,    r1,    r2, Addr_A, result");
	$display("        Should be   , 0101011000000001, 01010000, 0000000001000000, 0001,     0,     0, 000000,     1");
	#6
	$display(" ");
	$display("###################################### ADDI 3, $r5 ##############################################");
	$display("      Headers: $time,      instruction,   opcode,       reg_enable,   PC,    r1,    r2, Addr_A, result");
	$display("        Should be   , 0101010100000011, 01010000, 0000000000100000, 0002,     0,     0, 000000,     3");
	#4
	$display(" ");
	$display("###################################### ADDI 8, $r9 ##############################################");
	$display("      Headers: $time,      instruction,   opcode,       reg_enable,   PC,    r1,    r2, Addr_A, result");
	$display("        Should be   , 0101100100001000, 01010000, 0000001000000000, 0003,     0,     0, 000000,     8");
	#4

	$display(" ");
	$display("###################################### AND $r1, $r15 ############################################");
	$display("      Headers: $time,      instruction,   opcode,       reg_enable,   PC,    r1,    r2, Addr_A, result");
	$display("        Should be   , 0000000100011111, 00000001, 0000000000000010, 0004,     0,     0, 000000,     0");
	#4
	
	$display(" ");
	$display("###################################### AND $r4, $r15 ############################################");
	$display("      Headers: $time,      instruction,   opcode,       reg_enable,   PC,    r1,    r2, Addr_A, result");
	$display("        Should be   , 0000010000011111, 00000001, 0000000000010000, 0005,     0,     0, 000000,     0");
	#4

	$display(" ");
	$display("###################################### ADDI 1, $r1 ##############################################");
	$display("      Headers: $time,      instruction,   opcode,       reg_enable,   PC,    r1,    r2, Addr_A, result");
	$display("        Should be   , 0101000100000001, 01010000, 0000000000000010, 0006,     1,     0, 000000,     1");
	#4
	
	$display(" ");
	$display("###################################### ADDI 233, $r4 ############################################");
	$display("      Headers: $time,      instruction,   opcode,       reg_enable,   PC,    r1,    r2, Addr_A, result");
	$display("        Should be   , 0101010011101001, 01011110, 0000000000010000, 0007,     1,     0, 000000,   233");
	#4
	$display(" ");
	$display("###################################### STORE $r4 -> $r5 Mem 4 ###################################");
	$display("      Headers: $time,      instruction,   opcode,       reg_enable,   PC,    r1,    r2, Addr_A, result");
	$display("        Should be   , 0100010001000101, 01010000, 0000000000000000, 0008,     1,     0, 000011,   233");
	#4
	
	$display(" ");
	$display("###################################### STORE $r1 -> $r6 Mem 1 ###################################");
	$display("      Headers: $time,      instruction,   opcode,       reg_enable,   PC,    r1,    r2, Addr_A, result");
	$display("        Should be   , 0100000101000110, 01010000, 0000000000000000, 0009,     1,     0, 000001,     1");
	#6

	$display(" ");
	$display("###################################### ADD $r1, $r2 #############################################");
	$display("      Headers: $time,      instruction,   opcode,       reg_enable,   PC,    r1,    r2, Addr_A, result");
	$display("        Should be   , 0000000101010001, 00000101, 0000000000000010, 000A,     1,     0, 000000,     1");
	#6
	
	$display(" ");
	$display("###################################### LOAD $r6 Mem1 -> $r2 #####################################");
	$display("      Headers: $time,      instruction,   opcode,       reg_enable,   PC,    r1,    r2, Addr_A, result");
	$display("        Should be   , 0100001000000110, 01000000, 0000000000000000, 000B,     1,     1, 000001,     1");
	#6
	
	$display(" ");
	$display("###################################### CMP $r1, $r4 #$###########################################");
	$display("      Headers: $time,      instruction,   opcode,       reg_enable,   PC,    r1,    r2, Addr_A, result");
	$display("        Should be   , 0000000110110100, 01010000, 0000000000000000, 000D,     1,     1, 000000,     0");
	#4
	
	$display(" ");
	$display("###################################### Jcond 3 in $r5 if $r4 < $r1 ##############################");
	$display("      Headers: $time,      instruction,   opcode,       reg_enable,   PC,    r1,    r2, Addr_A, result");
	$display("        Should be   , 0100000111000100, 01010000, 0000000000000000, 000D,     1,     1, 000000,     3");
	#8
	
	$display(" ");
	$display("###################################### Jump 8(located in $r9) ###################################");
	$display("      Headers: $time,      instruction,   opcode,       reg_enable,   PC,    r1,    r2, Addr_A, result");
	$display("        Should be   , 0100000111000100, 01000000, 0000000000000000, 0008,     1,     1, 000000,     8");
	#8
	
	$display(" ");
	$display("###################################### STORE $r1 -> $r6 Mem 1 ###################################");
	$display("      Headers: $time,      instruction,   opcode,       reg_enable,   PC,    r1,    r2, Addr_A, result");
	$display("        Should be   , 0100000101000110, 01010000, 0000000000000000, 0009,     1,     1, 000001,     1");
	#4
	
	$display(" ");
	$display("###################################### ADD $r1, $r2 #############################################");
	$display("      Headers: $time,      instruction,   opcode,       reg_enable,   PC,    r1,    r2, Addr_A, result");
	$display("        Should be   , 0000000101010001, 00000101, 0000000000000010, 000A,     1,     1, 000000,     2");
	#4
	
	$display(" ");
	$display("###################################### LOAD $r6 Mem1 -> $r2 #####################################");
	$display("      Headers: $time,      instruction,   opcode,       reg_enable,   PC,    r1,    r2, Addr_A, result");
	$display("        Should be   , 0100001000000110, 01000000, 0000000000000000, 000B,     2,     2, 000001,     2");
	#6
	
	$display(" ");
	$display("###################################### CMP $r1, $r4 #$###########################################");
	$display("      Headers: $time,      instruction,   opcode,       reg_enable,   PC,    r1,    r2, Addr_A, result");
	$display("        Should be   , 0000000110110100, 00001011, 0000000000000000, 000D,     1,     1, 000000,     0");
	#4
	
	$display(" ");
	$display("###################################### Jcond 3 in $r5 if $r4 < $r1 ##############################");
	$display("      Headers: $time,      instruction,   opcode,       reg_enable,   PC,    r1,    r2, Addr_A, result");
	$display("        Should be   , 0100000111000100, 01010000, 0000000000000000, 000D,     1,     1, 000000,     3");
	#8
	
	$display(" ");
	$display("###################################### Jump 8(located in $r9) ###################################");
	$display("      Headers: $time,      instruction,   opcode,       reg_enable,   PC,    r1,    r2, Addr_A, result");
	$display("        Should be   , 0100000111000100, 01010000, 0000000000000000, 0008,     0,     0, 000000,     3");
	#8
	
	$display(" ");
	#40
	$display(" ");
end
endtask	
    
endmodule



