
/**
 * Debounces and generates a single pulse on button presses
 */
module button (
    input  logic clk,
    input  logic in,
    output logic out
);
  logic btn_debounced;

  debounce u_debounce (
      .clk(clk),
      .rst(1'b0),
      .in (in),
      .out(btn_debounced)
  );

  single_pulse u_single_pulse (
      .clk(clk),
      .rst(1'b0),
      .in (btn_debounced),
      .out(out)
  );
endmodule
