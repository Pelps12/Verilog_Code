class msdap_agent extends uvm_agent;
  `uvm_component_utils(msdap_agent)

  msdap_driver driver;
  msdap_monitor monitor;
  msdap_sequencer sequencer;

  function new(string name = "msdap_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    driver = msdap_driver::type_id::create("driver", this);
    monitor = msdap_monitor::type_id::create("monitor", this);
    sequencer = msdap_sequencer::type_id::create("sequencer", this);
  endfunction
endclass
