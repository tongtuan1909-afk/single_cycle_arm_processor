module pc_unit(
    input  logic        clk,
    input  logic        reset,
    // Tin hieu dieu khien MUX PC
    input  logic        PCSrc,
    // Du lieu tu MUX Write Back
    input  logic [31:0] Result,
    output logic [31:0] PC,
    output logic [31:0] PCPlus4,
    output logic [31:0] PCPlus8
);
    // Tao dia chi PC + 4
    assign PCPlus4 = PC + 32'd4;
    // Tao dia chi PC + 8
    assign PCPlus8 = PC + 32'd8;
    // Cap nhat PC tai canh len cua clock
    always_ff @(posedge clk) begin
        // Reset PC ve 0
        if (reset)
            PC <= 32'b0;
        // PCSrc = 1: Chon Result
        else if (PCSrc)
            PC <= Result;
        // PCSrc = 0: Chon PCPlus4
        else
            PC <= PCPlus4;

    end

endmodule

