module controller(

    // =====================================
    // CAC NGO VAO
    // =====================================

    input logic clk,
    input logic reset,

    // Lenh 32 bit tu Instruction Memory
    input logic [31:0] Instr,

    // Cac co trang thai tu ALU: {N,Z,C,V}
    input logic [3:0] ALUFlags,


    // =====================================
    // CAC NGO RA DATAPATH
    // =====================================

    output logic PCSrc,

    output logic [1:0] RegSrc,
    output logic RegWrite,

    output logic [1:0] ImmSrc,

    output logic ALUSrc,

    output logic [2:0] ALUControl,

    output logic MemWrite,
    output logic MemtoReg

);


    // =====================================
    // CAC TIN HIEU NOI BO
    // =====================================

    logic RegW;
    logic MemW;
    logic [1:0] FlagW;
    logic NoWrite;
    logic PCS;
    logic RegW_Final;


    // =====================================
    // 1. DECODER
    // =====================================

    decoder Decoder(

        .Instr(Instr),

        .Branch(),
        .MemtoReg(MemtoReg),
        .MemW(MemW),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),

        .RegW(RegW),
        .RegSrc(RegSrc),

        .ALUControl(ALUControl),
        .FlagW(FlagW),

        .PCS(PCS),
        .NoWrite(NoWrite)

    );


    // =====================================
    // 2. XU LY QUYEN GHI REGISTER FILE
    // =====================================

    // NoWrite = 1: Khong cho phep ghi thanh ghi
    // Vi du: lenh CMP
    assign RegW_Final = RegW & ~NoWrite;


    // =====================================
    // 3. CONDITIONAL LOGIC
    // =====================================

    conditional_logic ConditionalLogic(

        .clk(clk),
        .reset(reset),

        .Cond(Instr[31:28]),

        // Dua 4 co tu ALU vao Conditional Logic
        .ALUFlags(ALUFlags),

        // Dua 2 bit FlagW de dieu khien viec luu co
        .FlagW(FlagW),

        .PCS(PCS),
        .RegW(RegW_Final),
        .MemW(MemW),

        .PCSrc(PCSrc),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite)

    );

endmodule


