`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:54:08 08/30/2011 
// Design Name: 
// Module Name:    ALU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ALU( A, B, C, Cin, Opcode, Flags
    );
input [15:0] A, B;
input [7:0] Opcode;
input Cin;
output reg [15:0] C;
output reg [4:0] Flags;

parameter ADD 		=	8'b00000101;
parameter ADDI		=	8'b0101XXXX;
parameter ADDU		=	8'b00000110;
parameter ADDUI 	=	8'b0110XXXX;
parameter ADDC		=	8'b00000111;
parameter ADDCU 	=	8'b00001000;
parameter ADDCUI 	=	8'b0011XXXX;
parameter ADDCI 	=	8'b0100XXXX;
parameter SUB 		=	8'b00001001;
parameter ALSH 	=	8'b11010100;
parameter ARSH 	=	8'b11010101;
parameter NOP 		=	8'b00000000;
parameter SUBI		=	8'b1001XXXX;
parameter CMP 		=	8'b00001011;
parameter CMPI		=	8'b1011XXXX;
parameter CMPU		=	8'b00001100;
parameter CMPUI	=	8'b1100XXXX;
parameter AND 		=	8'b00000001;
parameter OR 		=	8'b00000010;
parameter XOR 		=	8'b00000011;
parameter NOT 		=	8'b00000100;
parameter LSH 		=	8'b10000100;
parameter LSHI 	=	8'b1000000X;
parameter RSH 		=	8'b10000101;
parameter RSHI 	=	8'b1010XXXX;

always @(A, B, Cin, Opcode, Flags)
begin
	case (Opcode[7:4])
	ADD[7:4]: //All Standard Codes
	begin
		case (Opcode[3:0])
		ADD[3:0]:
			begin				
			{Flags[3],C} = A + B;
			if (C == 16'h0000) Flags[4] = 1'b1;
			else Flags[4] = 1'b0;
			if( (~A[15] & ~B[15] & C[15]) | (A[15] & B[15] & ~C[15]) ) Flags[2] = 1'b1;
			else Flags[2] = 1'b0;
			if(C[15] == 1'b1) Flags[1] = 1'b1;
			else Flags[1] = 1'b0;
			Flags[0] = 1'b0;
			end
			
		ADDU[3:0]:
			begin				
			{Flags[3],C} = A + B;
			if (C == 16'h0000) Flags[4] = 1'b1;
			else Flags[4] = 1'b0;
			Flags[2:0] = 3'b000;
			end
			
		ADDC[3:0]:
			begin				
			{Flags[3],C} = A + B + Cin;
			if (C == 16'h0000) Flags[4] = 1'b1;
			else Flags[4] = 1'b0;
			if( (~A[15] & ~B[15] & C[15]) | (A[15] & B[15] & ~C[15]) ) Flags[2] = 1'b1;
			else Flags[2] = 1'b0;
			if(C[15] == 1'b1) Flags[1] = 1'b1;
			else Flags[1] = 1'b0;
			Flags[0] = 1'b0;
			end
			
		ADDCU[3:0]:
			begin				
			{Flags[3],C} = A + B + Cin;
			if (C == 16'h0000) Flags[4] = 1'b1;
			else Flags[4] = 1'b0;
			Flags[2:0] = 3'b000;
			end
			
		SUB[3:0]:
			begin
			C = A - B;
			if (C == 16'h0000) Flags[4] = 1'b1;
			else Flags[4] = 1'b0;
			if( (~A[15] & ~B[15] & C[15]) | (A[15] & B[15] & ~C[15]) ) Flags[1] = 1'b1;
			else Flags[1] = 1'b0;
			Flags[0] = 1'b0; Flags[2] = 1'b0; Flags[3] = 1'b0;
			end
			
		CMP[3:0]:
			begin
			C = 16'h0000;
			if(A !== B)
				begin
				if( A[15] == B[15] )
				begin
					if (A < B) Flags[0] = 1'b1;
					else Flags[0] = 1'b0;
				end
				else if (A[15] == 1'b0) Flags[0] = 1'b0;
				else Flags[0] = 1'b1;
				Flags[4:1] = 4'b0000;
				end
			else Flags = 5'b10000;
			end
			
		CMPU[3:0]:
			begin
			if( A < B ) Flags[0] = 1'b1;
			else Flags[0] = 1'b0;
			C = 16'h0000;
			Flags[4:1] = 4'b0000;
			if (A == B) Flags[4] = 1'b1;
			end
			
		AND[3:0]:
			begin
			C = A & B;
			Flags[4:0] = 5'b00000;
			end
			
		OR[3:0]:
			begin
			C = A | B;
			Flags[4:0] = 5'b00000;
			end
			
		XOR[3:0]:
			begin
			C = A ^ B;
			Flags[4:0] = 5'b00000;
			end
			
		NOT[3:0]:
			begin
			C = ~A;
			Flags[4:0] = 5'b00000;
			end
			
		default: 
			begin
				C = 16'h0000;
				Flags = 5'b00000;
			end
		
		endcase
	end
	
	ADDI[7:4]:
		begin			
		{Flags[3],C} = A + B;
		if (C == 16'h0000) Flags[4] = 1'b1;
		else Flags[4] = 1'b0;
		if( (~A[15] & ~B[15] & C[15]) | (A[15] & B[15] & ~C[15]) ) Flags[2] = 1'b1;
		else Flags[2] = 1'b0;
		if(C[15] == 1'b1) Flags[1] = 1'b1;
		else Flags[1] = 1'b0;
		Flags[0] = 1'b0;
		end	
		
	ADDUI[7:4]:
		begin
		{Flags[3],C} = A + Opcode[3:0];
		if (C == 16'h0000) Flags[4] = 1'b1;
		else Flags[4] = 1'b0;
		Flags[2:0] = 3'b000;
		end
			
	ADDCUI[7:4]:
		begin
		{Flags[3],C} = A + Opcode[3:0] + Cin;
		if (C == 16'h0000) Flags[4] = 1'b1;
		else Flags[4] = 1'b0;
		Flags[2:0] = 3'b000;
		end
		
	ADDCI[7:4]:
		begin
		{Flags[3],C} = A + Opcode[3:0] + Cin;
		if (C == 16'h0000) Flags[4] = 1'b1;
		else Flags[4] = 1'b0;
		if( (~A[15] & ~B[15] & C[15]) | (A[15] & B[15] & ~C[15]) ) Flags[2] = 1'b1;
		else Flags[2] = 1'b0;
		if(C[15] == 1'b1) Flags[1] = 1'b1;
		else Flags[1] = 1'b0;
		Flags[0] = 1'b0;
		end
		
	SUBI[7:4]:
		begin
		C = A - Opcode[3:0];
		if (C == 16'h0000) Flags[4] = 1'b1;
		else Flags[4] = 1'b0;
		if( (~A[15] & ~B[15] & C[15]) | (A[15] & B[15] & ~C[15]) ) Flags[1] = 1'b1;
		else Flags[1] = 1'b0;
		Flags[0] = 1'b0; Flags[2] = 1'b0; Flags[3] = 1'b0;
		end
		
	CMPI[7:4]:
		begin
		C = 16'h0000;
		if(A !== Opcode[3:0])
			begin
			if( A[15] == Opcode[3] )
				begin
					if (A < Opcode[3:0]) Flags[0] = 1'b1;
					else Flags[0] = 1'b0;
				end
				else
				begin
					if (A[15] == 1'b0) Flags[0] = 1'b0;
					else Flags[0] = 1'b1;
				end
			Flags[4:1] = 4'b0000;
		end
		else Flags = 5'b10000;
		end
		
	CMPUI[7:4]:
		begin
		if( A < Opcode[3:0] ) Flags[0] = 1'b1;
		else Flags[0] = 1'b0;
		C = 16'h0000;
		Flags[4:1] = 4'b0000;
		if (A == Opcode[3:0]) Flags[4] = 1'b1;
		end
			
	LSH[7:4]:
	begin
		case (Opcode[3:1])
		LSH[3:1]:
		begin
			case (Opcode[0])
			LSH[0]:
				begin
				C = A << B; 
				Flags = 5'b00000;
				end
			RSH[0]:
				begin
				C = A >> B;
				Flags = 5'b00000;
				end
			
			default: 
				begin
				C = 16'h0000;
				Flags = 5'b00000;
				end
			endcase
		end
			
		LSHI[3:1]:
			begin
			C = A << Opcode[0]; 
			Flags = 5'b00000;
			end
			
		default: 
			begin
			C = 16'h0000;
			Flags = 5'b00000;
			end
		
		endcase
	end
		
	RSHI[7:4]:
		begin
		C = A >> Opcode[3:0];
		Flags = 5'b00000;
		end
			
	ALSH[7:4]:
	begin
		case (Opcode[3:0])
		ALSH[3:0]:
			begin
			if (A[15] == 1'b1) Flags[1:0] = 2'b10;
			else Flags[1:0] = 2'b00;
			C = A <<< B; 
			Flags[4:2] = 3'b000;
			end
				
		ARSH[3:0]:
			begin
			if (A[15] == 1'b1) Flags[1:0] = 2'b10;
			else Flags[1:0] = 2'b00;
			C = A >>> B;
			Flags[4:2] = 3'b000;
			end
				
		default: 
			begin
			C = 16'h0000;
			Flags = 5'b00000;
			end
		endcase
	end		
				
	default: 
		begin
		C = 16'h0000;
		Flags = 5'b00000;
		end
	endcase
end

endmodule
