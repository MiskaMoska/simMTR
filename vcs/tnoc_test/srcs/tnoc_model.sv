class ModelPort;
    uvm_blocking_get_port #(cibd_transaction) bp_local,bp_bound;
    uvm_analysis_port #(cibd_transaction) ap_local,ap_bound;
endclass

class ModelRx;
    cibd_transaction rx_local,rx_bound;
endclass

class tnoc_model extends uvm_component;
    `uvm_component_utils(tnoc_model)
    ModelPort mport[];
    ModelRx rx[];

    function new(string name = "tnoc_model",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mport = new[`NOC_WIDTH*`NOC_HEIGHT];
        rx = new[`NOC_WIDTH*`NOC_HEIGHT];

        foreach(mport[i]) begin
            mport[i] = new();
            mport[i].bp_local = new($sformatf("mport[%0d].bp_local",i),this);
            mport[i].ap_local = new($sformatf("mport[%0d].ap_local",i),this);
            mport[i].bp_bound = new($sformatf("mport[%0d].bp_bound",i),this);
            mport[i].ap_bound = new($sformatf("mport[%0d].ap_bound",i),this);
        end
        foreach(rx[i]) begin
            rx[i] = new();
            rx[i].rx_local = new($sformatf("rx[%0d].rx_local",i));
            rx[i].rx_bound = new($sformatf("rx[%0d].rx_bound",i));
        end

    endfunction

    protected function void fire(input cibd_transaction trans);
        int rid = trans.rtdrid_y * `NOC_WIDTH + trans.rtdrid_x;
        if(trans.outbound) mport[rid].ap_bound.write(trans);
        else mport[rid].ap_local.write(trans);
    endfunction

    virtual task main_phase(uvm_phase phase);
        super.main_phase(phase);
        foreach(mport[i_item]) begin
            int i = i_item;
            fork
                while(1) begin
                    mport[i].bp_local.get(rx[i].rx_local);
                    fire(rx[i].rx_local);
                end
                while(1) begin
                    mport[i].bp_bound.get(rx[i].rx_bound);
                    fire(rx[i].rx_bound);
                end
            join_none
        end
    endtask
endclass