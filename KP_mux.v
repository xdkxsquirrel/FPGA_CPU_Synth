`timescale 1ns / 1ps
module KP_mux (select, Song, Keypressed, q);

input select;
input [15:0] Song;
input [15:0] Keypressed;
output reg  	[15:0] q;

always @(select, Song, Keypressed)
begin
    case (select)
        1'b0:
            q = Keypressed;
				
        1'b1:
		      q = Song;

        default:
            q = Keypressed;
    endcase
end
        

endmodule