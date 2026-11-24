module alu_decoder(

    // ALUOp nhan tu Main Decoder
    input logic ALUOp,

    // Ma phep toan trong lenh ARM: Instr[24:21]
    input logic [3:0] Funct,

    // Bit S trong lenh ARM: Instr[20]
    input logic S,

    // Ma dieu khien phep toan cua ALU
    output logic [2:0] ALUControl,

    // Dieu khien cap nhat cac co trang thai
    output logic [1:0] FlagW,

    // Khong cho phep ghi ket qua khi CMP
    output logic NoWrite
);

    always_comb begin

        // Gia tri mac dinh
        ALUControl = 3'b010;  // ADD
        FlagW       = 2'b00;  // Khong cap nhat co
        NoWrite     = 1'b0;   // Cho phep ghi thanh ghi


        // =====================================
        // 1. KHONG PHAI DATA PROCESSING
        // =====================================

        if (ALUOp == 1'b0) begin

            // LDR, STR, Branch su dung ADD
            ALUControl = 3'b010;

            FlagW = 2'b00;

            NoWrite = 1'b0;

        end


        // =====================================
        // 2. DATA PROCESSING
        // =====================================

        else begin

            case (Funct)

                // ---------------------------------
                // ADD
                // ---------------------------------
                4'b0100: begin

                    ALUControl = 3'b010;

                    // ADD va ADDS
                    if (S == 1'b1)
                        FlagW = 2'b11;

                end


                // ---------------------------------
                // SUB
                // ---------------------------------
                4'b0010: begin

                    ALUControl = 3'b011;

                    // SUB va SUBS
                    if (S == 1'b1)
                        FlagW = 2'b11;

                end


                // ---------------------------------
                // AND
                // ---------------------------------
                4'b0000: begin

                    ALUControl = 3'b000;

                    // ANDS chi cap nhat N va Z
                    if (S == 1'b1)
                        FlagW = 2'b10;

                end


                // ---------------------------------
                // ORR
                // ---------------------------------
                4'b1100: begin

                    ALUControl = 3'b001;

                    // ORRS chi cap nhat N va Z
                    if (S == 1'b1)
                        FlagW = 2'b10;

                end


                // ---------------------------------
                // CMP
                // ---------------------------------
                4'b1010: begin

                    if (S == 1'b1) begin

                        // CMP su dung phep tru rieng cua ALU
                        ALUControl = 3'b111;

                        // Cap nhat ca NZCV
                        FlagW = 2'b11;

                        // Khong ghi ket qua vao Register File
                        NoWrite = 1'b1;

                    end

                end


                // ---------------------------------
                // LENH KHONG HO TRO
                // ---------------------------------
                default: begin

                    ALUControl = 3'b010;
                    FlagW = 2'b00;
                    NoWrite = 1'b0;

                end

            endcase

        end

    end

endmodule
