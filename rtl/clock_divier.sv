module clock_divier #(
    parameter SRC_FREQ_HZ = 100_000_000,  // Input clock frequency in Hz
    parameter OUT_FREQ_HZ = 1_000_000     // Desired output frequency in Hz
) (
    input  logic clk_in,  // Input clock
    input  logic rst,     // Active high reset
    output logic clk_out  // Output divided clock
);
  localparam int DIVISOR = SRC_FREQ_HZ / (2 * OUT_FREQ_HZ);
  localparam int COUNTER_WIDTH = $clog2(DIVISOR);

  logic [COUNTER_WIDTH-1:0] counter;

  // Counter logic
  always_ff @(posedge clk_in or posedge rst) begin
    if (rst) begin
      counter <= '0;
      clk_out <= 1'b0;
    end else begin
      if (counter >= (DIVISOR - 1)) begin
        counter <= '0;
        clk_out <= ~clk_out;  // Toggle output
      end else begin
        counter <= counter + 1'b1;
      end
    end
  end
endmodule
