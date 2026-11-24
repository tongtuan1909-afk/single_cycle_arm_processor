module tb_pc_logic;

    // Inputs
    logic [3:0] Rd;
    logic RegW_Final;
    logic Branch;

    // Output
    logic PCS;

    // Ket noi DUT
    pc_logic dut(
        .Rd(Rd),
        .RegW_Final(RegW_Final),
        .Branch(Branch),
        .PCS(PCS)
    );

    initial begin

        // Test 1: Ghi vao R15
        Rd = 4'd15;
        RegW_Final = 1'b1;
        Branch = 1'b0;
        #10;
        if (PCS == 1'b1) $display("PASS");
        else $display("FAIL");

        // Test 2: Rd = 15 nhung khong ghi
        Rd = 4'd15;
        RegW_Final = 1'b0;
        Branch = 1'b0;
        #10;
        if (PCS == 1'b0) $display("PASS");
        else $display("FAIL");

        // Test 3: Branch = 1
        Rd = 4'd1;
        RegW_Final = 1'b0;
        Branch = 1'b1;
        #10;
        if (PCS == 1'b1) $display("PASS");
        else $display("FAIL");

        // Test 4: Rd = 15 va Branch = 1
        Rd = 4'd15;
        RegW_Final = 1'b1;
        Branch = 1'b1;
        #10;
        if (PCS == 1'b1) $display("PASS");
        else $display("FAIL");

        // Test 5: Khong cap nhat PC
        Rd = 4'd2;
        RegW_Final = 1'b1;
        Branch = 1'b0;
        #10;
        if (PCS == 1'b0) $display("PASS");
        else $display("FAIL");

        // Test 6: Rd = 15 nhung Branch = 0
        Rd = 4'd15;
        RegW_Final = 1'b0;
        Branch = 1'b0;
        #10;
        if (PCS == 1'b0) $display("PASS");
        else $display("FAIL");

        $finish;

    end

endmodule