module uart_rx(clk, rst,rx,rx_ready,rx_data);
	input logic clk, rst, rx;
	output logic rx_avail;
	output logic rx_data[7:0];
	
	logic rx_buffer; 
	logic [15:0] clk_count;
	logic [2:0] bit_index; 
	
	parameter baud_rate = 115200;
	parameter clk_frq_hz = 10000000;
	parameter clks_per_bit = clk_frq_hz / baud_rate;
	
	enum logic [2:0] {IDLE,START,DATA,STOP} ps, ns;
	
	always_comb 
		begin 
			
			case(ps) 
			
			IDLE: 
				begin 
					bit_index = b'00;
				end
			
			START: 
				begin 
					bit_index = b'01;
				end 
			
			DATA: 
				begin 
					bit_index = b'10;
				end
			
			STOP:
				begin 
					bit_index = b'11;
				end
		endcase 	
			
			
	
	always_comb 
		begin
			ns = ps;
		
			case(ps)
				
				IDLE:
					begin
						if(~rx) ns = START;
							else ns = IDLE;
					end
				
			
				START :
					begin
						if (clk_count = (clks_per_bit-1) / 2)
									if (~rx) ns = START;
								else ns = IDLE;
					end
				
				DATA : 
					begin
						if (clk_count = clks_per_bit-1) 
							if (bit_index = b'07) ns = STOP;
								else ns = DATA;
					end
					
				
				STOP : 
					begin
						;
					end 
					
		endcase
		
	always_ff @(posedge clk) begin 
	 rx_buffer <= rx;
	 rx <= buffer;
	 end 
	
	always_ff @(posedge clk) begin
		if (rst) begin 
			counter <= 0;
			bit_index <= 0;
		if (ps <= DATA) clk <= clk + 1;
	
		ps <= ns;
			end 
		
		 
		
		
		
		
		
		
		
	
