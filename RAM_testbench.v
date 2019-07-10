`timescale 1ns / 1ps
module RAM_testbench(q_a, q_b);
//outputs
output [7:0] q_a, q_b;



reg [7:0] data_a, data_b;
reg [5:0] addr_a, addr_b;
reg we_a, we_b, clk, reset;
integer i;
integer old_a;
integer old_b;
integer address;
dual_port_ram_single_clock ram(.data_a(data_a), .data_b(data_b), .addr_a(addr_a), .addr_b(addr_b), .we_a(we_a), .we_b(we_b), .clk(clk), .q_a(q_a), .q_b(q_b));
initial begin
clk = 1;
data_a = 8'b0000_0000;
data_b = 8'b0000_0000;
addr_a = 6'b00_0000;
addr_b = 6'b00_0000;
we_a = 0;
we_b = 0;
//Offsetting from the clock
#19
//Initializing all A RAM
for( i = 0; i< 17; i = i+ 1)
begin
	addr_a = i;
	data_a = 8'b0000_0000;
	we_a = 1;

end

//Initializing all B RAM
for( i = 0; i< 17; i = i+ 1)
begin
	addr_b = i;
	data_b = 8'b0000_0000;
	#20
	we_b = 1;
end

$display("Starting Simulation");

//A_only();
//B_only();
Both_no_collisions();
#500
$finish;
end

always
begin
#10 clk <= ~clk;
end



 //Will go through changing a address and b addresses alternating between reading and writing.
task A_only;
begin
	$display("====================================================================================================");
	$display("Testing A ONLY");
	$display("====================================================================================================");
	//Initialize Inputs
	data_a = 8'b0000_0000;
	data_b = 8'b0000_0000;
	addr_a = 6'b00_0000;
	addr_b = 6'b00_0000;
	we_a = 0;
	we_b = 0;
	reset = 0;
	address = 0;
	old_a = 0;
	
	//Random simulation
	for( i = 0; i< 10; i = i+ 1)
	begin
	//#20
		//Switching a on and off. (write first then read)
		we_a = ~we_a;
		$display("we_a is: %d", we_a);
		if(we_a)
		#22
		begin
			addr_a = address;
			old_a = data_a;
			data_a = ($random % 255) + 1;
			$display("Writing %d a at location: %d at i = %d", data_a, addr_a, i);
			address = address + 1;
		end
		if(we_a == 0)
		begin
		#18
			if(q_a != old_a)
			begin
				$display("****INCORRECT Read from RAM. q_a: %d, old_a: %d at i = %d", q_a, old_a, i);
			end
			else if(q_a == old_a)
			begin
				$display("CORRECT Read from RAM. q_a: %d, old_a: %d at i = %d", q_a, old_a, i);
			end
			else
			begin
				$display("Something wierd is going on here.... q_a: %d, old_a: %d at i=%d", q_a, old_a, i);
			end
		end	
	end
end
endtask
		
		
task B_only;
begin
	$display("====================================================================================================");
	$display("Testing B ONLY");
	$display("====================================================================================================");
	//Initialize Inputs
	data_a = 8'b0000_0000;
	data_b = 8'b0000_0000;
	addr_a = 6'b00_0000;
	addr_b = 6'b00_0000;
	we_a = 0;
	we_b = 0;
	reset = 0;
	address = 0;
	old_b = 0;
	
	//Random simulation
	for( i = 0; i< 10; i = i+ 1)
	begin
	//#20
		//Switching a on and off. (write first then read)
		we_b = ~we_b;
		$display("we_b is: %d", we_b);
		if(we_b)
		#22
		begin
			addr_b = address;
			old_b = data_b;
			data_b = ($random % 255) + 1;
			$display("Writing %d b at location: %d at i = %d", data_b, addr_b, i);
			address = address + 1;
		end
		if(we_b == 0)
		begin
		#18
			if(q_b != old_b)
			begin
				$display("****INCORRECT Read from RAM. q_b: %d, old_b: %d at i = %d", q_b, old_b, i);
			end
			else if(q_b == old_b)
			begin
				$display("CORRECT Read from RAM. q_b: %d, old_b: %d at i = %d", q_b, old_b, i);
			end
			else
			begin
				$display("Something wierd is going on here.... q_b: %d, old_b: %d at i=%d", q_b, old_b, i);
			end
		end	
	end
end
endtask

task Both_no_collisions;
begin
	$display("====================================================================================================");
	$display("Testing Both No Collisions but writing over each other ONLY");
	$display("====================================================================================================");
	//Initialize Inputs
	data_a = 8'b0000_0000;
	data_b = 8'b0000_0000;
	addr_a = 6'b00_0000;
	addr_b = 6'b00_0000;
	we_a = 0;
	we_b = 0;
	reset = 0;
	address = 0;
	old_b = 0;
	
	//Random simulation
	for( i = 0; i< 10; i = i+ 1)
	begin
		//Switching a on and off. (write first then read)
		we_b = ~we_b;
		we_a = we_b;
		$display("we_b is: %d", we_b);
		$display("we_a is: %d", we_a);
		if(we_b)
		#22
		begin
			addr_b = address;
			addr_a = address+3;
			old_b = data_b;
			old_a = data_a;
			data_b = ($random % 255) + 1;
			data_a = ($random % 255) + 1;
			$display("Writing %d a at location: %d at i = %d", data_a, addr_a, i);
			$display("Writing %d b at location: %d at i = %d", data_b, addr_b, i);
			address = address + 1;
		end
		if(we_b == 0)
		begin
		#18
			if(q_b != old_b)
			begin
				$display("****INCORRECT Read from %d. q_b: %d, old_b: %d at i = %d", addr_b, q_b, old_b, i);
			end
			else if(q_b == old_b)
			begin
				$display("CORRECT Read from %d. q_b: %d, old_b: %d at i = %d", addr_b, q_b, old_b, i);
			end
			else
			begin
				$display("Something wierd is going on here at %d: q_b: %d, old_b: %d at i=%d", addr_b, q_b, old_b, i);
			end
			
			
			if(q_a != old_a)
			begin
				$display("****INCORRECT Read from %d. q_a: %d, old_a: %d at i = %d", addr_a, q_a, old_a, i);
			end
			else if(q_a == old_a)
			begin
				$display("CORRECT Read from %d. q_a: %d, old_a: %d at i = %d",addr_a, q_a, old_a, i);
			end
			else
			begin
				$display("Something wierd is going on here.... q_a: %d, old_a: %d at i=%d", q_a, old_a, i);
			end
			
		end	
	end
end
endtask
		
		
endmodule


