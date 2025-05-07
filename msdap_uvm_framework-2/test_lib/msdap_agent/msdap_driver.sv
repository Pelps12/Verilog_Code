class msdap_driver extends uvm_driver#(msdap_txn);
  `uvm_component_utils(msdap_driver)

  virtual msdap_if.TB vif;

  function new(string name = "msdap_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    if (!uvm_config_db#(virtual msdap_if.TB)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "No virtual interface set")
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      msdap_txn tx;
      seq_item_port.get_next_item(tx);
      vif.in_data <= tx.data_in;
      vif.in_valid <= 1;
      @(posedge vif.clk);
      vif.in_valid <= 0;
      seq_item_port.item_done();
    end
  endtask
endclass
