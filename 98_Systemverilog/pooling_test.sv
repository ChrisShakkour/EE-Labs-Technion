`timescale 1ns/100fs

module pooling_test;

   logic clk,En;
   logic [7:0] convResult;
   logic [3:0][7:0] pooledPixels;

   Pooling 
     I_Pooling(.*);
   
   initial clk = 1'b0 ;
   
   initial begin 
      //code that sets convResult. For example:
      convResult = 8'h31;
      @(negedge clk);
      convResult = 8'h84;
      @(negedge clk);
      convResult = 8'h38;
      @(negedge clk);
      convResult = 8'h07;
      @(negedge clk);
      convResult = 8'h73;
      @(negedge clk);
      convResult = 8'h90;
      @(negedge clk);
      convResult = 8'h62;
      @(negedge clk);
      convResult = 8'h84;
      @(negedge clk);
      #80 $finish; 
   end

   initial begin
      @(posedge clk);
      En = 1'b1;
   end

   always #5 clk = ~clk; 
   
endmodule
