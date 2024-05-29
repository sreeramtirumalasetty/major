/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none



module tt_um_multiplier_mbm (
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


module latchh(input [7:0]d,           // 1-bit input pin for data  
             input clk,          // 1-bit input pin for enabling the latch
              output reg [7:0]q);     // 1-bit output pin for data output  
  
   always @ (posedge clk)  
    q <= d;  
endmodule

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
