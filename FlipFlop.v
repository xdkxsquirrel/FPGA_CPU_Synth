module FlipFlop (data, clk, reset, q);

input [4:0]data;
input clk, reset; 

output reg [4:0]q;

always @ ( posedge clk)
if (reset == 1'b1) 
  q <= 5'b00000;
else 
  q <= data;

endmodule