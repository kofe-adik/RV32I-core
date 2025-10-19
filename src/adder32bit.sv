module adder32bit(
  input  logic [31:0] a,
  input  logic [31:0] b,
  input  logic        cin,
  output logic [31:0] sum,
  output logic        cout
);

  logic [31:0] carry;

FA fa0  (.a(a[ 0]),.b(b[ 0]),.cin(cin),      .sum(sum[ 0]),.cout(carry[ 0]));
FA fa1  (.a(a[ 1]),.b(b[ 1]),.cin(carry[ 0]),.sum(sum[ 1]),.cout(carry[ 1]));
FA fa2  (.a(a[ 2]),.b(b[ 2]),.cin(carry[ 1]),.sum(sum[ 2]),.cout(carry[ 2]));
FA fa3  (.a(a[ 3]),.b(b[ 3]),.cin(carry[ 2]),.sum(sum[ 3]),.cout(carry[ 3]));
FA fa4  (.a(a[ 4]),.b(b[ 4]),.cin(carry[ 3]),.sum(sum[ 4]),.cout(carry[ 4]));
FA fa5  (.a(a[ 5]),.b(b[ 5]),.cin(carry[ 4]),.sum(sum[ 5]),.cout(carry[ 5]));
FA fa6  (.a(a[ 6]),.b(b[ 6]),.cin(carry[ 5]),.sum(sum[ 6]),.cout(carry[ 6]));
FA fa7  (.a(a[ 7]),.b(b[ 7]),.cin(carry[ 6]),.sum(sum[ 7]),.cout(carry[ 7]));
FA fa8  (.a(a[ 8]),.b(b[ 8]),.cin(carry[ 7]),.sum(sum[ 8]),.cout(carry[ 8]));
FA fa9  (.a(a[ 9]),.b(b[ 9]),.cin(carry[ 8]),.sum(sum[ 9]),.cout(carry[ 9]));
FA fa10 (.a(a[10]),.b(b[10]),.cin(carry[ 9]),.sum(sum[10]),.cout(carry[10]));
FA fa11 (.a(a[11]),.b(b[11]),.cin(carry[10]),.sum(sum[11]),.cout(carry[11]));
FA fa12 (.a(a[12]),.b(b[12]),.cin(carry[11]),.sum(sum[12]),.cout(carry[12]));
FA fa13 (.a(a[13]),.b(b[13]),.cin(carry[12]),.sum(sum[13]),.cout(carry[13]));
FA fa14 (.a(a[14]),.b(b[14]),.cin(carry[13]),.sum(sum[14]),.cout(carry[14]));
FA fa15 (.a(a[15]),.b(b[15]),.cin(carry[14]),.sum(sum[15]),.cout(carry[15]));
FA fa16 (.a(a[16]),.b(b[16]),.cin(carry[15]),.sum(sum[16]),.cout(carry[16]));
FA fa17 (.a(a[17]),.b(b[17]),.cin(carry[16]),.sum(sum[17]),.cout(carry[17]));
FA fa18 (.a(a[18]),.b(b[18]),.cin(carry[17]),.sum(sum[18]),.cout(carry[18]));
FA fa19 (.a(a[19]),.b(b[19]),.cin(carry[18]),.sum(sum[19]),.cout(carry[19]));
FA fa20 (.a(a[20]),.b(b[20]),.cin(carry[19]),.sum(sum[20]),.cout(carry[20]));
FA fa21 (.a(a[21]),.b(b[21]),.cin(carry[20]),.sum(sum[21]),.cout(carry[21]));
FA fa22 (.a(a[22]),.b(b[22]),.cin(carry[21]),.sum(sum[22]),.cout(carry[22]));
FA fa23 (.a(a[23]),.b(b[23]),.cin(carry[22]),.sum(sum[23]),.cout(carry[23]));
FA fa24 (.a(a[24]),.b(b[24]),.cin(carry[23]),.sum(sum[24]),.cout(carry[24]));
FA fa25 (.a(a[25]),.b(b[25]),.cin(carry[24]),.sum(sum[25]),.cout(carry[25]));
FA fa26 (.a(a[26]),.b(b[26]),.cin(carry[25]),.sum(sum[26]),.cout(carry[26]));
FA fa27 (.a(a[27]),.b(b[27]),.cin(carry[26]),.sum(sum[27]),.cout(carry[27]));
FA fa28 (.a(a[28]),.b(b[28]),.cin(carry[27]),.sum(sum[28]),.cout(carry[28]));
FA fa29 (.a(a[29]),.b(b[29]),.cin(carry[28]),.sum(sum[29]),.cout(carry[29]));
FA fa30 (.a(a[30]),.b(b[30]),.cin(carry[29]),.sum(sum[30]),.cout(carry[30]));
FA fa31 (.a(a[31]),.b(b[31]),.cin(carry[30]),.sum(sum[31]),.cout(carry[31]));

    assign cout = carry[31];

endmodule