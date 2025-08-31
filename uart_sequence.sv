`timescale 1ns/1ps
import uvm_pkg::*;
`include "uvm_macros.svh"

class uart_sequence extends uvm_sequence #(uart_transaction);
  `uvm_object_utils(uart_sequence)

  function new(string name = "uart_sequence");
    super.new(name);
  endfunction

  virtual task body();
    uart_transaction tr;
    repeat (20) begin // Number of transactions
      tr = uart_transaction::type_id::create("tr");
      assert(tr.randomize()); // Random data
      start_item(tr);
      finish_item(tr);
    end
  endtask
endclass
