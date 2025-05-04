class msdap_sequence extends uvm_sequence#(msdap_txn);
  `uvm_object_utils(msdap_sequence)

  function new(string name = "msdap_sequence");
    super.new(name);
  endfunction

  task body();
    msdap_txn tx;
    repeat (10) begin
      tx = msdap_txn::type_id::create("tx");
      tx.randomize();
      start_item(tx);
      finish_item(tx);
    end
  endtask
endclass
