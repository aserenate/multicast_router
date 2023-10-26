module rc_multicast_sub#(
  parameter DEPTH=4,
  parameter WIDTH=2,
  parameter DATASIZE=30,
  parameter router_ID=6
  )(
  output reg[DATASIZE-1:0] data_out1,
  output reg[4:0] direction_out1,

  output reg[DATASIZE-1:0] data_out2,
  output reg[4:0] direction_out2,

  output reg[DATASIZE-1:0] data_out3,
  output reg[4:0] direction_out3,

  output reg[DATASIZE-1:0] data_out4,
  output reg[4:0] direction_out4,

  output reg[DATASIZE-1:0] data_out5,
  output reg[4:0] direction_out5,

  input wire[DATASIZE-1:0] data_in,
  input wire valid_in,
  input wire rc_ready,

  input wire rc_clk,
  input wire rst_n
  );

  wire[15:0] dst_list;
  assign dst_list = data_in[24:9];
  assign dst_list_S = dst_list[3:0];
  assign dst_list_L = dst_list[4];
  assign dst_list_E = dst_list[7:5];
  assign dst_list_W = dst_list[8];
  assign dst_list_N = dst_list[15:9];

  always@(posedge rc_clk, negedge rst_n) begin
    if(!rst_n)
      data_out1 <= 30'b0;
    else if (rc_ready)
      data_out1 <= {data_in[29:17],8'b0,data_in[8:1],1'b1};
    else
      data_out1 <= data_out1;
  end

  always@(posedge rc_clk, negedge rst_n) begin
    if(!rst_n)
      data_out2 <= 30'b0;
    else if (rc_ready)
      data_out2 <= {data_in[29:25],8'b0,dst_list_L,4'b0,data_in[8:1],1'b1};
    else
      data_out2 <= data_out2;
  end

  always@(posedge rc_clk, negedge rst_n) begin
    if(!rst_n)
      data_out3 <= 30'b0;
    else if (rc_ready)
      data_out3 <= {data_in[29:25],8'b0,dst_list_S,5'b0,data_in[8:1],1'b1};
    else
      data_out3 <= data_out3;
  end

  always@(posedge rc_clk, negedge rst_n) begin
    if(!rst_n)
      data_out4 <= 30'b0;
    else if (rc_ready)
      data_out4 <= {data_in[29:25],7'b0,dst_list_W,8'b0,data_in[8:1],1'b1};
    else
      data_out4 <= data_out4;
  end

  always@(posedge rc_clk, negedge rst_n) begin
    if(!rst_n)
      data_out5 <= 30'b0;
    else if (rc_ready)
      data_out5 <= {data_in[29:25],dst_list_N,9'b0,data_in[8:1],1'b1};
    else
      data_out5 <= data_out5;
  end


  always@(posedge rc_clk, negedge rst_n) begin
    if(!rst_n)
      direction_out1 <= 5'b00000;
    else if(!valid_in & rc_ready)
      direction_out1 <= 5'b00000;
    else if(!rc_ready)
      direction_out1 <= direction_out1;
    else
      direction_out1 <= 5'b00100;
  end

  always@(posedge rc_clk, negedge rst_n) begin
    if(!rst_n)
      direction_out2 <= 5'b00000;
    else if(!valid_in & rc_ready)
      direction_out2 <= 5'b00000;
    else if(!rc_ready)
      direction_out2 <= direction_out2;
    else
      direction_out2 <= 5'b00001;
  end

  always@(posedge rc_clk, negedge rst_n) begin
    if(!rst_n)
      direction_out3 <= 5'b00000;
    else if(!valid_in & rc_ready)
      direction_out3 <= 5'b00000;
    else if(!rc_ready)
      direction_out3 <= direction_out3;
    else
      direction_out3 <= 5'b00010;
  end

  always@(posedge rc_clk, negedge rst_n) begin
    if(!rst_n)
      direction_out4 <= 5'b00000;
    else if(!valid_in & rc_ready)
      direction_out4 <= 5'b00000;
    else if(!rc_ready)
      direction_out4 <= direction_out4;
    else
      direction_out4 <= 5'b10000;
  end

  
  always@(posedge rc_clk, negedge rst_n) begin
    if(!rst_n)
      direction_out5 <= 5'b00000;
    else if(!valid_in & rc_ready)
      direction_out5 <= 5'b00000;
    else if(!rc_ready)
      direction_out5 <= direction_out5;
    else
      direction_out5 <= 5'b01000;
  end

endmodule