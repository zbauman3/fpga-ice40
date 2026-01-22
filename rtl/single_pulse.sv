module single_pulse (
    input  logic clk,
    input  logic rst,
    input  logic in,
    output logic out
);
  logic in_d;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      in_d <= 1'b0;
      out  <= 1'b0;
    end else begin
      in_d <= in;
      out  <= in & ~in_d;
    end
  end
endmodule
