`include "uvm_macros.svh"
import uvm_pkg::*;

module tb_top;
  logic clk, rst_n;
  msdap_if intf(clk, rst_n);

  // Instantiate DUT here (replace MSDAP with your DUT name)
  MSDAP dut (
    .clk(clk),
    .rst_n(rst_n),
    .in_data(intf.in_data),
    .in_valid(intf.in_valid),
    .out_data(intf.out_data),
    .out_valid(intf.out_valid)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Reset sequence
  initial begin
    rst_n = 0;
    #20 rst_n = 1;
  end

  // Start UVM test
  initial begin
    run_test("msdap_test");
  end
endmodule
