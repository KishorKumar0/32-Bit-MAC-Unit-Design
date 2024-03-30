`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Kishor Kumar
// 
// Create Date: 30.03.2024 01:33:31
// Design Name: MAC Unit
// Module Name: vedic_32x32
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

module half_adder(x,y,s,c);
   input x,y;
   output s,c;
   assign s=x^y;
   assign c=x&y;
endmodule // half adder


module full_adder(x,y,c_in,s,c_out);
   input x,y,c_in;
   output s,c_out;
 assign s = (x^y) ^ c_in;
 assign c_out = (y&c_in)| (x&y) | (x&c_in);
endmodule // full_adder


module vedic_2x2(a,b,c);
input [1:0]a;
input [1:0]b;
output [3:0]c;
wire [3:0]c;
wire [3:0]temp;
//stage 1
// four multiplication operation of bits accourding to vedic logic done using and gates 
assign c[0]=a[0]&b[0]; 
assign temp[0]=a[1]&b[0];
assign temp[1]=a[0]&b[1];
assign temp[2]=a[1]&b[1];
//stage two 
// using two half adders 
half_adder z1(temp[0],temp[1],c[1],temp[3]);
half_adder z2(temp[2],temp[3],c[2],c[3]);
endmodule

//////////////////////////////////////////////////////////////////////////////////


module add_4_bit(input1,input2,answer);
parameter N=4;
input [N-1:0] input1,input2;
   output [N-1:0] answer;
   wire  carry_out;
  wire [N-1:0] carry;
   genvar i;
   generate 
   for(i=0;i<N;i=i+1)
     begin: generate_N_bit_Adder
   if(i==0) 
  half_adder f(input1[0],input2[0],answer[0],carry[0]);
   else
  full_adder f(input1[i],input2[i],carry[i-1],answer[i],carry[i]);
     end
  assign carry_out = carry[N-1];
   endgenerate
endmodule 

module vedic_4x4(a,b,c);
input [3:0]a;
input [3:0]b;
output [7:0]c;

wire [3:0]q0;	
wire [3:0]q1;	
wire [3:0]q2;
wire [3:0]q3;	
wire [7:0]c;
wire [3:0]temp1;
wire [5:0]temp2;
wire [3:0]q4;
wire [3:0]q5;
wire [3:0]q6;
// using 4 2x2 multipliers
vedic_2x2 z1(a[1:0],b[1:0],q0[3:0]);
vedic_2x2 z2(a[3:2],b[1:0],q1[3:0]);
vedic_2x2 z3(a[1:0],b[3:2],q2[3:0]);
vedic_2x2 z4(a[3:2],b[3:2],q3[3:0]);
// stage 1 adders 
assign temp1 ={2'b0,q0[3:2]};
add_4_bit z5(q1, q2, q4);
add_4_bit z6(temp1,q4,q5);
assign temp2 ={2'b0,q5[3:2]};
// stage 2 adder
add_4_bit z7(temp2,q3,q6);
// fnal output assignment 
assign c = {q6[3:0], q5[1:0], q0[1:0]};


endmodule

//////////////////////////////////////////////////////////////////////////////////

module add_8_bit(input1,input2,answer);
parameter N=8;
input [N-1:0] input1,input2;
   output [N-1:0] answer;
   wire  carry_out;
  wire [N-1:0] carry;
   genvar i;
   generate 
   for(i=0;i<N;i=i+1)
     begin: generate_N_bit_Adder
   if(i==0) 
  half_adder f(input1[0],input2[0],answer[0],carry[0]);
   else
  full_adder f(input1[i],input2[i],carry[i-1],answer[i],carry[i]);
     end
  assign carry_out = carry[N-1];
   endgenerate
endmodule 


module vedic_8x8(a,b,c);
   
input [7:0]a;
input [7:0]b;
output [15:0]c;

wire [15:0]q0;	
wire [15:0]q1;	
wire [15:0]q2;
wire [15:0]q3;	
wire [15:0]c;
wire [7:0]temp1;
wire [11:0]temp2;
wire [7:0]q4;
wire [7:0]q5;
wire [7:0]q6;
// using 4 4x4 multipliers
vedic_4x4 z1(a[3:0],b[3:0],q0[7:0]);
vedic_4x4 z2(a[7:4],b[3:0],q1[7:0]);
vedic_4x4 z3(a[3:0],b[7:4],q2[7:0]);
vedic_4x4 z4(a[7:4],b[7:4],q3[7:0]);

// stage 1 adders 
assign temp1 ={4'b0,q0[7:4]};
add_8_bit z5(q1, q2, q4);
add_8_bit z6(temp1,q4,q5);
assign temp2 ={4'b0,q5[7:4]};
// stage 2 adder
add_8_bit z7(temp2,q3,q6);
// fnal output assignment 
assign c = {q6[7:0], q5[3:0], q0[3:0]};

endmodule

//////////////////////////////////////////////////////////////////////////////////

module add_16_bit(input1,input2,answer);
parameter N=16;
input [N-1:0] input1,input2;
   output [N-1:0] answer;
   wire  carry_out;
  wire [N-1:0] carry;
   genvar i;
   generate 
   for(i=0;i<N;i=i+1)
     begin: generate_N_bit_Adder
   if(i==0) 
  half_adder f(input1[0],input2[0],answer[0],carry[0]);
   else
  full_adder f(input1[i],input2[i],carry[i-1],answer[i],carry[i]);
     end
  assign carry_out = carry[N-1];
   endgenerate
endmodule 

module vedic_16x16(a,b,c);
input [15:0]a;
input [15:0]b;
output [31:0]c;

wire [15:0]q0;	
wire [15:0]q1;	
wire [15:0]q2;
wire [15:0]q3;	
wire [31:0]c;
wire [15:0]temp1;
wire [23:0]temp2;
wire [15:0]q4;
wire [23:0]q5;
wire [23:0]q6;
// using 4 8x8 multipliers
vedic_8x8 z1(a[7:0],b[7:0],q0[15:0]);
vedic_8x8 z2(a[15:8],b[7:0],q1[15:0]);
vedic_8x8 z3(a[7:0],b[15:8],q2[15:0]);
vedic_8x8 z4(a[15:8],b[15:8],q3[15:0]);



// stage 1 adders 
assign temp1 ={8'b0,q0[14:8]};
add_16_bit z5(q1, q2, q4);
add_16_bit z6(temp1,q4,q5);
assign temp2 ={8'b0,q5[15:8]};
// stage 2 adder
add_16_bit z7(temp2,q3,q6);
// fnal output assignment 
assign c = {q6[15:0], q5[7:0], q0[7:0]};

endmodule

//////////////////////////////////////////////////////////////////////////////////
module add_32_bit(
    input [31:0] A,
    input [31:0] B,
    output [32:0] S
);

    wire Cin = 1'b0;
    wire [31:0] C;
    wire [31:0] P1, G1;
    square sq[31:0](A[31:0], B[31:0], P1[31:0], G1[31:0]);

    wire [31:1] P2, G2;
    smallCircle sC0(G1[0], C[0]);
    bigCircle bC0[31:1](P1[31:1], G1[31:1], P1[30:0], G1[30:0], P2[31:1], G2[31:1]);

    wire [31:3] P3, G3;
    smallCircle sC[2:1](G2[2:1], C[2:1]);
    bigCircle bC[31:3](P2[31:3], G2[31:3], P2[29:1], G2[29:1], P3[31:3], G3[31:3]);

    wire [31:7] P4, G4;
    smallCircle sC2[6:3](G3[6:3], C[6:3]);
    bigCircle bC2[31:7](P3[31:7], G3[31:7], P3[27:3], G3[27:3], P4[31:7], G4[31:7]);

    wire [31:15] P5, G5;
    smallCircle sC3[14:7](G4[14:7], C[14:7]);
    bigCircle bC3[31:15](P4[31:15], G4[31:15], P4[23:7], G4[23:7], P5[31:15], G5[31:15]);  

    wire [31:31] P6, G6;
    smallCircle sC4[30:15](G5[30:15], C[30:15]);
    bigCircle bC4[31:31](P5[31], G5[31], P5[15], G5[15], P6[31], G6[31]);

    smallCircle sC5(G6[31], C[31]);

    triangle t0(P1[0], Cin, S[0]);
    triangle t1[31:1](P1[31:1], C[30:0], S[31:1]);

    smallCircle sC6(C[31], S[32]);

endmodule



module vedic_32x32(a,b,c);
input [31:0]a;
input [31:0]b;
output [63:0]c;

wire [31:0]q0;	
wire [31:0]q1;	
wire [31:0]q2;
wire [31:0]q3;	
wire [63:0]c;
wire [31:0]temp1;
wire [47:0]temp2;
wire [47:0]temp3;
wire [47:0]temp4;
wire [31:0]q4;
wire [47:0]q5;
wire [47:0]q6;
// using 4 16x16 multipliers
vedic_16x16 z1(a[15:0],b[15:0],q0[31:0]);
vedic_16x16 z2(a[31:16],b[15:0],q1[31:0]);
vedic_16x16 z3(a[15:0],b[31:16],q2[31:0]);
vedic_16x16 z4(a[31:16],b[31:16],q3[31:0]);




// stage 1 adders 
assign temp1 ={16'b0,q0[31:16]};
add_32_bit z5(q1, q2, q4);
add_32_bit z6(temp1,q4,q5);
assign temp2 ={16'b0,q5[31:16]};
// stage 2 adder
add_32_bit z7(temp2,q3,q6);
// fnal output assignment 
assign c = {q6[31:0], q5[15:0], q0[15:0]};

endmodule
