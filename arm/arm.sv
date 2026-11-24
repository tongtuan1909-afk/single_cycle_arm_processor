module arm(

    // =====================================
    // CAC NGO VAO BEN NGOAI
    // =====================================

    input logic clk,
    input logic reset,


    // =====================================
    // CAC NGO RA DE QUAN SAT
    // =====================================

    output logic [31:0] PC,
    output logic [31:0] Instr,
    output logic [31:0] ALUResult,
    output logic [3:0] ALUFlags,
    output logic [31:0] Result

);


    // =====================================
    // 1. CAC DAY NOI NOI BO
    // =====================================

    // Tin hieu dieu khien PC
    logic PCSrc;

    // Tin hieu dieu khien Register File
    logic [1:0] RegSrc;
    logic RegWrite;

    // Tin hieu dieu khien Extend
    logic [1:0] ImmSrc;

    // Tin hieu dieu khien ALU
    logic ALUSrc;
    logic [2:0] ALUControl;

    // Tin hieu dieu khien Data Memory
    logic MemWrite;
    logic MemtoReg;


    // =====================================
    // 2. KET NOI DATAPATH
    // =====================================

    datapath Datapath(

        .clk(clk),
        .reset(reset),

        // Cac tin hieu dieu khien tu Controller
        .PCSrc(PCSrc),
        .RegSrc(RegSrc),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .ALUControl(ALUControl),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),

        // Cac tin hieu phan hoi
        .PC(PC),
        .Instr(Instr),
        .ALUResult(ALUResult),
        .ALUFlags(ALUFlags),
        .Result(Result)

    );


    // =====================================
    // 3. KET NOI CONTROLLER
    // =====================================

    controller Controller(

        .clk(clk),
        .reset(reset),

        // Lenh va co trang thai tu Datapath
        .Instr(Instr),
        .ALUFlags(ALUFlags),

        // Cac tin hieu dieu khien Datapath
        .PCSrc(PCSrc),
        .RegSrc(RegSrc),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .ALUControl(ALUControl),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg)

    );


endmodule
