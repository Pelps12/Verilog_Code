`include "uvm_macros.svh"
import uvm_pkg::*;

module tb_top;
  logic clk, rst_n;
  msdap_if intf(clk, rst_n);

  // Instantiate DUT here (replace MSDAP with your DUT name)
  MSDAP dut (
  // Instantiate DUT here (replace MSDAP with your DUT name)
MSDAP dut (
    .Dclk(msdap_if_inst.Dclk),
    .Sclk(msdap_if_inst.Sclk),
    .Reset_n(msdap_if_inst.Reset_n),
    .Frame(msdap_if_inst.Frame),
    .Start(msdap_if_inst.Start),
    .InputL(msdap_if_inst.InputL),
    .InputR(msdap_if_inst.InputR),
    .InReady(msdap_if_inst.InReady),
    .OutReady(msdap_if_inst.OutReady),
    .OutputL(msdap_if_inst.OutputL),
    .OutputR(msdap_if_inst.OutputR)
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
