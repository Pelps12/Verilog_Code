class msdap_sequencer extends uvm_sequencer#(msdap_txn);
  `uvm_component_utils(msdap_sequencer)

  function new(string name = "msdap_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction
endclass
