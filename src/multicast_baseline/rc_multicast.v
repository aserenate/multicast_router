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

  output wire[DATASIZE-1:0] data_out_W4,
  output wire[4:0] direction_out_W4,
  
  output wire[DATASIZE-1:0] data_out_W5,
  output wire[4:0] direction_out_W5,

  input wire[DATASIZE-1:0] W_data_in,
  input wire W_valid_in,
  input wire rc_ready_W,


  output wire[DATASIZE-1:0] data_out_N1,
  output wire[4:0] direction_out_N1,
  
  output wire[DATASIZE-1:0] data_out_N2,
  output wire[4:0] direction_out_N2,

  output wire[DATASIZE-1:0] data_out_N3,
  output wire[4:0] direction_out_N3,

  output wire[DATASIZE-1:0] data_out_N4,
  output wire[4:0] direction_out_N4,
  
  output wire[DATASIZE-1:0] data_out_N5,
  output wire[4:0] direction_out_N5,

  input wire[DATASIZE-1:0] N_data_in,
  input wire N_valid_in,
  input wire rc_ready_N,


  output wire[DATASIZE-1:0] data_out_L1,
  output wire[4:0] direction_out_L1,
  
  output wire[DATASIZE-1:0] data_out_L2,
  output wire[4:0] direction_out_L2,

  output wire[DATASIZE-1:0] data_out_L3,
  output wire[4:0] direction_out_L3,

  output wire[DATASIZE-1:0] data_out_L4,
  output wire[4:0] direction_out_L4,
  
  output wire[DATASIZE-1:0] data_out_L5,
  output wire[4:0] direction_out_L5,

  input wire[DATASIZE-1:0] L_data_in,
  input wire L_valid_in,
  input wire rc_ready_L,


  output wire[DATASIZE-1:0] data_out_E1,
  output wire[4:0] direction_out_E1,
  
  output wire[DATASIZE-1:0] data_out_E2,
  output wire[4:0] direction_out_E2,

  output wire[DATASIZE-1:0] data_out_E3,
  output wire[4:0] direction_out_E3,

  output wire[DATASIZE-1:0] data_out_E4,
  output wire[4:0] direction_out_E4,
  
  output wire[DATASIZE-1:0] data_out_E5,
  output wire[4:0] direction_out_E5,

  input wire[DATASIZE-1:0] E_data_in,
  input wire E_valid_in,
  input wire rc_ready_E,

  output wire[DATASIZE-1:0] data_out_S1,
  output wire[4:0] direction_out_S1,
  
  output wire[DATASIZE-1:0] data_out_S2,
  output wire[4:0] direction_out_S2,

  output wire[DATASIZE-1:0] data_out_S3,
  output wire[4:0] direction_out_S3,

  output wire[DATASIZE-1:0] data_out_S4,
  output wire[4:0] direction_out_S4,
  
  output wire[DATASIZE-1:0] data_out_S5,
  output wire[4:0] direction_out_S5,

  input wire[DATASIZE-1:0] S_data_in,
  input wire S_valid_in,
  input wire rc_ready_S,

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
    .data_out4(data_out_W4),
    .data_out5(data_out_W5),
    .direction_out1(direction_out_W1),
    .direction_out2(direction_out_W2),
    .direction_out3(direction_out_W3),
    .direction_out4(direction_out_W4),
    .direction_out5(direction_out_W5),
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
      .data_out4(data_out_N4),
      .data_out5(data_out_N5),
      .direction_out1(direction_out_N1),
      .direction_out2(direction_out_N2),
      .direction_out3(direction_out_N3),
      .direction_out4(direction_out_N4),
      .direction_out5(direction_out_N5),
      .data_in(N_data_in),
      .valid_in(N_valid_in),
      .rc_ready(rc_ready_N),
      
      .rc_clk(rc_clk),
      .rst_n(rst_n)
      );

      rc_multicast_sub #(
        .DEPTH(DEPTH),
        .WIDTH(WIDTH),
        .DATASIZE(DATASIZE),
        .router_ID(router_ID)
    
        ) rc_multicast_L (
        .data_out1(data_out_L1),
        .data_out2(data_out_L2),
        .data_out3(data_out_L3),
        .data_out4(data_out_L4),
        .data_out5(data_out_L5),
        .direction_out1(direction_out_L1),
        .direction_out2(direction_out_L2),
        .direction_out3(direction_out_L3),
        .direction_out4(direction_out_L4),
        .direction_out5(direction_out_L5),
        .data_in(L_data_in),
        .valid_in(L_valid_in),
        .rc_ready(rc_ready_L),
        
        .rc_clk(rc_clk),
        .rst_n(rst_n)
        );

        rc_multicast_sub #(
          .DEPTH(DEPTH),
          .WIDTH(WIDTH),
          .DATASIZE(DATASIZE),
          .router_ID(router_ID)
      
          ) rc_multicast_E (
          .data_out1(data_out_E1),
          .data_out2(data_out_E2),
          .data_out3(data_out_E3),
          .data_out4(data_out_E4),
          .data_out5(data_out_E5),
          .direction_out1(direction_out_E1),
          .direction_out2(direction_out_E2),
          .direction_out3(direction_out_E3),
          .direction_out4(direction_out_E4),
          .direction_out5(direction_out_E5),
          .data_in(E_data_in),
          .valid_in(E_valid_in),
          .rc_ready(rc_ready_E),
          
          .rc_clk(rc_clk),
          .rst_n(rst_n)
          );

          rc_multicast_sub #(
            .DEPTH(DEPTH),
            .WIDTH(WIDTH),
            .DATASIZE(DATASIZE),
            .router_ID(router_ID)
        
            ) rc_multicast_S (
            .data_out1(data_out_S1),
            .data_out2(data_out_S2),
            .data_out3(data_out_S3),
            .data_out4(data_out_S4),
            .data_out5(data_out_S5),
            .direction_out1(direction_out_S1),
            .direction_out2(direction_out_S2),
            .direction_out3(direction_out_S3),
            .direction_out4(direction_out_S4),
            .direction_out5(direction_out_S5),
            .data_in(S_data_in),
            .valid_in(S_valid_in),
            .rc_ready(rc_ready_S),
            
            .rc_clk(rc_clk),
            .rst_n(rst_n)
            );


endmodule