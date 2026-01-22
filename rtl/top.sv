module top (
    input clk,
    input rst_n,
    input btn_up,
    input btn_down,
    output logic [7:0] led = 0
);

  logic rst, btn_up_debounced, btn_down_debounced, btn_up_pulse, btn_down_pulse;

  assign rst = ~rst_n;

  debounce u_btn_up (
      .clk(clk),
      .rst(rst),
      .in (btn_up),
      .out(btn_up_debounced)
  );

  single_pulse u_btn_up_pulse (
      .clk(clk),
      .rst(rst),
      .in (btn_up_debounced),
      .out(btn_up_pulse)
  );

  debounce u_btn_down (
      .clk(clk),
      .rst(rst),
      .in (btn_down),
      .out(btn_down_debounced)
  );

  single_pulse u_btn_down_pulse (
      .clk(clk),
      .rst(rst),
      .in (btn_down_debounced),
      .out(btn_down_pulse)
  );

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      led <= 8'd0;
    end else if (btn_up_pulse) begin
      if (led == 8'b0) led <= led + 8'd1;
      else led <= led << 8'd1;
    end else if (btn_down_pulse) begin
      if (led == 8'b0) led <= 8'b10000000;
      else led <= led >> 8'd1;
    end
  end

endmodule
