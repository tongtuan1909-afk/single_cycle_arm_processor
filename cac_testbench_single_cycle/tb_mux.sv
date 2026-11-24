module tb_mux;

    // Khai bao tin hieu
    logic [31:0] In0;
    logic [31:0] In1;
    logic Sel;
    logic [31:0] Out;

    // Ket noi DUT
    mux uut(
        .In0(In0),
        .In1(In1),
        .Sel(Sel),
        .Out(Out)
    );

    // Test
    initial begin

        // Test 1: Sel = 0, chon In0
        In0 = 32'd10;
        In1 = 32'd20;
        Sel = 0;

        #10;

        if (Out == 32'd10)
            $display("PASS");
        else
            $display("FAIL");


        // Test 2: Sel = 1, chon In1
        In0 = 32'd10;
        In1 = 32'd20;
        Sel = 1;

        #10;

        if (Out == 32'd20)
            $display("PASS");
        else
            $display("FAIL");


        // Test 3: Sel = 0, du lieu khac
        In0 = 32'd100;
        In1 = 32'd200;
        Sel = 0;

        #10;

        if (Out == 32'd100)
            $display("PASS");
        else
            $display("FAIL");


        // Test 4: Sel = 1, du lieu khac
        In0 = 32'd100;
        In1 = 32'd200;
        Sel = 1;

        #10;

        if (Out == 32'd200)
            $display("PASS");
        else
            $display("FAIL");


        // Test 5: Kiem tra gia tri 0 va FFFFFFFF
        In0 = 32'h00000000;
        In1 = 32'hFFFFFFFF;
        Sel = 0;

        #10;

        if (Out == 32'h00000000)
            $display("PASS");
        else
            $display("FAIL");


        // Test 6: Chon In1 = FFFFFFFF
        Sel = 1;

        #10;

        if (Out == 32'hFFFFFFFF)
            $display("PASS");
        else
            $display("FAIL");


        $finish;

    end

endmodule