// FIFO RTL
module fifo #(parameter DATA_WIDTH=8, DEPTH=16, ADDR_WIDTH=$clog2(DEPTH))(
    input  logic clk,rst_n, wr_en, rd_en,
    input  logic [DATA_WIDTH-1:0] wr_data,
    output logic full, empty,
    output logic [DATA_WIDTH-1:0] rd_data,
    output logic [ADDR_WIDTH:0] count
);
    logic [DATA_WIDTH-1:0] mem [DEPTH-1:0];
    logic [ADDR_WIDTH-1:0] wptr,rptr;
    logic [ADDR_WIDTH:0] cnt;
    assign full=(cnt==DEPTH); assign empty=(cnt==0); assign count=cnt; assign rd_data=mem[rptr];
    always_ff @(posedge clk or negedge rst_n) begin
      if(!rst_n) begin wptr<=0;rptr<=0;cnt<=0; end
      else begin
        if(wr_en && !full) begin mem[wptr]<=wr_data; wptr<=wptr+1; end
        if(rd_en && !empty) rptr<=rptr+1;
        case({wr_en && !full, rd_en && !empty})
          2'b10: cnt<=cnt+1;
          2'b01: cnt<=cnt-1;
          default: cnt<=cnt;
        endcase
      end
    end
endmodule
