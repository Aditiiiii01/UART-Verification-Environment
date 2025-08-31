`timescale 1ns/1ps
import uvm_pkg::*;
`include "uvm_macros.svh"

class uart_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(uart_scoreboard)

  mailbox #(uart_transaction) expected_mb;
  mailbox #(uart_transaction) actual_mb;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    expected_mb = new();
    actual_mb = new();
  endfunction

  // Connect analysis ports from driver/monitor
  virtual function void write_expected(uart_transaction tr);
    expected_mb.put(tr);
  endfunction

  virtual function void write_actual(uart_transaction tr);
    actual_mb.put(tr);
  endfunction

  task run_phase(uvm_phase phase);
    uart_transaction exp_tr, act_tr;
    forever begin
      expected_mb.get(exp_tr);
      actual_mb.get(act_tr);
      if (exp_tr.data !== act_tr.data) begin
        `uvm_error("UART_SCOREBOARD", $sformatf("Mismatch! Expected: %0h, Actual: %0h", exp_tr.data, act_tr.data))
      end
      else begin
        `uvm_info("UART_SCOREBOARD", $sformatf("Match: %0h", act_tr.data), UVM_MEDIUM)
      end
    end
  endtask
endclass
