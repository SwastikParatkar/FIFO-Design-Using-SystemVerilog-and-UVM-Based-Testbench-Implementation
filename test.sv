import pkg_fifo::*; import uvm_pkg::*; `include "uvm_macros.svh"
class fifo_test extends uvm_test;
  fifo_env env;
  `uvm_component_utils(fifo_test)
  function new(string n="fifo_test",uvm_component p=null); super.new(n,p); endfunction
  function void build_phase(uvm_phase p); env=fifo_env::type_id::create("env",this); endfunction
  task run_phase(uvm_phase p); fifo_sequence s=fifo_sequence::type_id::create("s"); p.raise_objection(this); s.start(env.agent.seqr); #10000; p.drop_objection(this); endtask
endclass
