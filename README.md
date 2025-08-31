UART RTL and UVM Verification Environment
Overview

This repository contains a UART (Universal Asynchronous Receiver/Transmitter) design in Verilog along with a complete UVM-based verification environment in SystemVerilog.
The project demonstrates constrained-random verification, self-checking testbenches, and functional coverage for robust UART IP validation.

Repository Structure
File	Description
uart.v	UART RTL design (Verilog)
uart_if.sv	UART interface (SystemVerilog)
uart_driver.sv	UVM driver for generating transactions
uart_monitor.sv	UVM monitor for observing DUT signals
uart_scoreboard.sv	UVM scoreboard for checking correctness
uart_sequence.sv	UVM sequence defining constrained-random test scenarios
uart_env.sv	UVM environment integrating driver, monitor, and scoreboard
uart_env_test.sv	UVM test class to run sequences
uart_tb.sv	Top-level testbench (clock/reset, DUT instantiation, starts UVM)
Features

UART transmitter and receiver implementation

Full UVM verification environment with driver, monitor, sequence, and scoreboard

Constrained-random test generation for corner-case validation

Self-checking testbenches with assertions

Functional coverage for TX/RX operations

Compatible with UVM-enabled SystemVerilog simulators (ModelSim, QuestaSim, VCS)

Getting Started

Clone the repository:

git clone <repository_url>


Compile all RTL and UVM files with a UVM-enabled SystemVerilog simulator.

Run the top-level testbench (uart_tb.sv) to start the verification environment.

Usage

Modify uart_sequence.sv to add or change test scenarios.

Use functional coverage reports to check completeness.

Extend the environment by adding additional monitors or scoreboards if needed.

Simulation

Note: Simulation requires a UVM-enabled SystemVerilog simulator (QuestaSim, ModelSim, VCS).
Simulation files are included in the repository; simulation results will be added once the local setup is fully operational.

Author

Aditi Vishal Paunikar

Email: aditivpaunikar@gmail.com

LinkedIn: linkedin.com/in/aditi-vishal-paunikar-9ba789259
