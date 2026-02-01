module segments (
    input logic clk,
    input logic rst,
    input logic [3:0][7:0] chars,

    output logic [3:0] out_addr = 0,
    output logic [7:0] out_data = 0
);

  // first divide the clock. We want each segment to be updated at 144 Hz
  // so we set the desired frequency to 144 * 4 = 576 Hz
  logic clk_div;
  clock_divider #(
      .SRC_FREQ_HZ(100_000_000),
      .OUT_FREQ_HZ(144 * 4)
  ) u_clock_divider (
      .in (clk),
      .rst(rst),
      .out(clk_div)
  );

  // cycle through each of the 4 segments, setting them as active one at a time
  always_ff @(posedge clk_div or posedge rst) begin
    if (rst) begin
      out_addr <= 0;
    end else begin
      if (out_addr == 4'b1000 || out_addr == 0) begin
        out_addr <= 1;
      end else begin
        out_addr <= out_addr << 1;
      end
    end
  end

  // set the data for the current segment
  always_comb begin
    case (out_addr)
      4'b0001: out_data = chars[0];
      4'b0010: out_data = chars[1];
      4'b0100: out_data = chars[2];
      4'b1000: out_data = chars[3];
      default: out_data = 0;
    endcase
  end
endmodule
