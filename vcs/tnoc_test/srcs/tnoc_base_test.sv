class tnoc_base_test extends uvm_test;

    tnoc_env env;

    `uvm_component_utils(tnoc_base_test)

    function new(string name,uvm_component parent);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = tnoc_env::type_id::create("env",this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction

endclass