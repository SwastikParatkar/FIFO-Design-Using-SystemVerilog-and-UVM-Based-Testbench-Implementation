package pkg_fifo;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  typedef enum {OP_NONE,OP_WRITE,OP_READ} op_e;
  class fifo_item extends uvm_sequence_item;
    rand op_e op; rand bit [7:0] data;
    constraint c { if(op==OP_WRITE) data inside {[0:255]}; }
    `uvm_object_utils_begin(fifo_item)
      `uvm_field_enum(op_e,op,UVM_DEFAULT)
      `uvm_field_int(data,UVM_DEFAULT)
    `uvm_object_utils_end
    function new(string n="fifo_item"); super.new(n); endfunction
  endclass
endpackage
