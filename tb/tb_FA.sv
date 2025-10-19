`timescale 1ns/1ps

module tb_FA;
    logic a, b, cin;
    logic sum, cout;
    logic exp_sum, exp_cout;

    FA dut (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    integer fd_in, fd_golden;
    integer line_no = 0;
    integer ret;
    int fail_count = 0;

    initial begin
        fd_in = $fopen("./ref/tb_FA_ref.txt", "r");
        fd_golden = $fopen("./golden/tb_FA_golden.txt", "r");

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
            ret = $fscanf(fd_in, "%b %b %b\n", a, b, cin);
            ret = $fscanf(fd_golden, "%b %b\n", exp_sum, exp_cout);
            #1;
            line_no++;

            if (sum !== exp_sum || cout !== exp_cout) begin
                $display("FAIL line %0d: a=%b b=%b cin=%b -> got sum=%b cout=%b, expected %b %b",
                         line_no, a, b, cin, sum, cout, exp_sum, exp_cout);
                fail_count++;
            end else begin
                $display("PASS line %0d: a=%b b=%b cin=%b", line_no, a, b, cin);
            end
        end

        $fclose(fd_in);
        $fclose(fd_golden);

        if (fail_count == 0)
            $display("=== tb_FA PASSED ===");
        else
            $display("=== tb_FA FAILED (%0d mismatches) ===", fail_count);

        $finish;
    end
endmodule
