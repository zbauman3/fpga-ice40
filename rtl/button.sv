
/**
 * This module debounces and generates a single pulse on the button press.
 */
module button (
    input  logic clk,
    input  logic in,
    output logic out
);
  logic btn_debounced;
  // We're not using reset, so we're using a constant 0
  wire  rst;
  assign rst = 1'b0;

  debounce u_debounce (
      .clk(clk),
      .rst(rst),
      .in (in),
      .out(btn_debounced)
  );

  single_pulse u_single_pulse (
      .clk(clk),
      .rst(rst),
      .in (btn_debounced),
      .out(out)
  );
endmodule
