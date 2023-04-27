`timescale 1ns/1ps

module RRA_tb;

parameter N = 4;

initial begin
	$vcdplusfile("RRA_tb.vpd");
	$vcdplusmemon;
	$vcdpluson;

	$fsdbDumpfile("RRA_tb.fsdb"); 		//指定生成的的fsdb
	$fsdbDumpvars(0,RRA_tb);   //0表示生成scalar_dut模块及以下所有的仿真数据
end

class reqRand;
    rand bit [N-1:0] req;
endclass

logic clk;
logic rst_n;
logic [N-1:0] req;
logic [N-1:0] grant;

reqRand rand_req;

RR_arbiter
#(
    .N(N)
)
RR_u
(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .req    (req    ),
    .grant  (grant  )
);

task generateReq();
    @(posedge clk);
    rand_req.randomize();
    req <= rand_req.req;
endtask

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    rst_n = 0;
    #20 rst_n = 1;
end

initial begin
    rand_req = new();
    req = 'b0;
    wait(rst_n == 1);
    repeat(1000) generateReq();

    $finish();
end

endmodule
