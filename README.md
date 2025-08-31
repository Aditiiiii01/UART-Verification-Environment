# UART RTL and UVM Verification Environment

## Overview
This repository contains a UART (Universal Asynchronous Receiver/Transmitter) design in Verilog along with a complete UVM-based verification environment in SystemVerilog. The project demonstrates constrained-random verification, functional coverage, and self-checking testbenches for a robust UART IP.

## Repository Structure
- `uart.v` : UART RTL (Verilog)
- `uart_if.sv` : UART interface (SystemVerilog)
- `uart_driver.sv` : UVM driver
- `uart_monitor.sv` : UVM monitor
- `uart_scoreboard.sv` : UVM scoreboard
- `uart_sequence.sv` : UVM sequence
- `uart_env.sv` : UVM environment
- `uart_env_test.sv` : UVM test class
- `uart_tb.sv` : Top-level testbench

## Features
- UART transmitter and receiver implementation
- UVM environment with driver, monitor, sequence, and scoreboard
- Constrained-random test generation
- Self-checking testbenches
- Functional coverage for TX/RX operations
- Compatible with standard simulators like ModelSim and QuestaSim

## Getting Started
1. Clone the repository:
   ```bash
   git clone <repository_url>
Compile all RTL and UVM files with your simulator.

Run the testbench (uart_tb.sv) to start the verification environment.

Usage
Modify uart_sequence.sv to add or change test scenarios.

Use coverage reports to check functional completeness.

Add additional monitors or scoreboards if extending the environment.
## Note
Simulation:
The complete UVM-based verification environment can be simulated using a UVM-enabled SystemVerilog simulator (e.g., QuestaSim, VCS). Simulation files are included in the repository; simulation results will be added once the local setup is fully operational.


## Author
Aditi Vishal Paunikar

Email: aditivpaunikar@gmail.com

LinkedIn: linkedin.com/in/aditi-vishal-paunikar-9ba789259
