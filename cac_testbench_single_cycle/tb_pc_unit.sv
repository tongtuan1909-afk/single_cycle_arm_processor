module tb_pc_unit;

    logic clk;
    logic reset;
    logic PCSrc;
    logic [31:0] Result;

    logic [31:0] PC;
    logic [31:0] PCPlus4;
    logic [31:0] PCPlus8;

    pc_unit uut (
        .clk(clk),
        .reset(reset),
        .PCSrc(PCSrc),
        .Result(Result),
        .PC(PC),
        .PCPlus4(PCPlus4),
        .PCPlus8(PCPlus8)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        // Khoi tao cac tin hieu
        reset = 1;
        PCSrc = 0;
        Result = 32'b0;

        // Test 1: Reset PC ve 0
        @(posedge clk);
        #1;

        if (PC == 0)
            $display("TEST 1 PASS: Reset PC = 0");
        else
            $display("TEST 1 FAIL: PC = %d", PC);


        // Bo reset
        @(negedge clk);
        reset = 0;


        // Test 2: PC tang tu 0 len 4
        @(posedge clk);
        #1;

        if (PC == 4)
            $display("TEST 2 PASS: PC = 4");
        else
            $display("TEST 2 FAIL: PC = %d", PC);


        // Test 3: PC tang tu 4 len 8
        @(posedge clk);
        #1;

        if (PC == 8)
            $display("TEST 3 PASS: PC = 8");
        else
            $display("TEST 3 FAIL: PC = %d", PC);


        // Test 4: Kiem tra PCPlus4 va PCPlus8
        if (PCPlus4 == 12 && PCPlus8 == 16)
            $display("TEST 4 PASS: PCPlus4 = 12, PCPlus8 = 16");
        else
            $display("TEST 4 FAIL: PCPlus4 = %d, PCPlus8 = %d",
                      PCPlus4, PCPlus8);


        // Test 5: PCSrc = 1, PC nhan Result
        @(negedge clk);
        PCSrc = 1;
        Result = 32'd100;

        @(posedge clk);
        #1;

        if (PC == 100)
            $display("TEST 5 PASS: PC nhan Result = 100");
        else
            $display("TEST 5 FAIL: PC = %d", PC);


        // Test 6: PCSrc = 0, PC tiep tuc PC + 4
        @(negedge clk);
        PCSrc = 0;

        @(posedge clk);
        #1;

        if (PC == 104)
            $display("TEST 6 PASS: PC = 104");
        else
            $display("TEST 6 FAIL: PC = %d", PC);


        // Test 7: Reset lai khi PC dang khac 0
        @(negedge clk);
        reset = 1;

        @(posedge clk);
        #1;

        if (PC == 0)
            $display("TEST 7 PASS: Reset lai PC = 0");
        else
            $display("TEST 7 FAIL: PC = %d", PC);


        // Ket thuc mo phong
        $display("--------------------------------");
        $display("FINISH TESTBENCH PC UNIT");
        $display("--------------------------------");

        $finish;

    end

endmodule