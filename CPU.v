`timescale 1ns / 1ps

module CPU(reset, clock, Address_B, Song_Select, Key_Pressed, data_b, r1);

input Song_Select;
input reset;
input clock;
input [15:0] Address_B;
input [15:0] Key_Pressed;
output [15:0] r1;
output [15:0] data_b;

wire [15:0] n1, n2, n3, n4, n5, n6, n7, n9, Song;	

wire select_alu_ram, W_en_B, Cin, select_immediate, PC_en, w_en_A;
wire [3:0]  selectA, selectB;
wire [7:0]  opcode;
wire [15:0] instruction;
wire [4:0] flags;
wire [15:0] Program_counter;
wire [15:0] PC_Input;
wire [15:0] src_reg, q, dest_reg;
wire [15:0] immediate, output_a;
wire [15:0] r0, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
wire [15:0] imm_reg_output, regEnable;
wire [15:0] result;
wire [4:0] flip_flop_input;
wire [4:0] flag_data;
wire [4:0] flag_output;
wire [15:0] Address_A;
wire branch;
	
//    clk,        reset, PC_en, PC_input,      PC_output
PC pc(clock, reset, PC_en, branch, PC_Input, Program_counter);

FlipFlop FF(flip_flop_input, clock, reset, flag_data);

FlipFlop FF_two(flag_data, clock, reset, flag_output);

//      address         clock        q
ROM rom(Program_counter, clock, instruction);

//     clock, reset,[15:0] Instruction,||[7:0] opcode,[3:0] muxA_select,[3:0] muxB_select,imm_select,alu_or_ram,w_enA,PC_en,[15:0] immediate,[15:0] reg_en
Controller cpu_c(clock, reset, instruction, opcode, selectA, selectB, select_immediate, select_alu_ram, w_en_A, PC_en, immediate, regEnable, PC_Input, Address_A, src_reg, flag_output, branch);

//             flags  carry
Flags flag_alu(flags, clock, Cin, flip_flop_input);

//                         select          r0      r1        q
Two_Input_Mux mux_alu_RAM( select_alu_ram, result, output_a, q ); 

//        select   r0  r1  r2  r3  r4  r5  r6  r7  r8  r9  r10  r11  r12  r13  r14  r15  q
mux MUXA( selectA, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, 16'h0000, dest_reg);
mux MUXB( selectB, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, 16'h0000, src_reg);

//                          select,           r0        r1         q
Two_Input_Mux immeditae_alu(select_immediate, src_reg, immediate, imm_reg_output);

//          ALUBus, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, regEnable, clk, reset
Memory REGISTERS(q, r0, n1, n2, n3, n4, n5, n6, n7, r8, n9, Song, r11, r12, r13, r14, r15, regEnable, clock, reset);

KP_mux KPMUX(Song_Select, Song, Key_Pressed, r10);

//        A,              B,       C,     Cin, Opcode, Flags
ALU alu( dest_reg, imm_reg_output, result, Cin, opcode, flags);

Slow_Pulse SP( clock, Song_Select, r9 ); 

//       data_a, data_b,   addr_a,    addr_b,    we_a,   we_b, clk,        q_a,      q_b
RAM ram( result, 16'h0000, Address_A, Address_B, w_en_A, 1'b0, clock, output_a, data_b );

//Frequency_Generator(clock, Note, Key_Pressed,    frequency_out);
Frequency_Generator A(clock, 3'b001, r10[0], r1);
Frequency_Generator B(clock, 3'b010, r10[1], r2);
Frequency_Generator C(clock, 3'b011, r10[2], r3);
Frequency_Generator D(clock, 3'b100, r10[3], r4);
Frequency_Generator E(clock, 3'b101, r10[4], r5);
Frequency_Generator F(clock, 3'b110, r10[5], r6);
Frequency_Generator G(clock, 3'b111, r10[6], r7);

endmodule


