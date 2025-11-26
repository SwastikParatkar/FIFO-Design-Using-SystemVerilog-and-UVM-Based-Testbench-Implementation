import pkg_fifo::*; import uvm_pkg::*; `include "uvm_macros.svh"
class fifo_env extends uvm_env;
  fifo_agent a; fifo_scoreboard sb; fifo_cov cv;
  `uvm_component_utils(fifo_env)
  function new(string n,uvm_component p); super.new(n,p); endfunction
  function void build_phase(uvm_phase p); a=fifo_agent::type_id::create("agent",this); sb=fifo_scoreboard::type_id::create("sb",this); cv=fifo_cov::type_id::create("cv",this); endfunction
  function void connect_phase(uvm_phase p); a.mon.ap.connect(sb.ae); a.mon.ap.connect(cv.analysis_export); endfunction
endclass
