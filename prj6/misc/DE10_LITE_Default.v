
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module DE10_LITE_Default(

	input 		          		MAX10_CLK1_50,

	//////////// KEY //////////
	input 		     [1:0]		KEY,

	//////////// LED //////////
	output		     [6:0]		LEDR
	
);



//=======================================================
//  REG/WIRE declarations
//=======================================================



TrafficLightSignal t0 (
						.clk(MAX10_CLK1_50),
						.nrst(KEY[0]),
						.NorthRed(LEDR[1]),
						.NorthYellow(LEDR[2]),		
                  .NorthGreen(LEDR[3]),
                  .WestRed(LEDR[4]),		
                  .WestYellow(LEDR[5]),	
                  .WestGreen(LEDR[6]));	
						
						
endmodule 