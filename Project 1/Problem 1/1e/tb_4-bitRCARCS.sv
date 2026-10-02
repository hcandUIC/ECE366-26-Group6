module tb_linear_adder;
    reg [3:0] A, B;
    reg Cin;
    wire [3:0] S;
    wire Cout;

  	four_bit_RCA_RCS uut (.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));

    initial begin

      	$dumpfile("dump.vcd"); 
        $dumpvars(1, tb_linear_adder);

        // 1. Unsigned addition: 5 + 3 
        A = 4'b0101; B = 4'b0011; Cin = 0; #10;

        // 2. Unsigned subtraction: 7 - 2 
        A = 4'b0111; B = 4'b0010; Cin = 1; #10;

        // 3. Signed addition w/ negative operand: 6 + (-4)
        A = 4'b0110; B = 4'b1100; Cin = 0; #10;

        // 4. Signed subtraction w/ negative operand: 5 - (-3)
        A = 4'b0101; B = 4'b1101; Cin = 1; #10;

        // 5. Carry-out generated: 15 + 1
        A = 4'b1111; B = 4'b0001; Cin = 0; #10;

        $finish;
    end
endmodule