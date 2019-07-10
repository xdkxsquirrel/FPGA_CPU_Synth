`timescale 1ns / 1ps

module Ram_Reader(clock, data_b, Address_B, Key_Pressed, Output_Sound);

input clock;
input [15:0] data_b;
output reg [15:0] Address_B;
output reg [15:0] Key_Pressed;
output reg [15:0] Output_Sound;

parameter KEY			= 1'b0;
parameter OUTPUT		= 1'b1;

reg state;
reg next_state;

initial
	begin
	state = 0;
	end

always @ (state)
begin
	next_state = 0;
	case(state)
		KEY: 
			next_state = OUTPUT;
			
		OUTPUT:
			next_state = KEY;
			
		default: 
			next_state = KEY;
			
	endcase
end

always @ (posedge clock)
begin
	state <= next_state;
end

always @ (posedge clock)
begin 
	case(state)
		KEY: 
			begin
			Address_B <= 16'b0000000000001101;
			Key_Pressed <= Key_Pressed;
			Output_Sound <= data_b;
			end
			
		OUTPUT: 
			begin
			Address_B <= 16'b0000000000001110;
			Key_Pressed <= data_b;
			Output_Sound <= Output_Sound;
			end
			
		default: 
			begin
			Address_B <= 16'b0000000000001101;
			Key_Pressed <= data_b;
			Output_Sound <= Output_Sound;
			end
  endcase
end
endmodule