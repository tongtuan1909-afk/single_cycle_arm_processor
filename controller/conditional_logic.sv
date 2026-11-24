module conditional_logic(

    input logic clk,
    input logic reset,

    // Ma dieu kien cua lenh ARM
    input logic [3:0] Cond,

    // Cac co trang thai tu ALU: {N,Z,C,V}
    input logic [3:0] ALUFlags,

    // Cho phep cap nhat cac co
    input logic [1:0] FlagW,

    // Cac tin hieu dieu khien
    input logic PCS,
    input logic RegW,
    input logic MemW,

    // Cac tin hieu dau ra
    output logic PCSrc,
    output logic RegWrite,
    output logic MemWrite

);

    // Thanh ghi luu 4 co trang thai
    logic [3:0] Flags;

    // Tin hieu cho biet dieu kien lenh co thoa man khong
    logic CondEx;


    // =====================================
    // 1. KIEM TRA DIEU KIEN LENH ARM
    // =====================================

    always_comb begin

        case (Cond)

            4'b0000: CondEx = Flags[2];                 // EQ
            4'b0001: CondEx = ~Flags[2];                // NE

            4'b0010: CondEx = Flags[1];                 // CS
            4'b0011: CondEx = ~Flags[1];                // CC

            4'b0100: CondEx = Flags[3];                 // MI
            4'b0101: CondEx = ~Flags[3];                // PL

            4'b0110: CondEx = Flags[0];                 // VS
            4'b0111: CondEx = ~Flags[0];                // VC

            4'b1000: CondEx = Flags[1] & ~Flags[2];     // HI
            4'b1001: CondEx = ~Flags[1] | Flags[2];     // LS

            4'b1010: CondEx = (Flags[3] == Flags[0]);   // GE
            4'b1011: CondEx = (Flags[3] != Flags[0]);   // LT

            4'b1100: CondEx = ~Flags[2] &
                              (Flags[3] == Flags[0]);  // GT

            4'b1101: CondEx = Flags[2] |
                              (Flags[3] != Flags[0]);  // LE

            4'b1110: CondEx = 1'b1;                     // AL
            4'b1111: CondEx = 1'b0;                     // NV

            default: CondEx = 1'b0;

        endcase

    end


    // =====================================
    // 2. CAP NHAT THANH GHI FLAGS
    // =====================================

    always_ff @(posedge clk or posedge reset) begin

        if (reset) begin

            Flags <= 4'b0000;

        end

        else if (CondEx) begin

            // Cap nhat N va Z
            if (FlagW[1])
                Flags[3:2] <= ALUFlags[3:2];

            // Cap nhat C va V
            if (FlagW[0])
                Flags[1:0] <= ALUFlags[1:0];

        end

    end


    // =====================================
    // 3. TAO CAC TIN HIEU DIEU KHIEN
    // =====================================

    always_comb begin

        PCSrc    = PCS & CondEx;
        RegWrite = RegW & CondEx;
        MemWrite = MemW & CondEx;

    end

endmodule




