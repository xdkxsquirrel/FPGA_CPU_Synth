`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Utah
// Engineer: Donovan Bidlack
// 
// Create Date:    00:14:58 04/18/2017  
// Module Name:    Uart_Receiver 
// Project Name: 	 Final Lab UART
// Target Devices: XC6SLX16
//
//////////////////////////////////////////////////////////////////////////////////
module uart_receiver(
    input RCV,
    input clr,
    input clk,
    input RCV_ACK,
    output reg RCV_REQ,
    output reg [7:0] RCV_Data
    );

	reg [10:0] clk_divider = 0;
	reg [2:0] state = 0;
	
	reg [7:0] data = 0;
	reg [3:0] bit_counter = 0;
	reg [2:0] counter = 0;
	reg start_flag = 0;
	
	always@(posedge clk)
	begin
		if (clk_divider == 1302 || clr == 1) // clk_divider = 1302
		begin
			clk_divider <= 0;
			
			if (clr == 1)
			begin
				clk_divider <= 0;
				state <= 0;
			end
			else
				case (state)
					// state 0 : Listen for incoming data. Transition if RCV goes low.
					// state 1 : Count past the start bit. Transition after eight cycles.
					// state 2 : Sample data and collect bits. Transition once 8 bits are collected
					//				 and 8 bit times have passed.
					// state 3 : Wait for stop bits. Transition after receiving one.
					// state 4 : Wait for ACK for the RCV_REQ line and data transfer.
					//				 Transition when both are high.
					// state 5 : Wait for ACK signal to go low.
					3'b000 : state <= (RCV ? 3'b000 : 3'b001); 						
					3'b001 : state <= (start_flag ? 3'b010 : 3'b001); 
					3'b010 : state <= (bit_counter == 4'b1000 ? 3'b011 : 3'b010);
					3'b011 : state <= ((counter == 3'b100 && RCV == 1) ? 3'b100 : 3'b011);
					3'b100 : state <= (RCV_ACK ? 3'b101 : 3'b100);
					3'b101 : state <= (RCV_ACK ? 3'b101 : 3'b000);
					default : state <= 3'b000;
				endcase
		end
		else
			clk_divider <= clk_divider + 11'b1;
	end
	
	always@(posedge clk)
	begin
		if (clk_divider == 1302)
		begin
			case (state)
				3'b000 : begin 
									counter <= 0; bit_counter <= 0; // Keep data line low; listen for data.
									data <= 0; RCV_REQ <= 0; start_flag <= 0;
							end					 
				3'b001 : begin
								if (counter == 3'b111) // Wait for start bit time to elapse.
								begin
									start_flag <= 1;
									counter <= 0;
								end
								counter <= counter + 3'b001;		  
							end
				3'b010 : begin 
							  if (counter == 3'b100)				  // Sample data in the middle of each bit's time.
								  data <= {RCV, data[7:1]};
							  if (counter == 3'b111)				  // Wait for one bit time to pass before reseting counter.
							  begin
								  bit_counter <= bit_counter + 4'b0001;
								  counter <= 0;
							  end
							  counter <= counter + 3'b001;	  
							end
				3'b011 : counter <= counter + 3'b001;				// Wait for stop bit.
				3'b100 : begin RCV_Data <= data; RCV_REQ <= 1; end
				3'b101 : RCV_REQ <= 0;
				default : RCV_REQ <= 0;
			endcase
		end
	end
endmodule
