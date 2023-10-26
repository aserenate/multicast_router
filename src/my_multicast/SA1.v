`include "unicast_arbiter.v"

module SA#(
    parameter DEPTH=4,
    parameter WIDTH=2,
    parameter DATASIZE=30,
    parameter router_ID=6
    )(
        output	reg	[DATASIZE-1:0]	L_data_out,
        output	reg	[DATASIZE-1:0]	W_data_out,
        output	reg	[DATASIZE-1:0]	N_data_out,
        output	reg	[DATASIZE-1:0]	E_data_out,
        output	reg	[DATASIZE-1:0]	S_data_out,

        output	reg	L_valid_out,
        output	reg	W_valid_out,
        output	reg	N_valid_out,
        output	reg	E_valid_out,
        output	reg	S_valid_out,

        input	wire[4:0]	L_label,
		input	wire[4:0]	Nu_label,
		input	wire[4:0]	E_label,
		input	wire[4:0]	S_label,
		input	wire[4:0]	Wu_label,
		input	wire[4:0]	Nm_label1,
		input	wire[4:0]	Wm_label1,
		input	wire[4:0]	Nm_label2,
		input	wire[4:0]	Wm_label2,
		input	wire[4:0]	Nm_label3,
		input	wire[4:0]	Wm_label3,

        input	wire[DATASIZE-1:0]	L_data_in,
        input	wire[DATASIZE-1:0]	E_data_in,
        input	wire[DATASIZE-1:0]	S_data_in,
        input	wire[DATASIZE-1:0]	Wu_data_in,
        input	wire[DATASIZE-1:0]	Nu_data_in,
        input	wire[DATASIZE-1:0]	Wm_data_in1,
        input	wire[DATASIZE-1:0]	Nm_data_in1,
        input	wire[DATASIZE-1:0]	Wm_data_in2,
        input	wire[DATASIZE-1:0]	Nm_data_in2,
        input	wire[DATASIZE-1:0]	Wm_data_in3,
        input	wire[DATASIZE-1:0]	Nm_data_in3,

        input	wire	N_full,
        input	wire	S_full,
        input	wire	E_full,
        input	wire	W_full,

        output	wire	Nu_ready,
        output	wire	Nm_ready,
        output	wire	S_ready,
        output	wire	E_ready,
        output	wire	Wu_ready,
        output	wire	Wm_ready,
        output	wire	L_ready,

        input wire clk,
        input wire rst_n
    );

    wire	[DATASIZE-1:0]	Lu_data_out;
    wire	[DATASIZE-1:0]	Wu_data_out;
    wire	[DATASIZE-1:0]	Nu_data_out;
    wire	[DATASIZE-1:0]	Eu_data_out;
    wire	[DATASIZE-1:0]	Su_data_out;

    wire	Lu_valid_out;
    wire	Wu_valid_out;
    wire	Nu_valid_out;
    wire	Eu_valid_out;
    wire	Su_valid_out;

    unicast_arbiter #(
        .DEPTH(DEPTH),
        .WIDTH(WIDTH),
        .DATASIZE(DATASIZE),
        .router_ID(router_ID)
        ) unicast_arbiter(
  
      .ua_clk(clk),
      .rst_n(rst_n),
  
      .L_label(L_label),
      .W_label(Wu_label),
      .N_label(Nu_label),
      .E_label(E_label),
      .S_label(S_label),
  
      .L_data_in(L_data_in),
      .W_data_in(Wu_data_in),
      .N_data_in(Nu_data_in),
      .E_data_in(E_data_in),
      .S_data_in(S_data_in),
  
  
      .N_full(N_full_in),
      .S_full(S_full_in),
      .E_full(E_full_in),
      .W_full(W_full_in),
  
      .N_ready(Nu_ready),
      .W_ready(Wu_ready),
      .E_ready(E_ready),
      .S_ready(S_ready),
      .L_ready(L_ready),
  
  
      .L_valid_out(Lu_valid_out),
      .W_valid_out(Wu_valid_out),
      .N_valid_out(Nu_valid_out),
      .E_valid_out(Eu_valid_out),
      .S_valid_out(Su_valid_out),
  
      .L_data_out(Lu_data_out),
      .E_data_out(Eu_data_out),
      .S_data_out(Su_data_out),
      .W_data_out(Wu_data_out),
      .N_data_out(Nu_data_out)
  
    );


    wire	[DATASIZE-1:0]	Lm_data_out;
    wire	[DATASIZE-1:0]	Em_data_out;
    wire	[DATASIZE-1:0]	Sm_data_out;

    wire	Lm_valid_out;
    wire	Em_valid_out;
    wire	Sm_valid_out;

    multicast_arbiter #(
        .DEPTH(DEPTH),
        .WIDTH(WIDTH),
        .DATASIZE(DATASIZE),
        .router_ID(router_ID)
        ) multicast_arbiter(
            .ma_clk(clk),
            .rst_n(rst_n),
        
            .W_label1(Wm_label1),
            .N_label1(Nm_label1),
            .W_label2(Wm_label2),
            .N_label2(Nm_label2),
            .W_label3(Wm_label3),
            .N_label3(Nm_label3),
        
            .W_data_in1(Wm_data_in1),
            .N_data_in1(Nm_data_in1),
            .W_data_in2(Wm_data_in2),
            .N_data_in2(Nm_data_in2),
            .W_data_in3(Wm_data_in3),
            .N_data_in3(Nm_data_in3),
        
        
            .N_full(N_full_in),
            .S_full(S_full_in),
            .E_full(E_full_in),
            .W_full(W_full_in),
        
            .N_ready(Nm_ready),
            .W_ready(Wm_ready),
                
            .L_valid_out(Lm_valid_out),
            .E_valid_out(Em_valid_out),
            .S_valid_out(Sm_valid_out),
        
            .L_data_out(Lm_data_out),
            .E_data_out(Em_data_out),
            .S_data_out(Sm_data_out)
    );


    wire [1:0] grantE;
    wire [1:0] grantS;
    wire [1:0] grantL;

    wire [1:0] reqE;
    wire [1:0] reqS;
    wire [1:0] reqL; 

    assign reqE = {Em_valid_out,Eu_valid_out};
    assign reqS = {Sm_valid_out,Su_valid_out};
    assign reqL = {Lm_valid_out,Lu_valid_out};


    RR_arbiter#(
        .N(2)
    ) arbiterE(
        .clk(clk),
		.rst_n(rst_n),
        .req(reqE),
        .grant(grantE)
    );

    RR_arbiter#(
        .N(2)
    ) arbiterS(
        .clk(clk),
		.rst_n(rst_n),
        .req(reqS),
        .grant(grantS)
    );

    RR_arbiter#(
        .N(2)
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
			2'b01:begin
				E_data_src = Eu_data_out;
				E_port_valid = 1;
			end
			2'b10:begin
				E_data_src= Em_data_out;
				E_port_valid=1;
			end

			default:begin
				E_data_src	=	'h0;
				E_port_valid=0;             
			end
			endcase
	end

    always @(*) begin
		case(grantL)
			2'b01:begin
				L_data_src = Lu_data_out;
				L_port_valid = 1;               
			end
			2'b10:begin
				L_data_src= Lm_data_out;
				L_port_valid=1;             
			end

			default:begin
				L_data_src	=	'h0;
				L_port_valid=0;               
			end
			endcase
	end   

    always @(*) begin
		case(grantS)
			2'b01:begin
				S_data_src = Su_data_out;
				S_port_valid = 1;              
			end
			2'b10:begin
				S_data_src= Sm_data_out;
				S_port_valid=1;              
			end

			default:begin
				S_data_src	=	'h0;
				S_port_valid=0;            
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
        else if(!W_full)begin
                W_valid_out		<=		Wu_valid_out;
                W_data_out			<=		Wu_data_out;
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
        else if(!E_full)begin
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
        else if(!N_full)begin
                N_valid_out		<=		Nu_valid_out	;
                N_data_out			<=		Nu_data_out;
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
        else if(!S_full)begin
                S_valid_out		<=		S_port_valid;
                S_data_out			<=		S_data_src;
        end
        else begin
                S_valid_out		<=		S_valid_out;
                S_data_out			<=		S_data_out;
        end
    end

endmodule