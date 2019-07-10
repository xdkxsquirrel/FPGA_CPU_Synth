`timescale 1ns / 1ps

module TOP(
	input  clock,
	input  [3:0] buttons,
	input  [9:0] Sw,
	output [4:0] flags_display,
	output [6:0] seven_seg_out_one,
	output [6:0] seven_seg_out_two,
	output [6:0] seven_seg_out_three,
	output [6:0] seven_seg_out_four,
	output [6:0] seven_seg_out_five,
	output [6:0] seven_seg_out_six,
	output Output_Sound,
	output reg Ground
	);
	
wire [15:0] Address_B;
wire [15:0] data_b_out;
wire A_Square_Wave;
wire [15:0] Key_Pressed;
wire Slow_Clock;

//     slowClock(clock, reset, 1MHz_Clock );
//slowClock slwclk(clock, Slow_Clock);

//  CPU(reset, clock, Address_B, Song_Select, Key_Pressed,                                               data_b_out, A_Square_Wave)
CPU cpu(Sw[9], clock, Address_B, Sw[8], {9'b000000000, Sw[6], Sw[5], Sw[4], Sw[3], Sw[2], Sw[1], Sw[0]}, data_b_out, A_Square_Wave);

//KEYBOARDUART


//VGA HERE
//VGA_MODULE VGA(clock, --> Key_Pressed <--, .......);

//module Ram_Reader(clock, data_b, Address_B, Key_Pressed, Output_Sound);
Ram_Reader RAM_READER(clock, data_b_out, Address_B, Key_Pressed, Output_Sound);

//	 INPUTS [23:0]IN, [4:0]LEDS_IN, OUTPUTS LEDS_OUT, seven_seg_out_one, seven_seg_out_two, seven_seg_out_three, seven_seg_out_four, seven_seg_out_five, seven_seg_out_six
Compute_Display_Out d({{7'b0, A_Square_Wave}, {7'b0, Output_Sound}, Key_Pressed[7:0]}, 5'b00000, flags_display, seven_seg_out_one, seven_seg_out_two, seven_seg_out_three, seven_seg_out_four, seven_seg_out_five, seven_seg_out_six);

endmodule


