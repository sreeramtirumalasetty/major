`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.05.2024 22:24:50
// Design Name: 
// Module Name: cla
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


module cla(input [15:0]x, input [13:0]y, input cin, output  [15:0]sum);
wire [13:0] p;
wire [13:0]g;
wire [13:1] c;

assign sum[0]= x[0];
assign sum[1]= x[1];

assign p[0]= x[2] ^ y[0];
assign g[0]= x[2] & y[0];
assign c[1]= g[0] | (p[0] & cin);
assign sum[2]= p[0] ^ cin;

assign p[1]= x[3] ^ y[1];
assign g[1]= x[3] & y[1];
assign c[2]= g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
assign sum[3]= p[1] ^ c[1];

assign p[2]= x[4] ^ y[2];
assign g[2]= x[4] & y[2];
assign c[3]= g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & cin);
assign sum[4]= p[2] ^ c[2]; 

assign p[3]= x[5] ^ y[3];
assign g[3]= x[5] & y[3];
assign c[4]= g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & cin);
assign sum[5]= p[3] ^ c[3];

assign p[4]= x[6] ^ y[4];
assign g[4]= x[6] & y[4];
assign c[5]= g[4] | (p[4] & g[3]) |(p[4] & p[3] & g[2]) |(p[4] & p[3] & p[2] & g[1]) | (p[4] & p[3] & p[2] & p[1] & g[0]) | (p[4] & p[3] & p[2] & p[1] & p[0] & cin);
assign sum[6]= p[4] ^ c[4];

assign p[5]= x[7] ^ y[5];
assign g[5]= x[7] & y[5];
assign c[6]= g[5] | (p[5] & g[4]) |(p[5] & p[4] & g[3]) |(p[5] & p[4] & p[3] & g[2]) | (p[5] & p[4] & p[3] & p[2] & g[1]) | (p[5] & p[4] & p[3] & p[2] & p[1] & g[0]) | (p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & cin);
assign sum[7]= p[5] ^ c[5];

assign p[6]= x[8] ^ y[6];
assign g[6]= x[8] & y[6];
assign c[7]= g[6] | (p[6] & g[5]) | (p[6] & p[5] & g[4]) |(p[6] & p[5] & p[4] & g[3]) |(p[6] & p[5] & p[4] & p[3] & g[2]) | (p[6]  & p[5] & p[4] & p[3] & p[2] & g[1]) | (p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0]) | (p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & cin);
assign sum[8]= p[6] ^ c[6];

assign p[7]= x[9] ^ y[7];
assign g[7]= x[9] & y[7];
assign c[8]= g[7] | (p[7] & g[6]) | (p[7] & p[6] & g[5]) | (p[7] & p[6] & p[5] & g[4]) |(p[7] & p[6] & p[5] & p[4] & g[3]) |(p[7] & p[6] & p[5] & p[4] & p[3] & g[2]) | (p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & g[1]) | (p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0]) | (p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & cin);
assign sum[9]= p[7] ^ c[7];

assign p[8]= x[10] ^ y[8];
assign g[8]= x[10] & y[8];
assign c[9]= g[8] | (p[8] & g[7]) | (p[8] & p[7] & g[6]) | (p[8] & p[7] & p[6] & g[5]) | (p[8] & p[7] & p[6] & p[5] & g[4]) |(p[8] & p[7] & p[6] & p[5] & p[4] & g[3]) |(p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & g[2]) | (p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & g[1]) | (p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0]) | (p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & cin);
assign sum[10]= p[8] ^ c[8];

assign p[9]= x[11] ^ y[9];
assign g[9]= x[11] & y[9];
assign c[10]= g[9] | (p[9] & g[8]) | (p[9] & p[8] & g[7]) | (p[9] & p[8] & p[7] & g[6]) | (p[9] & p[8] & p[7] & p[6] & g[5]) | (p[9] & p[8] & p[7] & p[6] & p[5] & g[4]) |(p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & g[3]) |(p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & g[2]) | (p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & g[1]) | (p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0]) | (p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & cin);
assign sum[11]= p[9] ^ c[9];

assign p[10]= x[12] ^ y[10];
assign g[10]= x[12] & y[10];
assign c[11]= g[10] | (p[10] & g[9]) | (p[10] & p[9] & g[8]) | (p[10] & p[9] & p[8] & g[7]) | (p[10] & p[9] & p[8] & p[7] & g[6]) | (p[10] & p[9] & p[8] & p[7] & p[6] & g[5]) | (p[10] & p[9] & p[8] & p[7] & p[6] & p[5] & g[4]) |(p[10] & p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & g[3]) |(p[10] & p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & g[2]) | (p[10] & p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & g[1]) | (p[10] & p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0]) | (p[10] & p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & cin);
assign sum[12]= p[10] ^ c[10];

assign p[11]= x[13] ^ y[11];
assign g[11]= x[13] & y[11];
assign c[12]= g[11] | (p[11] & g[10]) | (p[11] & p[10] & g[9]) | (p[11] & p[10] & p[9] & g[8]) | (p[11] & p[10] & p[9] & p[8] & g[7]) | (p[11] & p[10] & p[9] & p[8] & p[7] & g[6]) | (p[11] & p[10] & p[9] & p[8] & p[7] & p[6] & g[5]) | (p[11] & p[10] & p[9] & p[8] & p[7] & p[6] & p[5] & g[4]) |(p[11] & p[10] & p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & g[3]) |(p[11] & p[10] & p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & g[2]) | (p[11] & p[10] & p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & g[1]) | (p[11] & p[10] & p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0]) | (p[11] & p[10] & p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & cin);
assign sum[13]= p[11] ^ c[11];

assign p[12]= x[14] ^ y[12];
assign g[12]= x[14] & y[12];
assign c[13]= g[12] | (p[12] & g[11]) | (p[12] & p[11] & g[10]) | (p[12] & p[11] & p[10] & g[9]) | (p[12] & p[11] & p[10] & p[9] & g[8]) | (p[12] & p[11] & p[10] & p[9] & p[8] & g[7]) | (p[12] & p[11] & p[10] & p[9] & p[8] & p[7] & g[6]) | (p[12] & p[11] & p[10] & p[9] & p[8] & p[7] & p[6] & g[5]) | (p[12] & p[11] & p[10] & p[9] & p[8] & p[7] & p[6] & p[5] & g[4]) |(p[12] & p[11] & p[10] & p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & g[3]) |(p[12] & p[11] & p[10] & p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & g[2]) | (p[12] & p[11] & p[10] & p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & g[1]) | (p[12] & p[11] & p[10] & p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0]) | (p[12] & p[11] & p[10] & p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & cin);
assign sum[14]= p[12] ^ c[12];

assign p[13]= x[15] ^ y[13];
assign g[13]= x[15] & y[13];
assign sum[15]= p[13] ^ c[13];

endmodule
