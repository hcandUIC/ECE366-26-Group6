
`timescale 1ns/1ps

module PPA_tb;

    reg [15:0] A;
    reg [15:0] B;
    reg Cin;

    wire [15:0] S;
    wire Cout;

    reg [16:0] expected;
    integer test_num;

    // Instantiate the 16-bit PPA
    PPA DUT (
        .A(A),
        .B(B),
        .Cin(Cin),
        .S(S),
        .Cout(Cout)
    );

    // Generate waveform file
    initial begin
        $dumpfile("PPA_waveform.vcd");
        $dumpvars(0, PPA_tb);
    end

    // Apply test cases and verify results
    initial begin
        test_num = 0;

        // Test 1: Basic addition
        A = 16'h000A;
        B = 16'h0005;
        Cin = 1'b0;
        expected = 17'h0000F;
        #10;
        check_result;

        // Test 2: Carry within the low 4 bits
        A = 16'h000F;
        B = 16'h0001;
        Cin = 1'b0;
        expected = 17'h00010;
        #10;
        check_result;

        // Test 3: Carry across multiple prefix levels
        A = 16'h0FFF;
        B = 16'h0001;
        Cin = 1'b0;
        expected = 17'h01000;
        #10;
        check_result;

        // Test 4: Carry across all 16 bits
        A = 16'hFFFF;
        B = 16'h0001;
        Cin = 1'b0;
        expected = 17'h10000;
        #10;
        check_result;

        // Test 5: Carry-in
        A = 16'h0010;
        B = 16'h0020;
        Cin = 1'b1;
        expected = 17'h00031;
        #10;
        check_result;

        // Test 6: Both operands are zero
        A = 16'h0000;
        B = 16'h0000;
        Cin = 1'b0;
        expected = 17'h00000;
        #10;
        check_result;

        // Test 7: Maximum operands with carry-in
        A = 16'hFFFF;
        B = 16'hFFFF;
        Cin = 1'b1;
        expected = 17'h1FFFF;
        #10;
        check_result;

        // Test 8: Alternating bit patterns
        A = 16'hAAAA;
        B = 16'h5555;
        Cin = 1'b0;
        expected = 17'h0FFFF;
        #10;
        check_result;

        $display("----------------------------------");
        $display("PPA TESTING COMPLETE");
        $display("Total tests: %0d", test_num);
        $display("----------------------------------");

        #10;
        $finish;
    end

    // Task to check the output
    task check_result;
        begin
            test_num = test_num + 1;

            if ({Cout, S} !== expected) begin
                $display("FAIL at time %0t", $time);
                $display("A        = %h", A);
                $display("B        = %h", B);
                $display("Cin      = %b", Cin);
                $display("Expected = %h", expected);
                $display("Actual   = %h", {Cout, S});
            end
            else begin
                $display("Test %0d PASSED: A=%h B=%h Cin=%b Result=%h",
                         test_num, A, B, Cin, {Cout, S});
            end
        end
    endtask

endmodule

