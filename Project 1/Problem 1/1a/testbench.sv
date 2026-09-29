module tb_adder;
    reg A, B, Cin;
    wire S, Cout;

    one_bit_full_adder uut (A, B, Cin, S, Cout);

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1, tb_adder);

        A = 0; B = 0; Cin = 0; #10;
        A = 0; B = 1; Cin = 0; #10;
        A = 1; B = 0; Cin = 1; #10;
        A = 1; B = 1; Cin = 1; #10;
        
        $finish;
    end
endmodule