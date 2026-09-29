module tb_loop_subtractor;
    reg [3:0] A, B;
    reg Cin;
    wire [3:0] S;
    wire Cout;
    
    integer i, j;

    four_bit_RCA_RCS uut (A, B, Cin, S, Cout);

    initial begin
        $dumpfile("dump.vcd"); $dumpvars(1, tb_loop_adder);

        Cin = 1;
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                A = i; B = j;
                #10;
            end
        end
        $finish;
    end
endmodule
