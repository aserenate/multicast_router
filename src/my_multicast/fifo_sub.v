
module fifo_sub #(
  parameter DEPTH = 4,// must be 2^x
  parameter WIDTH = 2,
  parameter DATASIZE=30
  ) (
  input wire[DATASIZE-1:0] wdata,
  output reg full,
  input wire wr_en,
  input wire rd_en,
  output reg[DATASIZE-1:0] rdata,
  output reg empty_n,

  input wire fifo_clk,
  input wire rst_n
  );
  
// register
  reg[DATASIZE-1:0] fifo[DEPTH-1:0];

// pointer
  reg[WIDTH:0] r_ptr;
  reg[WIDTH:0] w_ptr;
  
// read data
// assign  rdata = fifo[r_ptr[WIDTH-1:0]];
// read pointer move   
  always@(posedge fifo_clk, negedge rst_n) begin
    if(!rst_n)
      r_ptr <= {(WIDTH+1){1'b0}};
    else if(empty_n && rd_en)
      r_ptr <= r_ptr+1'b1;
    else
      r_ptr <= r_ptr;
  end    
 
// can read as soon as being written 
  always@(posedge fifo_clk, negedge rst_n) begin
    if(!rst_n)
      rdata <= 40'd0;
    else if(wr_en && ((rd_en && w_ptr == r_ptr + 1'b1) ||(!empty_n && w_ptr == r_ptr)))
      rdata <= wdata;
    else if(rd_en)
      rdata <= fifo[r_ptr[WIDTH-1:0]+1'b1];
    else
     // rdata <= fifo[r_ptr[WIDTH-1:0]];
      rdata <= rdata;
  end

  
//write data   
  always@(posedge fifo_clk, negedge rst_n) begin
    if(!rst_n)
      fifo[w_ptr[WIDTH-1:0]] <= fifo[w_ptr[WIDTH-1:0]];
    else if(!full & wr_en)
      fifo[w_ptr[WIDTH-1:0]] <= wdata;
    else
      fifo[w_ptr[WIDTH-1:0]] <= fifo[w_ptr[WIDTH-1:0]];
  end
  
//write pointer move
  always@(posedge fifo_clk, negedge rst_n) begin
    if(!rst_n)
      w_ptr <= {(WIDTH+1){1'b0}};
    else if(!full & wr_en)
      w_ptr <= w_ptr+1'b1;
    else
      w_ptr <= w_ptr;
  end

// empty and full   
  wire full_pre;
  wire full_hold;
  wire[WIDTH:0] r_ptr_add;
  wire[WIDTH:0] w_ptr_add;
  
  assign w_ptr_add = w_ptr +1'b1;
  assign r_ptr_add = r_ptr + 1'b1;
  assign full_pre = (!rd_en && w_ptr_add[WIDTH-1:0] == r_ptr[WIDTH-1:0] && w_ptr_add[WIDTH]^r_ptr[WIDTH]) || (rd_en && w_ptr[WIDTH-1:0] == r_ptr[WIDTH-1:0] && w_ptr[WIDTH]^r_ptr[WIDTH]);
  assign full_hold =(!rd_en && w_ptr[WIDTH-1:0] == r_ptr[WIDTH-1:0] && w_ptr[WIDTH]^r_ptr[WIDTH]) || (rd_en && w_ptr[WIDTH-1:0] == r_ptr_add[WIDTH-1:0] && w_ptr[WIDTH]^r_ptr_add[WIDTH]);
   
  always@(posedge fifo_clk, negedge rst_n) begin
    if(!rst_n)
      empty_n <= 1'b0;
    else if(rd_en && !wr_en && w_ptr == r_ptr_add)
      empty_n <= 1'b0;
    else if(!empty_n && !wr_en && w_ptr == r_ptr)
      empty_n <= 1'b0;
    else
      empty_n <= 1'b1;
  end
  
  always@(posedge fifo_clk, negedge rst_n) begin
    if(!rst_n)
      full <= 1'b0;
    else if(wr_en && full_pre)
      full <= 1'b1;
//    else if(full && (full_hold || full_pre))
    else if(full && full_hold)
      full <=1'b1;
    else
      full <= 1'b0;
  end

endmodule