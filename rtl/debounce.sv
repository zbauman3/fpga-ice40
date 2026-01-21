// NEEDS A LOT OF WORK

module debounce #(
    parameter integer CLK_HZ      = 100_000_000,
    parameter integer DEBOUNCE_MS = 20
) (
    input  wire clk,
    input  wire rst,
    input  wire btn_in,
    output reg  btn_out = 1'b0
);

  // Convert ms → cycles
  localparam integer DEBOUNCECYCLES = (CLK_HZ / 1000) * DEBOUNCE_MS;

  wire btn_s;
  sync u_sync (
      .clk(clk),
      .rst(rst),
      .in (btn_in),
      .out(btn_s)
  );

  // Stability counter
  reg [$clog2(DEBOUNCECYCLES)-1:0] cnt = 0;
  reg btn_prev = 1'b0;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      cnt      <= 0;
      btn_prev <= 0;
      btn_out  <= 0;
    end else begin
      if (btn_s != btn_prev) begin
        // Input changed → restart debounce
        btn_prev <= btn_s;
        cnt      <= 0;
      end else if (cnt < DEBOUNCECYCLES - 1) begin
        // Input stable → count
        cnt <= cnt + 1;
      end else begin
        // Stable long enough → accept
        btn_out <= btn_s;
      end
    end
  end

endmodule
