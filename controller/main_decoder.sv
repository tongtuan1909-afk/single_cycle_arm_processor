module main_decoder(

    // CAC NGO VAO

    // Truong Op cua lenh ARM
    input logic [1:0] Op,

    // Bit Funct[5]: phan biet Immediate va Register
    input logic Funct5,

    // Bit Funct[0]: phan biet LDR va STR
    input logic Funct0,

    // CAC NGO RA

    output logic Branch,
    output logic MemtoReg,
    output logic MemW,
    output logic ALUSrc,

    // Chon kieu mo rong Immediate
    output logic [1:0] ImmSrc,

    // Cho phep ghi Register File
    output logic RegW,

    // Chon dia chi doc Register File
    output logic [1:0] RegSrc,

    // Tin hieu bao cho ALU Decoder
    output logic ALUOp

);


    // =====================================
    // GIAI MA LENH
    // =====================================

    always_comb begin

        // Gia tri mac dinh
        Branch   = 1'b0;
        MemtoReg = 1'b0;
        MemW     = 1'b0;
        ALUSrc   = 1'b0;

        ImmSrc   = 2'b00;
        RegW     = 1'b0;
        RegSrc   = 2'b00;

        ALUOp    = 1'b0;


        case (Op)

            // =================================
            // 00: DATA PROCESSING
            // =================================

            2'b00: begin

                // Funct5 = 0: DP Register
                if (Funct5 == 1'b0) begin

                    ALUSrc = 1'b0;
                    RegW   = 1'b1;
                    RegSrc = 2'b00;
                    ALUOp  = 1'b1;

                end

                // Funct5 = 1: DP Immediate
                else begin

                    ALUSrc = 1'b1;
                    ImmSrc = 2'b00;
                    RegW   = 1'b1;
                    RegSrc = 2'b00;
                    ALUOp  = 1'b1;

                end

            end


            // =================================
            // 01: LOAD / STORE
            // =================================

            2'b01: begin

                // Funct0 = 0: STR
                if (Funct0 == 1'b0) begin

                    MemW   = 1'b1;
                    ALUSrc = 1'b1;
                    ImmSrc = 2'b01;
                    RegW   = 1'b0;
                    RegSrc = 2'b10;
                    ALUOp  = 1'b0;

                end

                // Funct0 = 1: LDR
                else begin

                    MemtoReg = 1'b1;
                    MemW     = 1'b0;
                    ALUSrc   = 1'b1;
                    ImmSrc   = 2'b01;
                    RegW     = 1'b1;
                    RegSrc   = 2'b00;
                    ALUOp    = 1'b0;

                end

            end


            // =================================
            // 10: BRANCH
            // =================================

            2'b10: begin

                Branch = 1'b1;
                ALUSrc = 1'b1;
                ImmSrc = 2'b10;
                RegW   = 1'b0;
                RegSrc = 2'b01;
                ALUOp  = 1'b0;

            end


            // =================================
            // 11: KHONG HO TRO
            // =================================

            2'b11: begin

                // Giu cac gia tri mac dinh

            end


            // Truong hop mac dinh
            default: begin

                // Giu cac gia tri mac dinh

            end

        endcase

    end

endmodule
