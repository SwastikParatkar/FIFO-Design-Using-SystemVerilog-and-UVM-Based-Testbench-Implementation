import pkg_fifo::*; import uvm_pkg::*; `include "uvm_macros.svh"
class fifo_driver extends uvm_driver#(fifo_item);
  virtual fifo_if vif;
  `uvm_component_utils(fifo_driver)
  function new(string n,uvm_component p); super.new(n,p); endfunction
  function void build_phase(uvm_phase p); if(!uvm_config_db#(virtual fifo_if)::get(this,"","vif",vif)) `uvm_fatal("NOVIF",""); endfunction
  task run_phase(uvm_phase p);
    fifo_item req;
    forever begin
      seq_item_port.get_next_item(req);
      if(req.op==OP_WRITE) begin do @(posedge vif.clk); while(vif.full); vif.do_write(req.data); end
      else if(req.op==OP_READ) begin do @(posedge vif.clk); while(vif.empty); vif.do_read(); end
      seq_item_port.item_done();
    end
  endtask
endclass
