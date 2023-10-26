`include "fifo_sub.v"

module fifo#(
  parameter DEPTH=4,
  parameter WIDTH=2,
  parameter DATASIZE=30
  )(
  output wire[DATASIZE-1:0] N_data_out,
  output wire N_valid_out,
  output wire N_full_out,

  input wire[DATASIZE-1:0] N_data_in,
  input wire N_valid_in,
  input wire fifo_ready_N,

  output wire[DATASIZE-1:0] E_data_out,
  output wire E_valid_out,
  output wire E_full_out,

  input wire[DATASIZE-1:0] E_data_in,
  input wire E_valid_in,
  input wire fifo_ready_E,

  output wire[DATASIZE-1:0] S_data_out,
  output wire S_valid_out,
  output wire S_full_out,

  input wire[DATASIZE-1:0] S_data_in,
  input wire S_valid_in,
  input wire fifo_ready_S,

  output wire[DATASIZE-1:0] W_data_out,
  output wire W_valid_out,
  output wire W_full_out,


  input wire[DATASIZE-1:0] W_data_in,
  input wire W_valid_in,
  input wire fifo_ready_W,

  output wire[DATASIZE-1:0] L_data_out,
  output wire L_valid_out,
  output wire L_full_out,

  input wire[DATASIZE-1:0] L_data_in,
  input wire L_valid_in,
  input wire fifo_ready_L,
  
  input wire fifo_clk,
  input wire rst_n
  );
  
  fifo_sub #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH),
    .DATASIZE(DATASIZE)
    ) fifo_N_unicast (
    .wdata(N_data_in),
    .full(N_full_out),
    .wr_en(N_valid_in),
    .rd_en(fifo_ready_N),
    .empty_n(N_valid_out),
    .rdata(N_data_out),
    
    .fifo_clk(fifo_clk),
    .rst_n(rst_n)
    );
  
  fifo_sub #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH),
    .DATASIZE(DATASIZE)
    ) fifo_E_unicast (
    .wdata(E_data_in),
    .full(E_full_out),
    .wr_en(E_valid_in),
    .rd_en(fifo_ready_E),
    .empty_n(E_valid_out),
    .rdata(E_data_out),
    
    .fifo_clk(fifo_clk),
    .rst_n(rst_n)
    );

  fifo_sub #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH),
    .DATASIZE(DATASIZE)
    ) fifo_S_unicast (
    .wdata(S_data_in),
    .full(S_full_out),
    .wr_en(S_valid_in),
    .rd_en(fifo_ready_S),
    .empty_n(S_valid_out),
    .rdata(S_data_out),
    
    .fifo_clk(fifo_clk),
    .rst_n(rst_n)
    );
  
    fifo_sub #(
      .DEPTH(DEPTH),
      .WIDTH(WIDTH),
      .DATASIZE(DATASIZE)
      ) fifo_W_unicast (
      .wdata(W_data_in),
      .full(W_full_out),
      .wr_en(W_valid_in),
      .rd_en(fifo_ready_W),
      .empty_n(W_valid_out),
      .rdata(W_data_out),
      
      .fifo_clk(fifo_clk),
      .rst_n(rst_n)
      );

  fifo_sub #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH),
    .DATASIZE(DATASIZE)
    ) fifo_L_unicast (
    .wdata(L_data_in),
    .full(L_full_out),
    .wr_en(L_valid_in),
    .rd_en(fifo_ready_L),
    .empty_n(L_valid_out),
    .rdata(L_data_out),
    
    .fifo_clk(fifo_clk),
    .rst_n(rst_n)
    );
  
endmodule