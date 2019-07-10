`timescale 1ns / 1ps
module Slow_Pulse( clock, Song_Select, Pulse );

input 			clock;
input				Song_Select;
output			Pulse;

reg [15:0] Pulse = 16'h0000;
reg [27:0] counter = 0;
reg pulse_count = 1'b0;

always@(posedge clock)
	begin
	if(Song_Select == 1)
	begin
		counter <= counter + 1;
	
		if (pulse_count == 0)
		begin
			if (counter > 30)
				begin
				pulse_count <= 1;
				counter <= 0;
				Pulse <= 16'h0000;
				end
		end
		else
		begin
			if (counter > 9000000)
				begin
				pulse_count <= 0;
				counter <= 0;
				Pulse <= 16'h0001;
				end
		end
	end
	else
	begin
		counter <= 0;
		pulse_count <= 0;
	end
	end

endmodule