interface fifo_if #(parameter DATA_WIDTH=8)(input logic clk,input logic rst_n);
  logic wr_en, rd_en;
  logic [DATA_WIDTH-1:0] wr_data, rd_data;
  logic full, empty;
  logic [$clog2(16):0] count;
  task do_write(input logic [DATA_WIDTH-1:0] d); @(posedge clk); wr_data<=d; wr_en<=1; @(posedge clk); wr_en<=0; endtask
  task do_read(); @(posedge clk); rd_en<=1; @(posedge clk); rd_en<=0; endtask
endinterface
