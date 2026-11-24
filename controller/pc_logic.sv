
module pc_logic(

    // Dia chi thanh ghi dich trong lenh ARM
    input logic [3:0] Rd,

    // Tin hieu cho phep ghi Register File
    // Da duoc xu ly NoWrite
    input logic RegW_Final,

    // Tin hieu nhan dien lenh Branch
    input logic Branch,

    // Tin hieu bao PC can duoc cap nhat
    output logic PCS
);

    // =====================================
    // XAC DINH CO CAN CAP NHAT PC HAY KHONG
    // =====================================

    always_comb begin

        // PCS = 1 neu:
        // 1. Lenh thuc su ghi vao R15
        // 2. Hoac lenh hien tai la Branch

        PCS = ((Rd == 4'd15) && RegW_Final) || Branch;

    end

endmodule
