class msdap_monitor extends uvm_monitor;
  `uvm_component_utils(msdap_monitor)

  function new(string name = "msdap_monitor", uvm_component parent = null);
    super.new(name, parent);
  endfunction
endclass
