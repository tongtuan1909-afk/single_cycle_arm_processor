module data_memory(

    // =====================================
    // CAC NGO VAO
    // =====================================

    // Xung clock
    input logic CLK,

    // Tin hieu cho phep ghi
    input logic WE,

    // Dia chi truy cap bo nho
    input logic [31:0] A,

    // Du lieu can ghi vao bo nho
    input logic [31:0] WD,

    // =====================================
    // NGO RA
    // =====================================

    // Du lieu doc tu bo nho
    output logic [31:0] RD

);

    // =====================================
    // KHAI BAO BO NHO
    // =====================================

    // Bo nho gom 256 o
    // Moi o co kich thuoc 32 bit
    logic [31:0] RAM [0:255];

    // =====================================
    // PHAN 1: DOC DU LIEU
    // =====================================

    // Doc du lieu theo dia chi A
    // Moi o nho chua 4 byte
    // A[9:2] dung de xac dinh vi tri o nho
    always_comb begin

        RD = RAM[A[9:2]];

    end

    // =====================================
    // PHAN 2: GHI DU LIEU
    // =====================================

    // Ghi du lieu tai canh len cua CLK
    always_ff @(posedge CLK) begin

        // Chi ghi khi WE = 1
        if (WE) begin

            RAM[A[9:2]] <= WD;

        end

    end

endmodule
