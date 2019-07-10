module Frequency_Generator(clock, note, is_pressed, frequency);
input clock;
input [2:0] note;
input is_pressed;

output reg [15:0] frequency;

reg [27:0] counter;
reg [27:0] note_count;

parameter A			= 3'b001;
parameter B			= 3'b010;
parameter C			= 3'b011;
parameter D			= 3'b100;
parameter E			= 3'b101;
parameter F			= 3'b110;
parameter G			= 3'b111;

initial
	begin
	frequency = 16'h0000;
	counter = 0;
	end

always@(posedge clock)
begin
	case(note)
		A:
			note_count = 113636;
		B: 
			note_count = 101239;
		C: 
			note_count =  95556;
		D: 
			note_count =  85131;
		E: 
			note_count =  75843;
		F: 
			note_count =  71586;
		G: 
			note_count =  63776;
	endcase
end

always@(posedge clock)
	begin
	if (is_pressed == 0)
		begin
		frequency <= 0;
		counter <= 0;
		end
	else
		begin
		counter <= counter + 1;
		if ( counter == note_count)
			begin
			counter <= 0;
			frequency <= ~frequency;
			end
		end
	end
endmodule 