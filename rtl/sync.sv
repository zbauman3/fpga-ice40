module sync (
    input  logic clk,
    input  logic rst,
    input  logic in,
    output logic out
);
  logic [1:0] sync = 2'b00;

  always_ff @(posedge clk or posedge rst) begin
    if (rst) sync <= 2'b00;
    else sync <= {sync[0], in};
  end

  assign out = sync[1];
endmodule
