module brc(
  input  logic [31:0] rs1_data,
  input  logic [31:0] rs2_data,
  input  logic        br_un,
  output logic        br_less,
  output logic        br_equal
);

  logic [31:0] br_diff;
  logic        co;
  logic        br_less_s;
  logic        br_less_u;
  
adder32bit u_adder (
  .a (rs1_data),
  .b (~rs2_data),
  .cin(1'b1),
  .sum (br_diff),
  .cout(co)
);
  
  assign br_less_u = ~co;
  assign br_less_s = rs1_data[31] ^ rs2_data[31] ? rs1_data[31] : br_diff[31];
  assign br_less   = br_un ? br_less_u : br_less_s;
  assign br_equal  = ~(|br_diff);
  
endmodule