module alu(
  input  logic [31:0] operand_a,
  input  logic [31:0] operand_b,
  input  logic [ 3:0] alu_op, // op[3:2]: 00 = Arithmetic, 01 = Logical, 10 = Shift
  output logic [31:0] alu_data
);

  logic [31:0] arithmetic_result;
  logic [31:0] logical_result;
  logic [31:0] shift_result;
  
arithmetic_unit au(
  .operand_a(operand_a),
  .operand_b(operand_b),
  .sel(alu_op[1:0]),
  .arithmetic_result(arithmetic_result)
);

logical_unit lu(
  .operand_a(operand_a),
  .operand_b(operand_b),
  .sel(alu_op[1:0]),
  .logical_result(logical_result)
);

shift_unit su(
  .operand_a(operand_a),
  .operand_b(operand_b),
  .sel(alu_op[1:0]),
  .shift_result(shift_result)
);

mux4to1 alu_mux(
  .a(arithmetic_result),
  .b(logical_result),
  .c(shift_result),
  .d(32'd0),
  .sel(alu_op[3:2]),
  .s(alu_data)
);

endmodule