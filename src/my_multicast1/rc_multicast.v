`include "rc_multicast_sub.v"
module rc_multicast#(
  parameter DEPTH=4,
  parameter WIDTH=2,
  parameter DATASIZE=30,
  parameter router_ID=6
  )(
  output wire[DATASIZE-1:0] data_out_W1,
  output wire[4:0] direction_out_W1,
  
  output wire[DATASIZE-1:0] data_out_W2,
  output wire[4:0] direction_out_W2,

  output wire[DATASIZE-1:0] data_out_W3,
  output wire[4:0] direction_out_W3,

  input wire[DATASIZE-1:0] W_data_in,
  input wire W_valid_in,
  input wire rc_ready_W,

  output wire[DATASIZE-1:0] data_out_N1,
  output wire[4:0] direction_out_N1,
  
  output wire[DATASIZE-1:0] data_out_N2,
  output wire[4:0] direction_out_N2,

  output wire[DATASIZE-1:0] data_out_N3,
  output wire[4:0] direction_out_N3,

  input wire[DATASIZE-1:0] N_data_in,
  input wire N_valid_in,
  input wire rc_ready_N,

  input wire rc_clk,
  input wire rst_n
  );

  rc_multicast_sub #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH),
    .DATASIZE(DATASIZE),
    .router_ID(router_ID)

    ) rc_multicast_W (
    .data_out1(data_out_W1),
    .data_out2(data_out_W2),
    .data_out3(data_out_W3),
    .direction_out1(direction_out_W1),
    .direction_out2(direction_out_W2),
    .direction_out3(direction_out_W3),
    .data_in(W_data_in),
    .valid_in(W_valid_in),
    .rc_ready(rc_ready_W),
    
    .rc_clk(rc_clk),
    .rst_n(rst_n)
    );

  rc_multicast_sub #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH),
    .DATASIZE(DATASIZE),
    .router_ID(router_ID)

    ) rc_multicast_N (
    .data_out1(data_out_N1),
    .data_out2(data_out_N2),
    .data_out3(data_out_N3),
    .direction_out1(direction_out_N1),
    .direction_out2(direction_out_N2),
    .direction_out3(direction_out_N3),
    .data_in(N_data_in),
    .valid_in(N_valid_in),
    .rc_ready(rc_ready_N),
    
    .rc_clk(rc_clk),
    .rst_n(rst_n)
    );
endmodule