// Quartus Prime Verilog Template
// True Dual Port RAM with single clock
module RAM
(
 input [15:0] data_a, data_b,
 input [15:0] addr_a, addr_b,
 input we_a, we_b, clk,
 output reg [15:0] q_a, q_b
);
 // Declare the RAM variable
 reg [15:0] ram[2**15-1:0];
 
initial begin
$readmemb("song.mem", ram);
end

 
 
 // Port A
 always @ (posedge clk)
 begin
   if (we_a)
   begin
    q_a = ram[addr_a];
    ram[addr_a] = data_a;
   end
   else
   begin
    q_a = ram[addr_a];
   end
 end
 
 
 // Port B
 always @ (posedge clk)
 begin
 
  if((we_a && we_b) && (addr_a == addr_b)) // If there is a collision then use address a.
  begin
   q_b = ram[addr_a];

  end
  else
  begin
   if (we_b)
   begin
    q_b = ram[addr_b];
    ram[addr_b] <= data_b;
   end
   else
   begin
    q_b = ram[addr_b];
   end
  end
  
  
 end
endmodule





