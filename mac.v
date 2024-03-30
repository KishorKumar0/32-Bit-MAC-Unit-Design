`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Kishor Kumar
// 
// Create Date: 30.03.2024 01:31:58
// Design Name: MAC unit
// Module Name: mac
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
    input clk, reset,
    output reg [64:0] accumulator_out
);
    wire [64:0] multiplication_result;
    wire [65:0] addition_result;
    reg [63:0] accumulator;

    // Perform the multiplication using a 16x16 Vedic multiplier
 
    vedic_32x32 multi(multiplicand, multiplier, multiplication_result);

    // Perform the addition of the multiplication result and the accumulator input
    adder adder(multiplication_result, accumulator_out, addition_result);

    // Output the final result as the accumulator output
    always @(posedge clk) begin
        if(reset) 
            accumulator_out <= 64'b0;  
        else begin
            accumulator_out <= addition_result[64:0];
        end
    end

endmodule
