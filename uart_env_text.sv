class uart_env_test extends uvm_test;
  `uvm_component_utils(uart_env_test)

  uart_env env;

  virtual function void build_phase(uvm_phase phase);
    env = uart_env::type_id::create("env", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    uart_sequence seq;
    phase.raise_objection(this);
    seq = uart_sequence::type_id::create("seq");
    seq.start(env.sequencer);
    phase.drop_objection(this);
  endtask
endclass
