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

// 4-bit RCA

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

// 32-bit CLA

module CLA(A, B, Cin, S, Cout);

    input [31:0] A, B;
    input Cin;
    output [31:0] S;
    output Cout;

    wire [31:0] P;
    wire [31:0] G;

    wire C4, C8, C12, C16;
    wire C20, C24, C28;

  // PROPAGATE (P)
    // P[i] = A[i] XOR B[i]

    xor (P[0],  A[0],  B[0]);
    xor (P[1],  A[1],  B[1]);
    xor (P[2],  A[2],  B[2]);
    xor (P[3],  A[3],  B[3]);
    xor (P[4],  A[4],  B[4]);
    xor (P[5],  A[5],  B[5]);
    xor (P[6],  A[6],  B[6]);
    xor (P[7],  A[7],  B[7]);
    xor (P[8],  A[8],  B[8]);
    xor (P[9],  A[9],  B[9]);
    xor (P[10], A[10], B[10]);
    xor (P[11], A[11], B[11]);
    xor (P[12], A[12], B[12]);
    xor (P[13], A[13], B[13]);
    xor (P[14], A[14], B[14]);
    xor (P[15], A[15], B[15]);
    xor (P[16], A[16], B[16]);
    xor (P[17], A[17], B[17]);
    xor (P[18], A[18], B[18]);
    xor (P[19], A[19], B[19]);
    xor (P[20], A[20], B[20]);
    xor (P[21], A[21], B[21]);
    xor (P[22], A[22], B[22]);
    xor (P[23], A[23], B[23]);
    xor (P[24], A[24], B[24]);
    xor (P[25], A[25], B[25]);
    xor (P[26], A[26], B[26]);
    xor (P[27], A[27], B[27]);
    xor (P[28], A[28], B[28]);
    xor (P[29], A[29], B[29]);
    xor (P[30], A[30], B[30]);
    xor (P[31], A[31], B[31]);

  // GENERATE (G)
    // G[i] = A[i] AND B[i]

    and (G[0],  A[0],  B[0]);
    and (G[1],  A[1],  B[1]);
    and (G[2],  A[2],  B[2]);
    and (G[3],  A[3],  B[3]);
    and (G[4],  A[4],  B[4]);
    and (G[5],  A[5],  B[5]);
    and (G[6],  A[6],  B[6]);
    and (G[7],  A[7],  B[7]);
    and (G[8],  A[8],  B[8]);
    and (G[9],  A[9],  B[9]);
    and (G[10], A[10], B[10]);
    and (G[11], A[11], B[11]);
    and (G[12], A[12], B[12]);
    and (G[13], A[13], B[13]);
    and (G[14], A[14], B[14]);
    and (G[15], A[15], B[15]);
    and (G[16], A[16], B[16]);
    and (G[17], A[17], B[17]);
    and (G[18], A[18], B[18]);
    and (G[19], A[19], B[19]);
    and (G[20], A[20], B[20]);
    and (G[21], A[21], B[21]);
    and (G[22], A[22], B[22]);
    and (G[23], A[23], B[23]);
    and (G[24], A[24], B[24]);
    and (G[25], A[25], B[25]);
    and (G[26], A[26], B[26]);
    and (G[27], A[27], B[27]);
    and (G[28], A[28], B[28]);
    and (G[29], A[29], B[29]);
    and (G[30], A[30], B[30]);
    and (G[31], A[31], B[31]);

    // C4

    wire c4_t1, c4_t2, c4_t3, c4_t4;
    wire c4_p32, c4_p321, c4_p3210;
    wire c4_o1, c4_o2, c4_o3;

    and (c4_t1, P[3], G[2]);

    and (c4_p32, P[3], P[2]);
    and (c4_t2, c4_p32, G[1]);

    and (c4_p321, c4_p32, P[1]);
    and (c4_t3, c4_p321, G[0]);

    and (c4_p3210, c4_p321, P[0]);
    and (c4_t4, c4_p3210, Cin);

    or (c4_o1, G[3], c4_t1);
    or (c4_o2, c4_o1, c4_t2);
    or (c4_o3, c4_o2, c4_t3);
    or (C4, c4_o3, c4_t4);

    // C8
  
    wire c8_t1, c8_t2, c8_t3, c8_t4;
    wire c8_p76, c8_p765, c8_p7654;
    wire c8_o1, c8_o2, c8_o3;

    and (c8_t1, P[7], G[6]);

    and (c8_p76, P[7], P[6]);
    and (c8_t2, c8_p76, G[5]);

    and (c8_p765, c8_p76, P[5]);
    and (c8_t3, c8_p765, G[4]);

    and (c8_p7654, c8_p765, P[4]);
    and (c8_t4, c8_p7654, C4);

    or (c8_o1, G[7], c8_t1);
    or (c8_o2, c8_o1, c8_t2);
    or (c8_o3, c8_o2, c8_t3);
    or (C8, c8_o3, c8_t4);
  
    // C12

    wire c12_t1, c12_t2, c12_t3, c12_t4;
    wire c12_p1110, c12_p11109, c12_p111098;
    wire c12_o1, c12_o2, c12_o3;

    and (c12_t1, P[11], G[10]);

    and (c12_p1110, P[11], P[10]);
    and (c12_t2, c12_p1110, G[9]);

    and (c12_p11109, c12_p1110, P[9]);
    and (c12_t3, c12_p11109, G[8]);

    and (c12_p111098, c12_p11109, P[8]);
    and (c12_t4, c12_p111098, C8);

    or (c12_o1, G[11], c12_t1);
    or (c12_o2, c12_o1, c12_t2);
    or (c12_o3, c12_o2, c12_t3);
    or (C12, c12_o3, c12_t4);

    // C16

    wire c16_t1, c16_t2, c16_t3, c16_t4;
    wire c16_p1514, c16_p151413, c16_p15141312;
    wire c16_o1, c16_o2, c16_o3;

    and (c16_t1, P[15], G[14]);

    and (c16_p1514, P[15], P[14]);
    and (c16_t2, c16_p1514, G[13]);

    and (c16_p151413, c16_p1514, P[13]);
    and (c16_t3, c16_p151413, G[12]);

    and (c16_p15141312, c16_p151413, P[12]);
    and (c16_t4, c16_p15141312, C12);

    or (c16_o1, G[15], c16_t1);
    or (c16_o2, c16_o1, c16_t2);
    or (c16_o3, c16_o2, c16_t3);
    or (C16, c16_o3, c16_t4);

    // C20

    wire c20_t1, c20_t2, c20_t3, c20_t4;
    wire c20_p1918, c20_p191817, c20_p19181716;
    wire c20_o1, c20_o2, c20_o3;

    and (c20_t1, P[19], G[18]);

    and (c20_p1918, P[19], P[18]);
    and (c20_t2, c20_p1918, G[17]);

    and (c20_p191817, c20_p1918, P[17]);
    and (c20_t3, c20_p191817, G[16]);

    and (c20_p19181716, c20_p191817, P[16]);
    and (c20_t4, c20_p19181716, C16);

    or (c20_o1, G[19], c20_t1);
    or (c20_o2, c20_o1, c20_t2);
    or (c20_o3, c20_o2, c20_t3);
    or (C20, c20_o3, c20_t4);

    // C24

    wire c24_t1, c24_t2, c24_t3, c24_t4;
    wire c24_p2322, c24_p232221, c24_p23222120;
    wire c24_o1, c24_o2, c24_o3;

    and (c24_t1, P[23], G[22]);

    and (c24_p2322, P[23], P[22]);
    and (c24_t2, c24_p2322, G[21]);

    and (c24_p232221, c24_p2322, P[21]);
    and (c24_t3, c24_p232221, G[20]);

    and (c24_p23222120, c24_p232221, P[20]);
    and (c24_t4, c24_p23222120, C20);

    or (c24_o1, G[23], c24_t1);
    or (c24_o2, c24_o1, c24_t2);
    or (c24_o3, c24_o2, c24_t3);
    or (C24, c24_o3, c24_t4);

    // C28

    wire c28_t1, c28_t2, c28_t3, c28_t4;
    wire c28_p2726, c28_p272625, c28_p27262524;
    wire c28_o1, c28_o2, c28_o3;

    and (c28_t1, P[27], G[26]);

    and (c28_p2726, P[27], P[26]);
    and (c28_t2, c28_p2726, G[25]);

    and (c28_p272625, c28_p2726, P[25]);
    and (c28_t3, c28_p272625, G[24]);

    and (c28_p27262524, c28_p272625, P[24]);
    and (c28_t4, c28_p27262524, C24);

    or (c28_o1, G[27], c28_t1);
    or (c28_o2, c28_o1, c28_t2);
    or (c28_o3, c28_o2, c28_t3);
    or (C28, c28_o3, c28_t4);

    // COUT

    wire co_t1, co_t2, co_t3, co_t4;
    wire co_p3130, co_p313029, co_p31302928;
    wire co_o1, co_o2, co_o3;

    and (co_t1, P[31], G[30]);

    and (co_p3130, P[31], P[30]);
    and (co_t2, co_p3130, G[29]);

    and (co_p313029, co_p3130, P[29]);
    and (co_t3, co_p313029, G[28]);

    and (co_p31302928, co_p313029, P[28]);
    and (co_t4, co_p31302928, C28);

    or (co_o1, G[31], co_t1);
    or (co_o2, co_o1, co_t2);
    or (co_o3, co_o2, co_t3);
    or (Cout, co_o3, co_t4);

    // 8 x 4-bit RCA BLOCKS

    wire unused0, unused1, unused2, unused3;
    wire unused4, unused5, unused6;

    four_bit_RCA_RCS RCA0(
        A[3:0],
        B[3:0],
        Cin,
        S[3:0],
        unused0
    );

    four_bit_RCA_RCS RCA1(
        A[7:4],
        B[7:4],
        C4,
        S[7:4],
        unused1
    );

    four_bit_RCA_RCS RCA2(
        A[11:8],
        B[11:8],
        C8,
        S[11:8],
        unused2
    );

    four_bit_RCA_RCS RCA3(
        A[15:12],
        B[15:12],
        C12,
        S[15:12],
        unused3
    );

    four_bit_RCA_RCS RCA4(
        A[19:16],
        B[19:16],
        C16,
        S[19:16],
        unused4
    );

    four_bit_RCA_RCS RCA5(
        A[23:20],
        B[23:20],
        C20,
        S[23:20],
        unused5
    );

    four_bit_RCA_RCS RCA6(
        A[27:24],
        B[27:24],
        C24,
        S[27:24],
        unused6
    );

    four_bit_RCA_RCS RCA7(
        A[31:28],
        B[31:28],
        C28,
        S[31:28],
        Cout
    );

endmodule
