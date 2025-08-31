`timescale 1ns/1ps
import uvm_pkg::*;
`include "uvm_macros.svh"

class uart_env extends uvm_env;
  
  `uvm_component_utils(uart_env)
  
  // Pointers to subcomponents
  uart_driver driver;
  uart_monitor monitor;
  uart_scoreboard scoreboard;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    driver = uart_driver::type_id::create("driver", this);
    monitor = uart_monitor::type_id::create("monitor", this);
    scoreboard = uart_scoreboard::type_id::create("scoreboard", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    // Later we’ll connect driver -> monitor -> scoreboard
  endfunction

endclass
