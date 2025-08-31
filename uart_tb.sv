`timescale 1ns/1ps
import uvm_pkg::*;
`include "uvm_macros.svh"

// Include all your environment and DUT files
`include "uart_if.sv"
`include "uart_driver.sv"
`include "uart_monitor.sv"
`include "uart_scoreboard.sv"
`include "uart_env.sv"
`include "uart_sequence.sv"
`include "uart.v"

// Top-level test
module uart_testbench;

  // Clock and reset signals
  logic clk;
  logic rst_n;

  // Instantiate the interface
  uart_if uart_if_inst(.clk(clk), .rst_n(rst_n));

  // Instantiate the DUT (UART)
  uart dut (
    .clk(clk),
    .rst_n(rst_n),
    .tx(uart_if_inst.tx),
    .rx(uart_if_inst.rx)
    // Add other signals as per your UART design
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 100MHz clock
  end

  // Reset generation
  initial begin
    rst_n = 0;
    #20;
    rst_n = 1;
  end

  // Run UVM test
  initial begin
    // Set virtual interface
    uvm_config_db#(virtual uart_if)::set(null, "uvm_test_top.env.driver", "vif", uart_if_inst);
    uvm_config_db#(virtual uart_if)::set(null, "uvm_test_top.env.monitor", "vif", uart_if_inst);

    // Run the test
    run_test("uart_env_test");
  end

endmodule

// Define a UVM test class
class uart_env_test extends uvm_test;
  `uvm_component_utils(uart_env_test)

  uart_env env;

  function new(string name="uart_env_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = uart_env::type_id::create("env", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    uart_sequence seq;
    phase.raise_objection(this);

    seq = uart_sequence::type_id::create("seq");
    seq.start(env.sequencer); // Start the sequence on env's sequencer

    // Wait for sequence to complete (optional if sequence handles it)
    #1000ns;

    phase.drop_objection(this);
  endtask
endclass
