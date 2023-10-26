`include "RR_arbiter.v"
`include "unicast_arbiter.v"

module multicast_arbiter#(
    parameter DEPTH=4,
    parameter WIDTH=2,
    parameter DATASIZE=30,
    parameter router_ID=6
    )(
        output	wire	[DATASIZE-1:0]	L_data_out,
        output	wire	[DATASIZE-1:0]	W_data_out,
        output	wire	[DATASIZE-1:0]	N_data_out,
        output	wire	[DATASIZE-1:0]	E_data_out,
        output	wire	[DATASIZE-1:0]	S_data_out,

        output	wire	L_valid_out,
        output	wire	W_valid_out,
        output	wire	N_valid_out,
        output	wire	E_valid_out,
        output	wire	S_valid_out,

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

        input	wire	Nu_full,
        input	wire	Nm_full,
        input	wire	S_full,
        input	wire	E_full,
        input	wire	Wu_full,
        input	wire	Wm_full,

        output	wire	Nu_ready,
        output	wire	Nm_ready,
        output	wire	S_ready,
        output	wire	E_ready,
        output	wire	Wu_ready,
        output	wire	Nm_ready,
        output	wire	L_ready,

        input wire ma_clk,
        input wire rst_n
    );