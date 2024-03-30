`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Kishor Kumar
// 
// Create Date: 30.03.2024 01:31:58
// Design Name: MAC Unit
// Module Name: MAC Module
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


module mac(
    input [31:0] multiplicand,
    input [31:0] multiplier,
    input [63:0] accumulator_in,
    output reg [64:0] accumulator_out
);

    wire [64:0] multiplication_result;
    wire [65:0] addition_result;

    // Perform the multiplication using a 16x16 Vedic multiplier
    vedic_32x32 mult(multiplicand, multiplier, multiplication_result);

    // Perform the addition of the multiplication result and the accumulator input
    adder adder(multiplication_result, accumulator_in, addition_result);

    // Output the final result as the accumulator output
    always @* begin
        accumulator_out = addition_result;
    end

endmodule
