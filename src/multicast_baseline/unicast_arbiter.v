`include "RR_arbiter.v"
module unicast_arbiter#(
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
		input	wire[4:0]	N_label,
		input	wire[4:0]	E_label,
		input	wire[4:0]	S_label,
		input	wire[4:0]	W_label,

        input	wire[DATASIZE-1:0]	L_data_in,
        input	wire[DATASIZE-1:0]	E_data_in,
        input	wire[DATASIZE-1:0]	S_data_in,
        input	wire[DATASIZE-1:0]	W_data_in,
        input	wire[DATASIZE-1:0]	N_data_in,

        input	wire	N_full,
        input	wire	S_full,
        input	wire	E_full,
        input	wire	W_full,

        output	wire	N_ready,
        output	wire	S_ready,
        output	wire	E_ready,
        output	wire	W_ready,
        output	wire	L_ready,

        input wire ua_clk,
        input wire rst_n
    );

    wire [4:0] grantW;
    wire [4:0] grantN;
    wire [4:0] grantE;
    wire [4:0] grantS;
    wire [4:0] grantL;

    wire [4:0] reqW;
    wire [4:0] reqN;
    wire [4:0] reqE;
    wire [4:0] reqS;
    wire [4:0] reqL; 

    assign reqW = {W_label[4],N_label[4],E_label[4],S_label[4],L_label[4]};
    assign reqN = {W_label[3],N_label[3],E_label[3],S_label[3],L_label[3]};
    assign reqE = {W_label[2],N_label[2],E_label[2],S_label[2],L_label[2]};
    assign reqS = {W_label[1],N_label[1],E_label[1],S_label[1],L_label[1]};
    assign reqL = {W_label[0],N_label[0],E_label[0],S_label[0],L_label[0]};

    RR_arbiter#(
        .N(5)
    ) arbiterW(
        .clk(ua_clk),
		.rst_n(rst_n),
        .req(reqW),
        .grant(grantW)
    );

    RR_arbiter#(
        .N(5)
    ) arbiterN(
        .clk(ua_clk),
		.rst_n(rst_n),
        .req(reqN),
        .grant(grantN)
    );

    RR_arbiter#(
        .N(5)
    ) arbiterE(
        .clk(ua_clk),
		.rst_n(rst_n),
        .req(reqE),
        .grant(grantE)
    );

    RR_arbiter#(
        .N(5)
    ) arbiterS(
        .clk(ua_clk),
		.rst_n(rst_n),
        .req(reqS),
        .grant(grantS)
    );

    RR_arbiter#(
        .N(5)
    ) arbiterL(
        .clk(ua_clk),
		.rst_n(rst_n),
        .req(reqL),
        .grant(grantL)
    );


    assign W_ready = ~(| W_label) | (grantW[4] & ~W_full) | (grantN[4] & ~N_full) | (grantE[4] & ~E_full) | (grantS[4] & ~S_full) | (grantL[4]);
    assign N_ready = ~(| N_label) | (grantW[3] & ~W_full) | (grantN[3] & ~N_full) | (grantE[3] & ~E_full) | (grantS[3] & ~S_full) | (grantL[3]);
    assign E_ready = ~(| E_label) | (grantW[2] & ~W_full) | (grantN[2] & ~N_full) | (grantE[2] & ~E_full) | (grantS[2] & ~S_full) | (grantL[2]);
    assign S_ready = ~(| S_label) | (grantW[1] & ~W_full) | (grantN[1] & ~N_full) | (grantE[1] & ~E_full) | (grantS[1] & ~S_full) | (grantL[1]);
    assign L_ready = ~(| L_label) | (grantW[0] & ~W_full) | (grantN[0] & ~N_full) | (grantE[0] & ~E_full) | (grantS[0] & ~S_full) | (grantL[0]);

    reg[DATASIZE-1:0]	L_data_src;
	reg[DATASIZE-1:0]	E_data_src;
	reg[DATASIZE-1:0]	S_data_src;
	reg[DATASIZE-1:0]	W_data_src;
	reg[DATASIZE-1:0]	N_data_src;


	reg	L_port_valid;
	reg	N_port_valid;
	reg	E_port_valid;
	reg	W_port_valid;
	reg	S_port_valid;

    always @(*) begin
		case(grantW)
			5'b00001:begin
				W_data_src = L_data_in;
				W_port_valid = 1;
			end
			5'b00010:begin
				W_data_src= S_data_in;
				W_port_valid=1;
			end
			5'b00100:begin
				W_data_src= E_data_in;
				W_port_valid=1;
			end
			5'b01000:begin
				W_data_src= N_data_in;
				W_port_valid=1;
			end
			5'b10000:begin
				W_data_src=W_data_in;
				W_port_valid=1;
			end

			default:begin
				W_data_src	=	'h0;
				W_port_valid=0;
			end
			endcase
	end

    
    always @(*) begin
		case(grantN)
			5'b00001:begin
				N_data_src = L_data_in;
				N_port_valid = 1;
			end
			5'b00010:begin
				N_data_src= S_data_in;
				N_port_valid=1;
			end
			5'b00100:begin
				N_data_src= E_data_in;
				N_port_valid=1;
			end
			5'b01000:begin
				N_data_src= N_data_in;
				N_port_valid=1;
			end
			5'b10000:begin
				N_data_src=W_data_in;
				N_port_valid=1;
			end

			default:begin
				N_data_src	=	'h0;
				N_port_valid=0;
			end
			endcase
	end

    always @(*) begin
		case(grantE)
			5'b00001:begin
				E_data_src = L_data_in;
				E_port_valid = 1;
			end
			5'b00010:begin
				E_data_src= S_data_in;
				E_port_valid=1;
			end
			5'b00100:begin
				E_data_src= E_data_in;
				E_port_valid=1;
			end
			5'b01000:begin
				E_data_src= N_data_in;
				E_port_valid=1;
			end
			5'b10000:begin
				E_data_src=W_data_in;
				E_port_valid=1;
			end

			default:begin
				E_data_src	=	'h0;
				E_port_valid=0;
			end
			endcase
	end

    always @(*) begin
		case(grantS)
			5'b00001:begin
				S_data_src = L_data_in;
				S_port_valid = 1;
			end
			5'b00010:begin
				S_data_src= S_data_in;
				S_port_valid=1;
			end
			5'b00100:begin
				S_data_src= E_data_in;
				S_port_valid=1;
			end
			5'b01000:begin
				S_data_src= N_data_in;
				S_port_valid=1;
			end
			5'b10000:begin
				S_data_src=W_data_in;
				S_port_valid=1;
			end

			default:begin
				S_data_src	=	'h0;
				S_port_valid=0;
			end
			endcase
	end

    always @(*) begin
		case(grantL)
			5'b00001:begin
				L_data_src = L_data_in;
				L_port_valid = 1;
			end
			5'b00010:begin
				L_data_src= S_data_in;
				L_port_valid=1;
			end
			5'b00100:begin
				L_data_src= E_data_in;
				L_port_valid=1;
			end
			5'b01000:begin
				L_data_src= N_data_in;
				L_port_valid=1;
			end
			5'b10000:begin
				L_data_src=W_data_in;
				L_port_valid=1;
			end

			default:begin
				L_data_src	=	'h0;
				L_port_valid=0;
			end
			endcase
	end

    always @(posedge ua_clk or posedge rst_n) begin
        if (!rst_n) begin

                L_valid_out	<=		0;
                L_data_out	<=		0;
        end
        else begin
                L_valid_out	<=		L_port_valid;
                L_data_out	<=		L_data_src;
        end
    end


    always @(posedge ua_clk or posedge rst_n) begin
        if (!rst_n) begin

                W_valid_out	<=		0;
                W_data_out	<=		0;
        end
        else if(!W_full)begin
                W_valid_out		<=		W_port_valid;
                W_data_out			<=		W_data_src;
        end
        else begin
                W_valid_out		<=		W_valid_out;
                W_data_out			<=		W_data_out;
        end
    end

    always @(posedge ua_clk or posedge rst_n) begin
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

    always @(posedge ua_clk or posedge rst_n) begin
        if (!rst_n) begin

                N_valid_out	<=		0;
                N_data_out	<=		0;
        end
        else if(!N_full)begin
                N_valid_out		<=		N_port_valid;
                N_data_out			<=		N_data_src;
        end
        else begin
                N_valid_out		<=		N_valid_out;
                N_data_out			<=		N_data_out;
        end
    end


    always @(posedge ua_clk or posedge rst_n) begin
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