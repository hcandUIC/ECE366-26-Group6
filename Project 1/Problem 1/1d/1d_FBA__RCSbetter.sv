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

// 4-bit RCA and RCS
module four_bit_RCA_RCS(A, B, Cin, S, Cout);

    input [3:0] A, B;
    input Cin;
    output wire [3:0] S;
    output wire Cout;

    wire [3:0] B_xor;
    wire C1, C2, C3;

    // Invert B when Cin = 1 (Subtraction mode)
    xor (B_xor[0], B[0], Cin);
    xor (B_xor[1], B[1], Cin);
    xor (B_xor[2], B[2], Cin);
    xor (B_xor[3], B[3], Cin);

    // Pass B_xor into the adders instead of B, using named mapping
    full_adder FA0(.A(A[0]), .B(B_xor[0]), .Cin(Cin), .S(S[0]), .Cout(C1));
    full_adder FA1(.A(A[1]), .B(B_xor[1]), .Cin(C1),  .S(S[1]), .Cout(C2));
    full_adder FA2(.A(A[2]), .B(B_xor[2]), .Cin(C2),  .S(S[2]), .Cout(C3));
    full_adder FA3(.A(A[3]), .B(B_xor[3]), .Cin(C3),  .S(S[3]), .Cout(Cout));

endmodule