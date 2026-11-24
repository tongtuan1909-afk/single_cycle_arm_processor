module tb_data_memory;

    logic CLK;
    logic WE;
    logic [31:0] A;
    logic [31:0] WD;
    logic [31:0] RD;

    // Ket noi module data_memory
    data_memory dut(
        .CLK(CLK),
        .WE(WE),
        .A(A),
        .WD(WD),
        .RD(RD)
    );

    // Tao clock
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end

    // Test
    initial begin

        WE = 0;
        A  = 0;
        WD = 0;

        // Test 1: Ghi va doc du lieu
        @(negedge CLK);
        A  = 32'd100;
        WD = 32'd25;
        WE = 1;

        @(posedge CLK);
        #1;

        if (RD == 32'd25)
            $display("PASS");
        else
            $display("FAIL");


        // Test 2: Ghi dia chi khac
        @(negedge CLK);
        A  = 32'd200;
        WD = 32'd50;
        WE = 1;

        @(posedge CLK);
        #1;

        if (RD == 32'd50)
            $display("PASS");
        else
            $display("FAIL");


        // Test 3: Doc lai du lieu cu
        @(negedge CLK);
        A  = 32'd100;
        WE = 0;

        #1;

        if (RD == 32'd25)
            $display("PASS");
        else
            $display("FAIL");


        // Test 4: WE = 0 khong ghi
        @(negedge CLK);
        A  = 32'd100;
        WD = 32'd99;
        WE = 0;

        @(posedge CLK);
        #1;

        if (RD == 32'd25)
            $display("PASS");
        else
            $display("FAIL");


        // Test 5: Ghi de du lieu
        @(negedge CLK);
        A  = 32'd100;
        WD = 32'd99;
        WE = 1;

        @(posedge CLK);
        #1;

        if (RD == 32'd99)
            $display("PASS");
        else
            $display("FAIL");


        // Test 6: Ghi va doc dia chi 104
        @(negedge CLK);
        A  = 32'd104;
        WD = 32'd123;
        WE = 1;

        @(posedge CLK);
        #1;

        if (RD == 32'd123)
            $display("PASS");
        else
            $display("FAIL");


        $finish;

    end

endmodule