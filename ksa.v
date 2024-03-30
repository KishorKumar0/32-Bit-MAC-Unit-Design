`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2024 10:50:55
// Design Name: MAC Unit
// Module Name: ksa
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



module square(
    input A,
    input B,
    output P,
    output G
);
	
	xor xor0 (P, A, B);
	and and0 (G, A, B);
	
endmodule


module bigCircle(
    input Pi,
    input Gi,
    input Pprev,
    input Gprev,
    output P,
    output G
);
	
	wire w;
	
	and and0 (P, Pi, Pprev);
	and and1 (w, Pi, Gprev);
	or or0 (G, Gi, w);
	
endmodule


module smallCircle(
    input Gi,
    output Ci
);
	
	buf buf0 (Ci, Gi);
	
endmodule


module triangle(
    input Pi,
    input Cprev,
    output Si
);
	
	xor xor0 (Si, Pi, Cprev);
	
endmodule


module ksa(
    input [47:0] A,
    input [47:0] B,
    output [48:0] S
);

    wire Cin = 1'b0;
    wire [47:0] C;
    wire [47:0] P1, G1;
    square sq[47:0](A[47:0], B[47:0], P1[47:0], G1[47:0]);

    wire [47:1] P2, G2;
    smallCircle sC0(G1[0], C[0]);
    bigCircle bC0[47:1](P1[47:1], G1[47:1], P1[46:0], G1[46:0], P2[47:1], G2[47:1]);

    wire [47:3] P3, G3;
    smallCircle sC[2:1](G2[2:1], C[2:1]);
    bigCircle bC[47:3](P2[47:3], G2[47:3], P2[45:1], G2[45:1], P3[47:3], G3[47:3]);

    wire [47:7] P4, G4;
    smallCircle sC2[6:3](G3[6:3], C[6:3]);
    bigCircle bC2[47:7](P3[47:7], G3[47:7], P3[43:3], G3[43:3], P4[47:7], G4[47:7]);

    wire [47:15] P5, G5;
    smallCircle sC3[14:7](G4[14:7], C[14:7]);
    bigCircle bC3[47:15](P4[47:15], G4[47:15], P4[39:7], G4[39:7], P5[47:15], G5[47:15]);  

    wire [47:31] P6, G6;
    smallCircle sC4[30:15](G5[30:15], C[30:15]);
    bigCircle bC4[47:31](P5[47:31], G5[47:31], P5[15], G5[15], P6[47:31], G6[47:31]);

    wire [47:47] P7, G7;
    smallCircle sC5[46:31](G6[46:31], C[46:31]);
    bigCircle bC5[47:47](P6[47], G6[47], P6[31], G6[31], P7[47], G7[47]);

    smallCircle sC6(G7[47], C[47]);

    triangle t0(P1[0], Cin, S[0]);
    triangle t1[47:1](P1[47:1], C[46:0], S[47:1]);

    smallCircle sC8(C[47], S[48]);

endmodule
