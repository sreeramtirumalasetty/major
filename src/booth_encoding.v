`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.05.2024 22:21:14
// Design Name: 
// Module Name: booth_encoding
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


module booth_encoding(input a,b,c,
                output zero,one,minus_one,two, minus_two);
wire a_n,b_n,c_n,a1,a2,a3,a4,a5,a6;
wire [7:0]i;

decoder_3_8 dec({a,b,c},i);

assign a_n=~a;
assign b_n=~b;
assign c_n=~c;

assign a1= a_n & b_n & c_n & i[0];
assign a2=a & b & c & i[7];
assign a3= a_n & b_n & c & i[1];
assign a4= a_n & b & c_n & i[2];

assign zero= a1 | a2;
assign one= a3 | a4;

assign a5= a & b_n & c & i[5];
assign a6= a & b & c_n & i[6];
assign minus_one= a5 | a6;

assign two= a_n & b & c & i[3];
assign minus_two=a & b_n & c_n & i[4];

endmodule

