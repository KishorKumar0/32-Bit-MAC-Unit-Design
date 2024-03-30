`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2024 01:36:23
// Design Name: MAC Unit
// Module Name: adder
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


module adder (input1, input2, product, carry_out);
parameter N = 64;
input [N-1:0] input1, input2;
output [N:0] product;
output carry_out;
wire [N-1:0] answer;
wire [N-1:0] carry;
genvar i;
generate
   for (i = 0; i < N; i = i + 1)
     begin: generate_N_bit_Adder
        if (i == 0)
          dkg_full_adder f(input1[0], input2[0], 1'b0, answer[0], carry[0]);
        else if (i == N-1)
          dkg_full_adder f(input1[i], input2[i], carry[i-1], answer[i], carry_out);
        else
          dkg_full_adder f(input1[i], input2[i], carry[i-1], answer[i], carry[i]);
     end
  assign carry_out = carry[N-1];
  assign product = {carry_out, answer};
endgenerate
endmodule

//Full adder design using reversible dkg logic
module dkg_full_adder(A, B,C,Sum, Carry);
input A, B, C;
output Sum, Carry;
assign Carry = (A & (B ^ C))^(B & C);
assign Sum = A ^ B ^ C;
endmodule
