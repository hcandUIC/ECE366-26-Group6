module tb_32bit_CLA;
    reg [31:0] A, B;
    reg Cin;
    wire [31:0] S;
    wire Cout;

    // Connect to your 32-bit CLA
    CLA uut (.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));

    initial begin
        $dumpfile("dump.vcd"); 
        $dumpvars(1, tb_32bit_CLA);

        // 1. Unsigned addition: 5 + 3
        A = 32'h0000_0005; B = 32'h0000_0003; Cin = 0; #10;

        // 2. Signed addition w/ negative operand: 6 + (-4)
        A = 32'h0000_0006; B = 32'hFFFF_FFFC; Cin = 0; #10;

        // 3. Carry-out generated: Maximum 32-bit value + 1
        A = 32'hFFFF_FFFF; B = 32'h0000_0001; Cin = 0; #10;

        // 4. Carry propagation across multiple 4-bit blocks
        A = 32'h0000_0FFF; B = 32'h0000_0001; Cin = 0; #10;

        $finish;
    end
endmodule