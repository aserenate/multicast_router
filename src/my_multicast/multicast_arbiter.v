`include "RR_arbiter.v"
module multicast_arbiter#(
    parameter DEPTH=4,
    parameter WIDTH=2,
    parameter DATASIZE=30,
    parameter router_ID=6
    )(
        output	reg	[DATASIZE-1:0]	L_data_out,
        output	reg	[DATASIZE-1:0]	E_data_out,
        output	reg	[DATASIZE-1:0]	S_data_out,

        output	reg	L_valid_out,
        output	reg	E_valid_out,
        output	reg	S_valid_out,

        input	wire[4:0]	W_label1,
		input	wire[4:0]	N_label1,
        input	wire[4:0]	W_label2,
		input	wire[4:0]	N_label2,
        input	wire[4:0]	W_label3,
		input	wire[4:0]	N_label3,

        input	wire[DATASIZE-1:0]	W_data_in1,
        input	wire[DATASIZE-1:0]	N_data_in1,
        input	wire[DATASIZE-1:0]	W_data_in2,
        input	wire[DATASIZE-1:0]	N_data_in2,
        input	wire[DATASIZE-1:0]	W_data_in3,
        input	wire[DATASIZE-1:0]	N_data_in3,

        input	wire	N_full,
        input	wire	S_full,
        input	wire	E_full,
        input	wire	W_full,

        output	wire	N_ready,
        output	wire	W_ready,

        input wire ma_clk,
        input wire rst_n
    );

    wire [1:0] grantE;
    wire [1:0] grantS;
    wire [1:0] grantL;

    wire [1:0] reqE;
    wire [1:0] reqS;
    wire [1:0] reqL; 

    assign reqE = {W_label1[2],N_label1[2]};
    assign reqS = {W_label3[1],N_label3[1]};
    assign reqL = {W_label2[0],N_label2[0]};


    RR_arbiter#(
        .N(2)
    ) arbiterE(
        .clk(ma_clk),
		.rst_n(rst_n),
        .req(reqE),
        .grant(grantE)
    );

    RR_arbiter#(
        .N(2)
    ) arbiterS(
        .clk(ma_clk),
		.rst_n(rst_n),
        .req(reqS),
        .grant(grantS)
    );

    RR_arbiter#(
        .N(2)
    ) arbiterL(
        .clk(ma_clk),
		.rst_n(rst_n),
        .req(reqL),
        .grant(grantL)
    );


    assign W_ready = ~(| W_label1) | ~(| W_label2) | ~(| W_label3) | (grantE[1] & ~E_full) | (grantS[1] & ~S_full) | (grantL[1]);
    assign N_ready = ~(| N_label1) | ~(| N_label2) | ~(| N_label3) | (grantE[0] & ~E_full) | (grantS[0] & ~S_full) | (grantL[0]);


    reg[DATASIZE-1:0]	L_data_src;
	reg[DATASIZE-1:0]	E_data_src;
	reg[DATASIZE-1:0]	S_data_src;

	reg	L_port_valid;
	reg	E_port_valid;
	reg	S_port_valid;


    always @(*) begin
		case(grantE)
			2'b01:begin
				E_data_src = N_data_in1;
				E_port_valid = 1;
			end
			2'b10:begin
				E_data_src= W_data_in1;
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
				L_data_src = N_data_in2;
				L_port_valid = 1;
			end
			2'b10:begin
				L_data_src= W_data_in2;
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
				S_data_src = N_data_in3;
				S_port_valid = 1;
			end
			2'b10:begin
				S_data_src= W_data_in3;
				S_port_valid=1;
			end

			default:begin
				S_data_src	=	'h0;
				S_port_valid=0;
			end
			endcase
	end

    always @(posedge ma_clk or posedge rst_n) begin
        if (!rst_n) begin

                L_valid_out	<=		0;
                L_data_out	<=		0;
        end
        else begin
                L_valid_out	<=		L_port_valid;
                L_data_out	<=		L_data_src;
        end
    end


    always @(posedge ma_clk or posedge rst_n) begin
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

    always @(posedge ma_clk or posedge rst_n) begin
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