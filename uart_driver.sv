`timescale 1ns/1ps
import uvm_pkg::*;
`include "uvm_macros.svh"

// Transaction class for UART
class uart_transaction extends uvm_sequence_item;
  rand bit [7:0] data;
  
  `uvm_object_utils(uart_transaction)
  
  function new(string name = "uart_transaction");
    super.new(name);
  endfunction
endclass

// Driver class
class uart_driver extends uvm_driver #(uart_transaction);
  `uvm_component_utils(uart_driver)
  
  virtual interface uart_if vif; // Connect this to your UART signals
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    if(!uvm_config_db#(virtual uart_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface not set for driver")
  endfunction

  virtual task run_phase(uvm_phase phase);
    uart_transaction tr;
    forever begin
      seq_item_port.get_next_item(tr); // Get transaction from sequence
      // Drive data to DUT
      vif.tx_data <= tr.data;
      // Add timing/waiting as per UART protocol
      seq_item_port.item_done();
    end
  endtask
endclass
