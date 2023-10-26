
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

        output	reg	[DATASIZE-1:0]	L_data_out,
        output	reg	[DATASIZE-1:0]	W_data_out,
        output	reg	[DATASIZE-1:0]	N_data_out,
        output	reg	[DATASIZE-1:0]	E_data_out,
        output	reg	[DATASIZE-1:0]	S_data_out,

        input	wire	L_valid_in,
        input	wire	W_valid_in,
        input	wire	N_valid_in,
        input	wire	E_valid_in,
        input	wire	S_valid_in,

        output	reg	L_valid_out,
        output	reg	W_valid_out,
        output	reg	N_valid_out,
        output	reg	E_valid_out,
        output	reg	S_valid_out,

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

    wire	[DATASIZE-1:0] data_out;
    wire [4:0] direction_out;

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

    wire  [DATASIZE-1:0]  data_out_W1;
    wire  [DATASIZE-1:0]  data_out_W2;
    wire  [DATASIZE-1:0]  data_out_W3;
    wire  [DATASIZE-1:0]  data_out_N1;
    wire  [DATASIZE-1:0]  data_out_N2;
    wire  [DATASIZE-1:0]  data_out_N3;   
    
    wire[4:0] Nm_label1;
    wire[4:0] Wm_label1;
    wire[4:0] Nm_label2;
    wire[4:0] Wm_label2;
    wire[4:0] Nm_label3;
    wire[4:0] Wm_label3;

    rc_multicast_sub #(
        .DEPTH(DEPTH),
        .WIDTH(WIDTH),
        .DATASIZE(DATASIZE),
        .router_ID(router_ID)
    
        ) rc_multicast_W (
        .data_out1(data_out_W1),
        .data_out2(data_out_W2),
        .data_out3(data_out_W3),
        .direction_out1(Wm_label1),
        .direction_out2(Wm_label2),
        .direction_out3(Wm_label3),
        .data_in(W_data_in),
        .valid_in(W_valid_out_fifo & W_data_out_fifo[0]),
        .rc_ready(W_ready),
        
        .rc_clk(clk),
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
        .direction_out1(Nm_label1),
        .direction_out2(Nm_label2),
        .direction_out3(Nm_label3),
        .data_in(N_data_in),
        .valid_in(N_valid_out_fifo & N_data_out_fifo[0]),
        .rc_ready(N_ready),
        
        .rc_clk(clk),
        .rst_n(rst_n)
        );

    wire [2:0] grantE;
    wire [2:0] grantS;
    wire [2:0] grantL;

    wire [2:0] reqE;
    wire [2:0] reqS;
    wire [2:0] reqL; 

    assign reqE = {Wm_label1[2],Nm_label1[2], direction_out[2]};
    assign reqS = {Wm_label3[1],Nm_label3[1], direction_out[1]};
    assign reqL = {Wm_label2[0],Nm_label2[0], direction_out[0]};


    RR_arbiter#(
        .N(3)
    ) arbiterE(
        .clk(clk),
		.rst_n(rst_n),
        .req(reqE),
        .grant(grantE)
    );

    RR_arbiter#(
        .N(3)
    ) arbiterS(
        .clk(clk),
		.rst_n(rst_n),
        .req(reqS),
        .grant(grantS)
    );

    RR_arbiter#(
        .N(3)
    ) arbiterL(
        .clk(clk),
		.rst_n(rst_n),
        .req(reqL),
        .grant(grantL)
    );
    reg[DATASIZE-1:0]	L_data_src;
	reg[DATASIZE-1:0]	E_data_src;
	reg[DATASIZE-1:0]	S_data_src;

	reg	L_port_valid;
	reg	E_port_valid;
	reg	S_port_valid;


    always @(*) begin
		case(grantE)
			3'b001:begin
				E_data_src = data_src;
				E_port_valid = 1;
			end
			3'b010:begin
				E_data_src = data_out_N1;
				E_port_valid = 1;
			end
			3'b100:begin
				E_data_src = data_out_W1;
				E_port_valid = 1;
			end
			default:begin
				E_data_src	=	'h0;
				E_port_valid=0;
			end
			endcase
	end

    always @(*) begin
		case(grantS)
			3'b001:begin
				S_data_src = data_src;
				S_port_valid = 1;
			end
			3'b010:begin
				S_data_src = data_out_N3;
				S_port_valid = 1;
			end
			3'b100:begin
				S_data_src = data_out_W3;
				S_port_valid = 1;
			end
			default:begin
				S_data_src	=	'h0;
				S_port_valid=0;
			end
			endcase
	end

    always @(*) begin
		case(grantL)
			3'b001:begin
				L_data_src = data_src;
				L_port_valid = 1;
			end
			3'b010:begin
				L_data_src = data_out_N2;
				L_port_valid = 1;
			end
			3'b100:begin
				L_data_src = data_out_W2;
				L_port_valid = 1;
			end
			default:begin
				L_data_src	=	'h0;
				L_port_valid=0;
			end
			endcase
	end

    always @(posedge clk or posedge rst_n) begin
        if (!rst_n) begin

                L_valid_out	<=		0;
                L_data_out	<=		0;
        end
        else begin
                L_valid_out	<=		L_port_valid;
                L_data_out	<=		L_data_src;
        end
    end


    always @(posedge clk or posedge rst_n) begin
        if (!rst_n) begin

                W_valid_out	<=		0;
                W_data_out	<=		0;
        end
        else if(!W_full_in)begin
                W_valid_out		<=		W_valid_out_fifo;
                W_data_out			<=		W_data_out_fifo;
        end
        else begin
                W_valid_out		<=		W_valid_out;
                W_data_out			<=		W_data_out;
        end
    end

    always @(posedge clk or posedge rst_n) begin
        if (!rst_n) begin

                E_valid_out	<=		0;
                E_data_out	<=		0;
        end
        else if(!E_full_in)begin
                E_valid_out		<=		E_port_valid;
                E_data_out			<=		E_data_src;
        end
        else begin
                E_valid_out		<=		E_valid_out;
                E_data_out			<=		E_data_out;
        end
    end

    always @(posedge clk or posedge rst_n) begin
        if (!rst_n) begin

                N_valid_out	<=		0;
                N_data_out	<=		0;
        end
        else if(!N_full_in)begin
                N_valid_out		<=		N_valid_out_fifo	;
                N_data_out			<=		N_data_out_fifo;
        end
        else begin
                N_valid_out		<=		N_valid_out;
                N_data_out			<=		N_data_out;
        end
    end


    always @(posedge clk or posedge rst_n) begin
        if (!rst_n) begin

                S_valid_out	<=		0;
                S_data_out	<=		0;
        end
        else if(!S_full_in)begin
                S_valid_out		<=		S_port_valid;
                S_data_out			<=		S_data_src;
        end
        else begin
                S_valid_out		<=		S_valid_out;
                S_data_out			<=		S_data_out;
        end
    end



  
endmodule
    