`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.05.2024 22:23:03
// Design Name: 
// Module Name: decoder_3_8
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


module decoder_3_8(input [2:0]din,
                    output reg[7:0]dout);
 always @( din )
        begin
          dout=8'd0;
          case (din)
              3'b000: dout[0]=1'b1;
              3'b001: dout[1]=1'b1;
              3'b010: dout[2]=1'b1;
              3'b011: dout[3]=1'b1;
              3'b100: dout[4]=1'b1;
              3'b101: dout[5]=1'b1;
              3'b110: dout[6]=1'b1;
              3'b111: dout[7]=1'b1;
              default: dout=8'd0;
          endcase
      end               
endmodule

