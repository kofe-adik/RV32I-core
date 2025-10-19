module tb_brc();

  logic [31:0] rs1_data;
  logic [31:0] rs2_data;
  logic        br_un;
  logic        br_less;
  logic        br_equal;
  logic       exp_br_less;
  logic       exp_br_equal;

brc dut (
    .rs1_data     (rs1_data),
    .rs2_data     (rs2_data),
    .br_un       (br_un),
    .br_less     (br_less),
    .br_equal    (br_equal)
);

  integer fd_in, fd_golden;
  integer line_no = 0;
  integer ret;
  int fail_count = 0;

    initial begin
        fd_in = $fopen("./ref/tb_brc_ref.txt", "r");
        fd_golden = $fopen("./golden/tb_brc_golden.txt", "r");

        if (fd_in == 0) begin
            $display("ERROR: cannot open ref file!");
            $finish;
        end
        if (fd_golden == 0) begin
            $display("ERROR: cannot open golden file!");
            $finish;
        end

        $display("=== Start tb_brc comparison ===");

        while (!$feof(fd_in) && !$feof(fd_golden)) begin
            ret = $fscanf(fd_in, "%b %h %h\n", br_un, rs1_data, rs2_data);
            ret = $fscanf(fd_golden, "%b %b\n", exp_br_less, exp_br_equal);
            #1;
            line_no++;

            if (br_less !== exp_br_less || br_equal !== exp_br_equal) begin
                $display("FAIL line %0d: br_un=%b rs1_data=%h rs2_data=%h -> got br_less=%b br_equal=%b, expected %b %b",
                         line_no, br_un, rs1_data, rs2_data, br_less, br_equal, exp_br_less, exp_br_equal);
                fail_count++;
            end else begin
                $display("PASS line %0d: br_un=%b rs1_data=%h rs2_data=%h", line_no, br_un, rs1_data, rs2_data);
            end
        end

        $fclose(fd_in);
        $fclose(fd_golden);

        if (fail_count == 0)
            $display("=== tb_brc PASSED ===");
        else
            $display("=== tb_brc FAILED (%0d mismatches) ===", fail_count);

        $finish;
    end
endmodule