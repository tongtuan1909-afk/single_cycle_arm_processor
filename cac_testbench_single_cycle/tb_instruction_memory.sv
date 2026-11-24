module tb_instruction_memory;

    // 1. Khai bao cac tin hieu
    logic [31:0] A;
    logic [31:0] RD;

    // 2. Ket noi module Instruction Memory
    instruction_memory uut (
        .A(A),
        .RD(RD)
    );

    // 3. Kiem tra hoat dong Instruction Memory
    initial begin

        // Khoi tao dia chi
        A = 32'b0;

        // Gan du lieu mau vao ROM de kiem tra
        uut.ROM[0]   = 32'hE3A00001;
        uut.ROM[1]   = 32'hE3A01002;
        uut.ROM[2]   = 32'hE3A02003;
        uut.ROM[3]   = 32'hE3A03004;
        uut.ROM[255] = 32'hE3A0F00F;

        // Test 1: Doc lenh tai dia chi 0
        A = 32'd0;
        #10;

        if (RD == 32'hE3A00001)
            $display("TEST 1 PASS: Read ROM[0]");
        else
            $display("TEST 1 FAIL: RD = %h", RD);

        // Test 2: Doc lenh tai dia chi 4
        A = 32'd4;
        #10;

        if (RD == 32'hE3A01002)
            $display("TEST 2 PASS: Read ROM[1]");
        else
            $display("TEST 2 FAIL: RD = %h", RD);

        // Test 3: Doc lenh tai dia chi 8
        A = 32'd8;
        #10;

        if (RD == 32'hE3A02003)
            $display("TEST 3 PASS: Read ROM[2]");
        else
            $display("TEST 3 FAIL: RD = %h", RD);

        // Test 4: Doc lenh tai dia chi 12
        A = 32'd12;
        #10;

        if (RD == 32'hE3A03004)
            $display("TEST 4 PASS: Read ROM[3]");
        else
            $display("TEST 4 FAIL: RD = %h", RD);

        // Test 5: Dia chi khong can chinh 4 byte
        A = 32'd1;
        #10;

        if (RD == 32'b0)
            $display("TEST 5 PASS: Misaligned address 1");
        else
            $display("TEST 5 FAIL: RD = %h", RD);

        // Test 6: Dia chi khong can chinh 4 byte
        A = 32'd2;
        #10;

        if (RD == 32'b0)
            $display("TEST 6 PASS: Misaligned address 2");
        else
            $display("TEST 6 FAIL: RD = %h", RD);

        // Test 7: Dia chi khong can chinh 4 byte
        A = 32'd3;
        #10;

        if (RD == 32'b0)
            $display("TEST 7 PASS: Misaligned address 3");
        else
            $display("TEST 7 FAIL: RD = %h", RD);

        // Test 8: Dia chi 5 khong can chinh 4 byte
        A = 32'd5;
        #10;

        if (RD == 32'b0)
            $display("TEST 8 PASS: Misaligned address 5");
        else
            $display("TEST 8 FAIL: RD = %h", RD);

        // Test 9: Doc lenh tai dia chi cuoi ROM
        A = 32'd1020;   // 255 * 4
        #10;

        if (RD == 32'hE3A0F00F)
            $display("TEST 9 PASS: Read ROM[255]");
        else
            $display("TEST 9 FAIL: RD = %h", RD);

        // Ket thuc Testbench
        $display("----------------------------------");
        $display("FINISH TESTBENCH INSTRUCTION MEMORY");
        $display("----------------------------------");

        $finish;
    end

endmodule