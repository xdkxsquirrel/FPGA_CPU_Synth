module Compute_Display_Out( 
	 input [23:0] IN,
	 input [4:0] LEDS_IN,
    output reg [4:0]LEDS_OUT,
	 output reg [6:0]seven_seg_out_one,
	 output reg [6:0]seven_seg_out_two,
	 output reg [6:0]seven_seg_out_three,
	 output reg [6:0]seven_seg_out_four,
	 output reg [6:0]seven_seg_out_five,
	 output reg [6:0]seven_seg_out_six
    );
always @*
begin
LEDS_OUT = LEDS_IN;
case (IN[23:20])
	4'b0000 :      	//Hexadecimal 0
		seven_seg_out_one = 7'b1000000;
	4'b0001 :    	//Hexadecimal 1
		seven_seg_out_one = 7'b1111001  ;
	4'b0010 :  		// Hexadecimal 2
		seven_seg_out_one = 7'b0100100 ; 
	4'b0011 : 		// Hexadecimal 3
		seven_seg_out_one = 7'b0110000 ;
	4'b0100 :		// Hexadecimal 4
		seven_seg_out_one = 7'b0011001 ;
	4'b0101 :		// Hexadecimal 5 
		seven_seg_out_one = 7'b0010010 ;  
	4'b0110 :		// Hexadecimal 6
		seven_seg_out_one = 7'b0000010 ;
	4'b0111 :		// Hexadecimal 7
		seven_seg_out_one = 7'b1111000;
	4'b1000 :     		 //Hexadecimal 8
		seven_seg_out_one = 7'b0000000;
	4'b1001 :    		//Hexadecimal 9
		seven_seg_out_one = 7'b0010000 ;
	4'b1010 :  		// Hexadecimal A
		seven_seg_out_one = 7'b0001000 ; 
	4'b1011 : 		// Hexadecimal B
		seven_seg_out_one = 7'b0000011;
	4'b1100 :		// Hexadecimal C
		seven_seg_out_one = 7'b1000110 ;
	4'b1101 :		// Hexadecimal D
		seven_seg_out_one = 7'b0100001 ;
	4'b1110 :		// Hexadecimal E
		seven_seg_out_one = 7'b0000110 ;
	4'b1111 :		// Hexadecimal F
		seven_seg_out_one = 7'b0001110 ;
	endcase
	
case (IN[19:16])
	4'b0000 :      	//Hexadecimal 0
		seven_seg_out_two = 7'b1000000;
	4'b0001 :    	//Hexadecimal 1
		seven_seg_out_two = 7'b1111001  ;
	4'b0010 :  		// Hexadecimal 2
		seven_seg_out_two = 7'b0100100 ; 
	4'b0011 : 		// Hexadecimal 3
		seven_seg_out_two = 7'b0110000 ;
	4'b0100 :		// Hexadecimal 4
		seven_seg_out_two = 7'b0011001 ;
	4'b0101 :		// Hexadecimal 5 
		seven_seg_out_two = 7'b0010010 ;  
	4'b0110 :		// Hexadecimal 6
		seven_seg_out_two = 7'b0000010 ;
	4'b0111 :		// Hexadecimal 7
		seven_seg_out_two = 7'b1111000;
	4'b1000 :     		 //Hexadecimal 8
		seven_seg_out_two = 7'b0000000;
	4'b1001 :    		//Hexadecimal 9
		seven_seg_out_two = 7'b0010000 ;
	4'b1010 :  		// Hexadecimal A
		seven_seg_out_two = 7'b0001000 ; 
	4'b1011 : 		// Hexadecimal B
		seven_seg_out_two = 7'b0000011;
	4'b1100 :		// Hexadecimal C
		seven_seg_out_two = 7'b1000110 ;
	4'b1101 :		// Hexadecimal D
		seven_seg_out_two = 7'b0100001 ;
	4'b1110 :		// Hexadecimal E
		seven_seg_out_two = 7'b0000110 ;
	4'b1111 :		// Hexadecimal F
		seven_seg_out_two = 7'b0001110 ;
	endcase
	
case (IN[15:12])
	4'b0000 :      	//Hexadecimal 0
		seven_seg_out_three = 7'b1000000;
	4'b0001 :    	//Hexadecimal 1
		seven_seg_out_three = 7'b1111001  ;
	4'b0010 :  		// Hexadecimal 2
		seven_seg_out_three = 7'b0100100 ; 
	4'b0011 : 		// Hexadecimal 3
		seven_seg_out_three = 7'b0110000 ;
	4'b0100 :		// Hexadecimal 4
		seven_seg_out_three = 7'b0011001 ;
	4'b0101 :		// Hexadecimal 5 
		seven_seg_out_three = 7'b0010010 ;  
	4'b0110 :		// Hexadecimal 6
		seven_seg_out_three = 7'b0000010 ;
	4'b0111 :		// Hexadecimal 7
		seven_seg_out_three = 7'b1111000;
	4'b1000 :     		 //Hexadecimal 8
		seven_seg_out_three = 7'b0000000;
	4'b1001 :    		//Hexadecimal 9
		seven_seg_out_three = 7'b0010000 ;
	4'b1010 :  		// Hexadecimal A
		seven_seg_out_three = 7'b0001000 ; 
	4'b1011 : 		// Hexadecimal B
		seven_seg_out_three = 7'b0000011;
	4'b1100 :		// Hexadecimal C
		seven_seg_out_three = 7'b1000110 ;
	4'b1101 :		// Hexadecimal D
		seven_seg_out_three = 7'b0100001 ;
	4'b1110 :		// Hexadecimal E
		seven_seg_out_three = 7'b0000110 ;
	4'b1111 :		// Hexadecimal F
		seven_seg_out_three = 7'b0001110 ;
	endcase
	
case (IN[11:8])
	4'b0000 :      	//Hexadecimal 0
		seven_seg_out_four = 7'b1000000;
	4'b0001 :    	//Hexadecimal 1
		seven_seg_out_four = 7'b1111001  ;
	4'b0010 :  		// Hexadecimal 2
		seven_seg_out_four = 7'b0100100 ; 
	4'b0011 : 		// Hexadecimal 3
		seven_seg_out_four = 7'b0110000 ;
	4'b0100 :		// Hexadecimal 4
		seven_seg_out_four = 7'b0011001 ;
	4'b0101 :		// Hexadecimal 5 
		seven_seg_out_four = 7'b0010010 ;  
	4'b0110 :		// Hexadecimal 6
		seven_seg_out_four = 7'b0000010 ;
	4'b0111 :		// Hexadecimal 7
		seven_seg_out_four = 7'b1111000;
	4'b1000 :     		 //Hexadecimal 8
		seven_seg_out_four = 7'b0000000;
	4'b1001 :    		//Hexadecimal 9
		seven_seg_out_four = 7'b0010000 ;
	4'b1010 :  		// Hexadecimal A
		seven_seg_out_four = 7'b0001000 ; 
	4'b1011 : 		// Hexadecimal B
		seven_seg_out_four = 7'b0000011;
	4'b1100 :		// Hexadecimal C
		seven_seg_out_four = 7'b1000110 ;
	4'b1101 :		// Hexadecimal D
		seven_seg_out_four = 7'b0100001 ;
	4'b1110 :		// Hexadecimal E
		seven_seg_out_four = 7'b0000110 ;
	4'b1111 :		// Hexadecimal F
		seven_seg_out_four = 7'b0001110 ;
	endcase
	
case (IN[7:4])
	4'b0000 :      	//Hexadecimal 0
		seven_seg_out_five = 7'b1000000;
	4'b0001 :    	//Hexadecimal 1
		seven_seg_out_five = 7'b1111001  ;
	4'b0010 :  		// Hexadecimal 2
		seven_seg_out_five = 7'b0100100 ; 
	4'b0011 : 		// Hexadecimal 3
		seven_seg_out_five = 7'b0110000 ;
	4'b0100 :		// Hexadecimal 4
		seven_seg_out_five = 7'b0011001 ;
	4'b0101 :		// Hexadecimal 5 
		seven_seg_out_five = 7'b0010010 ;  
	4'b0110 :		// Hexadecimal 6
		seven_seg_out_five = 7'b0000010 ;
	4'b0111 :		// Hexadecimal 7
		seven_seg_out_five = 7'b1111000;
	4'b1000 :     		 //Hexadecimal 8
		seven_seg_out_five = 7'b0000000;
	4'b1001 :    		//Hexadecimal 9
		seven_seg_out_five = 7'b0010000 ;
	4'b1010 :  		// Hexadecimal A
		seven_seg_out_five = 7'b0001000 ; 
	4'b1011 : 		// Hexadecimal B
		seven_seg_out_five = 7'b0000011;
	4'b1100 :		// Hexadecimal C
		seven_seg_out_five = 7'b1000110 ;
	4'b1101 :		// Hexadecimal D
		seven_seg_out_five = 7'b0100001 ;
	4'b1110 :		// Hexadecimal E
		seven_seg_out_five = 7'b0000110 ;
	4'b1111 :		// Hexadecimal F
		seven_seg_out_five = 7'b0001110 ;
	endcase
	
case (IN[3:0])
	4'b0000 :      	//Hexadecimal 0
		seven_seg_out_six = 7'b1000000;
	4'b0001 :    	//Hexadecimal 1
		seven_seg_out_six = 7'b1111001  ;
	4'b0010 :  		// Hexadecimal 2
		seven_seg_out_six = 7'b0100100 ; 
	4'b0011 : 		// Hexadecimal 3
		seven_seg_out_six = 7'b0110000 ;
	4'b0100 :		// Hexadecimal 4
		seven_seg_out_six = 7'b0011001 ;
	4'b0101 :		// Hexadecimal 5 
		seven_seg_out_six = 7'b0010010 ;  
	4'b0110 :		// Hexadecimal 6
		seven_seg_out_six = 7'b0000010 ;
	4'b0111 :		// Hexadecimal 7
		seven_seg_out_six = 7'b1111000;
	4'b1000 :     		 //Hexadecimal 8
		seven_seg_out_six = 7'b0000000;
	4'b1001 :    		//Hexadecimal 9
		seven_seg_out_six = 7'b0010000 ;
	4'b1010 :  		// Hexadecimal A
		seven_seg_out_six = 7'b0001000 ; 
	4'b1011 : 		// Hexadecimal B
		seven_seg_out_six = 7'b0000011;
	4'b1100 :		// Hexadecimal C
		seven_seg_out_six = 7'b1000110 ;
	4'b1101 :		// Hexadecimal D
		seven_seg_out_six = 7'b0100001 ;
	4'b1110 :		// Hexadecimal E
		seven_seg_out_six = 7'b0000110 ;
	4'b1111 :		// Hexadecimal F
		seven_seg_out_six = 7'b0001110 ;
	endcase
end
 endmodule