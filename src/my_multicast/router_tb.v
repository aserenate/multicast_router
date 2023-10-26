
module router_tb();

    parameter DEPTH=4;
    parameter WIDTH=2;
    parameter DATASIZE=30;
    parameter router_ID=6;

    reg	clk;
	reg	rst_n;

	reg	[DATASIZE-1:0]	L_data_in;
	reg	[DATASIZE-1:0]	N_data_in;
	reg	[DATASIZE-1:0]	E_data_in;
	reg	[DATASIZE-1:0]	S_data_in;
	reg	[DATASIZE-1:0]	W_data_in;

	wire	[DATASIZE-1:0]	L_data_out;
	wire	[DATASIZE-1:0]	N_data_out;
	wire	[DATASIZE-1:0]	E_data_out;
	wire	[DATASIZE-1:0]	S_data_out;
	wire	[DATASIZE-1:0]	W_data_out;

	reg	L_valid_in;
	reg	N_valid_in;
	reg	E_valid_in;
	reg	S_valid_in;
	reg	W_valid_in;

	wire	L_valid_out;
	wire	N_valid_out;
	wire	E_valid_out;
	wire	S_valid_out;
	wire	W_valid_out;

	reg	N_full_in;
	reg	E_full_in;
	reg	S_full_in;
	reg	W_full_in;

	wire	N_full_out;
	wire	E_full_out;
	wire	S_full_out;
	wire	W_full_out;

	router#(
        .DEPTH(DEPTH),
        .WIDTH(WIDTH),
        .DATASIZE(DATASIZE),
        .router_ID(router_ID)
        ) router_tb(
	.clk(clk),
	.rst_n(rst_n),

	.L_data_in(L_data_in),
	.N_data_in(N_data_in),
	.E_data_in(E_data_in),
	.S_data_in(S_data_in),
	.W_data_in(W_data_in),

	.L_data_out(L_data_out),
	.N_data_out(N_data_out),
	.E_data_out(E_data_out),
	.S_data_out(S_data_out),
	.W_data_out(W_data_out),

	.L_valid_in(L_valid_in),
	.N_valid_in(N_valid_in),
	.E_valid_in(E_valid_in),
	.S_valid_in(S_valid_in),
	.W_valid_in(W_valid_in),

	.L_valid_out(L_valid_out),
	.N_valid_out(N_valid_out),
	.E_valid_out(E_valid_out),
	.S_valid_out(S_valid_out),
	.W_valid_out(W_valid_out),

	.N_full_in(N_full_in),
	.E_full_in(E_full_in),
	.S_full_in(S_full_in),
	.W_full_in(W_full_in),

	.N_full_out(N_full_out),
	.E_full_out(E_full_out),
	.W_full_out(W_full_out),
	.S_full_out(S_full_out)
);

	initial begin
    clk = 1'b0;
    forever #50 clk = ~clk;
  	end

  	initial begin
            rst_n = 1'b0;
    #300    rst_n = 1'b1;
    end

    initial	begin
    	N_full_in=0;
    	W_full_in=0;    
    	E_full_in=1;
    	S_full_in=0;


    #800 E_full_in=0;
    #100 E_full_in=1;
    #100 E_full_in=0;
    end

    initial	begin
  	  		L_valid_in=1;
			N_valid_in=1;
			W_valid_in=1;		
			E_valid_in=1;
			S_valid_in=1;
	end


    initial	begin
    	L_data_in=30'b0110_0001_0000_0000_0000_0000000_0;	
		forever #100    L_data_in=L_data_in+2;
    end

    initial	begin   	
		E_data_in=30'b0111_0010_0000_0000_0000_0000000_0;
		forever #100	E_data_in=E_data_in+2;
    end

    initial	begin
		S_data_in=30'b0001_1000_0000_0000_0000_0000000_0;
		forever #100	S_data_in=S_data_in+2;
    end

    initial	begin    	
		N_data_in=30'b1011_0101_0000_0000_0000_0000000_0;
		forever #100	N_data_in=N_data_in+1;
    end

    initial	begin    	
		W_data_in=30'b0101_0000_0000_0000_0000_0000000_0;
		forever #100	W_data_in=W_data_in+1;
    end

endmodule
 