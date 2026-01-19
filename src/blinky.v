`default_nettype none

module blinky(
  input clk,
  input reset_n,
  output reg [7:0] led = 0
  );

  reg[22:0] counter = 0;

  always @(posedge clk or negedge reset_n) begin
    if(!reset_n) begin
      counter <= 0;
      led <= 0;
    end else begin
      counter <= counter + 1;
      if(&counter == 1) begin
        led <= led + 1;
      end
    end
  end

endmodule