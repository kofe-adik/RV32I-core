module regfile(
  input  logic        i_clk,
  input  logic        i_rst,
  input  logic [ 4:0] i_rs1_addr,
  input  logic [ 4:0] i_rs2_addr,
  output logic [31:0] o_rs1_data,
  output logic [31:0] o_rs2_data,
  input  logic [ 4:0] i_rd_addr,
  input  logic [31:0] i_rd_data,
  input  logic        i_rd_wren
);

  logic [31:0] wren;
  logic [31:0] reg_mem [0:31];
  
wren_decoder u_wren_decoder (
  .rd_addr (i_rd_addr),
  .rd_wren (i_rd_wren),
  .wren    (wren)
);

regmem u_regmem (
  .i_clk    (i_clk),
  .i_rst    (i_rst),
  .i_rd_data(i_rd_data),
  .wren     (wren),
  .reg_mem  (reg_mem)
);

mux5to32 u_mux_rs1 (
  .rsx_addr (i_rs1_addr),
  .register (reg_mem),
  .rsx_data (o_rs1_data)
);
  
mux5to32 u_mux_rs2 (
  .rsx_addr (i_rs2_addr),
  .register (reg_mem),
  .rsx_data (o_rs2_data)
);

endmodule

module register
#(parameter N = 32)(
  input  logic        i_clk,
  input  logic        i_rst,
  input  logic [N-1:0] d,
  input  logic        wren,
  output logic [N-1:0] q
);

  always_ff @(posedge i_clk or negedge i_rst)
  begin
    if (!i_rst)
      q <= 'd0;
    else if (wren)
      q <= d;
  end

endmodule

module regmem(
  input  logic        i_clk,
  input  logic        i_rst,
  input  logic [31:0] i_rd_data,
  input  logic [31:0] wren,
  output logic [31:0] reg_mem [0:31]
);

  register u_reg0  (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[0]),  .q(reg_mem[0]));
  register u_reg1  (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[1]),  .q(reg_mem[1]));
  register u_reg2  (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[2]),  .q(reg_mem[2]));
  register u_reg3  (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[3]),  .q(reg_mem[3]));
  register u_reg4  (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[4]),  .q(reg_mem[4]));
  register u_reg5  (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[5]),  .q(reg_mem[5]));
  register u_reg6  (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[6]),  .q(reg_mem[6]));
  register u_reg7  (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[7]),  .q(reg_mem[7]));
  register u_reg8  (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[8]),  .q(reg_mem[8]));
  register u_reg9  (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[9]),  .q(reg_mem[9]));
  register u_reg10 (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[10]), .q(reg_mem[10]));
  register u_reg11 (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[11]), .q(reg_mem[11]));
  register u_reg12 (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[12]), .q(reg_mem[12]));
  register u_reg13 (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[13]), .q(reg_mem[13]));
  register u_reg14 (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[14]), .q(reg_mem[14]));
  register u_reg15 (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[15]), .q(reg_mem[15]));
  register u_reg16 (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[16]), .q(reg_mem[16]));
  register u_reg17 (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[17]), .q(reg_mem[17]));
  register u_reg18 (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[18]), .q(reg_mem[18]));
  register u_reg19 (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[19]), .q(reg_mem[19]));
  register u_reg20 (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[20]), .q(reg_mem[20]));
  register u_reg21 (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[21]), .q(reg_mem[21]));
  register u_reg22 (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[22]), .q(reg_mem[22]));
  register u_reg23 (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[23]), .q(reg_mem[23]));
  register u_reg24 (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[24]), .q(reg_mem[24]));
  register u_reg25 (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[25]), .q(reg_mem[25]));
  register u_reg26 (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[26]), .q(reg_mem[26]));
  register u_reg27 (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[27]), .q(reg_mem[27]));
  register u_reg28 (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[28]), .q(reg_mem[28]));
  register u_reg29 (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[29]), .q(reg_mem[29]));
  register u_reg30 (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[30]), .q(reg_mem[30]));
  register u_reg31 (.i_clk(i_clk), .i_rst(i_rst), .d(i_rd_data), .wren(wren[31]), .q(reg_mem[31]));
endmodule

module mux5to32(
  input  logic [ 4:0] rsx_addr,
  input  logic [31:0] register [0:31],
  output logic [31:0] rsx_data
);

  always_comb begin
    case (rsx_addr)
      5'd0:  rsx_data = register[0];
      5'd1:  rsx_data = register[1];
      5'd2:  rsx_data = register[2];
      5'd3:  rsx_data = register[3];
      5'd4:  rsx_data = register[4];
      5'd5:  rsx_data = register[5];
      5'd6:  rsx_data = register[6];
      5'd7:  rsx_data = register[7];
      5'd8:  rsx_data = register[8];
      5'd9:  rsx_data = register[9];
      5'd10: rsx_data = register[10];
      5'd11: rsx_data = register[11];
      5'd12: rsx_data = register[12];
      5'd13: rsx_data = register[13];
      5'd14: rsx_data = register[14];
      5'd15: rsx_data = register[15];
      5'd16: rsx_data = register[16];
      5'd17: rsx_data = register[17];
      5'd18: rsx_data = register[18];
      5'd19: rsx_data = register[19];
      5'd20: rsx_data = register[20];
      5'd21: rsx_data = register[21];
      5'd22: rsx_data = register[22];
      5'd23: rsx_data = register[23];
      5'd24: rsx_data = register[24];
      5'd25: rsx_data = register[25];
      5'd26: rsx_data = register[26];
      5'd27: rsx_data = register[27];
      5'd28: rsx_data = register[28];
      5'd29: rsx_data = register[29];
      5'd30: rsx_data = register[30];
      5'd31: rsx_data = register[31];
      default: rsx_data = 32'b0;
    endcase
  end

endmodule

module wren_decoder(
  input  logic [ 4:0] rd_addr,
  input  logic        rd_wren,
  output logic [31:0] wren
);

  always_comb begin
    case(rd_addr)
      5'd0:  wren = 32'd0;
      5'd1:  wren = rd_wren ? 32'h0000_0002 : 32'd0;
      5'd2:  wren = rd_wren ? 32'h0000_0004 : 32'd0;
      5'd3:  wren = rd_wren ? 32'h0000_0008 : 32'd0;
      5'd4:  wren = rd_wren ? 32'h0000_0010 : 32'd0;
      5'd5:  wren = rd_wren ? 32'h0000_0020 : 32'd0;
      5'd6:  wren = rd_wren ? 32'h0000_0040 : 32'd0;
      5'd7:  wren = rd_wren ? 32'h0000_0080 : 32'd0;
      5'd8:  wren = rd_wren ? 32'h0000_0100 : 32'd0;
      5'd9:  wren = rd_wren ? 32'h0000_0200 : 32'd0;
      5'd10: wren = rd_wren ? 32'h0000_0400 : 32'd0;
      5'd11: wren = rd_wren ? 32'h0000_0800 : 32'd0;
      5'd12: wren = rd_wren ? 32'h0000_1000 : 32'd0;
      5'd13: wren = rd_wren ? 32'h0000_2000 : 32'd0;
      5'd14: wren = rd_wren ? 32'h0000_4000 : 32'd0;
      5'd15: wren = rd_wren ? 32'h0000_8000 : 32'd0;
      5'd16: wren = rd_wren ? 32'h0001_0000 : 32'd0;
      5'd17: wren = rd_wren ? 32'h0002_0000 : 32'd0;
      5'd18: wren = rd_wren ? 32'h0004_0000 : 32'd0;
      5'd19: wren = rd_wren ? 32'h0008_0000 : 32'd0;
      5'd20: wren = rd_wren ? 32'h0010_0000 : 32'd0;
      5'd21: wren = rd_wren ? 32'h0020_0000 : 32'd0;
      5'd22: wren = rd_wren ? 32'h0040_0000 : 32'd0;
      5'd23: wren = rd_wren ? 32'h0080_0000 : 32'd0;
      5'd24: wren = rd_wren ? 32'h0100_0000 : 32'd0;
      5'd25: wren = rd_wren ? 32'h0200_0000 : 32'd0;
      5'd26: wren = rd_wren ? 32'h0400_0000 : 32'd0;
      5'd27: wren = rd_wren ? 32'h0800_0000 : 32'd0;
      5'd28: wren = rd_wren ? 32'h1000_0000 : 32'd0;
      5'd29: wren = rd_wren ? 32'h2000_0000 : 32'd0;
      5'd30: wren = rd_wren ? 32'h4000_0000 : 32'd0;
      5'd31: wren = rd_wren ? 32'h8000_0000 : 32'd0;
      default: wren = 32'd0;
    endcase
  end

endmodule

/*module regfile(
  input  logic        i_clk,
  input  logic        i_rst,
  input  logic [ 4:0] i_rs1_addr,
  input  logic [ 4:0] i_rs2_addr,
  output logic [31:0] o_rs1_data,
  output logic [31:0] o_rs2_data,
  input  logic [ 4:0] i_rd_addr,
  input  logic [31:0] i_rd_data,
  input  logic        i_rd_wren
);

  logic [31:0] reg_mem [0:31];
  logic wren_flag;
  integer i;
  
  assign wren_flag = i_rd_wren & (|i_rd_addr);
  
  always_ff @(posedge i_clk or negedge i_rst)
  begin
    if (!i_rst) begin
      reg_mem <= '{default:32'd0};
    end else if (wren_flag) begin
        reg_mem[i_rd_addr] <= i_rd_data;
    end
  end

  always_comb begin
    o_rs1_data = reg_mem[i_rs1_addr];
    o_rs2_data = reg_mem[i_rs2_addr];
  end
  
endmodule*/