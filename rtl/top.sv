module top (
    input clk,
    input rst_n,
    input btn_up,
    input btn_down,
    output reg [7:0] led = 0
);

  wire rst, btn_up_debounced;

  assign rst = ~rst_n;

  debounce u_btn_up (
      .clk(clk),
      .rst(rst),
      .btn_in(btn_up),
      .btn_out(btn_up_debounced)
  );

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      led <= 8'd0;
    end else if (btn_up_debounced) begin
      led <= led + 8'd1;
    end
  end

endmodule
