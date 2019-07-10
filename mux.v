`timescale 1ns / 1ps
module mux( select, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, q );

input          [3:0]  select;
input          [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
output reg  	[15:0] q;

wire  [3:0]  select;
wire  [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15; 


always @ (select, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, q)
begin
    case (select)
        4'b0000:
            q = r0;
        4'b0001:
            q = r1;
        4'b0010:
            q = r2;
        4'b0011:
            q = r3;
        4'b0100:
            q = r4;
        4'b0101:
            q = r5;
        4'b0110:
            q = r6;
        4'b0111:
            q = r7;
        4'b1000:
            q = r8;
        4'b1001:
            q = r9;
        4'b1010:
            q = r10;
        4'b1011:
            q = r11;
        4'b1100:
            q = r12;
        4'b1101:
            q = r13;
        4'b1110:
            q = r14;
        4'b1111:
            q = r15;
        default:
            q = r1;
    endcase
end
        

endmodule



