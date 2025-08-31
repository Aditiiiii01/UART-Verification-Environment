interface uart_if(input logic clk, input logic rst_n);
  logic tx;
  logic rx;

  // Clocking block for synchronous signals
  clocking cb @(posedge clk);
    input rx;
    output tx;
  endclocking

endinterface
