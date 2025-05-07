class msdap_env extends uvm_env;
  `uvm_component_utils(msdap_env)

  msdap_agent agent;
  msdap_scoreboard sb;

  function new(string name = "msdap_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    agent = msdap_agent::type_id::create("agent", this);
    sb = msdap_scoreboard::type_id::create("sb", this);
  endfunction
endclass
