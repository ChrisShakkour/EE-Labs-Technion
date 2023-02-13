`timescale 1ns/100fs

module FCNeuron
  ( 
    input 	       clk,
    input [7:0][7:0]   pooledPixelArray, 
    input [63:0]       weight, 
    output logic [7:0] result
    );
   
   logic [7:0] 	       sum;
   //integer 	       i;

   always_comb 
     begin
	sum = '0;
	sum = sum + pooledPixelArray[0] * weight[7:0];
	sum = sum + pooledPixelArray[1] * weight[15:8];
	sum = sum + pooledPixelArray[2] * weight[23:16];
	sum = sum + pooledPixelArray[3] * weight[31:24];
	sum = sum + pooledPixelArray[4] * weight[39:32];
	sum = sum + pooledPixelArray[5] * weight[47:40];
	sum = sum + pooledPixelArray[6] * weight[55:48];
 	sum = sum + pooledPixelArray[7] * weight[63:56];
     end

   always_ff @(posedge clk)
     result <= sum;

endmodule
