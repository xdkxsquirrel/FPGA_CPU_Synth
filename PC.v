module PC(
input clk,
input reset, 
input PC_en,
input branch,
input [15:0] PC_input,
output reg [15:0] PC_output
);

initial
begin
	PC_output = 16'h0000;
end


always @ (posedge clk)
	begin
		if (reset)
			PC_output = 16'h0000;
		else if(branch)
			PC_output = PC_input; 
		else if(PC_en)
			PC_output = PC_output + 1'b1;
	end
endmodule
