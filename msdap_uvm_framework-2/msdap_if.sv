interface msdap_if(input logic clk, input logic rst_n);
  logic [7:0] in_data;
  logic in_valid;
  logic [7:0] out_data;
  logic out_valid;

  modport DUT (input clk, rst_n, in_data, in_valid,
               output out_data, out_valid);
  modport TB (output in_data, in_valid, input out_data, out_valid);
endinterface
