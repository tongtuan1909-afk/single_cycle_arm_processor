module tb_shifter;

    logic [31:0] RD2;
    logic [4:0] Shamt;
    logic [1:0] Sh;
    logic [31:0] ShifterResult;

    // Goi module Shifter
    shifter uut (
        .RD2(RD2),
        .Shamt(Shamt),
        .Sh(Sh),
        .ShifterResult(ShifterResult)
    );

    initial begin

        // =====================================
        // TEST 1: LSL 1
        // =====================================
        RD2   = 32'h00000002;
        Shamt = 5'd1;
        Sh    = 2'b00;

        #10;

        if (ShifterResult == 32'h00000004)
            $display("TEST 1 PASS");
        else
            $display("TEST 1 FAIL: Result = %h", ShifterResult);


        // =====================================
        // TEST 2: LSL 3
        // =====================================
        RD2   = 32'h00000003;
        Shamt = 5'd3;
        Sh    = 2'b00;

        #10;

        if (ShifterResult == 32'h00000018)
            $display("TEST 2 PASS");
        else
            $display("TEST 2 FAIL: Result = %h", ShifterResult);


        // =====================================
        // TEST 3: LSR 1
        // =====================================
        RD2   = 32'h00000008;
        Shamt = 5'd1;
        Sh    = 2'b01;

        #10;

        if (ShifterResult == 32'h00000004)
            $display("TEST 3 PASS");
        else
            $display("TEST 3 FAIL: Result = %h", ShifterResult);


        // =====================================
        // TEST 4: LSR 3
        // =====================================
        RD2   = 32'h00000010;
        Shamt = 5'd3;
        Sh    = 2'b01;

        #10;

        if (ShifterResult == 32'h00000002)
            $display("TEST 4 PASS");
        else
            $display("TEST 4 FAIL: Result = %h", ShifterResult);


        // =====================================
        // TEST 5: LSR 0
        // =====================================
        RD2   = 32'h12345678;
        Shamt = 5'd0;
        Sh    = 2'b01;

        #10;

        if (ShifterResult == 32'h00000000)
            $display("TEST 5 PASS");
        else
            $display("TEST 5 FAIL: Result = %h", ShifterResult);


        // =====================================
        // TEST 6: LSL 0
        // =====================================
        RD2   = 32'h12345678;
        Shamt = 5'd0;
        Sh    = 2'b00;

        #10;

        if (ShifterResult == 32'h12345678)
            $display("TEST 6 PASS");
        else
            $display("TEST 6 FAIL: Result = %h", ShifterResult);


        // =====================================
        // TEST 7: LSR lam mat bit 1
        // =====================================
        RD2   = 32'h00000002;
        Shamt = 5'd3;
        Sh    = 2'b01;

        #10;

        if (ShifterResult == 32'h00000000)
            $display("TEST 7 PASS");
        else
            $display("TEST 7 FAIL: Result = %h", ShifterResult);


        // =====================================
        // TEST 8: LSL lam tran bit
        // =====================================
        RD2   = 32'h80000000;
        Shamt = 5'd1;
        Sh    = 2'b00;

        #10;

        if (ShifterResult == 32'h00000000)
            $display("TEST 8 PASS");
        else
            $display("TEST 8 FAIL: Result = %h", ShifterResult);


        // =====================================
        // TEST 9: LSR voi nhieu bit 1
        // =====================================
        RD2   = 32'hFFFFFFFF;
        Shamt = 5'd4;
        Sh    = 2'b01;

        #10;

        if (ShifterResult == 32'h0FFFFFFF)
            $display("TEST 9 PASS");
        else
            $display("TEST 9 FAIL: Result = %h", ShifterResult);


        // =====================================
        // TEST 10: LSL voi nhieu bit 1
        // =====================================
        RD2   = 32'h000000FF;
        Shamt = 5'd4;
        Sh    = 2'b00;

        #10;

        if (ShifterResult == 32'h00000FF0)
            $display("TEST 10 PASS");
        else
            $display("TEST 10 FAIL: Result = %h", ShifterResult);


        // =====================================
        // TEST 11: Sh khong ho tro (default)
        // =====================================
        RD2   = 32'h12345678;
        Shamt = 5'd5;
        Sh    = 2'b10;

        #10;

        if (ShifterResult == 32'h12345678)
            $display("TEST 11 PASS");
        else
            $display("TEST 11 FAIL: Result = %h", ShifterResult);


        // =====================================
        // TEST 12: Sh khong ho tro (default)
        // =====================================
        RD2   = 32'hABCDEF12;
        Shamt = 5'd10;
        Sh    = 2'b11;

        #10;

        if (ShifterResult == 32'hABCDEF12)
            $display("TEST 12 PASS");
        else
            $display("TEST 12 FAIL: Result = %h", ShifterResult);


        // =====================================
        // KET THUC TEST
        // =====================================
        $display("--------------------------------");
        $display("SHIFTER TEST COMPLETED");
        $finish;

    end

endmodule