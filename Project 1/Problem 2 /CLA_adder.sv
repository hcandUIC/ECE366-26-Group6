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


module four_bit_RCA_RCS(A, B, Cin, S, Cout);

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


module PPA(A, B, Cin, S, Cout);

    input [31:0] A, B;
    input Cin;
    output [31:0] S;
    output Cout;


endmodule

module PPA(A, B, Cin, S, Cout);

    input [31:0] A, B;
    input Cin;
    output [31:0] S;
    output Cout;


    wire [31:0] P;
    wire [31:0] G;

    or  (P[0], A[0], B[0]);
    and (G[0], A[0], B[0]);

    or  (P[1], A[1], B[1]);
    and (G[1], A[1], B[1]);

    or  (P[2], A[2], B[2]);
    and (G[2], A[2], B[2]);

    or  (P[3], A[3], B[3]);
    and (G[3], A[3], B[3]);

    or  (P[4], A[4], B[4]);
    and (G[4], A[4], B[4]);

    or  (P[5], A[5], B[5]);
    and (G[5], A[5], B[5]);

    or  (P[6], A[6], B[6]);
    and (G[6], A[6], B[6]);

    or  (P[7], A[7], B[7]);
    and (G[7], A[7], B[7]);

    or  (P[8], A[8], B[8]);
    and (G[8], A[8], B[8]);

    or  (P[9], A[9], B[9]);
    and (G[9], A[9], B[9]);

    or  (P[10], A[10], B[10]);
    and (G[10], A[10], B[10]);

    or  (P[11], A[11], B[11]);
    and (G[11], A[11], B[11]);

    or  (P[12], A[12], B[12]);
    and (G[12], A[12], B[12]);

    or  (P[13], A[13], B[13]);
    and (G[13], A[13], B[13]);

    or  (P[14], A[14], B[14]);
    and (G[14], A[14], B[14]);

    or  (P[15], A[15], B[15]);
    and (G[15], A[15], B[15]);

    or  (P[16], A[16], B[16]);
    and (G[16], A[16], B[16]);

    or  (P[17], A[17], B[17]);
    and (G[17], A[17], B[17]);

    or  (P[18], A[18], B[18]);
    and (G[18], A[18], B[18]);

    or  (P[19], A[19], B[19]);
    and (G[19], A[19], B[19]);

    or  (P[20], A[20], B[20]);
    and (G[20], A[20], B[20]);

    or  (P[21], A[21], B[21]);
    and (G[21], A[21], B[21]);

    or  (P[22], A[22], B[22]);
    and (G[22], A[22], B[22]);

    or  (P[23], A[23], B[23]);
    and (G[23], A[23], B[23]);

    or  (P[24], A[24], B[24]);
    and (G[24], A[24], B[24]);

    or  (P[25], A[25], B[25]);
    and (G[25], A[25], B[25]);

    or  (P[26], A[26], B[26]);
    and (G[26], A[26], B[26]);

    or  (P[27], A[27], B[27]);
    and (G[27], A[27], B[27]);

    or  (P[28], A[28], B[28]);
    and (G[28], A[28], B[28]);

    or  (P[29], A[29], B[29]);
    and (G[29], A[29], B[29]);

    or  (P[30], A[30], B[30]);
    and (G[30], A[30], B[30]);

    or  (P[31], A[31], B[31]);


    // -----------------------------------------
    // Block propagate
    // -----------------------------------------

    wire BP0, BP1, BP2, BP3;
    wire BP4, BP5, BP6, BP7;

    wire p0a, p0b;
    wire p1a, p1b;
    wire p2a, p2b;
    wire p3a, p3b;
    wire p4a, p4b;
    wire p5a, p5b;
    wire p6a, p6b;
    wire p7a, p7b;

    // Block 0
    and (p0a, P[0], P[1]);
    and (p0b, P[2], P[3]);
    and (BP0, p0a, p0b);

    // Block 1
    and (p1a, P[4], P[5]);
    and (p1b, P[6], P[7]);
    and (BP1, p1a, p1b);

    // Block 2
    and (p2a, P[8], P[9]);
    and (p2b, P[10], P[11]);
    and (BP2, p2a, p2b);

    // Block 3
    and (p3a, P[12], P[13]);
    and (p3b, P[14], P[15]);
    and (BP3, p3a, p3b);

    // Block 4
    and (p4a, P[16], P[17]);
    and (p4b, P[18], P[19]);
    and (BP4, p4a, p4b);

    // Block 5
    and (p5a, P[20], P[21]);
    and (p5b, P[22], P[23]);
    and (BP5, p5a, p5b);

    // Block 6
    and (p6a, P[24], P[25]);
    and (p6b, P[26], P[27]);
    and (BP6, p6a, p6b);

    // Block 7
    and (p7a, P[28], P[29]);
    and (p7b, P[30], P[31]);
    and (BP7, p7a, p7b);


    //Block generate wires

    wire BG0, BG1, BG2, BG3;
    wire BG4, BG5, BG6, BG7;

    // Temp wires
    wire x01, x02, x03;
    wire x11, x12, x13;
    wire x21, x22, x23;
    wire x31, x32, x33;
    wire x41, x42, x43;
    wire x51, x52, x53;
    wire x61, x62, x63;
    wire x71, x72, x73;

    // Block 0
    and (x01, P[3], G[2]);

    and (x02, P[3], P[2]);
    and (x02, x02, G[1]);

    and (x03, P[3], P[2]);
    and (x03, x03, P[1]);
    and (x03, x03, G[0]);

    or (x01, G[3], x01);
    or (x02, x01, x02);
    or (BG0, x02, x03);


    // Block 1
    and (x11, P[7], G[6]);

    and (x12, P[7], P[6]);
    and (x12, x12, G[5]);

    and (x13, P[7], P[6]);
    and (x13, x13, P[5]);
    and (x13, x13, G[4]);

    or (x11, G[7], x11);
    or (x12, x11, x12);
    or (BG1, x12, x13);


    // Block 2
    and (x21, P[11], G[10]);

    and (x22, P[11], P[10]);
    and (x22, x22, G[9]);

    and (x23, P[11], P[10]);
    and (x23, x23, P[9]);
    and (x23, x23, G[8]);

    or (x21, G[11], x21);
    or (x22, x21, x22);
    or (BG2, x22, x23);


    // Block 3
    and (x31, P[15], G[14]);

    and (x32, P[15], P[14]);
    and (x32, x32, G[13]);

    and (x33, P[15], P[14]);
    and (x33, x33, P[13]);
    and (x33, x33, G[12]);

    or (x31, G[15], x31);
    or (x32, x31, x32);
    or (BG3, x32, x33);


    // Block 4
    and (x41, P[19], G[18]);

    and (x42, P[19], P[18]);
    and (x42, x42, G[17]);

    and (x43, P[19], P[18]);
    and (x43, x43, P[17]);
    and (x43, x43, G[16]);

    or (x41, G[19], x41);
    or (x42, x41, x42);
    or (BG4, x42, x43);


    // Block 5
    and (x51, P[23], G[22]);

    and (x52, P[23], P[22]);
    and (x52, x52, G[21]);

    and (x53, P[23], P[22]);
    and (x53, x53, P[21]);
    and (x53, x53, G[20]);

    or (x51, G[23], x51);
    or (x52, x51, x52);
    or (BG5, x52, x53);


    // Block 6
    and (x61, P[27], G[26]);

    and (x62, P[27], P[26]);
    and (x62, x62, G[25]);

    and (x63, P[27], P[26]);
    and (x63, x63, P[25]);
    and (x63, x63, G[24]);

    or (x61, G[27], x61);
    or (x62, x61, x62);
    or (BG6, x62, x63);


    // Block 7
    and (x71, P[31], G[30]);

    and (x72, P[31], P[30]);
    and (x72, x72, G[29]);

    and (x73, P[31], P[30]);
    and (x73, x73, P[29]);
    and (x73, x73, G[28]);

    or (x71, G[31], x71);
    or (x72, x71, x72);
    or (BG7, x72, x73);


    // -----------------------------------------
    // Carry between 4-bit blocks
    // -----------------------------------------

    wire C4, C8, C12, C16;
    wire C20, C24, C28;

    wire c4x, c8x, c12x, c16x;
    wire c20x, c24x, c28x;

    // C4 = BG0 + BP0*Cin
    and (c4x, BP0, Cin);
    or  (C4, BG0, c4x);

    // C8 = BG1 + BP1*C4
    and (c8x, BP1, C4);
    or  (C8, BG1, c8x);

    // C12
    and (c12x, BP2, C8);
    or  (C12, BG2, c12x);

    // C16
    and (c16x, BP3, C12);
    or  (C16, BG3, c16x);

    // C20
    and (c20x, BP4, C16);
    or  (C20, BG4, c20x);

    // C24
    and (c24x, BP5, C20);
    or  (C24, BG5, c24x);

    // C28
    and (c28x, BP6, C24);
    or  (C28, BG6, c28x);

    // C32 / Cout
    wire c32x;
    and (c32x, BP7, C28);
    or  (Cout, BG7, c32x);


    // -----------------------------------------
    // Eight 4-bit RCA blocks
    // -----------------------------------------

    wire RCA_C0, RCA_C1, RCA_C2, RCA_C3;
    wire RCA_C4, RCA_C5, RCA_C6, RCA_C7;

    four_bit_RCA_RCS RCA0(
        A[3:0], B[3:0], Cin,
        S[3:0], RCA_C0
    );

    four_bit_RCA_RCS RCA1(
        A[7:4], B[7:4], C4,
        S[7:4], RCA_C1
    );

    four_bit_RCA_RCS RCA2(
        A[11:8], B[11:8], C8,
        S[11:8], RCA_C2
    );

    four_bit_RCA_RCS RCA3(
        A[15:12], B[15:12], C12,
        S[15:12], RCA_C3
    );

    four_bit_RCA_RCS RCA4(
        A[19:16], B[19:16], C16,
        S[19:16], RCA_C4
    );

    four_bit_RCA_RCS RCA5(
        A[23:20], B[23:20], C20,
        S[23:20], RCA_C5
    );

    four_bit_RCA_RCS RCA6(
        A[27:24], B[27:24], C24,
        S[27:24], RCA_C6
    );

    four_bit_RCA_RCS RCA7(
        A[31:28], B[31:28], C28,
        S[31:28], RCA_C7
    );

endmodule
