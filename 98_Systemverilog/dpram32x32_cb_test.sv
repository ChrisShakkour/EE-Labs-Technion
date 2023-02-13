`timescale 1ns/100fs

`define numAddr 5
`define numOut 32
`define wordDepth 32

module dpram32x32_cb_test;

   logic [`numAddr-1:0] A1;
   logic [`numAddr-1:0] A2;
   logic 		CEB1,WEB1, OEB1, CSB1, CEB2,WEB2, OEB2, CSB2;
   logic [`numOut-1:0] 	I1,I2;
   logic [`numOut-1:0] 	O1,O2;

   dpram32x32_cb
     RAM_U1(.*);

   initial begin
      A2 = '0;
      A1 = '0;
      I1 = '0;
      I2 = '0;
      WEB1 = 1'b1; // read by default
      WEB2 = 1'b1; // read by default
      CSB1 = 1'b0; // selected
      CSB2 = 1'b1; // not selected
      OEB1 = 1'b0; // output enabled
      OEB2 = 1'b1; // output disabled
      //initialize CEB1 and CEB2
      CEB1 = 1'b0;
      CEB2 = 1'b0; 
      //code for SRAM signals
      @(posedge CEB1); //1st posedge
      WEB1 = 1'b0;
      WEB2 = 1'b0;
      I1 = 32'h7b;
      A1 = 32'h0f;
      @(posedge CEB1); //2nd posedge
      I1 = 32'h67;
      A1 = 32'h0a;
      @(posedge CEB1); //3rd posedge
      WEB1 = 1'b1;
      A1 = 32'h0f;
      @(posedge CEB1); //3rd posedge
      WEB1 = 1'b1;
      A1 = 32'h0a;
      @(posedge CEB1); //3rd posedge
      CSB1 = 1'b1; // not_selected
 
      #30 $finish;
   end

   always #5 CEB1 = ~CEB1;
   always #5 CEB2 = ~CEB2;
   
endmodule
