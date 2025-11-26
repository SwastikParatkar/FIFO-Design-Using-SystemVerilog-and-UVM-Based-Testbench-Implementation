import pkg_fifo::*; import uvm_pkg::*; `include "uvm_macros.svh"
class fifo_cov extends uvm_subscriber#(fifo_item);
  `uvm_component_utils(fifo_cov)
  covergroup cg @(posedge uvm_root::get().get_time()); coverpoint item.data; endgroup
  fifo_item item; function new(string n,uvm_component p=null); super.new(n,p); cg=new; endfunction
  function void write(fifo_item t); item=t; if(t.op==OP_WRITE) cg.sample(); endfunction
endclass
