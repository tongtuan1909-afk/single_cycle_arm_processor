module tb_alu_decoder;

    // Inputs
    logic ALUOp;
    logic [3:0] Funct;
    logic S;

    // Outputs
    logic [2:0] ALUControl;
    logic [1:0] FlagW;
    logic NoWrite;

    // Ket noi DUT
    alu_decoder dut(
        .ALUOp(ALUOp),
        .Funct(Funct),
        .S(S),
        .ALUControl(ALUControl),
        .FlagW(FlagW),
        .NoWrite(NoWrite)
    );

    // Test
    initial begin

        // Test 1: LDR / STR / Branch (ALUOp = 0)
        ALUOp = 0; Funct = 4'b0000; S = 0;
        #10;
        if (ALUControl == 3'b010 && FlagW == 2'b00 && NoWrite == 0)
            $display("PASS");
        else $display("FAIL");


        // Test 2: ADD
        ALUOp = 1; Funct = 4'b0100; S = 0;
        #10;
        if (ALUControl == 3'b010 && FlagW == 2'b00 && NoWrite == 0)
            $display("PASS");
        else $display("FAIL");


        // Test 3: ADDS
        ALUOp = 1; Funct = 4'b0100; S = 1;
        #10;
        if (ALUControl == 3'b010 && FlagW == 2'b11 && NoWrite == 0)
            $display("PASS");
        else $display("FAIL");


        // Test 4: SUB
        ALUOp = 1; Funct = 4'b0010; S = 0;
        #10;
        if (ALUControl == 3'b011 && FlagW == 2'b00 && NoWrite == 0)
            $display("PASS");
        else $display("FAIL");


        // Test 5: SUBS
        ALUOp = 1; Funct = 4'b0010; S = 1;
        #10;
        if (ALUControl == 3'b011 && FlagW == 2'b11 && NoWrite == 0)
            $display("PASS");
        else $display("FAIL");


        // Test 6: AND
        ALUOp = 1; Funct = 4'b0000; S = 0;
        #10;
        if (ALUControl == 3'b000 && FlagW == 2'b00 && NoWrite == 0)
            $display("PASS");
        else $display("FAIL");


        // Test 7: ANDS
        ALUOp = 1; Funct = 4'b0000; S = 1;
        #10;
        if (ALUControl == 3'b000 && FlagW == 2'b10 && NoWrite == 0)
            $display("PASS");
        else $display("FAIL");


        // Test 8: ORR
        ALUOp = 1; Funct = 4'b1100; S = 0;
        #10;
        if (ALUControl == 3'b001 && FlagW == 2'b00 && NoWrite == 0)
            $display("PASS");
        else $display("FAIL");


        // Test 9: ORRS
        ALUOp = 1; Funct = 4'b1100; S = 1;
        #10;
        if (ALUControl == 3'b001 && FlagW == 2'b10 && NoWrite == 0)
            $display("PASS");
        else $display("FAIL");


        // Test 10: CMP
        ALUOp = 1; Funct = 4'b1010; S = 1;
        #10;
        if (ALUControl == 3'b111 && FlagW == 2'b11 && NoWrite == 1)
            $display("PASS");
        else $display("FAIL");


        // Test 11: CMP khi S = 0
        ALUOp = 1; Funct = 4'b1010; S = 0;
        #10;
        if (ALUControl == 3'b010 && FlagW == 2'b00 && NoWrite == 0)
            $display("PASS");
        else $display("FAIL");


        // Test 12: Lenh khong ho tro
        ALUOp = 1; Funct = 4'b1111; S = 1;
        #10;
        if (ALUControl == 3'b010 && FlagW == 2'b00 && NoWrite == 0)
            $display("PASS");
        else $display("FAIL");


        $finish;

    end

endmodule