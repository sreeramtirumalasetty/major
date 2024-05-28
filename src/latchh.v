`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.05.2024 22:18:46
// Design Name: 
// Module Name: latchh
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module latchh(input [7:0]d,           // 1-bit input pin for data  
             input clk,          // 1-bit input pin for enabling the latch
              output reg [7:0]q);     // 1-bit output pin for data output  
  
   always @ (posedge clk)  
    q <= d;  
endmodule

