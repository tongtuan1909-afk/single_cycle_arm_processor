module mux #(

    // Do rong du lieu mac dinh la 32 bit
    parameter int WIDTH = 32

)(

    // Hai ngo vao du lieu
    input logic [WIDTH-1:0] In0,
    input logic [WIDTH-1:0] In1,

    // Tin hieu dieu khien lua chon
    input logic Sel,

    // Ngo ra
    output logic [WIDTH-1:0] Out

);

    // Neu Sel = 0 thi chon In0
    // Neu Sel = 1 thi chon In1
    always_comb begin
        if (Sel == 1'b0)
            Out = In0;
        else
            Out = In1;

    end

endmodule
