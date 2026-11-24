module instruction_memory(
    // Dia chi doc lenh tu PC
    input  logic [31:0] A,
    // Lenh 32 bit doc duoc
    output logic [31:0] RD

);
   // khai báo bộ nhớ ROM 256ptu, mỗi ptu có 32 bit
    logic [31:0] ROM [0:255];
    always_comb begin
        // Kiem tra dia chi co chia het cho 4 hay khong
        if (A[1:0] == 2'b00)
            // Doc lenh tu vi tri tuong ung trong ROM
            RD = ROM[A[9:2]];
        // Neu dia chi khong can chinh 4 byte
        else
            RD = 32'b0;

    end

endmodule
