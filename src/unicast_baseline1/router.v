
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

        output	wire	[DATASIZE-1:0]	data_out,
        output  wire    [4:0] direction_out,

        input	wire	L_valid_in,
        input	wire	W_valid_in,
        input	wire	N_valid_in,
        input	wire	E_valid_in,
        input	wire	S_valid_in,

        output	wire	valid_out,

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

    reg  W_ready;
    reg  N_ready; 
    reg  L_ready;
    reg  E_ready;
    reg  S_ready;

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

    wire [4:0] req;
    assign req = {W_valid_out_fifo,N_valid_out_fifo,E_valid_out_fifo,S_valid_out_fifo,L_valid_out_fifo};

    RR_arbiter#(
        .N(5)
    ) arbiter(
        .clk(clk),
		.rst_n(rst_n),
        .req(req),
        .grant(grant)
    );

    reg[DATASIZE-1:0]	data_src;

    always @(*) begin
		case(grant)
			5'b00001:begin
				data_src = L_data_out_fifo;
                W_ready = 0;
                N_ready = 0;
                E_ready = 0;
                S_ready = 0;
				L_ready = 1;
			end
			5'b00010:begin
				data_src= S_data_out_fifo;
                W_ready = 0;
                N_ready = 0;
                E_ready = 0;
                S_ready = 1;
				L_ready = 0;
			end
			5'b00100:begin
				data_src= E_data_out_fifo;
                W_ready = 0;
                N_ready = 0;
                E_ready = 1;
                S_ready = 0;
				L_ready = 0;
			end
			5'b01000:begin
				data_src= N_data_out_fifo;
                W_ready = 0;
                N_ready = 1;
                E_ready = 0;
                S_ready = 0;
				L_ready = 0;
			end
			5'b10000:begin
				data_src=W_data_out_fifo;
                W_ready = 1;
                N_ready = 0;
                E_ready = 0;
                S_ready = 0;
				L_ready = 0;
			end

			default:begin
				data_src	=	'h0;
                W_ready = 0;
                N_ready = 0;
                E_ready = 0;
                S_ready = 0;
				L_ready = 0;
			end
			endcase
	end

    wire valid_in;

    assign valid_in = L_valid_out_fifo | S_valid_out_fifo | E_valid_out_fifo | N_valid_out_fifo | W_valid_out_fifo;

    rc_unicast_sub#(
        .DEPTH(DEPTH),
        .WIDTH(WIDTH),
        .DATASIZE(DATASIZE),
        .router_ID(router_ID)
        ) rc_unicast_sub(
        .data_out(data_out),
        .direction_out(direction_out),
        .data_in(data_src),
        .valid_in(valid_in),
        .rc_ready(W_ready | E_ready | N_ready | S_ready | L_ready),

        .rc_clk(clk),
        .rst_n(rst_n)        

        );


  
endmodule
    