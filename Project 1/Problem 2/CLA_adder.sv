module CLA(A, B, Cin, S, Cout);
    input [31:0] A, B;
    input Cin;
    output wire [31:0] S;
    output wire Cout;

    wire [8:0] C; // Fast carries between the 8 blocks
    assign C[0] = Cin;
    assign Cout = C[8];

    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : cla_block
          // propagate 
            wire p0, p1, p2, p3;
            wire g0, g1, g2, g3;

            or  (p0, A[4*i+0], B[4*i+0]);
            and (g0, A[4*i+0], B[4*i+0]);

            or  (p1, A[4*i+1], B[4*i+1]);
            and (g1, A[4*i+1], B[4*i+1]);

            or  (p2, A[4*i+2], B[4*i+2]);
            and (g2, A[4*i+2], B[4*i+2]);

            or  (p3, A[4*i+3], B[4*i+3]);
            and (g3, A[4*i+3], B[4*i+3]);

            // Block Propagate (P_block = p0 & p1 & p2 & p3)
            wire p01, p23, P_block;
            and (p01, p0, p1);
            and (p23, p2, p3);
            and (P_block, p01, p23);

            // G_block = g3 | (p3 & (g2 | (p2 & (g1 | (p1 & g0)))))
            wire p1_G0, G1;
            and (p1_G0, p1, g0);
            or  (G1, g1, p1_G0);

            wire p2_G1, G2;
            and (p2_G1, p2, G1);
            or  (G2, g2, p2_G1);

            wire p3_G2, G_block;
            and (p3_G2, p3, G2);
            or  (G_block, g3, p3_G2);

            // Carry Out (C[i+1] = G_block | (P_block & C[i]))
            wire P_Cin;
            and (P_Cin, P_block, C[i]);
            or  (C[i+1], G_block, P_Cin);

            // 5. Instantiate the 4-bit RCA for the Sum 
            wire unused_cout; // The slow ripple Cout is ignored in favor of the fast CLA carry
            four_bit_RCA pure_adder (
                .A(A[4*i+3 : 4*i]),
                .B(B[4*i+3 : 4*i]),
                .Cin(C[i]),
                .S(S[4*i+3 : 4*i]),
                .Cout(unused_cout)
            );
        end
    endgenerate
endmodule
module full_adder(A, B, Cin, S, Cout);

    input A, B, Cin;
    output S, Cout;

    wire x1;
    wire c1, c2;

    xor (x1, A, B);
    xor (S, x1, Cin);

    and (c1, A, B);
    and (c2, x1, Cin);

    or (Cout, c1, c2);

endmodule
module four_bit_RCA(A, B, Cin, S, Cout);

    input [3:0] A, B;
    input Cin;
    output [3:0] S;
    output Cout;

    wire C1, C2, C3;

  	full_adder FA0(A[0], B[0], Cin, S[0], C1);
    full_adder FA1(A[1], B[1], C1, S[1], C2);
    full_adder FA2(A[2], B[2], C2, S[2], C3);
    full_adder FA3(A[3], B[3], C3, S[3], Cout);

endmodule
