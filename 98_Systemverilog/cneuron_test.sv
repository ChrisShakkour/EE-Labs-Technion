`timescale 1ns/100fs

module cneuron_test;

   logic clk;
   logic [3:0] [7:0] pixels;
   logic [7:0] 	     convResult;
   logic [31:0]      kernel; 

   CNeuron 
     I_CNeuron
       (
	.clk		(clk),
	.kernel		(kernel),
	.pixels		(pixels),
	.convResult	(convResult)
	);

   /* +/- 1
    initial begin
    clk = 1'b0 ;
    @(negedge clk); kernel = 32'h01ffff01;
    @(negedge clk); pixels = {8'h01, 8'hff, 8'hff, 8'h01};
    @(negedge clk); pixels = {8'hff, 8'h01, 8'h01, 8'hff};
    @(negedge clk); pixels = {8'h01, 8'h01, 8'h01, 8'h01};
    @(negedge clk); pixels = {8'hff, 8'hff, 8'hff, 8'hff};
    // SWITCH KERNEL
    @(negedge clk); kernel = 32'hff0101ff;
    @(negedge clk); pixels = {8'h01, 8'hff, 8'hff, 8'h01};
    @(negedge clk); pixels = {8'hff, 8'h01, 8'h01, 8'hff};
    @(negedge clk); pixels = {8'h01, 8'h01, 8'h01, 8'h01};
    @(negedge clk); pixels = {8'hff, 8'hff, 8'hff, 8'hff};
    #20 $finish; 
   end
    */
   
   // +/- 5
   initial begin
      clk = 1'b0 ;
      @(negedge clk); kernel = 32'h05fbfb05;
      @(negedge clk); pixels = {8'h05, 8'hfb, 8'hfb, 8'h05};
      @(negedge clk); pixels = {8'hfb, 8'h05, 8'h05, 8'hfb};
      @(negedge clk); pixels = {8'h05, 8'h05, 8'h05, 8'h05};
      @(negedge clk); pixels = {8'hfb, 8'hfb, 8'hfb, 8'hfb};
      // SWITCH KERNEL
      @(negedge clk); kernel = 32'hfb0505fb;
      @(negedge clk); pixels = {8'h05, 8'hfb, 8'hfb, 8'h05};
      @(negedge clk); pixels = {8'hfb, 8'h05, 8'h05, 8'hfb};
      @(negedge clk); pixels = {8'h05, 8'h05, 8'h05, 8'h05};
      @(negedge clk); pixels = {8'hfb, 8'hfb, 8'hfb, 8'hfb};
      #20 $finish; 
   end
   
   always #5 clk = ~clk; 
   
endmodule
