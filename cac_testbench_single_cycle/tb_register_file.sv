module tb_register_file;

    // 1. Khai bao cac tin hieu
    logic clk;
    logic WE3;

    logic [3:0] A1, A2, A3;

    logic [31:0] WD3;
    logic [31:0] PCPlus8;

    logic [31:0] RD1, RD2;

    // 2. Ket noi module Register File
    register_file uut (
        .clk(clk),
        .WE3(WE3),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .WD3(WD3),
        .PCPlus8(PCPlus8),
        .RD1(RD1),
        .RD2(RD2)
    );

    // 3. Tao xung clock
    // Chu ky clock = 10ns
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // 4. Kiem tra hoat dong Register File
    initial begin

        // Khoi tao cac tin hieu
        WE3 = 0;
        A1 = 0;
        A2 = 0;
        A3 = 0;
        WD3 = 32'b0;
        PCPlus8 = 32'b0;

        // Test 1: Ghi gia tri vao R1
        @(negedge clk);
        WE3 = 1;
        A3 = 4'd1;
        WD3 = 32'h12345678;

        @(posedge clk);
        #1;

        // Doc R1
        A1 = 4'd1;
        #1;

        if (RD1 == 32'h12345678)
            $display("TEST 1 PASS: Write and Read R1");
        else
            $display("TEST 1 FAIL: RD1 = %h", RD1);


        // Test 2: Ghi gia tri vao R2
        @(negedge clk);
        A3 = 4'd2;
        WD3 = 32'hABCDEF12;

        @(posedge clk);
        #1;

        // Doc dong thoi R1 va R2
        A1 = 4'd1;
        A2 = 4'd2;
        #1;

        if (RD1 == 32'h12345678 && RD2 == 32'hABCDEF12)
            $display("TEST 2 PASS: Read R1 and R2 simultaneously");
        else
            $display("TEST 2 FAIL: RD1 = %h, RD2 = %h", RD1, RD2);


        // Test 3: WE3 = 0, khong cho phep ghi
        @(negedge clk);
        WE3 = 0;
        A3 = 4'd1;
        WD3 = 32'hFFFFFFFF;

        @(posedge clk);
        #1;

        A1 = 4'd1;
        #1;

        if (RD1 == 32'h12345678)
            $display("TEST 3 PASS: WE3 = 0, register unchanged");
        else
            $display("TEST 3 FAIL: RD1 = %h", RD1);


        // Test 4: Khong cho ghi vao R15
        @(negedge clk);
        WE3 = 1;
        A3 = 4'd15;
        WD3 = 32'hFFFFFFFF;

        @(posedge clk);
        #1;

        // Doc R15, gia tri phai la PCPlus8
        A1 = 4'd15;
        PCPlus8 = 32'h00000080;
        #1;

        if (RD1 == 32'h00000080)
            $display("TEST 4 PASS: R15 returns PCPlus8");
        else
            $display("TEST 4 FAIL: RD1 = %h", RD1);


        // Test 5: Kiem tra cong doc thu hai voi R15
        A2 = 4'd15;
        PCPlus8 = 32'h00000100;
        #1;

        if (RD2 == 32'h00000100)
            $display("TEST 5 PASS: RD2 returns PCPlus8");
        else
            $display("TEST 5 FAIL: RD2 = %h", RD2);


        // Test 6: Ghi lai R1 voi gia tri moi
        @(negedge clk);
        WE3 = 1;
        A3 = 4'd1;
        WD3 = 32'h87654321;

        @(posedge clk);
        #1;

        A1 = 4'd1;
        #1;

        if (RD1 == 32'h87654321)
            $display("TEST 6 PASS: Overwrite R1");
        else
            $display("TEST 6 FAIL: RD1 = %h", RD1);


        // Test 7: Ghi R3 khi WE3 = 1
        @(negedge clk);
        A3 = 4'd3;
        WD3 = 32'h5555AAAA;

        @(posedge clk);
        #1;

        A1 = 4'd3;
        #1;

        if (RD1 == 32'h5555AAAA)
            $display("TEST 7 PASS: Write and Read R3");
        else
            $display("TEST 7 FAIL: RD1 = %h", RD1);


        // Ket thuc Testbench
        $display("----------------------------------");
        $display("FINISH TESTBENCH REGISTER FILE");
        $display("----------------------------------");

        $finish;
    end

endmodule