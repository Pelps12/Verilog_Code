class msdap_txn extends uvm_sequence_item;
  rand bit [7:0] data_in;
  bit [7:0] expected_out;

  `uvm_object_utils(msdap_txn)

  function new(string name = "msdap_txn");
    super.new(name);
  endfunction
endclass
