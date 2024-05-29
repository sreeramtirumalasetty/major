/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none


module tt_um_sreeramtirumalasetty (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

assign uio_oe=0;
assign ena=0;
assign rst_n=0;




wire [7:0]mcand,mlier;
wire [15:0]ans;
latchh lat1(ui_in,clk,mcand);
latchh lat2(uio_in,clk,mlier);

wire [22:1]s;
wire [21:1]c;

wire [7:0]two_compl;
assign two_compl=~mcand+1;

reg [15:0]p0;
reg [13:0]p1;
reg [11:0]p2;
reg [9:0]p3;
 
wire [4:0]x1,x2,x3,x4;
//partial 1
 booth_encoding cod1(mlier[1],mlier[0],1'b0,x1[4],x1[3],x1[2],x1[1],x1[0]);
 always @( * )
        begin
          p0=16'd0;
          case (x1)
              5'b10000: p0=16'd0;
              5'b01000: p0={{8{mcand[7]}},mcand};
              5'b00100: p0={{8{two_compl[7]}},two_compl};
              5'b00010: p0={{7{mcand[7]}},mcand,1'b0};
              5'b00001: 
              begin
                p0={{7{two_compl[7]}},two_compl,1'b0};
               end
              default: p0=16'd0;
          endcase
      end   

//partial 2
    
    booth_encoding cod2(mlier[3],mlier[2],mlier[1],x2[4],x2[3],x2[2],x2[1],x2[0]);
 always @( * )
        begin
          p1=14'd0;
          case (x2)
              5'b10000: p1=14'd0;
              5'b01000: p1={{6{mcand[7]}},mcand};
              5'b00100: p1={{6{two_compl[7]}},two_compl};
              5'b00010: p1={{5{mcand[7]}},mcand,1'd0};
              5'b00001: 
              begin
                p1={{5{two_compl[7]}},two_compl,1'd0};
               end
              default: p1=14'd0;
          endcase
      end 
      
 //partial 3
 booth_encoding cod3(mlier[5],mlier[4],mlier[3],x3[4],x3[3],x3[2],x3[1],x3[0]);
 always @( * )
        begin
          p2=12'd0;
          case (x3)
              5'b10000: p2=12'd0;
              5'b01000: p2={{4{mcand[7]}},mcand};
              5'b00100: p2={{4{two_compl[7]}},two_compl};
              5'b00010: p2={{3{mcand[7]}},mcand,1'd0};
              5'b00001: 
              begin
                p2={{3{two_compl[7]}},two_compl,1'd0};
               end
              default: p2=12'd0;
          endcase
      end 
 
//partial 4
booth_encoding cod4(mlier[7],mlier[6],mlier[5],x4[4],x4[3],x4[2],x4[1],x4[0]);
always @( * )
        begin
          p3=10'd0;
          case (x4)
              5'b10000: p3=10'd0;
              5'b01000: p3={{2{mcand[7]}},mcand};
              5'b00100: p3={{2{two_compl[7]}},two_compl};
              5'b00010: p3={{1{mcand[7]}},mcand,1'd0};
              5'b00001: 
              begin
                p3={{1{two_compl[7]}},two_compl,1'd0};
               end
              default: p3=10'd0;
          endcase
      end 

//1st reduction 4 to 3
assign s[1]=p2[2] ^ p3[0];
assign c[1]=p2[2] & p3[0];

assign s[2]=(p1[5] ^p2[3]) ^ p3[1];
assign c[2]= (p1[5] & p2[3]) | (p2[3] & p3[1]) | (p3[1] & p1[5]);

assign s[3]=( p1[6] ^p2[4] ) ^ p3[2];
assign c[3]= (p1[6] & p2[4]) | (p2[4] & p3[2]) | (p3[2] & p1[6]);

assign s[4]=( p1[7] ^p2[5] ) ^ p3[3];
assign c[4]= (p1[7] & p2[5]) | (p2[5] & p3[3]) | (p3[3] & p1[7]);

assign s[5]=( p1[8] ^p2[6] ) ^ p3[4];
assign c[5]= (p1[8] & p2[6]) | (p2[6] & p3[4]) | (p3[4] & p1[8]);

assign s[6]=( p1[9] ^p2[7] ) ^ p3[5];
assign c[6]= (p1[9] & p2[7]) | (p2[7] & p3[5]) | (p3[5] & p1[9]);

assign s[7]=( p1[10] ^p2[8] ) ^ p3[6];
assign c[7]= (p1[10] & p2[8]) | (p2[8] & p3[6]) | (p3[6] & p1[10]);

assign s[8]=( p1[11] ^p2[9] ) ^ p3[7];
assign c[8]= (p1[11] & p2[9]) | (p2[9] & p3[7]) | (p3[7] & p1[11]);

assign s[9]=( p1[12] ^p2[10] ) ^ p3[8];
assign c[9]= (p1[12] & p2[10]) | (p2[10] & p3[8]) | (p3[8] & p1[12]);

assign s[10]=( p1[13] ^p2[11] ) ^ p3[9];
//assign c[10]= (p1[13] & p2[11]) | (p2[11] & p3[9]) | (p3[9] & p1[13]);

//2nd reduction 3 to 2
assign s[11]=p1[2] ^ p2[0];
assign c[11]=p1[2] & p2[0];

assign s[12]=( p0[5] ^p1[3] ) ^ p2[1];
assign c[12]= (p0[5] & p1[3]) | (p1[3] & p2[1]) | (p2[1] & p0[5]);

assign s[13]=( p0[6] ^p1[4] ) ^ s[1];
assign c[13]= (p0[6] & p1[4]) | (p1[4] & s[1]) | (s[1] & p0[6]);

assign s[14]=( p0[7] ^c[1] ) ^ s[2];
assign c[14]= (p0[7] & c[1]) | (c[1] & s[2]) | (s[2] & p0[7]);

assign s[15]=( p0[8] ^c[2] ) ^ s[3];
assign c[15]= (p0[8] & c[2]) | (c[2] & s[3]) | (s[3] & p0[8]);

assign s[16]=( p0[9] ^c[3] ) ^ s[4];
assign c[16]= (p0[9] & c[3]) | (c[3] & s[4]) | (s[4] & p0[9]);

assign s[17]=( p0[10] ^c[4] ) ^ s[5];
assign c[17]= (p0[10] & c[4]) | (c[4] & s[5]) | (s[5] & p0[10]);

assign s[18]=( p0[11] ^c[5] ) ^ s[6];
assign c[18]= (p0[11] & c[5]) | (c[5] & s[6]) | (s[6] & p0[11]);

assign s[19]=( p0[12] ^c[6] ) ^ s[7];
assign c[19]= (p0[12] & c[6]) | (c[6] & s[7]) | (s[7] & p0[12]);

assign s[20]=( p0[13] ^c[7] ) ^ s[8];
assign c[20]= (p0[13] & c[7]) | (c[7] & s[8]) | (s[8] & p0[13]);

assign s[21]=( p0[14] ^c[8] ) ^ s[9];
assign c[21]= (p0[14] & c[8]) | (c[8] & s[9]) | (s[9] & p0[14]);

assign s[22]=( p0[15] ^c[9] ) ^ s[10];


cla cla1(.x({c[21:11],p0[4:0]}),.y({s[22:11],p1[1],p1[0]}),.cin(1'b0),.sum({ans}));

latchh lat3(ans[7:0],clk,uo_out);
latchh lat4(ans[15:8],clk,uio_out);

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, rst_n, 1'b0};

endmodule
