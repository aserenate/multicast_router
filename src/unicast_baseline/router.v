
module router#(
    parameter DEPTH=4,
    parameter WIDTH=2,
    parameter DATASIZE=30,
    parameter router_ID=6
    )(
        input 	wire	clk,
        input 	wire	rst_n,
        output  wire    full,

        input	wire	[DATASIZE-1:0]	L_data_in,
        input	wire	[DATASIZE-1:0]	W_data_in,
        input	wire	[DATASIZE-1:0]	N_data_in,
        input	wire	[DATASIZE-1:0]	E_data_in,
        input	wire	[DATASIZE-1:0]	S_data_in,

        output	wire	[DATASIZE-1:0]	L_data_out,
        output	wire	[DATASIZE-1:0]	W_data_out,
        output	wire	[DATASIZE-1:0]	N_data_out,
        output	wire	[DATASIZE-1:0]	E_data_out,
        output	wire	[DATASIZE-1:0]	S_data_out,

        input	wire	L_valid_in,
        input	wire	W_valid_in,
        input	wire	N_valid_in,
        input	wire	E_valid_in,
        input	wire	S_valid_in,

        output	wire	L_valid_out,
        output	wire	W_valid_out,
        output	wire	N_valid_out,
        output	wire	E_valid_out,
        output	wire	S_valid_out,

        input	wire	W_full_in,
        input	wire	N_full_in,
        input	wire	E_full_in,
        input	wire	S_full_in,
    
        output	wire	W_full_out,
        output	wire	N_full_out,
        output	wire	E_full_out,
        output	wire	S_full_out
    
    );

    wire	[DATASIZE-1:0]  W_data_out_fifo;
    wire	[DATASIZE-1:0]  N_data_out_fifo;
    wire	[DATASIZE-1:0]  L_data_out_fifo;
    wire	[DATASIZE-1:0]  E_data_out_fifo;
    wire	[DATASIZE-1:0]  S_data_out_fifo;

    wire	W_valid_out_fifo;
    wire	N_valid_out_fifo;
    wire	L_valid_out_fifo;
    wire	E_valid_out_fifo;
    wire	S_valid_out_fifo;

    wire  W_ready;
    wire  N_ready; 
    wire  L_ready;
    wire  E_ready;
    wire  S_ready;

    fifo#(
        .DEPTH(DEPTH),
        .WIDTH(WIDTH),
        .DATASIZE(DATASIZE)
        ) fifo(

        .N_data_out(N_data_out_fifo),
        .N_valid_out(N_valid_out_fifo),
        .N_full_out(N_full_out),
        .N_data_in(N_data_in),
        .N_valid_in(N_valid_in),
        .fifo_ready_N(N_ready),     
  
        .E_data_out(E_data_out_fifo),
        .E_valid_out(E_valid_out_fifo),
        .E_full_out(E_full_out),
        .E_data_in(E_data_in),
        .E_valid_in(E_valid_in),
        .fifo_ready_E(E_ready),
  
        .S_data_out(S_data_out_fifo),
        .S_valid_out(S_valid_out_fifo),
        .S_full_out(S_full_out),
        .S_data_in(S_data_in),
        .S_valid_in(S_valid_in),
        .fifo_ready_S(S_ready),
  
        .W_data_out(W_data_out_fifo),
        .W_valid_out(W_valid_out_fifo),
        .W_full_out(W_full_out),
        .W_data_in(W_data_in),
        .W_valid_in(W_valid_in),
        .fifo_ready_W(W_ready),
  
        .L_data_out(L_data_out_fifo),
        .L_valid_out(L_valid_out_fifo),
        .L_full_out(full),
        .L_data_in(L_data_in),
        .L_valid_in(L_valid_in),
        .fifo_ready_L(L_ready),
    
        .fifo_clk(clk),
        .rst_n(rst_n)
    );

    wire[4:0] L_label;
    wire[4:0] N_label;
    wire[4:0] E_label;
    wire[4:0] S_label;
    wire[4:0] W_label;

    wire  [DATASIZE-1:0]  L_data_out_rc;
    wire  [DATASIZE-1:0]  W_data_out_rc;
    wire  [DATASIZE-1:0]  N_data_out_rc;
    wire  [DATASIZE-1:0]  E_data_out_rc;
    wire  [DATASIZE-1:0]  S_data_out_rc;

    rc_unicast#(
        .DEPTH(DEPTH),
        .WIDTH(WIDTH),
        .DATASIZE(DATASIZE),
        .router_ID(router_ID)
        ) rc_unicast(

        .data_out_1(N_data_out_rc),
        .direction_out_1(N_label),
        .N_data_in(N_data_out_fifo),
        .N_valid_in(N_valid_out_fifo),
        .rc_ready_N(N_ready),
        
        .data_out_2(E_data_out_rc),
        .direction_out_2(E_label),
        .E_data_in(E_data_out_fifo),
        .E_valid_in(E_valid_out_fifo),
        .rc_ready_E(E_ready),
      
        .data_out_3(W_data_out_rc),
        .direction_out_3(W_label),
        .W_data_in(W_data_out_fifo),
        .W_valid_in(W_valid_out_fifo),
        .rc_ready_W(W_ready),
      
        .data_out_4(S_data_out_rc),
        .direction_out_4(S_label),
        .S_data_in(S_data_out_fifo),
        .S_valid_in(S_valid_out_fifo),
        .rc_ready_S(S_ready),
      
        .data_out_5(L_data_out_rc),
        .direction_out_5(L_label),
        .L_data_in(L_data_out_fifo),
        .L_valid_in(L_valid_out_fifo),
        .rc_ready_L(L_ready),
      
        .rc_clk(clk),
        .rst_n(rst_n)

    );

    unicast_arbiter #(
        .DEPTH(DEPTH),
        .WIDTH(WIDTH),
        .DATASIZE(DATASIZE),
        .router_ID(router_ID)
        ) unicast_arbiter(
  
      .ua_clk(clk),
      .rst_n(rst_n),
  
      .L_label(L_label),
      .W_label(W_label),
      .N_label(N_label),
      .E_label(E_label),
      .S_label(S_label),
  
      .L_data_in(L_data_out_rc),
      .W_data_in(W_data_out_rc),
      .N_data_in(N_data_out_rc),
      .E_data_in(E_data_out_rc),
      .S_data_in(S_data_out_rc),
  
  
      .N_full(N_full_in),
      .S_full(S_full_in),
      .E_full(E_full_in),
      .W_full(W_full_in),
  
      .N_ready(N_ready),
      .W_ready(W_ready),
      .E_ready(E_ready),
      .S_ready(S_ready),
      .L_ready(L_ready),
  
  
      .L_valid_out(L_valid_out),
      .W_valid_out(W_valid_out),
      .N_valid_out(N_valid_out),
      .E_valid_out(E_valid_out),
      .S_valid_out(S_valid_out),
  
      .L_data_out(L_data_out),
      .E_data_out(E_data_out),
      .S_data_out(S_data_out),
      .W_data_out(W_data_out),
      .N_data_out(N_data_out)
  
    );
  
endmodule
    