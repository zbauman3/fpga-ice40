module segments (
    input logic clk,
    input logic rst,
    input logic [3:0][7:0] chars,

    output logic [3:0] out_addr,
    output logic [7:0] out_data
);
  logic clk_div;
  clock_divier #(
      .SRC_FREQ_HZ(100_000_000),
      .OUT_FREQ_HZ(144 * 4)
  ) u_clock_divier (
      .clk_in(clk),
      .rst(rst),
      .clk_out(clk_div)
  );

  always_ff @(posedge clk_div or posedge rst) begin
    if (rst) begin
      out_addr <= 4'b0000;
    end else begin
      if (out_addr == 4'b1000 || out_addr == 4'b0000) begin
        out_addr <= 4'b0001;
      end else begin
        out_addr <= out_addr << 1;
      end
    end
  end

  always_comb begin
    case (out_addr)
      4'b0001: out_data = chars[0];
      4'b0010: out_data = chars[1];
      4'b0100: out_data = chars[2];
      4'b1000: out_data = chars[3];
      default: out_data = 8'b00000000;
    endcase
  end
endmodule
