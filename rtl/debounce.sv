module debounce #(
    parameter integer CLK_HZ      = 100_000_000,
    parameter integer DEBOUNCE_MS = 20
) (
    input  logic clk,
    input  logic rst,
    input  logic in,
    output logic out = 0
);
  localparam integer DEBOUNCE_CYCLES = (CLK_HZ / 1000) * DEBOUNCE_MS;

  // Synchronize input to the clock domain
  logic in_s;
  sync u_sync (
      .clk(clk),
      .rst(rst),
      .in (in),
      .out(in_s)
  );

  // Stability counter
  logic [$clog2(DEBOUNCE_CYCLES)-1:0] cnt = 0;
  logic prev = 0;

  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      cnt  <= 0;
      prev <= 0;
      out  <= 0;
    end else begin
      if (in_s != prev) begin
        // Input changed > restart debounce
        prev <= in_s;
        cnt  <= 0;
      end else if (cnt < DEBOUNCE_CYCLES - 1) begin
        // Input stable > count
        cnt <= cnt + 1;
      end else begin
        // Stable long enough > accept
        out <= in_s;
      end
    end
  end

endmodule

module single_pulse (
    input  logic clk,
    input  logic rst,
    input  logic in,
    output logic out
);
  logic in_d;

  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      in_d <= 0;
      out  <= 0;
    end else begin
      in_d <= in;
      out  <= in & ~in_d;
    end
  end
endmodule
