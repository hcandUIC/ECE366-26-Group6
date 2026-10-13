module PPA(A, B, Cin, S, Cout);

    input [15:0] A, B;
    input Cin;
    output [15:0] S;
    output Cout;

    // P[stage][bit] and G[stage][bit]
    wire [15:0] P [0:4];
    wire [15:0] G [0:4];

    wire [16:0] C;

    genvar i;
    genvar stage;

    // STAGE 0: bit level G and P
    // P[i] = A[i] OR B[i]
    // G[i] = A[i] AND B[i]

    assign P[0] = A | B;
    assign G[0] = A & B;

    // stage 1-4 : prefix tree
    //
    // Stage 1: distance 1
    // Stage 2: distance 2
    // Stage 3: distance 4
    // Stage 4: distance 8
    //
  	// G(i:j) = G(i:k) OR (P(i:k) AND G(k-1:j))
    //
    // P(i:j) = P(i:k) AND P(k-1:j)

    generate
        for (stage = 1; stage <= 4; stage = stage + 1) begin : PREFIX_STAGE

          	for (i = 0; i < 16; i = i + 1) begin : PREFIX_BIT
              
            	if (i >= (1 << (stage - 1))) begin : COMBINE

              		assign P[stage][i] = P[stage-1][i] & P[stage-1][i - (1 << (stage - 1))];

              		assign G[stage][i] = G[stage-1][i] | (P[stage-1][i] & G[stage-1][i - (1<< (stage - 1))]);

                end
                else begin : PASS_THROUGH

                    assign P[stage][i] = P[stage-1][i];
                    assign G[stage][i] = G[stage-1][i];

                end

            end
        end
    endgenerate

    // carry generation
    // C[i+1] = G(i:0) OR (P(i:0) AND Cin)

    assign C[0] = Cin;

    generate
      
        for (i = 0; i < 16; i = i + 1) begin : CARRY_OUT

          	assign C[i+1] = G[4][i] | (P[4][i] & Cin);

        end
      
    endgenerate

    // sum generation
    // S[i] = A[i] XOR B[i] XOR C[i]

    assign S = A ^ B ^ C[15:0];

    // Final carry-out
    assign Cout = C[16];

endmodule