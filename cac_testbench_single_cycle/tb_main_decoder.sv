module tb_main_decoder;

    // ==============================
    // Cac tin hieu dau vao
    // ==============================
    logic [1:0] Op;
    logic Funct5;
    logic Funct0;

    // ==============================
    // Cac tin hieu dau ra
    // ==============================
    logic Branch;
    logic MemtoReg;
    logic MemW;
    logic ALUSrc;
    logic [1:0] ImmSrc;
    logic RegW;
    logic [1:0] RegSrc;
    logic ALUOp;

    // ==============================
    // Ket noi module main_decoder
    // ==============================
    main_decoder dut(
        .Op(Op),
        .Funct5(Funct5),
        .Funct0(Funct0),

        .Branch(Branch),
        .MemtoReg(MemtoReg),
        .MemW(MemW),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .RegW(RegW),
        .RegSrc(RegSrc),
        .ALUOp(ALUOp)
    );

    // ==============================
    // Kiem tra ket qua
    // ==============================
    task check_outputs(
        input logic EBranch,
        input logic EMemtoReg,
        input logic EMemW,
        input logic EALUSrc,
        input logic [1:0] EImmSrc,
        input logic ERegW,
        input logic [1:0] ERegSrc,
        input logic EALUOp
    );
    begin

        if ({Branch, MemtoReg, MemW, ALUSrc,
             ImmSrc, RegW, RegSrc, ALUOp}
            ==
            {EBranch, EMemtoReg, EMemW, EALUSrc,
             EImmSrc, ERegW, ERegSrc, EALUOp})

            $display("PASS");

        else
            $display("FAIL");

    end
    endtask

    // ==============================
    // Bat dau kiem tra
    // ==============================
    initial begin

        // Test 1: ADD Register
        Op = 2'b00;
        Funct5 = 1'b0;
        Funct0 = 1'b0;
        #10;
        check_outputs(0,0,0,0,2'b00,1,2'b00,1);

        // Test 2: ADD Immediate
        Op = 2'b00;
        Funct5 = 1'b1;
        Funct0 = 1'b0;
        #10;
        check_outputs(0,0,0,1,2'b00,1,2'b00,1);

        // Test 3: STR
        Op = 2'b01;
        Funct5 = 1'b0;
        Funct0 = 1'b0;
        #10;
        check_outputs(0,0,1,1,2'b01,0,2'b10,0);

        // Test 4: LDR
        Op = 2'b01;
        Funct5 = 1'b0;
        Funct0 = 1'b1;
        #10;
        check_outputs(0,1,0,1,2'b01,1,2'b00,0);

        // Test 5: Branch
        Op = 2'b10;
        Funct5 = 1'b0;
        Funct0 = 1'b0;
        #10;
        check_outputs(1,0,0,1,2'b10,0,2'b01,0);

        // Test 6: Unsupported instruction
        Op = 2'b11;
        Funct5 = 1'b0;
        Funct0 = 1'b0;
        #10;
        check_outputs(0,0,0,0,2'b00,0,2'b00,0);

        $finish;

    end

endmodule