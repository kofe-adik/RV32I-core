module arithmetic_unit(
  input  logic [31:0] operand_a,
  input  logic [31:0] operand_b,
  input  logic [ 1:0] sel, //add sub slt sltu
  output logic [31:0] arithmetic_result
);

  logic        sub_flag;
  logic [31:0] w_operand_b;
  logic [31:0] sum;
  logic        co;
  logic        signed_less, unsigned_less;

  adder32bit u_adder (
    .a (operand_a),
    .b (w_operand_b),
    .cin(sub_flag),   // cin = 1 khi SUB/SLT/SLTU, = 0 khi ADD
    .sum(sum),
    .cout(co)
  );

  always_comb begin
    case(sel)
      2'b00: arithmetic_result = sum;                        // ADD
      2'b01: arithmetic_result = sum;                        // SUB
      2'b10: arithmetic_result = {31'b0, signed_less};       // SLT
      2'b11: arithmetic_result = {31'b0, unsigned_less};     // SLTU
      default: arithmetic_result = 32'b0;
    endcase
  end

  assign sub_flag      = sel[1] | sel[0];
  assign w_operand_b   = operand_b ^ {32{sub_flag}};
  assign unsigned_less = ~co;
  assign signed_less   = operand_a[31] ^ operand_b[31] ? operand_a[31] : sum[31];
  
endmodule