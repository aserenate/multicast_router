
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

    wire	[DATASIZE-1:0]  Wu_data_out_fifo;
    wire	[DATASIZE-1:0]  Nu_data_out_fifo;
    wire	[DATASIZE-1:0]  Wm_data_out_fifo;
    wire	[DATASIZE-1:0]  Nm_data_out_fifo;
    wire	[DATASIZE-1:0]  L_data_out_fifo;
    wire	[DATASIZE-1:0]  E_data_out_fifo;
    wire	[DATASIZE-1:0]  S_data_out_fifo;

    wire	Wu_valid_out_fifo;
    wire	Nu_valid_out_fifo;
    wire	Wm_valid_out_fifo;
    wire	Nm_valid_out_fifo;
    wire	L_valid_out_fifo;
    wire	E_valid_out_fifo;
    wire	S_valid_out_fifo;

    wire  Wu_ready;
    wire  Nu_ready;
    wire  Wm_ready;
    wire  Nm_ready;    
    wire  L_ready;
    wire  E_ready;
    wire  S_ready;
    wire  Nu_full_out;
    wire  Nm_full_out;
    wire  Wu_full_out;
    wire  Wm_full_out;

    assign N_full_out = Nu_full_out | Nm_full_out;
    assign W_full_out = Wu_full_out | Wm_full_out;

    fifo#(
        .DEPTH(DEPTH),
        .WIDTH(WIDTH),
        .DATASIZE(DATASIZE)
        ) fifo(

        .N_data_out_u(Nu_data_out_fifo),
        .N_valid_out_u(Nu_valid_out_fifo),
        .N_full_out_u(Nu_full_out),
        .N_data_out_m(Nm_data_out_fifo),
        .N_valid_out_m(Nm_valid_out_fifo),
        .N_full_out_m(Nm_full_out),
        .N_data_in(N_data_in),
        .N_valid_in(N_valid_in),
        .fifo_ready_Nu(Nu_ready),
        .fifo_ready_Nm(Nm_ready),        
  
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
  
        .W_data_out_u(Wu_data_out_fifo),
        .W_valid_out_u(Wu_valid_out_fifo),
        .W_full_out_u(Wu_full_out),
        .W_data_out_m(Wm_data_out_fifo),
        .W_valid_out_m(Wm_valid_out_fifo),
        .W_full_out_m(Wm_full_out),
        .W_data_in(W_data_in),
        .W_valid_in(W_valid_in),
        .fifo_ready_Wu(Wu_ready),
        .fifo_ready_Wm(Wm_ready),
  
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
    wire[4:0] Nu_label;
    wire[4:0] E_label;
    wire[4:0] S_label;
    wire[4:0] Wu_label;
    wire[4:0] Nm_label1;
    wire[4:0] Wm_label1;
    wire[4:0] Nm_label2;
    wire[4:0] Wm_label2;
    wire[4:0] Nm_label3;
    wire[4:0] Wm_label3;

    wire  [DATASIZE-1:0]  L_data_out_rc;
    wire  [DATASIZE-1:0]  Wu_data_out_rc;
    wire  [DATASIZE-1:0]  Nu_data_out_rc;
    wire  [DATASIZE-1:0]  E_data_out_rc;
    wire  [DATASIZE-1:0]  S_data_out_rc;
    wire  [DATASIZE-1:0]  Wm_data_out1_rc;
    wire  [DATASIZE-1:0]  Nm_data_out1_rc;
    wire  [DATASIZE-1:0]  Wm_data_out2_rc;
    wire  [DATASIZE-1:0]  Nm_data_out2_rc;
    wire  [DATASIZE-1:0]  Wm_data_out3_rc;
    wire  [DATASIZE-1:0]  Nm_data_out3_rc;

    rc_unicast#(
        .DEPTH(DEPTH),
        .WIDTH(WIDTH),
        .DATASIZE(DATASIZE),
        .router_ID(router_ID)
        ) rc_unicast(

        .data_out_1(Nu_data_out_rc),
        .direction_out_1(Nu_label),
        .N_data_in(Nu_data_out_fifo),
        .N_valid_in(Nu_valid_out_fifo),
        .rc_ready_N(Nu_ready),
        
        .data_out_2(E_data_out_rc),
        .direction_out_2(E_label),
        .E_data_in(E_data_out_fifo),
        .E_valid_in(E_valid_out_fifo),
        .rc_ready_E(E_ready),
      
        .data_out_3(Wu_data_out_rc),
        .direction_out_3(Wu_label),
        .W_data_in(Wu_data_out_fifo),
        .W_valid_in(Wu_valid_out_fifo),
        .rc_ready_W(Wu_ready),
      
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

    rc_multicast#(
        .DEPTH(DEPTH),
        .WIDTH(WIDTH),
        .DATASIZE(DATASIZE),
        .router_ID(router_ID)
        ) rc_multicast(

        .data_out_N1(Nm_data_out1_rc),
        .direction_out_N1(Nm_label1),
        .data_out_N2(Nm_data_out2_rc),
        .direction_out_N2(Nm_label2),
        .data_out_N3(Nm_data_out3_rc),
        .direction_out_N3(Nm_label3),
        .N_data_in(Nm_data_out_fifo),
        .N_valid_in(Nm_valid_out_fifo),
        .rc_ready_N(Nm_ready),

        .data_out_W1(Wm_data_out1_rc),
        .direction_out_W1(Wm_label1),
        .data_out_W2(Wm_data_out2_rc),
        .direction_out_W2(Wm_label2),
        .data_out_W3(Wm_data_out3_rc),
        .direction_out_W3(Wm_label3),
        .W_data_in(Wm_data_out_fifo),
        .W_valid_in(Wm_valid_out_fifo),
        .rc_ready_W(Wm_ready),

        .rc_clk(clk),
        .rst_n(rst_n)
    );

    SA#(
        .DEPTH(DEPTH),
        .WIDTH(WIDTH),
        .DATASIZE(DATASIZE),
        .router_ID(router_ID)
        ) SA(
            .clk(clk),
            .rst_n(rst_n),
        
            .L_label(L_label),
            .Wu_label(Wu_label),
            .Nu_label(Nu_label),
            .E_label(E_label),
            .S_label(S_label),
            .Wm_label1(Wm_label1),
            .Nm_label1(Nm_label1),
            .Wm_label2(Wm_label2),
            .Nm_label2(Nm_label2),            
            .Wm_label3(Wm_label3),
            .Nm_label3(Nm_label3),
            
            .L_data_in(L_data_out_rc),
            .Wu_data_in(Wu_data_out_rc),
            .Nu_data_in(Nu_data_out_rc),
            .E_data_in(E_data_out_rc),
            .S_data_in(S_data_out_rc),
            .Wm_data_in1(Wm_data_out1_rc),
            .Nm_data_in1(Nm_data_out1_rc),            
            .Wm_data_in2(Wm_data_out2_rc),
            .Nm_data_in2(Nm_data_out2_rc),            
            .Wm_data_in3(Wm_data_out3_rc),
            .Nm_data_in3(Nm_data_out3_rc),    
            
            .N_full(N_full_in),
            .S_full(S_full_in),
            .E_full(E_full_in),
            .W_full(W_full_in),
        
            .Nu_ready(Nu_ready),
            .Wu_ready(Wu_ready),
            .Nm_ready(Nm_ready),
            .Wm_ready(Wm_ready),
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
    