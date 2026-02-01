/**
 * Divides an input clock frequency by a desired output frequency
 */
module clock_divider #(
    /** Input clock frequency in Hz */
    parameter integer SRC_FREQ_HZ = 100_000_000,
    /** Desired output frequency in Hz */
    parameter integer OUT_FREQ_HZ = 1_000_000
) (
    input  logic in,
    input  logic rst,
    output logic out
);
  localparam integer DIVISOR = SRC_FREQ_HZ / (2 * OUT_FREQ_HZ);
  localparam integer COUNTER_WIDTH = $clog2(DIVISOR);

  logic [COUNTER_WIDTH-1:0] counter;

  always_ff @(posedge in or posedge rst) begin
    if (rst) begin
      counter <= 0;
      out <= 0;
    end else begin
      if (counter >= (DIVISOR - 1)) begin
        counter <= 0;
        out <= ~out;
      end else begin
        counter <= counter + 1;
      end
    end
  end
endmodule
