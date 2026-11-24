
module decoder(

    // =====================================
    // DAU VAO
    // =====================================

    // Ma lenh ARM, chua toan bo du lieu 32 bit
    input logic [31:0] Instr,


    // =====================================
    // DAU RA DIEU KHIEN DATAPATH
    // =====================================

    output logic Branch,
    output logic MemtoReg,
    output logic MemW,
    output logic ALUSrc,

    output logic [1:0] ImmSrc,
    output logic RegW,
    output logic [1:0] RegSrc,

    // Ma dieu khien ALU 3 bit
    output logic [2:0] ALUControl,

    // Dieu khien cap nhat co trang thai
    output logic [1:0] FlagW,

    // Khong ghi thanh ghi khi CMP
    output logic NoWrite,

    // Tin hieu bao PC can duoc cap nhat
    output logic PCS
);


    // =====================================
    // CAC TIN HIEU NOI BO
    // =====================================

    logic ALUOp;

    // Tin hieu cho phep ghi thanh ghi sau khi xu ly NoWrite
    logic RegW_Final;


    // =====================================
    // 1. MAIN DECODER
    // =====================================

    main_decoder Main_Decoder(

        .Op(Instr[27:26]),

        // Bit I trong lenh Data Processing
        .Funct5(Instr[25]),

        // Bit L trong lenh Load/Store
        .Funct0(Instr[20]),

        .Branch(Branch),
        .MemtoReg(MemtoReg),
        .MemW(MemW),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .RegW(RegW),
        .RegSrc(RegSrc),
        .ALUOp(ALUOp)

    );


    // =====================================
    // 2. ALU DECODER
    // =====================================

    alu_decoder ALU_Decoder(

        .ALUOp(ALUOp),

        // Ma phep toan
        .Funct(Instr[24:21]),

        // Bit S
        .S(Instr[20]),

        .ALUControl(ALUControl),

        .FlagW(FlagW),

        .NoWrite(NoWrite)

    );


    // =====================================
    // 3. XU LY TIN HIEU GHI THANH GHI
    // =====================================

    // Neu NoWrite = 1:
    // Khong cho phep ghi Register File
    //
    // Neu NoWrite = 0:
    // RegW_Final = RegW

    assign RegW_Final = RegW & ~NoWrite;


    // =====================================
    // 4. PC LOGIC
    // =====================================

    pc_logic PC_Logic(

        .Rd(Instr[15:12]),

        // Su dung RegW_Final thay vi RegW
        .RegW_Final(RegW_Final),

        .Branch(Branch),

        .PCS(PCS)

    );


endmodule

