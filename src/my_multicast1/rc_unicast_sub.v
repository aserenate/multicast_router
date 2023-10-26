
module rc_unicast_sub#(
  parameter DEPTH=4,
  parameter WIDTH=2,
  parameter DATASIZE=30,
  parameter router_ID=6
  )(
  output reg[DATASIZE-1:0] data_out,
  output reg[4:0] direction_out,

  input wire[DATASIZE-1:0] data_in,
  input wire valid_in,
  input wire rc_ready,

  input wire rc_clk,
  input wire rst_n
  );

  wire[4:0] dst;
  assign dst = data_in[24:20];

  reg[4:0] direction;

  always @ (*) begin
    case (dst)
      5'd0:  direction = 5'b00010;
      5'd1:  direction = 5'b00010;
      5'd2:  direction = 5'b00010;
      5'd3:  direction = 5'b00010;
      5'd4:  direction = 5'b00010;
      5'd5:  direction = 5'b10000;
      5'd6:  direction = 5'b00001;
      5'd7:  direction = 5'b00100;
      5'd8:  direction = 5'b00100;
      5'd9:  direction = 5'b00100;
      5'd10: direction = 5'b01000;
      5'd11: direction = 5'b01000;
      5'd12: direction = 5'b01000;
      5'd13: direction = 5'b01000;
      5'd14: direction = 5'b01000;
      5'd15: direction = 5'b01000;
      5'd16: direction = 5'b01000;
      5'd17: direction = 5'b01000;
      5'd18: direction = 5'b01000;
      5'd19: direction = 5'b01000;
      default:direction = 5'b00000;
    endcase
  end

  always@(posedge rc_clk, negedge rst_n) begin
    if(!rst_n)
      data_out <= 30'b0;
    else if (rc_ready)
      data_out <= data_in;
    else
      data_out <= data_out;
  end

  always@(posedge rc_clk, negedge rst_n) begin
    if(!rst_n)
      direction_out <= 5'b00000;
    else if(!valid_in & rc_ready)
      direction_out <= 5'b00000;
    else if(!rc_ready)
      direction_out <= direction_out;
    else
      direction_out <= direction;
  end

endmodule