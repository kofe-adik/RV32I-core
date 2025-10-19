module mux4to1(
  input  logic [31:0] a,
  input  logic [31:0] b,
  input  logic [31:0] c,
  input  logic [31:0] d,
  input  logic [ 1:0] sel,
  output logic [31:0] s
);

  always_comb begin
    case(sel)
      2'b00: s = a;
      2'b01: s = b;
      2'b10: s = c;
      2'b11: s = d;
    endcase
  end

endmodule