module tb_conditional_logic;

    logic clk;
    logic reset;

    logic [3:0] Cond;
    logic [3:0] ALUFlags;
    logic [1:0] FlagW;

    logic PCS;
    logic RegW;
    logic MemW;

    logic PCSrc;
    logic RegWrite;
    logic MemWrite;

    // Goi module conditional_logic
    conditional_logic dut (
        .clk(clk),
        .reset(reset),
        .Cond(Cond),
        .ALUFlags(ALUFlags),
        .FlagW(FlagW),
        .PCS(PCS),
        .RegW(RegW),
        .MemW(MemW),
        .PCSrc(PCSrc),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite)
    );

    // Tao Clock
    initial clk = 0;
    always #5 clk = ~clk;

    integer errors = 0;

    // Kiem tra ket qua
    task check(
        input logic exp_PC,
        input logic exp_Reg,
        input logic exp_Mem
    );
    begin
        #1;

        if (PCSrc !== exp_PC ||
            RegWrite !== exp_Reg ||
            MemWrite !== exp_Mem)
            errors = errors + 1;
    end
    endtask

    initial begin

        // Khoi tao
        reset = 1;
        Cond = 4'b1110;       // AL
        ALUFlags = 4'b0000;
        FlagW = 2'b00;
        PCS = 0;
        RegW = 0;
        MemW = 0;

        #2;
        reset = 0;

        // Test 1: AL - Luon thoa man
        Cond = 4'b1110;
        PCS = 1;
        RegW = 1;
        MemW = 1;
        check(1, 1, 1);

        // Test 2: EQ - Z = 1
        Cond = 4'b0000;
        ALUFlags = 4'b0100;
        FlagW = 2'b11;
        @(posedge clk);
        #1;
        FlagW = 2'b00;
        check(1, 1, 1);

        // Test 3: NE - Z = 1 (khong thoa man)
        Cond = 4'b0001;
        check(0, 0, 0);

        // Test 4: CS - C = 1
        Cond = 4'b0010;
        ALUFlags = 4'b0010;
        FlagW = 2'b11;
        @(posedge clk);
        #1;
        FlagW = 2'b00;
        check(1, 1, 1);

        // Test 5: MI - N = 1
        Cond = 4'b0100;
        ALUFlags = 4'b1000;
        FlagW = 2'b11;
        @(posedge clk);
        #1;
        FlagW = 2'b00;
        check(1, 1, 1);

        // Test 6: VS - V = 1
        Cond = 4'b0110;
        ALUFlags = 4'b0001;
        FlagW = 2'b11;
        @(posedge clk);
        #1;
        FlagW = 2'b00;
        check(1, 1, 1);

        // Test 7: HI - C=1, Z=0
        Cond = 4'b1000;
        ALUFlags = 4'b0010;
        FlagW = 2'b11;
        @(posedge clk);
        #1;
        FlagW = 2'b00;
        check(1, 1, 1);

        // Test 8: GE - N=V
        Cond = 4'b1010;
        ALUFlags = 4'b0000;
        FlagW = 2'b11;
        @(posedge clk);
        #1;
        FlagW = 2'b00;
        check(1, 1, 1);

        // Test 9: GT - Z=0, N=V
        Cond = 4'b1100;
        check(1, 1, 1);

        // Test 10: NE - Z=0
        Cond = 4'b0001;
        check(1, 1, 1);

        // Test 11: NV - Luon khong thoa man
        Cond = 4'b1111;
        check(0, 0, 0);

        // Test 12: CondEx=1, cac tin hieu dieu khien bang 0
        Cond = 4'b1110;
        PCS = 0;
        RegW = 0;
        MemW = 0;
        check(0, 0, 0);

        // Test 13: CondEx=0, cac tin hieu dieu khien bang 1
        Cond = 4'b1111;
        PCS = 1;
        RegW = 1;
        MemW = 1;
        check(0, 0, 0);

        // Test 14: Reset Flags
        reset = 1;
        #2;
        reset = 0;
        Cond = 4'b0000;       // EQ
        check(0, 0, 0);       // Z=0 sau reset

        // Ket qua
        if (errors == 0)
            $display("PASS");
        else
            $display("FAIL");

        $finish;
    end

endmodule