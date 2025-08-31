`timescale 1ns/1ps
import uvm_pkg::*;
`include "uvm_macros.svh"

class uart_monitor extends uvm_monitor;
  `uvm_component_utils(uart_monitor)

  virtual uart_if vif; // virtual interface

  uvm_analysis_port #(uart_transaction) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  task run_phase(uvm_phase phase);
    uart_transaction tr;
    forever begin
      @(posedge vif.clk);
      if (vif.tx_valid) begin
        tr = uart_transaction::type_id::create("tr");
        tr.data = vif.tx_data;
        tr.valid = vif.tx_valid;
        ap.write(tr);
      end
    end
  endtask
endclass
