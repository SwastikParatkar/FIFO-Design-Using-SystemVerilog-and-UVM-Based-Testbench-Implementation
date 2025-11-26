// UVM top
`timescale 1ns/1ps
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "pkg_fifo.sv"
`include "fifo_if.sv"
`include "fifo_assertions.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "coverage.sv"
`include "agent.sv"
`include "env.sv"
`include "sequence.sv"
`include "test.sv"

module tb_top;
  parameter DATA_WIDTH=8; parameter DEPTH=16;
  logic clk; logic rst_n;
  fifo_if #(DATA_WIDTH) vif(clk,rst_n);
  logic [$clog2(DEPTH):0] count;

  fifo #(.DATA_WIDTH(DATA_WIDTH),.DEPTH(DEPTH)) dut(
    .clk(clk),.rst_n(rst_n),.wr_en(vif.wr_en),.wr_data(vif.wr_data),
    .full(vif.full),.rd_en(vif.rd_en),.rd_data(vif.rd_data),
    .empty(vif.empty),.count(count)
  );

  fifo_assertions #(.DATA_WIDTH(DATA_WIDTH),.DEPTH(DEPTH)) a(
    .clk(clk),.rst_n(rst_n),.wr_en(vif.wr_en),.rd_en(vif.rd_en),
    .full(vif.full),.empty(vif.empty),.count(count)
  );

  initial clk=0; always #5 clk=~clk;
  initial begin rst_n=0; vif.wr_en=0; vif.rd_en=0; vif.wr_data=0; #30 rst_n=1; end

  initial begin
    #1;
    uvm_config_db#(virtual fifo_if)::set(null,"env.agent","vif",vif);
    uvm_config_db#(virtual fifo_if)::set(null,"env.agent.driver","vif",vif);
    uvm_config_db#(virtual fifo_if)::set(null,"env.agent.monitor","vif",vif);
    run_test("fifo_test");
  end
endmodule
