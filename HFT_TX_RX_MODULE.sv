module tx_rx(clk, rst,rx,rx_clear,rx_ready,rx_data);
	input logic clk, rst, rx,rx_clear;
	output logic rx_ready;
	output logic rx_data[7:0];
	
	parameter baud_rate = 115200;
	parameter clk_frq_hz = 10000000;
	parameter clks_per_bit = clk_frq_hz / baud_rate;
	
	enum {IDLE,START,DATA,STOP,DONE} ps, ns;
	
	always_comb begin
		ns = ps;
		rx_done = 0;
		
		case(ps)
			
			IDLE : 	if(~rx) ns = START;
					else if ((rx & DONE) | ~START) ns = IDLE;
			
		
			START : 	if (clk_count = clks_per_bit / 2)
							if (~rx) ns = START;
						else ns = IDLE;
			
			DATA : if (clk_count = clks_per_bit) 
							if (bit_index = b'07)
								ns = STOP;
					 else ns = DATA;
				
			
			STOP : if (clk_count = clks_per_bit) ns = STOP;
			
			DONE : if (STOP) ns = IDLE; 
			endcase
		end	
	
	always_ff @(posedge clk) begin
		if (rst) 
		ns <= IDLE 
		
		
		
		
		
		
	
