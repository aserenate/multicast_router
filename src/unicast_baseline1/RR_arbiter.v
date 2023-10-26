module RR_arbiter
#(
    parameter N = 4
)
(
    input  wire clk,
    input  wire rst_n,
    input  wire [N-1:0] req,
    output reg [N-1:0] grant
);
    
wire [2*N-1:0] req_a, req_sub;
wire [2*N-1:0] grant_tmp;
    
    
assign req_a = {req, req};
assign req_sub = (|grant==0) ? req_a -  {{(2*N-1){1'b0}}, 1'b1} : req_a - {{(N-1){1'b0}}, grant,1'b0};
assign grant_tmp = req_a & (~req_sub);
    
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) grant <= 'b0;
    else begin
        grant <= (grant_tmp[2*N-1:N] | grant_tmp[N-1:0]);
    end
end
    
endmodule