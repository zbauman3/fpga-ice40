module sync (
    input  wire clk,
    input  wire rst,
    input  wire in,
    output wire out
);
  reg [1:0] sync = 2'b00;

  always @(posedge clk or posedge rst) begin
    if (rst) sync <= 2'b00;
    else sync <= {sync[0], in};
  end

  assign out = sync[1];
endmodule
