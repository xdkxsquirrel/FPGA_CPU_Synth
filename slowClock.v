module slowClock(clk, clk_1Hz);
input clk;
output clk_1Hz;

reg clk_1Hz = 1'b0;
reg [27:0] counter;

always@(posedge clk)
	begin
	counter <= counter + 1;
   if ( counter == 10000000)
		begin
      counter <= 0;
      clk_1Hz <= ~clk_1Hz;
      end
	end
endmodule 