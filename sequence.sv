import pkg_fifo::*; import uvm_pkg::*; `include "uvm_macros.svh"
class fifo_sequence extends uvm_sequence#(fifo_item);
  `uvm_object_utils(fifo_sequence)
  function new(string n="seq"); super.new(n); endfunction
  task body(); fifo_item it; repeat(50) begin it=fifo_item::type_id::create("it"); if($urandom_range(0,1)) it.op=OP_WRITE; else it.op=OP_READ; it.randomize(); start_item(it); finish_item(it); end endtask
endclass
