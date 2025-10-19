module tb_alu();

  logic [31:0] operand_a;
  logic [31:0] operand_b;
  logic [ 3:0] alu_op;
  logic [31:0] alu_data;
  logic [31:0] exp_alu_data;
  
  alu dut (
    .operand_a(operand_a),
    .operand_b(operand_b),
    .alu_op(alu_op),
    .alu_data(alu_data)
  );
  

    integer fd_in, fd_golden;
    integer line_no = 0;
    integer ret;
    int fail_count = 0;

    initial begin
        fd_in = $fopen("./ref/tb_alu_ref.txt", "r");
        fd_golden = $fopen("./golden/tb_alu_golden.txt", "r");

        if (fd_in == 0) begin
            $display("ERROR: cannot open ref file!");
            $finish;
        end
        if (fd_golden == 0) begin
            $display("ERROR: cannot open golden file!");
            $finish;
        end

        $display("=== Start tb_FA comparison ===");

        while (!$feof(fd_in) && !$feof(fd_golden)) begin
            ret = $fscanf(fd_in, "%b %h %h\n", alu_op, operand_a, operand_b);
            ret = $fscanf(fd_golden, "%h\n", exp_alu_data);
            #1;
            line_no++;

            if (alu_data !== exp_alu_data) begin
                $display("FAIL line %0d: alu_op=%b operand_a=%h operand_b=%h -> got alu_data=%h, expected %h",
                         line_no, alu_op, operand_a, operand_b, alu_data, exp_alu_data);
                fail_count++;
            end else begin
                $display("PASS line %0d: alu_op=%b operand_a=%h operand_b=%h", line_no, alu_op, operand_a, operand_b);
            end
        end

        $fclose(fd_in);
        $fclose(fd_golden);

        if (fail_count == 0)
            $display("=== tb_alu PASSED ===");
        else
            $display("=== tb_alu FAILED (%0d mismatches) ===", fail_count);

        $finish;
    end
endmodule
