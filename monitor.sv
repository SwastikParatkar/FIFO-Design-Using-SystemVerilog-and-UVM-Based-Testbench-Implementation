import pkg_fifo::*; import uvm_pkg::*; `include "uvm_macros.svh"
class fifo_monitor extends uvm_component;
  virtual fifo_if vif; uvm_analysis_port#(fifo_item) ap;
  `uvm_component_utils(fifo_monitor)
  function new(string n,uvm_component p); super.new(n,p); ap=new("ap",this); endfunction
  function void build_phase(uvm_phase p); if(!uvm_config_db#(virtual fifo_if)::get(this,"","vif",vif)) `uvm_fatal("NOVIF",""); endfunction
  task run_phase(uvm_phase p);
    fifo_item t;
    forever begin @(posedge vif.clk);
      if(vif.wr_en && !vif.full) begin t=new(); t.op=OP_WRITE; t.data=vif.wr_data; ap.write(t); end
      if(vif.rd_en && !vif.empty) begin t=new(); t.op=OP_READ; t.data=vif.rd_data; ap.write(t); end
    end end
  endtask
endclass
