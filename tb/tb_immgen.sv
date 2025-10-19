module tb_immgen();

  logic [31:0] i_instr;
  logic [31:0] o_imm;
  logic [31:0] exp_imm;

immgen dut (
    .i_instr (i_instr),
    .o_imm   (o_imm)
);

  integer fd_in, fd_golden;
  integer line_no = 0;
  integer ret;
  int fail_count = 0;

    initial begin
        fd_in = $fopen("./ref/tb_immgen_ref.txt", "r");
        fd_golden = $fopen("./golden/tb_immgen_golden.txt", "r");

        if (fd_in == 0) begin
            $display("ERROR: cannot open ref file!");
            $finish;
        end
        if (fd_golden == 0) begin
            $display("ERROR: cannot open golden file!");
            $finish;
        end

        $display("=== Start tb_immgen comparison ===");

        while (!$feof(fd_in) && !$feof(fd_golden)) begin
            ret = $fscanf(fd_in, "%h\n", i_instr);
            ret = $fscanf(fd_golden, "%h\n", exp_imm);
            #1;
            line_no++;

            if (o_imm !== exp_imm) begin
                $display("FAIL line %0d: i_instr=%h -> got o_imm=%h, expected %h",
                         line_no, i_instr, o_imm, exp_imm);
                fail_count++;
            end else begin
                $display("PASS line %0d: i_instr=%h -> got o_imm=%h, expected %h",
                         line_no, i_instr, o_imm, exp_imm);
            end
        end

        $fclose(fd_in);
        $fclose(fd_golden);

        if (fail_count == 0)
            $display("=== tb_immgen PASSED ===");
        else
            $display("=== tb_immgen FAILED (%0d mismatches) ===", fail_count);

        $finish;
    end
endmodule