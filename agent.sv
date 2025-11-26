import pkg_fifo::*; import uvm_pkg::*; `include "uvm_macros.svh"
class fifo_agent extends uvm_component;
  uvm_sequencer#(fifo_item) seqr; fifo_driver drv; fifo_monitor mon; virtual fifo_if vif;
  `uvm_component_utils(fifo_agent)
  function new(string n,uvm_component p); super.new(n,p); endfunction
  function void build_phase(uvm_phase p);
    seqr=uvm_sequencer#(fifo_item)::type_id::create("seqr",this);
    drv=fifo_driver::type_id::create("drv",this);
    mon=fifo_monitor::type_id::create("mon",this);
    uvm_config_db#(virtual fifo_if)::get(this,"","vif",vif);
    uvm_config_db#(virtual fifo_if)::set(this,"drv","vif",vif);
    uvm_config_db#(virtual fifo_if)::set(this,"mon","vif",vif);
  endfunction
  function void connect_phase(uvm_phase p); drv.seq_item_port.connect(seqr.seq_item_export); endfunction
endclass
