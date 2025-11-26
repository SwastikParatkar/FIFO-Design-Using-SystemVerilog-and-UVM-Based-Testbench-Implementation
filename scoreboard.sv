import pkg_fifo::*; import uvm_pkg::*; `include "uvm_macros.svh"
class fifo_scoreboard extends uvm_component;
  uvm_analysis_export#(fifo_item) ae; fifo_item q[$];
  `uvm_component_utils(fifo_scoreboard)
  function new(string n,uvm_component p); super.new(n,p); ae=new("ae",this); endfunction
  task run_phase(uvm_phase p);
    fifo_item t;
    forever begin ae.get(t);
      if(t.op==OP_WRITE) q.push_back(t);
      else if(t.op==OP_READ) begin
        if(q.size()==0) `uvm_error("SB","Underflow");
        else begin fifo_item g=q.pop_front(); if(g.data!=t.data) `uvm_error("SB","Mismatch"); end
      end
    end
  endtask
endclass
