`timescale 1ns / 1ps
module Two_Input_Mux( select, r0, r1, q );
input select;
input [15:0] r0;
input [15:0] r1;
output reg [15:0] q;


always @ (select, r0, r1, q)
begin
    case (select)
        2'b00:
            q = r0;
        2'b01:
            q = r1;
        default:
            q = r1;
    endcase
end
        

endmodule



