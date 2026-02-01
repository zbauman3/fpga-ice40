module top (
    input clk,
    input rst_n,
    input btn_up,
    input btn_down,
    input btn_left,
    input btn_right,
    input btn_center,

    output logic [15:0] led,
    output wire  [ 3:0] seg_addr_n,
    output wire  [ 7:0] seg_data_n
);

  logic btn_up_pressed, btn_down_pressed, btn_left_pressed, btn_right_pressed, btn_center_pressed;
  logic [3:0] seg_addr;
  logic [7:0] seg_data;
  logic [3:0][7:0] chars;
  wire rst;
  logic [0:9][7:0] SEG_LOOKUP;

  assign rst = ~rst_n;
  assign seg_addr_n = ~seg_addr;
  assign seg_data_n = ~seg_data;
  assign SEG_LOOKUP = {
    8'b00111111,  // 0
    8'b00000110,  // 1
    8'b01011011,  // 2
    8'b01001111,  // 3
    8'b01100110,  // 4
    8'b01101101,  // 5
    8'b01111101,  // 6
    8'b00000111,  // 7
    8'b01111111,  // 8
    8'b01101111  // 9
  };

  button u_btn_up (
      .clk(clk),
      .in (btn_up),
      .out(btn_up_pressed)
  );

  button u_btn_down (
      .clk(clk),
      .in (btn_down),
      .out(btn_down_pressed)
  );

  button u_btn_left (
      .clk(clk),
      .in (btn_left),
      .out(btn_left_pressed)
  );

  button u_btn_right (
      .clk(clk),
      .in (btn_right),
      .out(btn_right_pressed)
  );

  button u_btn_center (
      .clk(clk),
      .in (btn_center),
      .out(btn_center_pressed)
  );

  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      led <= 16'd0;
    end else if (led > 16'd9999) begin
      led <= 16'd0;
    end else if (btn_up_pressed) begin
      if (led < 16'd9999) begin
        led <= led + 16'd1;
      end else begin
        led <= 16'd0;
      end
    end else if (btn_down_pressed) begin
      if (led > 16'd0) begin
        led <= led - 16'd1;
      end else begin
        led <= 16'd9999;
      end
    end
  end

  always_comb begin
    chars[0] = SEG_LOOKUP[(led/1000)%10];
    chars[1] = SEG_LOOKUP[(led/100)%10];
    chars[2] = SEG_LOOKUP[(led/10)%10];
    chars[3] = SEG_LOOKUP[led%10];
  end

  segments u_segments (
      .clk(clk),
      .rst(rst),
      .chars(chars),
      .out_addr(seg_addr),
      .out_data(seg_data)
  );
endmodule
