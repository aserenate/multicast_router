
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

    wire[4:0] L_label1;
    wire[4:0] N_label1;
    wire[4:0] E_label1;
    wire[4:0] S_label1;
    wire[4:0] W_label1;

    wire[4:0] L_label2;
    wire[4:0] N_label2;
    wire[4:0] E_label2;
    wire[4:0] S_label2;
    wire[4:0] W_label2;

    wire[4:0] L_label3;
    wire[4:0] N_label3;
    wire[4:0] E_label3;
    wire[4:0] S_label3;
    wire[4:0] W_label3;

    wire[4:0] L_label4;
    wire[4:0] N_label4;
    wire[4:0] E_label4;
    wire[4:0] S_label4;
    wire[4:0] W_label4;

    wire[4:0] L_label5;
    wire[4:0] N_label5;
    wire[4:0] E_label5;
    wire[4:0] S_label5;
    wire[4:0] W_label5;

    wire  [DATASIZE-1:0]  L_data_out1_rc;
    wire  [DATASIZE-1:0]  W_data_out1_rc;
    wire  [DATASIZE-1:0]  N_data_out1_rc;
    wire  [DATASIZE-1:0]  E_data_out1_rc;
    wire  [DATASIZE-1:0]  S_data_out1_rc;

    wire  [DATASIZE-1:0]  L_data_out2_rc;
    wire  [DATASIZE-1:0]  W_data_out2_rc;
    wire  [DATASIZE-1:0]  N_data_out2_rc;
    wire  [DATASIZE-1:0]  E_data_out2_rc;
    wire  [DATASIZE-1:0]  S_data_out2_rc;

    wire  [DATASIZE-1:0]  L_data_out3_rc;
    wire  [DATASIZE-1:0]  W_data_out3_rc;
    wire  [DATASIZE-1:0]  N_data_out3_rc;
    wire  [DATASIZE-1:0]  E_data_out3_rc;
    wire  [DATASIZE-1:0]  S_data_out3_rc;

    wire  [DATASIZE-1:0]  L_data_out4_rc;
    wire  [DATASIZE-1:0]  W_data_out4_rc;
    wire  [DATASIZE-1:0]  N_data_out4_rc;
    wire  [DATASIZE-1:0]  E_data_out4_rc;
    wire  [DATASIZE-1:0]  S_data_out4_rc;

    wire  [DATASIZE-1:0]  L_data_out5_rc;
    wire  [DATASIZE-1:0]  W_data_out5_rc;
    wire  [DATASIZE-1:0]  N_data_out5_rc;
    wire  [DATASIZE-1:0]  E_data_out5_rc;
    wire  [DATASIZE-1:0]  S_data_out5_rc;

    rc_multicast#(
        .DEPTH(DEPTH),
        .WIDTH(WIDTH),
        .DATASIZE(DATASIZE),
        .router_ID(router_ID)
        ) rc_multicast(
        .data_out_W1(W_data_out1_rc),
        .data_out_W2(W_data_out2_rc),
        .data_out_W3(W_data_out3_rc),
        .data_out_W4(W_data_out4_rc),
        .data_out_W5(W_data_out5_rc),
        .direction_out_W1(W_label1),
        .direction_out_W2(W_label2),
        .direction_out_W3(W_label3),
        .direction_out_W4(W_label4),
        .direction_out_W5(W_label5),
        .W_data_in(W_data_out_fifo),
        .W_valid_in(W_valid_out_fifo),
        .rc_ready_W(W_ready),

        .data_out_N1(N_data_out1_rc),
        .data_out_N2(N_data_out2_rc),
        .data_out_N3(N_data_out3_rc),
        .data_out_N4(N_data_out4_rc),
        .data_out_N5(N_data_out5_rc),
        .direction_out_N1(N_label1),
        .direction_out_N2(N_label2),
        .direction_out_N3(N_label3),
        .direction_out_N4(N_label4),
        .direction_out_N5(N_label5),
        .N_data_in(N_data_out_fifo),
        .N_valid_in(N_valid_out_fifo),
        .rc_ready_N(N_ready),

        .data_out_L1(L_data_out1_rc),
        .data_out_L2(L_data_out2_rc),
        .data_out_L3(L_data_out3_rc),
        .data_out_L4(L_data_out4_rc),
        .data_out_L5(L_data_out5_rc),
        .direction_out_L1(L_label1),
        .direction_out_L2(L_label2),
        .direction_out_L3(L_label3),
        .direction_out_L4(L_label4),
        .direction_out_L5(L_label5),
        .L_data_in(L_data_out_fifo),
        .L_valid_in(L_valid_out_fifo),
        .rc_ready_L(L_ready),

        .data_out_E1(E_data_out1_rc),
        .data_out_E2(E_data_out2_rc),
        .data_out_E3(E_data_out3_rc),
        .data_out_E4(E_data_out4_rc),
        .data_out_E5(E_data_out5_rc),
        .direction_out_E1(E_label1),
        .direction_out_E2(E_label2),
        .direction_out_E3(E_label3),
        .direction_out_E4(E_label4),
        .direction_out_E5(E_label5),
        .E_data_in(E_data_out_fifo),
        .E_valid_in(E_valid_out_fifo),
        .rc_ready_E(E_ready),

        .data_out_S1(S_data_out1_rc),
        .data_out_S2(S_data_out2_rc),
        .data_out_S3(S_data_out3_rc),
        .data_out_S4(S_data_out4_rc),
        .data_out_S5(S_data_out5_rc),
        .direction_out_S1(S_label1),
        .direction_out_S2(S_label2),
        .direction_out_S3(S_label3),
        .direction_out_S4(S_label4),
        .direction_out_S5(S_label5),
        .S_data_in(S_data_out_fifo),
        .S_valid_in(S_valid_out_fifo),
        .rc_ready_S(S_ready),        


        .rc_clk(clk),
        .rst_n(rst_n)

    );

    multicast_arbiter #(
        .DEPTH(DEPTH),
        .WIDTH(WIDTH),
        .DATASIZE(DATASIZE),
        .router_ID(router_ID)
        ) multicast_arbiter(
  
      .ma_clk(clk),
      .rst_n(rst_n),
  
      .L_label1(L_label1),
      .W_label1(W_label1),
      .N_label1(N_label1),
      .E_label1(E_label1),
      .S_label1(S_label1),
  
      .L_data_in1(L_data_out1_rc),
      .W_data_in1(W_data_out1_rc),
      .N_data_in1(N_data_out1_rc),
      .E_data_in1(E_data_out1_rc),
      .S_data_in1(S_data_out1_rc),

      .L_label2(L_label2),
      .W_label2(W_label2),
      .N_label2(N_label2),
      .E_label2(E_label2),
      .S_label2(S_label2),
  
      .L_data_in2(L_data_out2_rc),
      .W_data_in2(W_data_out2_rc),
      .N_data_in2(N_data_out2_rc),
      .E_data_in2(E_data_out2_rc),
      .S_data_in2(S_data_out2_rc),

      .L_label3(L_label3),
      .W_label3(W_label3),
      .N_label3(N_label3),
      .E_label3(E_label3),
      .S_label3(S_label3),
  
      .L_data_in3(L_data_out3_rc),
      .W_data_in3(W_data_out3_rc),
      .N_data_in3(N_data_out3_rc),
      .E_data_in3(E_data_out3_rc),
      .S_data_in3(S_data_out3_rc),

      .L_label4(L_label4),
      .W_label4(W_label4),
      .N_label4(N_label4),
      .E_label4(E_label4),
      .S_label4(S_label4),
  
      .L_data_in4(L_data_out4_rc),
      .W_data_in4(W_data_out4_rc),
      .N_data_in4(N_data_out4_rc),
      .E_data_in4(E_data_out4_rc),
      .S_data_in4(S_data_out4_rc),

      .L_label5(L_label5),
      .W_label5(W_label5),
      .N_label5(N_label5),
      .E_label5(E_label5),
      .S_label5(S_label5),
  
      .L_data_in5(L_data_out5_rc),
      .W_data_in5(W_data_out5_rc),
      .N_data_in5(N_data_out5_rc),
      .E_data_in5(E_data_out5_rc),
      .S_data_in5(S_data_out5_rc),
  
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
    