

`timescale 1ns/1ps

module tb_arm;

    // =============================================
    // 1. KHAI BAO TIN HIEU
    // =============================================

    logic clk;
    logic reset;

    logic [31:0] PC;
    logic [31:0] Instr;
    logic [31:0] ALUResult;
    logic [3:0]  ALUFlags;
    logic [31:0] Result;

    integer i;

    // =============================================
    // 2. KHOI TAO BO XU LY ARM
    // =============================================

    arm DUT (
        .clk(clk),
        .reset(reset),

        .PC(PC),
        .Instr(Instr),
        .ALUResult(ALUResult),
        .ALUFlags(ALUFlags),
        .Result(Result)
    );

    // =============================================
    // 3. TAO XUNG CLOCK
    // Chu ky = 10ns
    // =============================================

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // =============================================
    // 4. TASK KIEM TRA REGISTER FILE
    // =============================================

    task automatic check_reg(
        input integer reg_num,
        input logic [31:0] expected,
        input string message
    );
        begin
            if (DUT.Datapath.Register_File.rf[reg_num] === expected) begin
                $display(
                    "[PASS] %s | R%0d = %0d (0x%08h)",
                    message,
                    reg_num,
                    DUT.Datapath.Register_File.rf[reg_num],
                    DUT.Datapath.Register_File.rf[reg_num]
                );
            end
            else begin
                $display(
                    "[FAIL] %s | R%0d = %0d (0x%08h) | Expected = %0d (0x%08h)",
                    message,
                    reg_num,
                    DUT.Datapath.Register_File.rf[reg_num],
                    DUT.Datapath.Register_File.rf[reg_num],
                    expected,
                    expected
                );

                $fatal(1, "REGISTER FILE CHECK FAILED");
            end
        end
    endtask

    // =============================================
    // 5. TASK KIEM TRA DATA MEMORY
    // =============================================

    task automatic check_memory(
        input integer address,
        input logic [31:0] expected,
        input string message
    );
        begin
            if (DUT.Datapath.Data_Memory.RAM[address] === expected) begin
                $display(
                    "[PASS] %s | RAM[%0d] = %0d",
                    message,
                    address,
                    DUT.Datapath.Data_Memory.RAM[address]
                );
            end
            else begin
                $display(
                    "[FAIL] %s | RAM[%0d] = %0d | Expected = %0d",
                    message,
                    address,
                    DUT.Datapath.Data_Memory.RAM[address],
                    expected
                );

                $fatal(1, "DATA MEMORY CHECK FAILED");
            end
        end
    endtask

    // =============================================
    // 6. CHUONG TRINH TEST
    // =============================================

    initial begin

        $display("");
        $display("========================================");
        $display("       START ARM PROCESSOR TEST");
        $display("========================================");

        // -----------------------------------------
        // BUOC 1: KHOI TAO RESET
        // -----------------------------------------

        reset = 1'b1;

        // -----------------------------------------
        // BUOC 2: KHOI TAO INSTRUCTION MEMORY
        // -----------------------------------------

        // Khoi tao ROM bang lenh NOP
        for (i = 0; i < 256; i = i + 1) begin
            DUT.Datapath.Instruction_Memory.ROM[i] = 32'hE1A00000;
        end

        // -----------------------------------------
        // BUOC 3: KHOI TAO REGISTER FILE
        // -----------------------------------------

        for (i = 0; i < 15; i = i + 1) begin
            DUT.Datapath.Register_File.rf[i] = 32'd0;
        end

        // Du lieu ban dau
        DUT.Datapath.Register_File.rf[1] = 32'd10;
        DUT.Datapath.Register_File.rf[3] = 32'd20;

        // -----------------------------------------
        // BUOC 4: KHOI TAO DATA MEMORY
        // -----------------------------------------

        for (i = 0; i < 256; i = i + 1) begin
            DUT.Datapath.Data_Memory.RAM[i] = 32'd0;
        end

        // -----------------------------------------
        // BUOC 5: NAP CHUONG TRINH ARM VAO ROM
        // -----------------------------------------

        // ROM[0], dia chi 0:
        // ADD R2, R1, R3
        // R2 = 10 + 20 = 30
        DUT.Datapath.Instruction_Memory.ROM[0] = 32'hE0812003;

        // ROM[1], dia chi 4:
        // ADD R4, R1, #5
        // R4 = 10 + 5 = 15
        DUT.Datapath.Instruction_Memory.ROM[1] = 32'hE2814005;

        // ROM[2], dia chi 8:
        // SUB R5, R3, R1
        // R5 = 20 - 10 = 10
        DUT.Datapath.Instruction_Memory.ROM[2] = 32'hE0435001;

        // ROM[3], dia chi 12:
        // AND R6, R1, R3
        // R6 = 10 AND 20 = 0
        DUT.Datapath.Instruction_Memory.ROM[3] = 32'hE0016003;

        // ROM[4], dia chi 16:
        // ORR R7, R1, R3
        // R7 = 10 OR 20 = 30
        DUT.Datapath.Instruction_Memory.ROM[4] = 32'hE1817003;

        // ROM[5], dia chi 20:
        // STR R2, [R0, #0]
        // RAM[0] = R2 = 30
        DUT.Datapath.Instruction_Memory.ROM[5] = 32'hE5802000;

        // ROM[6], dia chi 24:
        // LDR R8, [R0, #0]
        // R8 = RAM[0] = 30
        DUT.Datapath.Instruction_Memory.ROM[6] = 32'hE5908000;

        // ROM[7], dia chi 28:
        // CMP R1, R3
        // Tinh R1 - R3 = 10 - 20 = -10
        DUT.Datapath.Instruction_Memory.ROM[7] = 32'hE1510003;

        // ROM[8], dia chi 32:
        // B .
        // Nhan tai chinh lenh Branch hien tai
        DUT.Datapath.Instruction_Memory.ROM[8] = 32'hEAFFFFFE;

        // -----------------------------------------
        // BUOC 6: GIU RESET QUA 2 CANH LEN CLOCK
        // -----------------------------------------

        repeat (2) @(posedge clk);

        // Ha reset tai canh xuong
        @(negedge clk);
        reset = 1'b0;

        $display("");
        $display("========== START EXECUTING ==========");

        // =========================================
        // LENH 1: ADD R2, R1, R3
        // R2 = 10 + 20 = 30
        // =========================================

        @(posedge clk);
        #1;

        check_reg(2, 32'd30, "ADD R2, R1, R3");

        // =========================================
        // LENH 2: ADD R4, R1, #5
        // R4 = 10 + 5 = 15
        // =========================================

        @(posedge clk);
        #1;

        check_reg(4, 32'd15, "ADD R4, R1, #5");

        // =========================================
        // LENH 3: SUB R5, R3, R1
        // R5 = 20 - 10 = 10
        // =========================================

        @(posedge clk);
        #1;

        check_reg(5, 32'd10, "SUB R5, R3, R1");

        // =========================================
        // LENH 4: AND R6, R1, R3
        // R6 = 10 AND 20 = 0
        // =========================================

        @(posedge clk);
        #1;

        check_reg(6, 32'd0, "AND R6, R1, R3");

        // =========================================
        // LENH 5: ORR R7, R1, R3
        // R7 = 10 OR 20 = 30
        // =========================================

        @(posedge clk);
        #1;

        check_reg(7, 32'd30, "ORR R7, R1, R3");

        // =========================================
        // LENH 6: STR R2, [R0, #0]
        // RAM[0] = 30
        // =========================================

        @(posedge clk);
        #1;

        check_memory(0, 32'd30, "STR R2, [R0, #0]");

        // =========================================
        // LENH 7: LDR R8, [R0, #0]
        // R8 = RAM[0] = 30
        // =========================================

        @(posedge clk);
        #1;

        check_reg(8, 32'd30, "LDR R8, [R0, #0]");

        // =========================================
        // LENH 8: CMP R1, R3
        // R1 - R3 = 10 - 20 = -10
        // NZCV = 1000
        // =========================================

        // Luc nay PC = 28, Instr la lenh CMP.
        // ALUFlags la co do ALU tinh ra.
        // Kiem tra truoc canh clock ghi co.

        #1;

        if (ALUFlags === 4'b1000) begin
            $display("[PASS] CMP ALUFlags = %b", ALUFlags);
        end
        else begin
            $display(
                "[FAIL] CMP ALUFlags = %b | Expected = 1000",
                ALUFlags
            );

            $fatal(1, "CMP ALU FLAGS CHECK FAILED");
        end

        // Cho canh clock de ConditionalLogic luu NZCV
        @(posedge clk);
        #1;

        if (DUT.Controller.ConditionalLogic.Flags === 4'b1000) begin
            $display("[PASS] CMP stored NZCV = 1000");
        end
        else begin
            $display(
                "[FAIL] Stored NZCV = %b | Expected = 1000",
                DUT.Controller.ConditionalLogic.Flags
            );

            $fatal(1, "CONDITIONAL FLAGS CHECK FAILED");
        end

        // CMP chi cap nhat co, khong ghi ket qua vao thanh ghi
        check_reg(0, 32'd0, "CMP must not write R0");

        // =========================================
        // LENH 9: B .
        // PC = 32, branch ve chinh dia chi 32
        // =========================================

        // Kiem tra PC truoc khi thuc hien Branch
        if (PC === 32'd32) begin
            $display("[PASS] PC before BRANCH = 32");
        end
        else begin
            $display(
                "[FAIL] PC before BRANCH = %0d | Expected = 32",
                PC
            );

            $fatal(1, "PC BEFORE BRANCH CHECK FAILED");
        end

        // Thuc hien lenh Branch tai dia chi 32
        @(posedge clk);
        #1;

        if (PC === 32'd32) begin
            $display("[PASS] BRANCH: PC remains at 32");
        end
        else begin
            $display(
                "[FAIL] BRANCH: PC = %0d | Expected = 32",
                PC
            );

            $fatal(1, "BRANCH CHECK FAILED");
        end

        // =========================================
        // KET THUC
        // =========================================

        $display("");
        $display("========================================");
        $display("       ALL ARM TESTS PASSED!");
        $display("========================================");

        $finish;

    end

endmodule

