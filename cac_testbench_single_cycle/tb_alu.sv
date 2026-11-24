module tb_alu;

    logic [31:0] SrcA;
    logic [31:0] SrcB;
    logic [2:0] ALUControl;

    logic [31:0] ALUResult;
    logic [3:0] ALUFlags;

    // Goi module ALU
    alu uut (
        .SrcA(SrcA),
        .SrcB(SrcB),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult),
        .ALUFlags(ALUFlags)
    );

    initial begin

        // =====================================
        // TEST 1: AND
        // =====================================
        SrcA = 32'h0000000F;
        SrcB = 32'h00000005;
        ALUControl = 3'b000;
        #10;

        if (ALUResult == 32'h00000005)
            $display("TEST 1 PASS");
        else
            $display("TEST 1 FAIL: Result = %h", ALUResult);


        // =====================================
        // TEST 2: ORR
        // =====================================
        SrcA = 32'h0000000A;
        SrcB = 32'h00000005;
        ALUControl = 3'b001;
        #10;

        if (ALUResult == 32'h0000000F)
            $display("TEST 2 PASS");
        else
            $display("TEST 2 FAIL: Result = %h", ALUResult);


        // =====================================
        // TEST 3: ADD
        // =====================================
        SrcA = 32'h00000015;
        SrcB = 32'h0000000A;
        ALUControl = 3'b010;
        #10;

        if (ALUResult == 32'h0000001F)
            $display("TEST 3 PASS");
        else
            $display("TEST 3 FAIL: Result = %h", ALUResult);


        // =====================================
        // TEST 4: SUB
        // =====================================
        SrcA = 32'h00000020;
        SrcB = 32'h00000008;
        ALUControl = 3'b011;
        #10;

        if (ALUResult == 32'h00000018)
            $display("TEST 4 PASS");
        else
            $display("TEST 4 FAIL: Result = %h", ALUResult);


        // =====================================
        // TEST 5: XOR
        // =====================================
        SrcA = 32'h0000000F;
        SrcB = 32'h00000005;
        ALUControl = 3'b100;
        #10;

        if (ALUResult == 32'h0000000A)
            $display("TEST 5 PASS");
        else
            $display("TEST 5 FAIL: Result = %h", ALUResult);


        // =====================================
        // TEST 6: BIC
        // =====================================
        SrcA = 32'h0000000F;
        SrcB = 32'h00000005;
        ALUControl = 3'b101;
        #10;

        if (ALUResult == 32'h0000000A)
            $display("TEST 6 PASS");
        else
            $display("TEST 6 FAIL: Result = %h", ALUResult);


        // =====================================
        // TEST 7: MOV
        // =====================================
        SrcA = 32'hAAAAAAAA;
        SrcB = 32'h00000055;
        ALUControl = 3'b110;
        #10;

        if (ALUResult == 32'h00000055)
            $display("TEST 7 PASS");
        else
            $display("TEST 7 FAIL: Result = %h", ALUResult);


        // =====================================
        // TEST 8: CMP
        // =====================================
        SrcA = 32'h00000020;
        SrcB = 32'h00000008;
        ALUControl = 3'b111;
        #10;

        if (ALUResult == 32'h00000018)
            $display("TEST 8 PASS");
        else
            $display("TEST 8 FAIL: Result = %h", ALUResult);


        // =====================================
        // TEST 9: ADD ket qua bang 0
        // =====================================
        SrcA = 32'hFFFFFFFF;
        SrcB = 32'h00000001;
        ALUControl = 3'b010;
        #10;

        if (ALUResult == 32'h00000000)
            $display("TEST 9 PASS");
        else
            $display("TEST 9 FAIL: Result = %h", ALUResult);


        // =====================================
        // TEST 10: SUB ket qua am
        // =====================================
        SrcA = 32'h00000005;
        SrcB = 32'h00000008;
        ALUControl = 3'b011;
        #10;

        if (ALUResult == 32'hFFFFFFFD)
            $display("TEST 10 PASS");
        else
            $display("TEST 10 FAIL: Result = %h", ALUResult);


        // =====================================
        // TEST 11: XOR
        // =====================================
        SrcA = 32'hAAAAAAAA;
        SrcB = 32'h55555555;
        ALUControl = 3'b100;
        #10;

        if (ALUResult == 32'hFFFFFFFF)
            $display("TEST 11 PASS");
        else
            $display("TEST 11 FAIL: Result = %h", ALUResult);


        // =====================================
        // TEST 12: AND ket qua bang 0
        // =====================================
        SrcA = 32'h0000000F;
        SrcB = 32'h000000F0;
        ALUControl = 3'b000;
        #10;

        if (ALUResult == 32'h00000000)
            $display("TEST 12 PASS");
        else
            $display("TEST 12 FAIL: Result = %h", ALUResult);


        // =====================================
        // KET THUC
        // =====================================
        $display("--------------------------------");
        $display("ALU TEST COMPLETED");
        $finish;

    end

endmodule