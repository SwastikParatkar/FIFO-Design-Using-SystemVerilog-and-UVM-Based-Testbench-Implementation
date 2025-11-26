module fifo_assertions #(parameter DATA_WIDTH=8,DEPTH=16)(
  input logic clk,rst_n,wr_en,rd_en,full,empty,
  input logic [$clog2(DEPTH):0] count
);
  property no_write_when_full; @(posedge clk) disable iff(!rst_n) full && wr_en |-> 0; endproperty
  assert property(no_write_when_full);

  property no_read_when_empty; @(posedge clk) disable iff(!rst_n) empty && rd_en |-> 0; endproperty
  assert property(no_read_when_empty);
endmodule
