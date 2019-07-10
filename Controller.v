`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Engineer: Donovan Bidlack
//
// Create Date:   9:59:01 11/10/2018
// Design Name:   Controller
// Module Name:   Controller.v
// Project Name:  Controller
//
////////////////////////////////////////////////////////////////////////////////

module Controller
(
	input clock, 
	input reset,
	input [15:0] Instruction,
	//input flags
	output reg [7:0] opcode,
	output reg [3:0] muxA_select, 
	output reg [3:0] muxB_select,
	output reg imm_select, 
	output reg alu_or_ram, 
	output reg w_enA, 
	output reg PC_en,
	output reg [15:0] immediate, 
	output reg [15:0] reg_en,
	output reg [15:0] PC_input,
	output reg [15:0] RAM_address,
	input  [15:0] src_reg,
	input [4:0] flags,
	output reg branch

);

parameter ADD			= 8'b00000101;
parameter ADDI			= 8'b0101XXXX;
parameter ADDU			= 8'b00000110;
parameter ADDUI		= 8'b0110XXXX;
parameter ADDC			= 8'b00000111;
parameter ADDCU		= 8'b00001000;
parameter ADDCUI     = 8'b0011XXXX;
parameter ADDCI		= 8'b0111XXXX;
parameter SUB			= 8'b00001001;
parameter SUBI			= 8'b1001XXXX;
parameter CMP			= 8'b00001011;
parameter CMPI			= 8'b1011XXXX;
parameter CMPU			= 8'b00001100;
parameter CMPUI		= 8'b1100XXXX;
parameter AND			= 8'b00000001;
parameter OR         = 8'b00000010;
parameter XOR			= 8'b00000011;
parameter NOT			= 8'b00000100;
parameter LSH			= 8'b10000100;
parameter LSHI			= 8'b1000000X;
parameter RSH			= 8'b10000101;
parameter RSHI			= 8'b1010XXXX;
parameter ALSH			= 8'b11010100;
parameter ARSH			= 8'b11010101;
parameter NOP			= 8'b00000000;
parameter LOAD			= 8'b01000000;
parameter STORE		= 8'b01000100;
parameter JUMP			= 8'b01001000;
parameter Jcond		= 8'b01001100;

localparam
    Fetch 			= 4'b0000,
	 Reset 			= 4'b0001,
	 R_Type 			= 4'b0010,
	 Load_Setup 	= 4'b0011,
	 Load_Perform 	= 4'b0100,
	 Store_Setup 	= 4'b0101,
	 Store_Perform = 4'b0110,
	 Jump_Setup 	= 4'b0111,
	 Jump_Perform 	= 4'b1000,
	 Jump_Pause    = 4'b1001,
	 Load_Pause		= 4'b1010;
	 
reg [3:0] State, Next;

always @(posedge clock, posedge reset)
begin
    if(reset) // go to state zero if reset
        begin
        State <= Reset;
        end
    else // otherwise update the states
        begin
        State <= Next;
        end
end

always @(State)
begin
	// store current state as next
	
	case(State)
		Fetch:
			begin
			opcode 		= NOP;
			muxA_select = 4'b0000;
			muxB_select = 4'b0000;
			imm_select 	= 1'b0;
			alu_or_ram 	= 1'b0;
			w_enA 		= 1'b0;
			immediate 	= 16'h0000;
			reg_en 		= 16'h0000;
			PC_input		= 16'h0000;
			branch		= 1'b0;
			RAM_address	= 16'h0000;
				
			//{opcode[7:4],rdest,opcode[3:0],rsrc} = Instruction
			case(Instruction[15:12])
				ADD[7:4], ADDI[7:4]:
					begin
					Next 			= R_Type;
					PC_en 		= 1'b1;
					end
					
				STORE[7:4]:
					begin
					if(Instruction[7:4] == STORE[3:0])
						begin
						Next = Store_Setup;
						PC_en 		= 1'b0;
						end
					else if(Instruction[7:4] == LOAD[3:0])
						begin
						Next = Load_Setup;
						PC_en 		= 1'b0;
						end
					else if(Instruction[7:4] == JUMP[3:0])
						begin
						Next = Jump_Setup;
						PC_en 		= 1'b0;
						end
					else if(Instruction[7:4] == Jcond[3:0])
						begin
						Next = Jump_Setup;
						PC_en 		= 1'b0;
						end
					else
						begin
						Next = Fetch;
						PC_en 		= 1'b0;
						end
					end
				default:
					begin
					Next = Fetch;
					PC_en 		= 1'b0;
					end
				endcase
			end
				
		Reset: 
			begin
			opcode 		= NOP;
			muxA_select = 4'b0000;
			muxB_select = 4'b0000;
			imm_select 	= 1'b0;
			alu_or_ram 	= 1'b0;
			w_enA 		= 1'b0;
			PC_en 		= 1'b0;
			immediate 	= 16'h0000;
			reg_en 		= 16'h0000;
			PC_input		= 16'h0000;
			branch		= 1'b0;
			RAM_address	= 16'h0000;
			Next = Fetch;
			end
			
		R_Type: 
			begin
			Next = Fetch;
			//{opcode[7:4],rdest,opcode[3:0],rsrc} = Instruction
			case(Instruction[15:12])
				4'b0000: //NON IMMEDIATES
					begin
					opcode 		= {Instruction[15:12],Instruction[7:4]};
					muxA_select = Instruction[11:8];
					muxB_select = Instruction[3:0];
					imm_select 	= 1'b0;
					alu_or_ram 	= 1'b0;
					w_enA 		= 1'b0;
					PC_en 		= 1'b0;
					immediate 	= 16'h0000;
					PC_input		= 16'h0000;
					
					if((Instruction[7:4] == CMP[3:0]) || (Instruction[7:4] == 4'b0000))
						reg_en 	= 16'h0000;
					else
						reg_en 	= 2**((Instruction[11:8]));
						
					branch		= 1'b0;
					RAM_address	= 16'h0000;
					end
					
				4'b0101: //IMMEDIATES
					begin
					opcode 		= {Instruction[15:12],Instruction[7:4]};
					muxA_select = Instruction[11:8];
					muxB_select = Instruction[3:0];
					imm_select 	= 1'b1;
					alu_or_ram 	= 1'b0;
					w_enA 		= 1'b0;
					PC_en 		= 1'b0;
					immediate 	= {8'h00,Instruction[7:0]};
					PC_input		= 16'h0000;
					reg_en 		= 2**((Instruction[11:8]));
					branch		= 1'b0;
					RAM_address	= 16'h0000;
					end
					
					default: 
						begin
						opcode 		= NOP;
						muxA_select = 4'b0000;
						muxB_select = 4'b0000;
						imm_select 	= 1'b0;
						alu_or_ram 	= 1'b0;
						w_enA 		= 1'b0;
						PC_en 		= 1'b0;
						immediate 	= 16'h0000;
						reg_en 		= 16'h0000;
						PC_input		= 16'h0000;
						branch		= 1'b0;
						RAM_address	= 16'h0000;
						end
				endcase
			end
			
		Load_Setup: 
			begin
			opcode 		= {Instruction[15:12],Instruction[7:4]};
			muxA_select = Instruction[11:8];
			muxB_select = Instruction[3:0];
			imm_select 	= 1'b0;
			alu_or_ram 	= 1'b1;
			w_enA 		= 1'b0;
			PC_en 		= 1'b0;
			immediate 	= 16'h0000;
			reg_en 		= 16'h0000;
			PC_input		= 16'h0000;
			RAM_address	= 16'h0000;
			Next 			= Load_Perform;
			branch		= 1'b0;
			end
			
		Load_Perform: 
			begin
			opcode 		= 8'b01010000;
			muxA_select = Instruction[11:8];
			muxB_select = Instruction[3:0];
			imm_select 	= 1'b1;
			alu_or_ram 	= 1'b1;
			w_enA 		= 1'b0;
			PC_en 		= 1'b1;
			immediate 	= 16'h0000;
			reg_en 		= 16'h0000;
			PC_input		= 16'h0000;
			RAM_address	= src_reg;
			Next 			= Load_Pause;
			branch		= 1'b0;
			end
			
		Load_Pause: 
			begin
			opcode 		= 8'b01010000;
			muxA_select = Instruction[11:8];
			muxB_select = Instruction[3:0];
			imm_select 	= 1'b1;
			alu_or_ram 	= 1'b1;
			w_enA 		= 1'b0;
			PC_en 		= 1'b0;
			immediate 	= 16'h0000;
			reg_en 		= 2**(Instruction[11:8]);
			PC_input		= 16'h0000;
			RAM_address	= src_reg;
			Next 			= Fetch;
			branch		= 1'b0;
			end
			
		Store_Setup: 
			begin
			opcode 		= 8'b01010000;
			muxA_select = Instruction[11:8];
			muxB_select = Instruction[3:0];
			imm_select 	= 1'b1;
			alu_or_ram 	= 1'b0;
			w_enA 		= 1'b1;
			PC_en 		= 1'b1;
			immediate 	= 16'h0000;
			reg_en 		= 16'h0000;
			PC_input		= 16'h0000;
			RAM_address = src_reg;
			Next 			= Store_Perform;
			branch		= 1'b0;
			end
			
		Store_Perform: 
			begin
			opcode 		= 8'b01010000;
			muxA_select = Instruction[11:8];
			muxB_select = Instruction[3:0];
			imm_select 	= 1'b1;
			alu_or_ram 	= 1'b0;
			w_enA 		= 1'b1;
			PC_en 		= 1'b0;
			immediate 	= 16'h0000;
			reg_en 		= 16'h0000;
			PC_input		= 16'h0000;
			RAM_address = src_reg;
			Next 			= Fetch;
			end
			
		Jump_Setup: 
			begin
			opcode 		= {Instruction[15:12],Instruction[7:4]};
			muxA_select = Instruction[11:8];
			muxB_select = Instruction[3:0];
			imm_select 	= 1'b0;
			alu_or_ram 	= 1'b0;
			w_enA 		= 1'b0;
			PC_en 		= 1'b1;
			immediate 	= 16'h0000;
			reg_en 		= 16'h0000;
			PC_input		= src_reg;
			RAM_address	= 16'h0000;
			Next 			= Jump_Perform;
			branch		= 1'b0;
			end
			
		Jump_Perform: 
			begin
			opcode 		= {Instruction[15:12],Instruction[7:4]};
			muxA_select = Instruction[11:8];
			muxB_select = Instruction[3:0];
			imm_select 	= 1'b0;
			alu_or_ram 	= 1'b0;
			w_enA 		= 1'b0;
			PC_en 		= 1'b0;
			immediate 	= 16'h0000;
			reg_en 		= 16'h0000;
			PC_input		= src_reg;
			RAM_address	= 16'h0000;
			Next 			= Jump_Pause;
			if((flags[0] == 1'b1) || ({Instruction[15:12],Instruction[7:4]} == JUMP))
				branch		= 1'b1;
			else
				branch		= 1'b0;
			end
			
		Jump_Pause: 
			begin
			opcode 		= 8'h00;
			muxA_select = Instruction[11:8];
			muxB_select = Instruction[3:0];
			imm_select 	= 1'b0;
			alu_or_ram 	= 1'b0;
			w_enA 		= 1'b0;
			PC_en 		= 1'b0;
			immediate 	= 16'h0000;
			reg_en 		= 16'h0000;
			PC_input		= src_reg;
			RAM_address	= 16'h0000;
			Next 			= Fetch;
			branch		= 1'b0;
			end
			

			
		default:
			begin
			opcode 		= NOP;
			muxA_select = 4'b0000;
			muxB_select = 4'b0000;
			imm_select 	= 1'b0;
			alu_or_ram 	= 1'b0;
			w_enA 		= 1'b0;
			PC_en 		= 1'b0;
			immediate 	= 16'h0000;
			reg_en 		= 16'h0000;
			PC_input		= 16'h0000;
			branch		= 1'b0;
			RAM_address	= 16'h0000;
			Next 			= Fetch;
			end
    endcase
end

endmodule