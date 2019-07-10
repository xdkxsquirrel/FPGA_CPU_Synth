`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: JoCee Porter
//
// Create Date:   14:25:01 09/01/2018
// Design Name:   alu
// Module Name:   C:/Documents and Settings/Administrator/ALU/alutest.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALU_testbench;

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
	ALU uut (
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
	ADD();
	ADDI();
	ADDU();
	ADDUI();
	ADDC();
	ADDCU();
	ADDCUI();
	ADDCI();
	SUB();
	SUBI();
	CMP();
	CMPI();
	CMPU();
	AND();
	OR();
	XOR();
	NOT();
	LSH();
	LSHI();
	RSH();
	RSHI();
	ALSH();
	ARSH();
	$stop;
end



//////////////////////////////////////////////////////////////////////
// ADD
////////////////////////////////////////////////////////////////////// 
task ADD;
begin
//			$monitor("A: %0d, B: %0d, C: %0d, Flags[1:0]: %b, time:%0d", A, B, C, Flags[1:0], $time );


		// Initialize Inputs
		A = 0;
		B = 0;
		Opcode = 8'b00000101;
	
		#100
		//6 + 12 = 18
		A = 16'h0006; B = 16'h000C; #10;
		$display("TESTING ADD 6+12=18");
		if (C !== 16'h0012) $display("A: %0d, B: %0d, C: %0d, Flags[4:0]: %b, Failed", A, B, C, Flags[4:0]); #10;
		
		//FFFF + 0002 = 1 0001
		A = 16'hFFFF; B = 16'h0002; #10;
		$display("TESTING ADD 0xFFFF+0x0002=0x0001");
		if (C !== 16'h0001 && Flags[4:0] !== 5'b01000) $display("A: %0d, B: %0d, C: %0d, Flags[4:0]: %b, Failed", A, B, C, Flags[4:0]); #10;		
		#10
		
		A = 10;
		B = 10;
		#10
		$display("TESTING ADD 10+10=20");
		if(C !== 20)
		begin
			$display("C incorrect in ADD");
			$display("A: %0d, B: %0d, C: %0d, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
			$display("Flags--- Carry bit: %b, Flag Bit: %b, Comparison bit: %b, Negative: %b'", Flags[0], Flags[1], Flags[2], Flags[3], Flags[4]);
		end
		if(Flags[3] !== 0)
			$display("Carry bit incorrect in ADD");
		if(Flags[0] !== 0)
			$display("Low bit incorrect in ADD");
		if(Flags[2] !== 0)
			$display("Flag bit incorrect in ADD");
		if(Flags[4] !== 0)
			$display("Comparison bit incorrect in ADD");
		if(Flags[1] !== 0)
			$display("Negative bit incorrect in ADD");

		#10
		A = 16'b0111_1111_1111_1111;
		B = 16'b0111_1111_1111_1111;
		#10
		SignedA = A;
		SignedB = B;
		SignedC = C;
		$display("TESTING ADD 0x7FFF+0X7FFF=0xFFFE Overflow");
		if(C !== 16'b1111111111111110)
			begin
			$display("A: %0d, B: %0d, C: %0d, Flags[4:0]: %b, time:%0d", SignedA, SignedB, SignedC, Flags[4:0], $time );
			$display("Flags--- Carry bit: %b, Flag Bit: %b, Comparison bit: %b, Negative: %b, Low: %b", Flags[3], Flags[2], Flags[4], Flags[1], Flags[0]);
			end

		if(Flags[3] !== 0)
			$display("Carry bit incorrect in ADD");
		if(Flags[0] !== 0)
			$display("Low bit incorrect in ADD");
		if(Flags[2] !== 1)
			$display("Flag bit incorrect in ADD");
		if(Flags[4] !== 0)
			$display("Comparison bit incorrect in ADD");
		if(Flags[1] !== 1)
			$display("Negative bit incorrect in ADD");
		end
endtask	

task ADDC;
		begin
		Opcode = 8'b0000_0111;
		A = 16'b1111111111111010;
		B = 16'b1111111111111110;
		Cin = 1'b1;
		#10
		$display("TESTING ADDC");

		if(C !== 16'b1111111111111001)
		begin
			SignedA = A;
			SignedB = B;
			SignedC = C;
			$display("C incorrect in ADDC");
			$display("A: %0d, B: %0d, C: %0d, Flags[4:0]: %b, time:%0d", SignedA, SignedB, SignedC, Flags[4:0], $time );
			$display("A: %0d, B: %0d, C: %0d, Flags[4:0]: %b, time:%0d", SignedA, SignedB, SignedC, Flags[4:0], $time );
				$display("Flags--- Carry bit: %b, Flag Bit: %b, Comparison bit: %b, Negative: %b, Low: %b", Flags[3], Flags[2], Flags[4], Flags[1], Flags[0]);
		end
		//Flags should display here.
		if(Flags[3] !== 1)
			//14+1+1 -> 16
			$display("Carry bit incorrect in ADDC");
		if(Flags[0] !== 0)
			$display("Low bit incorrect in ADDC");
		if(Flags[2] !== 1)
			$display("Flag bit incorrect in ADDC");
		if(Flags[4] !== 0)
			$display("Comparison bit incorrect in ADDC");
		if(Flags[1] !== 0)
			$display("Negative bit incorrect in ADDC");
		end
endtask	

task ADDCU;
		// Testing ADDCU opcode: 0000_0111
		begin
		Opcode = 8'b0000_1000;
		A = 13;
		B = 2;
		Cin = 1'b1;	
		#10
		$display("TESTING ADDCU");

		if(C !== 16)
		begin
			$display("C incorrect in ADDCU");
			$display("A: %0d, B: %0d, C: %0d, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
			$display("A: %0d, B: %0d, C: %0d, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
			$display("Flags--- Carry bit: %b, Flag Bit: %b, Comparison bit: %b, Negative: %b, Low: %b", Flags[3], Flags[2], Flags[4], Flags[1], Flags[0]);
		end
		//Flags should display here.
		if(Flags[3] !== 1)
			//14+1+1 -> 16
			$display("Carry bit incorrect in ADDCU");
		if(Flags[0] !== 0)
			$display("Low bit incorrect in ADDCU");
		if(Flags[2] !== 1)
			$display("Flag bit incorrect in ADDCU");
		if(Flags[4] !== 0)
			$display("Comparison bit incorrect in ADDCU");
		if(Flags[1] !== 0)
			$display("Negative bit incorrect in ADDCU");
		end
endtask

task SUB;		
		//Testing SUB opcode: 0000_1001
		begin
		Opcode = 8'b0000_1001;
		A = 10;
		B = 20;
		#10
		SignedA = A;
		SignedB = B;
		SignedC = C;
		$display("TESTING SUB");
		if(SignedC!== -10)
		begin
			$display("A: %0d, B: %0d, C: %0d, Flags[4:0]: %b, time:%0d", SignedA, SignedB, SignedC, Flags[4:0], $time );		
			$display("Flags--- Carry bit: %b, Flag Bit: %b, Comparison bit: %b, Negative: %b, Low: %b", Flags[3], Flags[2], Flags[4], Flags[1], Flags[0]);
		end
		if(Flags[3] !== 0)
			$display("Carry bit incorrect in SUB");
		if(Flags[0] !== 0)
			$display("Low bit incorrect in SUB");
		if(Flags[2] !== 0)
			$display("Flag bit incorrect in SUB");
		if(Flags[4] !== 0)
			$display("Comparison bit incorrect in SUB");
		if(Flags[1] !== 0)
			$display("Negative bit incorrect in SUB");
		end
endtask

task SUB1;		
		//Testing SUB (signed subtraction) opcode: 0000_1001
		begin
		Opcode = 8'b0000_1001;
		A = 20;
		B = 10;
		#10
		if(C !== 10)
		begin
			$display("TESTING SUB1");
			$display("A: %0d, B: %0d, C: %0d, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
			$display("Flags--- Carry bit: %b, Flag Bit: %b, Comparison bit: %b, Negative: %b, Low: %b", Flags[3], Flags[2], Flags[4], Flags[1], Flags[0]);
		end
		if(Flags[3] !== 0)
			$display("Carry bit incorrect in SUB");
		if(Flags[0] !== 0)
			$display("Low bit incorrect in SUB");
		if(Flags[2] !== 0)
			$display("Flag bit incorrect in SUB");
		if(Flags[4] !== 0)
			$display("Comparison bit incorrect in SUB");
		if(Flags[1] !== 0)
			$display("Negative bit incorrect in SUB");
		end
endtask		
task CMP;		
		//Testing CMP opcode: 0000_1011
		begin
		Opcode = 8'b0000_1011;
		A = 10;
		B = 20;
		#10
		$display("TESTING CMP");
		if(C !== 16'b0000_0000_0000_0000)
		begin
			$display("A: %0d, B: %0d, C: %0d, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
			$display("Flags--- Carry bit: %b, Flag Bit: %b, Comparison bit: %b, Negative: %b, Low: %b", Flags[3], Flags[2], Flags[4], Flags[1], Flags[0]);
		end
		if(Flags[3] !== 0)
			$display("Carry bit incorrect in CMP");
		if(Flags[0] !== 1)
			$display("Low bit incorrect in CMP");
		if(Flags[2] !== 0)
			$display("Flag bit incorrect in CMP");
		if(Flags[3] !== 0)
			$display("Comparison bit incorrect in CMP");
		if(Flags[1] !== 0)
			$display("Negative bit incorrect in CMP");
		end
endtask		
		
task CMP2;		
		//Testing CMP opcode: 0000_1011
		begin
		Opcode = 8'b0000_1011;
		A = 20;
		B = 10;
		#10
		$display("TESTING CMP2 ");
		if(C !== 16'b0000_0000_0000_0000)
		begin
			$display("A: %0d, B: %0d, C: %0d, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
			$display("Flags--- Carry bit: %b, Flag Bit: %b, Comparison bit: %b, Negative: %b, Low: %b", Flags[3], Flags[2], Flags[4], Flags[1], Flags[0]);
		end
		if(Flags[3] !== 0)
			$display("Carry bit incorrect in CMP");
		if(Flags[0] !== 0)
			$display("Low bit incorrect in CMP");
		if(Flags[2] !== 0)
			$display("Flag bit incorrect in CMP");
		if(Flags[4] !== 0)
			$display("Comparison bit incorrect in CMP");
		if(Flags[1] !== 0)
			$display("Negative bit incorrect in CMP");
		end
endtask
task CMP3;		
		//Testing CMP opcode: 0000_1011
		begin
		Opcode = 8'b0000_1011;
		A = 16'b0000000000000010;
		B = 16'b0000000000000010;
		#10
		$display("TESTING CMP3 ");
		if(C !== 16'b0000_0000_0000_0000)
		begin
			$display("A: %0d, B: %0d, C: %0d, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
			$display("Flags--- Carry bit: %b, Flag Bit: %b, Comparison bit: %b, Negative: %b, Low: %b", Flags[3], Flags[2], Flags[4], Flags[1], Flags[0]);
		end
		if(Flags[3] !== 0)
			$display("Carry bit incorrect in CMP");
		if(Flags[0] !== 0)
			$display("Low bit incorrect in CMP");
		if(Flags[2] !== 0)
			$display("Flag bit incorrect in CMP");
		if(Flags[4] !== 1)
			$display("Comparison bit incorrect in CMP");
		if(Flags[1] !== 0)
			$display("Negative bit incorrect in CMP");
		end
endtask
task OR;
		//Testing OR opcode: b0000_0010
		begin
		Opcode = 8'b0000_0010;
		A = 16'b0000_0011_1111_0011;
		B = 16'b1111_1100_0000_1100;
		#10
		$display("TESTING OR");
		if(C !== 16'b1111_1111_1111_1111)
		begin
			$display("OR Failed");
			$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
			$display("Flags--- Carry bit: %b, Flag Bit: %b, Comparison bit: %b, Negative: %b, Low: %b", Flags[3], Flags[2], Flags[4], Flags[1], Flags[0]);
		end
		if(Flags[3] !== 0)
			$display("Carry bit incorrect in OR");
		if(Flags[0] !== 0)
			$display("Low bit incorrect in OR");
		if(Flags[2] !== 0)
			$display("Flag bit incorrect in OR");
		if(Flags[4] !== 0)
			$display("Comparison bit incorrect in OR");
		if(Flags[1] !== 0)
			$display("Negative bit incorrect in OR");
		#100
		//Testing opcode: 0000_1011
		Opcode = 8'b0000_0010;
		A = 16'b0000_0011_1111_0011;
		B = 16'b0000_0011_1111_0011;
		#10
		//$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
		//$display("Flags--- Carry bit: %b, Flag Bit: %b Comparison bit: %b Negative: %b", Flags[0], Flags[1], Flags[2], Flags[3], Flags[4]);
		if(Flags[3] !== 0)
			$display("Carry bit incorrect in OR");
		if(Flags[0] !== 0)
			$display("Low bit incorrect in OR");
		if(Flags[2] !== 0)
			$display("Flag bit incorrect in OR");
		if(Flags[4] !== 0)
			$display("Comparison bit incorrect in OR");
		if(Flags[1] !== 0)
			$display("Negative bit incorrect in OR");
		end
endtask	

task XOR;
		//Testing OR opcode: 0000_1011
		begin
		Opcode = 8'b0000_0011;
		A = 16'b0000_0011_1111_0011;
		B = 16'b1111_1101_0100_1100;
		
		#10
		$display("TESTING XOR");
		if(C !== 16'b1111_1110_1011_1111)
		begin
			$display("Failed XOR");
			$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
			$display("Flags--- Carry bit: %b, Flag Bit: %b, Comparison bit: %b, Negative: %b, Low: %b", Flags[3], Flags[2], Flags[4], Flags[1], Flags[0]);
		end
		if(Flags[3] !== 0)
			$display("Carry bit incorrect in XOR");
		if(Flags[0] !== 0)
			$display("Low bit incorrect in XOR");
		if(Flags[2] !== 0)
			$display("Flag bit incorrect in XOR");
		if(Flags[4] !== 0)
			$display("Comparison bit incorrect in XOR");
		if(Flags[1] !== 0)
			$display("Negative bit incorrect in XOR");
		end
endtask

task AND;
		//Testing AND opcode: 0000_0001
		begin
		Opcode = 8'b0000_0001;
		A = 16'b0000_0011_1111_0011;
		B = 16'b1111_1100_0000_1100;
		#10
		$display("TESTING AND");
		if(C !== 0)
			begin
			$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
			$display("Flags--- Carry bit: %b, Flag Bit: %b, Comparison bit: %b, Negative: %b, Low: %b", Flags[3], Flags[2], Flags[4], Flags[1], Flags[0]);
			$display("C is incorrect in AND");
			end
		if(Flags[3] !== 0)
			$display("Carry bit incorrect in AND");
		if(Flags[0] !== 0)
			$display("Low bit incorrect in AND");
		if(Flags[2] !== 0)
			$display("Flag bit incorrect in AND");
		if(Flags[4] !== 0)
			$display("Comparison bit incorrect in AND");
		if(Flags[1] !== 0)
			$display("Negative bit incorrect in AND");
		end
endtask		
task AND2;
		//Testing AND opcode: 0000_0001
		begin
		Opcode = 8'b0000_0001;
		A = 16'b1111_1111_1111_1111;
		B = 16'b1111_1111_1111_1111;
		#10
		$display("TESTING AND2");
		if(C !== 16'b1111111111111111)
		begin
			$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
			$display("Flags--- Carry bit: %b, Flag Bit: %b, Comparison bit: %b, Negative: %b, Low: %b", Flags[3], Flags[2], Flags[4], Flags[1], Flags[0]);
			$display("C is incorrect in AND");
		end
		if(Flags[3] !== 0)
			$display("Carry bit incorrect in AND");
		if(Flags[0] !== 0)
			$display("Low bit incorrect in AND");
		if(Flags[2] !== 0)
			$display("Flag bit incorrect in AND");
		if(Flags[4] !== 0)
			$display("Comparison bit incorrect in AND");
		if(Flags[1] !== 0)
			$display("Negative bit incorrect in AND");
		end	
endtask
task AND3;
		//Testing AND opcode: 0000_0001
		begin
		Opcode = 8'b0000_0001;
		A = 16'b0000_0001_0011_0111;
		B = 16'b1111_1111_1111_1111;
		#10
		$display("TESTING AND3");
		if(C !== 16'b0000_0001_0011_0111)
		begin
			$display("C is incorrect in AND");
			$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
			$display("Flags--- Carry bit: %b, Flag Bit: %b, Comparison bit: %b, Negative: %b, Low: %b", Flags[3], Flags[2], Flags[4], Flags[1], Flags[0]);
		end
		if(Flags[3] !== 0)
			$display("Carry bit incorrect in AND");
		if(Flags[0] !== 0)
			$display("Low bit incorrect in AND");
		if(Flags[2] !== 0)
			$display("Flag bit incorrect in AND");
		if(Flags[4] !== 0)
			$display("Comparison bit incorrect in AND");
		if(Flags[1] !== 0)
			$display("Negative bit incorrect in AND");
		end	
endtask


task ADDU;
		//Testing ADDU opcode: b0000_0110
		begin
		Opcode = 8'b0000_0110;
		A = 16'b1001_1001_1111_1111;
		B = 16'b1000000000000000;
		#10
		$display("TESTING ADDU");
		if(C !== 16'b0001_1001_1111_1111)
		begin
			$display("C is incorrect in ADDU");
			$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
			$display("Flags--- Carry bit: %b, Flag Bit: %b, Comparison bit: %b, Negative: %b, Low: %b", Flags[3], Flags[2], Flags[4], Flags[1], Flags[0]);
		end
		if(Flags[3] !== 1)
			$display("Carry bit incorrect in ADDU");
		if(Flags[0] !== 0)
			$display("Low bit incorrect in ADDU");
		if(Flags[2] !== 0)
			$display("Flag bit incorrect in ADDU");
		if(Flags[4] !== 0)
			$display("Comparison bit incorrect in ADDU");
		if(Flags[1] !== 0)
			$display("Negative bit incorrect in ADDU");
		end	
endtask

task ADDUI;
		//Testing ANDUI opcode: 0000_0001
		begin
		Opcode = 8'b0110_1111;
		B = 4'b1111;
		A = 16'b1100_0110_1100_1101;
		#10
		$display("TESTING ADDUI");
		if(C !== 16'b1100_0111_1100_1100)
		begin
			$display("C is incorrect in ANDUI");
			$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
			$display("Flags--- Carry bit: %b, Flag Bit: %b, Comparison bit: %b, Negative: %b, Low: %b", Flags[3], Flags[2], Flags[4], Flags[1], Flags[0]);
		end
		if(Flags[3] !== 1)
			$display("Carry bit incorrect in ANDUI");
		if(Flags[0] !== 0)
			$display("Low bit incorrect in ANDUI");
		if(Flags[2] !== 0)
			$display("Flag bit incorrect in ANDUI");
		if(Flags[4] !== 0)
			$display("Comparison bit incorrect in ANDUI");
		if(Flags[1] !== 0)
			$display("Negative bit incorrect in ANDUI");
		end	
endtask

task ADDI;
		//Testing ANDUI opcode: 0000_0001
		begin
		Opcode = 8'b0101_1111;
		B = 4'b1111;
		A = 16'b1000_0000_0000_0001;
		#10
		if(C !== 16'b1000_0000_0000_0000)
		begin
			$display("C is incorrect in ANDI");
			$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
			$display("Flags--- Carry bit: %b, Flag Bit: %b, Comparison bit: %b, Negative: %b, Low: %b", Flags[3], Flags[2], Flags[4], Flags[1], Flags[0]);
		end
		if(Flags[3] !== 1)
			$display("Carry bit incorrect in ANDUI");
		if(Flags[0] !== 0)
			$display("Low bit incorrect in ANDUI");
		if(Flags[2] !== 0)
			$display("Flag bit incorrect in ANDUI");
		if(Flags[4] !== 0)
			$display("Comparison bit incorrect in ANDUI");
		if(Flags[1] !== 1)
			$display("Negative bit incorrect in ANDUI");
		end	
endtask



task NOP;
		//Testing ANDI opcode: 0000_0000
		begin
		Opcode = 8'b0000_0000;
		A = 16'b0000_1111_0000_1111;
		B = 16'b0111_1111_1111_1111;
		#10
		$display("TESTING NOP");
		if(C !== 16'b0000_0000_0000_0000)
		begin
			$display("C is incorrect in ANDI");
			$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
			$display("Flags--- Carry bit: %b, Flag Bit: %b, Comparison bit: %b, Negative: %b, Low: %b", Flags[3], Flags[2], Flags[4], Flags[1], Flags[0]);
		end
		if(Flags[3] !== 0)
			$display("Carry bit incorrect in NOP");
		if(Flags[0] !== 0)
			$display("Low bit incorrect in NOP");
		if(Flags[2] !== 0)
			$display("Flag bit incorrect in NOP");
		if(Flags[4] !== 0)
			$display("Comparison bit incorrect in NOP");
		if(Flags[1] !== 0)
			$display("Negative bit incorrect in NOP");
		end	
endtask

task ADDI2;
		//Testing ANDI opcode: 0000_0001
		begin
		Opcode = 8'b0101_0100;
		A = 4'b0000;
		B = 16'b0111_1111_1111_1111;
		#10
		if(C !== 16'b1000_0000_0111_1111)
		begin
			$display("C is incorrect in ANDI");
			$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
			$display("Flags--- Carry bit: %b, Flag Bit: %b, Comparison bit: %b, Negative: %b, Low: %b", Flags[3], Flags[2], Flags[4], Flags[1], Flags[0]);
		end
		if(Flags[3] !== 0)
			$display("Carry bit incorrect in ANDUI");
		if(Flags[0] !== 0)
			$display("Low bit incorrect in ANDUI");
		if(Flags[2] !== 1)
			$display("Flag bit incorrect in ANDUI");
		if(Flags[4] !== 0)
			$display("Comparison bit incorrect in ANDUI");
		if(Flags[1] !== 1)
			$display("Negative bit incorrect in ANDUI");
		end	
endtask

task NOT;
		//Testing ANDI opcode: 0000_0100
		begin
		Opcode = 8'b0000_0100;
		A = 16'b0111_1111_1111_1111;
		B = 16'b0111_1111_1111_1111;
		#10
		$display("TESTING NOT ");
		if(C !== 16'b1000_0000_0000_0000)
		begin
			$display("C is incorrect in NOT");
			$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
			$display("Flags--- Carry bit: %b, Flag Bit: %b, Comparison bit: %b, Negative: %b, Low: %b", Flags[3], Flags[2], Flags[4], Flags[1], Flags[0]);
		end
		if(Flags[3] !== 0)
			$display("Carry bit incorrect in NOT");
		if(Flags[0] !== 0)
			$display("Low bit incorrect in NOT");
		if(Flags[2] !== 0)
			$display("Flag bit incorrect in NOT");
		if(Flags[4] !== 0)
			$display("Comparison bit incorrect in NOT");
		if(Flags[1] !== 0)
			$display("Negative bit incorrect in NOT");
		end	
endtask

task LSH;
		//Testing ANDI opcode: 1000_0100
		begin
		Opcode = 8'b1000_0100;
		A = 16'b0111_1001_1111_1111;
		B = 16'b0111_1111_1111_1111;
		#10
		$display("TESTING LSH ");
		if(C !== 16'b1111001111111110)
		begin
			$display("C is incorrect in LSH");
			$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
			$display("Flags--- Carry bit: %b, Flag Bit: %b, Comparison bit: %b, Negative: %b, Low: %b", Flags[3], Flags[2], Flags[4], Flags[1], Flags[0]);
		end
		if(Flags[3] !== 0)
			$display("Carry bit incorrect in LSH");
		if(Flags[0] !== 0)
			$display("Low bit incorrect in LSH");
		if(Flags[2] !== 0)
			$display("Flag bit incorrect in LSH");
		if(Flags[4] !== 0)
			$display("Comparison bit incorrect in LSH");
		if(Flags[1] !== 0)
			$display("Negative bit incorrect in LSH");
		end	
endtask






task RSH;
		begin
		Opcode = 8'b1000_0101;
		A = 16'b0111_1001_1111_1111;
		B = 16'b0111_1111_1111_1111;
		#10
		$display("TESTING RSH ");
		if(C !== 16'b0011_1100_1111_1111)
		begin
			$display("C is incorrect in RSH");
			$display("A: %b, B: %b, C: %b, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
			$display("Flags--- Carry bit: %b, Flag Bit: %b, Comparison bit: %b, Negative: %b, Low: %b", Flags[3], Flags[2], Flags[4], Flags[1], Flags[0]);
		end
		if(Flags[3] !== 0)
			$display("Carry bit incorrect in RSH");
		if(Flags[0] !== 0)
			$display("Low bit incorrect in RSH");
		if(Flags[2] !== 0)
			$display("Flag bit incorrect in RSH");
		if(Flags[4] !== 0)
			$display("Comparison bit incorrect in RSH");
		if(Flags[1] !== 0)
			$display("Negative bit incorrect in RSH");
		end	
endtask      
endmodule



