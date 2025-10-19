module immgen(
  input  logic [31:0] i_instr,
  output logic [31:0] o_imm
);

  localparam OP     = 7'h33;
  localparam OP_IMM = 7'h13;
  localparam LOAD   = 7'h03;
  localparam STORE  = 7'h23;
  localparam BRANCH = 7'h63;
  localparam JAL    = 7'h6F;
  localparam JALR   = 7'h67;
  localparam LUI    = 7'h37;
  localparam AUIPC  = 7'h17;
  localparam SYS    = 7'h73;

  logic [31:0] imm_r_type;
  logic [31:0] imm_i_type;
  logic [31:0] imm_s_type;
  logic [31:0] imm_b_type;
  logic [31:0] imm_u_type;
  logic [31:0] imm_j_type;
  
  always_comb begin
    imm_r_type = 32'd0;
    imm_i_type = {{20{i_instr[31]}},i_instr[31:20]};
    imm_s_type = {{20{i_instr[31]}},i_instr[31:25],i_instr[11:7]};
    imm_b_type = {{19{i_instr[31]}},i_instr[31],i_instr[7],i_instr[30:25],i_instr[11:8],1'b0};
    imm_u_type = {i_instr[31:12],12'd0};
    imm_j_type = {{11{i_instr[31]}},i_instr[31],i_instr[19:12],i_instr[20],i_instr[30:21],1'b0};
    case(i_instr[6:0])
      OP:         o_imm = imm_r_type;
      OP_IMM, LOAD, JALR, SYS: 
                  o_imm = imm_i_type;
      STORE:      o_imm = imm_s_type;
      BRANCH:     o_imm = imm_b_type;
      JAL:        o_imm = imm_j_type;
      LUI, AUIPC: o_imm = imm_u_type;
      default:    o_imm = 32'd0;
    endcase
  end
  
endmodule