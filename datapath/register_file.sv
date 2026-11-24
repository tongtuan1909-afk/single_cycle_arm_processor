module register_file(
    input  logic        clk,
    // Tin hieu cho phep ghi
    input  logic        WE3,
    // Dia chi hai cong doc
    input  logic [3:0]  A1,
    input  logic [3:0]  A2,
    // Dia chi cong ghi
    input  logic [3:0]  A3,
    // Du lieu ghi
    input  logic [31:0] WD3,
    // Gia tri PC + 8
    input  logic [31:0] PCPlus8,
    // Du lieu doc
    output logic [31:0] RD1,
    output logic [31:0] RD2
);

    // Tao 15 thanh ghi tu R0 den R14
    // Moi thanh ghi co 32 bit
    logic [31:0] rf [0:14];

    always_ff @(posedge clk) begin

        // Chi ghi khi WE3 = 1
        // Khong ghi vao R15
        if (WE3 && (A3 != 4'd15)) begin

            rf[A3] <= WD3;

        end

    end

    always_comb begin

        // Neu doc R15 thi tra ve PC + 8
        if (A1 == 4'd15) begin

            RD1 = PCPlus8;

        end

        // Neu khong thi doc tu mang thanh ghi
        else begin

            RD1 = rf[A1];

        end

    end

    always_comb begin

        // Neu doc R15 thi tra ve PC + 8
        if (A2 == 4'd15) begin

            RD2 = PCPlus8;
				
        end

        // Neu khong thi doc tu mang thanh ghi
        else begin

            RD2 = rf[A2];

        end

    end

endmodule
