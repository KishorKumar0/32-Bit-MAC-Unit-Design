`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2024 01:37:17
// Design Name: MAC Unit
// Module Name: mac_tb
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


module mac_tb;

    parameter CLK_PERIOD = 10; 
    
    reg [31:0] multiplicand;
    reg [31:0] multiplier;
    wire [64:0] accumulator_out;

    reg clk = 0;
    reg reset;
    mac Accunaltor (
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .clk(clk),
        .reset(reset),
        .accumulator_out(accumulator_out)
    );

    always #((CLK_PERIOD / 2)) clk = ~clk;

    initial begin
        reset = 1;
        multiplicand = 32'h11111111;
        multiplier = 32'h11111111;
        
       #10 reset = 0;
        #100 multiplicand = 32'h12345678; multiplier = 32'h87654321;

        #100 $finish;
    end

    always @(posedge clk) begin
        $display("Time = %0t: multiplicand = %d, multiplier = %d, accumulator_out = %d",
                 $time, multiplicand, multiplier, accumulator_out);
    end

endmodule
