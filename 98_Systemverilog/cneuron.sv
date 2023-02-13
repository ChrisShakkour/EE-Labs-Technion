`timescale 1ns/100fs

module CNeuron 
  (
   input 	      clk,
   input [31:0]       kernel, 
   input [3:0] [7:0]  pixels, 
   output logic [7:0] convResult
   );
   
   logic [7:0] 	      sum;
   logic [3:0][7:0]   kernel_packed;
   integer 	      i;

   assign kernel_packed = kernel;
   always_comb begin
      sum = '0;
      for(i=0; i<4; i++) begin : sum_calculation_logic
	 sum = sum + pixels[i]*kernel_packed[i];
      end
   end
   
   always_ff @(posedge clk)
     convResult <= sum;

endmodule // CNeuron

/*
 sum = sum + kernel[7:0]   * pixels[0];
 sum = sum + kernel[15:8]  * pixels[1];
 sum = sum + kernel[23:16] * pixels[2];
 sum = sum + kernel[31:24] * pixels[3];
 */
