module tb_extend;

    // 1. Khai bao cac tin hieu
    logic [31:0] Instr;
    logic [1:0] ImmSrc;
    logic [31:0] ExtImm;

    // 2. Ket noi module Extend
    extend uut (
        .Instr(Instr),
        .ImmSrc(ImmSrc),
        .ExtImm(ExtImm)
    );

    // 3. Kiem tra hoat dong Extend
    initial begin

        // Khoi tao
        Instr = 32'b0;
        ImmSrc = 2'b00;

        // Test 1: Data Processing Immediate, khong xoay
        Instr = 32'h00000012;
        ImmSrc = 2'b00;
        #10;

        if (ExtImm == 32'h00000012)
            $display("TEST 1 PASS: Immediate without rotation");
        else
            $display("TEST 1 FAIL: ExtImm = %h", ExtImm);


        // Test 2: Data Processing Immediate, xoay phai 2 bit
        Instr = 32'h00001112;
        ImmSrc = 2'b00;
        #10;

        if (ExtImm == 32'h80000004)
            $display("TEST 2 PASS: ROR 2 bits");
        else
            $display("TEST 2 FAIL: ExtImm = %h", ExtImm);


        // Test 3: LDR/STR Immediate 12-bit
        Instr = 32'h00000123;
        ImmSrc = 2'b01;
        #10;

        if (ExtImm == 32'h00000123)
            $display("TEST 3 PASS: LDR/STR Immediate");
        else
            $display("TEST 3 FAIL: ExtImm = %h", ExtImm);


        // Test 4: Branch offset duong
        Instr = 32'h00000003;
        ImmSrc = 2'b10;
        #10;

        if (ExtImm == 32'h0000000C)
            $display("TEST 4 PASS: Branch positive offset");
        else
            $display("TEST 4 FAIL: ExtImm = %h", ExtImm);


        // Test 5: Branch offset am (-3)
        Instr = 32'h00FFFFFD;
        ImmSrc = 2'b10;
        #10;

        if (ExtImm == 32'hFFFFFFF4)
            $display("TEST 5 PASS: Branch negative offset");
        else
            $display("TEST 5 FAIL: ExtImm = %h", ExtImm);


        // Ket thuc Testbench
        $display("--------------------------------");
        $display("FINISH TESTBENCH EXTEND");
        $display("--------------------------------");

        $finish;
    end

endmodule