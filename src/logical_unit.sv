module logical_unit(
  input  logic [31:0] operand_a,
  input  logic [31:0] operand_b,
  input  logic [ 1:0] sel, // sel[1:0]: 00=AND, 01=OR, 10=XOR
  output logic [31:0] logical_result
);

  always_comb begin
    case(sel)
      2'b00:   logical_result = operand_a & operand_b;
      2'b01:   logical_result = operand_a | operand_b;
      2'b10:   logical_result = operand_a ^ operand_b;
      default: logical_result = 32'd0;
    endcase
  end
  
endmodule