class ModelPort;
    uvm_blocking_get_port #(cibd_transaction) bp;
    uvm_analysis_port #(cibd_transaction) ap;
endclass

class ModelRx;
    cibd_transaction rx;
endclass

class mtr_model extends uvm_component;
    `uvm_component_utils(mtr_model)
    ModelPort mport[];
    ModelRx rx[];

    function new(string name = "mtr_model",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mport = new[4*`NOC_WIDTH*`NOC_HEIGHT];
        rx = new[4*`NOC_WIDTH*`NOC_HEIGHT];

        foreach(mport[i]) begin
            mport[i] = new();
            mport[i].bp = new($sformatf("mport[%0d].bp",i),this);
            mport[i].ap = new($sformatf("mport[%0d].ap",i),this);
        end
        foreach(rx[i]) begin
            rx[i] = new();
            rx[i].rx = new($sformatf("rx[%0d].rx",i));
        end

    endfunction

    protected function void fire(input cibd_transaction trans);
        int rid = trans.dcid * `NOC_WIDTH * `NOC_HEIGHT + trans.drid_y * `NOC_WIDTH + trans.drid_x;
        mport[rid].ap.write(trans);
    endfunction

    virtual task main_phase(uvm_phase phase);
        super.main_phase(phase);
        foreach(mport[i_item]) begin
            int i = i_item;
            fork
                while(1) begin
                    mport[i].bp.get(rx[i].rx);
                    fire(rx[i].rx);
                end
            join_none
        end
    endtask
endclass