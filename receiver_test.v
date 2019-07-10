`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: University of Utah
// Engineer: Donovan Bidlack
// 
// Create Date:   13:10:32 04/21/2017 
// Design Name:   Uart_Receiver
// Module Name:   Receiver_Test.v
// Project Name: 	 Final Lab UART
// Target Devices: XC6SLX16
//
//////////////////////////////////////////////////////////////////////////////////

module receiver_test;

	// Inputs
	reg RCV;
	reg clr;
	reg clk;
	reg RCV_ACK;

	// Outputs
	wire RCV_REQ;
	wire [7:0] RCV_Data;

	// Instantiate the Unit Under Test (UUT)
	uart_receiver uut (
		.RCV(RCV), 
		.clr(clr), 
		.clk(clk), 
		.RCV_ACK(RCV_ACK), 
		.RCV_REQ(RCV_REQ), 
		.RCV_Data(RCV_Data)
	);

	always #1 clk = ~clk;		

	initial begin
		// Initialize Inputs
		RCV = 1;
		clr = 0;
		clk = 0;
		RCV_ACK = 0;

		// Wait 100 ns for global reset to finish
		#100;

  	   // Add stimulus here
		
		// ASCII code T: 01010100
		RCV <= 0;   // Start bit
		#64
		
		RCV <= 0;
		#64;
	
		RCV <= 0;
		#64;
		
		RCV <= 1;
		#64;
		
		RCV <= 0;
		#64;
		
		RCV <= 1;
		#64;
	
		RCV <= 0;
		#64;
		
		RCV <= 1;
		#64;
		
		RCV <= 0;   // Parity bit
		#64;
		
		RCV <= 1;   // Stop bit
		#64;
		
		RCV_ACK <= 1;
		#64;
		
		RCV_ACK <= 0;
		#64;
		
		if (RCV_Data != 8'b01010100)
			$display("1st byte received incorrectly: Received %b, should be 01010100.",
						RCV_Data);
		else
			$display("1st byte: The output matches the input: %b == 01010100", RCV_Data);
		
				// ASCII code Z: 01011010
		RCV <= 0;   // Start bit
		#64;
		
		RCV <= 0;
		#64;
		
		RCV <= 1;
		#64;
		
		RCV <= 0;
		#64;
		
		RCV <= 1;
		#64;
		
		RCV <= 1;
		#64;
		
		RCV <= 0;
		#64;
		
		RCV <= 1;
		#64;
		
		RCV <= 0;   // Parity bit
		#64;
		
		RCV <= 1;   // Stop bit
		#64;
		
		RCV_ACK <= 1;
		#64;
		
		RCV_ACK <= 0;
		#64;
		
		if (RCV_Data != 8'b01011010)
			$display("2nd byte received incrrectly: Received %b, should be 01011010.",
						RCV_Data);
		else
			$display("2nd byte: The output matches the input: %b == 01011010.", RCV_Data);
	end
	      
endmodule

