module shifter(

    // Du lieu dau vao lay tu Register File
    input logic [31:0] RD2,

    // So bit can dich
    input logic [4:0] Shamt,

    // Ma lua chon phep dich
    input logic [1:0] Sh,

    // Ket qua sau khi dich
    output logic [31:0] ShifterResult

);

    // =====================================
    // THUC HIEN CAC PHEP DICH
    // =====================================

    always_comb begin

        // Gia tri mac dinh
        ShifterResult = RD2;

        case (Sh)

            // ---------------------------------
            // 00: LSL - DICH TRAI LOGIC
            // ---------------------------------
            2'b00: begin
                ShifterResult = RD2 << Shamt;
            end

            // ---------------------------------
            // 01: LSR - DICH PHAI LOGIC
            // ---------------------------------
            2'b01: begin

                if (Shamt == 5'd0)
                    ShifterResult = 32'b0;
                else
                    ShifterResult = RD2 >> Shamt;

            end

            // ---------------------------------
            // CAC TRUONG HOP KHONG HO TRO
            // ---------------------------------
            default: begin
                ShifterResult = RD2;
            end

        endcase

    end

endmodule

