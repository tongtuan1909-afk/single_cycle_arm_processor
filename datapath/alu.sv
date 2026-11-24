module alu(

    // =====================================
    // CAC NGO VAO
    // =====================================

    input logic [31:0] SrcA,
    input logic [31:0] SrcB,
    input logic [2:0] ALUControl,

    // =====================================
    // CAC NGO RA
    // =====================================

    output logic [31:0] ALUResult,
    output logic [3:0] ALUFlags

);

    // Bien trung gian 33 bit
    logic [32:0] Sum;
    logic [32:0] Sub;

    // Cac co trang thai
    logic N;
    logic Z;
    logic C;
    logic V;


    always_comb begin

        // Gia tri mac dinh
        Sum = 33'b0;
        Sub = 33'b0;

        ALUResult = 32'b0;

        N = 1'b0;
        Z = 1'b0;
        C = 1'b0;
        V = 1'b0;


        case (ALUControl)

            // 000: AND
            3'b000: begin
                ALUResult = SrcA & SrcB;
            end

            // 001: ORR
            3'b001: begin
                ALUResult = SrcA | SrcB;
            end

            // 010: ADD
            3'b010: begin

                // Cong 33 bit de lay bit nho
                Sum = {1'b0, SrcA} + {1'b0, SrcB};

                // Lay 32 bit ket qua
                ALUResult = Sum[31:0];

                // C = bit nho thu 33
                C = Sum[32];

                // V = 1 khi hai so cung dau
                // nhung ket qua lai khac dau
                V = (~(SrcA[31] ^ SrcB[31]))
                    & (SrcA[31] ^ ALUResult[31]);

            end

            // 011: SUB
            3'b011: begin

                // Tru 33 bit
                Sub = {1'b0, SrcA} - {1'b0, SrcB};

                // Lay 32 bit ket qua
                ALUResult = Sub[31:0];

                // C = 1 neu khong co muon
                C = ~Sub[32];

                // V = 1 khi hai so khac dau
                // va ket qua khac dau SrcA
                V = (SrcA[31] ^ SrcB[31])
                    & (SrcA[31] ^ ALUResult[31]);

            end

            // 100: XOR
            3'b100: begin
                ALUResult = SrcA ^ SrcB;
            end

            // 101: BIC
            3'b101: begin
                ALUResult = SrcA & (~SrcB);
            end

            // 110: MOV
            3'b110: begin
                ALUResult = SrcB;
            end

            // 111: CMP
            3'b111: begin

                // CMP thuc hien phep tru SrcA - SrcB
                Sub = {1'b0, SrcA} - {1'b0, SrcB};

                ALUResult = Sub[31:0];

                // Cap nhat Carry
                C = ~Sub[32];

                // Cap nhat Overflow
                V = (SrcA[31] ^ SrcB[31])
                    & (SrcA[31] ^ ALUResult[31]);

            end

            default: begin
                ALUResult = 32'b0;
            end

        endcase


        // =====================================
        // CAP NHAT CAC CO TRANG THAI
        // =====================================

        // N = bit dau cua ket qua
        N = ALUResult[31];

        // Z = 1 neu ket qua bang 0
        Z = (ALUResult == 32'b0);

        // Thu tu cac co: N, Z, C, V
        ALUFlags = {N, Z, C, V};

    end

endmodule

