module shift_unit(
  input  logic [31:0] operand_a,
  input  logic [31:0] operand_b,
  input  logic [ 1:0] sel,  // sel[1:0]: 00=SLL, 01=SRL, 10=SRA
  output logic [31:0] shift_result
);

  logic [ 4:0] shamt;
  logic        fill;
  logic [31:0] stage [0:5];

  // Conditional reversal at stage[0]
  assign stage[0] = sel[0] ? operand_a : {
    operand_a[ 0], operand_a[ 1], operand_a[ 2], operand_a[ 3],
    operand_a[ 4], operand_a[ 5], operand_a[ 6], operand_a[ 7],
    operand_a[ 8], operand_a[ 9], operand_a[10], operand_a[11],
    operand_a[12], operand_a[13], operand_a[14], operand_a[15],
    operand_a[16], operand_a[17], operand_a[18], operand_a[19],
    operand_a[20], operand_a[21], operand_a[22], operand_a[23],
    operand_a[24], operand_a[25], operand_a[26], operand_a[27],
    operand_a[28], operand_a[29], operand_a[30], operand_a[31]
  };

  // Shift stages
  assign stage[1] = shamt[0] ? {fill,       stage[0][31:1]}   : stage[0];
  assign stage[2] = shamt[1] ? {{2{fill}},  stage[1][31:2]}   : stage[1];
  assign stage[3] = shamt[2] ? {{4{fill}},  stage[2][31:4]}   : stage[2];
  assign stage[4] = shamt[3] ? {{8{fill}},  stage[3][31:8]}   : stage[3];
  assign stage[5] = shamt[4] ? {{16{fill}}, stage[4][31:16]}  : stage[4];

  // Output reversal
  assign shift_result = sel[0] ? stage[5] : {
    stage[5][ 0], stage[5][ 1], stage[5][ 2], stage[5][ 3],
    stage[5][ 4], stage[5][ 5], stage[5][ 6], stage[5][ 7],
    stage[5][ 8], stage[5][ 9], stage[5][10], stage[5][11],
    stage[5][12], stage[5][13], stage[5][14], stage[5][15],
    stage[5][16], stage[5][17], stage[5][18], stage[5][19],
    stage[5][20], stage[5][21], stage[5][22], stage[5][23],
    stage[5][24], stage[5][25], stage[5][26], stage[5][27],
    stage[5][28], stage[5][29], stage[5][30], stage[5][31]
  };

  // Control
  assign shamt = operand_b[4:0];
  assign fill  = sel[1] ? operand_a[31] : 1'b0;

endmodule