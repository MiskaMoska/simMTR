class ScoreboardQueue;
    cibd_transaction q[$];
endclass

class ScoreboardPort;
    uvm_blocking_get_port #(cibd_transaction) exp_bp_local,exp_bp_bound,act_bp_local,act_bp_bound;
endclass

class tnoc_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(tnoc_scoreboard)
    ScoreboardPort sport[];
    ScoreboardQueue matrix_act_local[],matrix_act_bound[],matrix_exp_local[],matrix_exp_bound[];
    cibd_transaction get_act_local[],get_act_bound[],get_exp_local[],get_exp_bound[];

    function new(string name = "tnoc_scoreboard",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        sport = new[`NOC_WIDTH*`NOC_HEIGHT];
        matrix_act_local = new[`NOC_WIDTH*`NOC_HEIGHT];
        matrix_act_bound = new[`NOC_WIDTH*`NOC_HEIGHT];
        matrix_exp_local = new[`NOC_WIDTH*`NOC_HEIGHT];
        matrix_exp_bound = new[`NOC_WIDTH*`NOC_HEIGHT];
        get_act_local = new[`NOC_WIDTH*`NOC_HEIGHT];
        get_act_bound = new[`NOC_WIDTH*`NOC_HEIGHT];
        get_exp_local = new[`NOC_WIDTH*`NOC_HEIGHT];
        get_exp_bound = new[`NOC_WIDTH*`NOC_HEIGHT];

        foreach(sport[i]) begin
            sport[i] = new();
            sport[i].exp_bp_local = new($sformatf("sport[%0d].exp_bp_local",i),this);
            sport[i].exp_bp_bound = new($sformatf("sport[%0d].exp_bp_bound",i),this);
            sport[i].act_bp_local = new($sformatf("sport[%0d].act_bp_local",i),this);
            sport[i].act_bp_bound = new($sformatf("sport[%0d].act_bp_bound",i),this);
        end

        foreach(matrix_act_local[i])
            matrix_act_local[i] = new();
        foreach(matrix_act_bound[i])
            matrix_act_bound[i] = new();
        foreach(matrix_act_local[i])
            matrix_exp_local[i] = new();
        foreach(matrix_act_bound[i])
            matrix_exp_bound[i] = new();
    endfunction

    protected function void act_queue_local_push(input cibd_transaction trans,input int id);
        matrix_act_local[id].q.push_back(trans);
    endfunction

    protected function void act_queue_bound_push(input cibd_transaction trans,input int id);
        matrix_act_bound[id].q.push_back(trans);
    endfunction

    protected function void exp_queue_local_push(input cibd_transaction trans,input int id);
        matrix_exp_local[id].q.push_back(trans);
    endfunction

    protected function void exp_queue_bound_push(input cibd_transaction trans,input int id);
        matrix_exp_bound[id].q.push_back(trans);
    endfunction

    virtual task main_phase(uvm_phase phase);
        bit result;
        super.main_phase(phase);
        foreach(sport[i_item]) begin
            int i = i_item;
            fork
                while(1) begin
                    sport[i].exp_bp_local.get(get_exp_local[i]);
                    exp_queue_local_push(get_exp_local[i],i);
                end
            join_none
        end
        foreach(sport[i_item]) begin
            int i = i_item;
            fork
                while(1) begin
                    sport[i].exp_bp_bound.get(get_exp_bound[i]);
                    exp_queue_bound_push(get_exp_bound[i],i);
                end
            join_none
        end
        foreach(sport[i_item]) begin
            int i = i_item;
            fork
                while(1) begin
                    sport[i].act_bp_local.get(get_act_local[i]);
                    act_queue_local_push(get_act_local[i],i);
                end
            join_none
        end
        foreach(sport[i_item]) begin
            int i = i_item;
            fork
                while(1) begin
                    sport[i].act_bp_bound.get(get_act_bound[i]);
                    act_queue_bound_push(get_act_bound[i],i);
                end
            join_none
        end
    endtask

    function int test_check();
        for(int x = 0; x < `NOC_WIDTH; x++) begin
            for(int y = 0; y < `NOC_HEIGHT; y++) begin
                bit flag = 0;
                int id = y * `NOC_WIDTH + x;
                `uvm_info("tnoc_scoreboard",$sformatf("\n\n\nstarting verification at router (%0d,%0d)",x,y),UVM_LOW)

                //local port
                if(matrix_exp_local[id].q.size() != matrix_act_local[id].q.size()) begin
                    `uvm_info("tnoc_scoreboard","ERROR! queue size not equal at local output port",UVM_LOW)
                    `uvm_info("tnoc_scoreboard",$sformatf("expect transactions:%0d but actual transactions:%0d",matrix_exp_local[id].q.size(),matrix_act_local[id].q.size()),UVM_LOW)
                end else begin
                    for(int act = 0; act < matrix_act_local[id].q.size(); act ++) begin
                        flag = 0;
                        for(int exp = 0; exp < matrix_exp_local[id].q.size(); exp ++) begin
                            if(matrix_exp_local[id].q[exp].compare_payload(matrix_act_local[id].q[act])) begin
                                flag = 1;
                                matrix_exp_local[id].q.delete(exp);
                                break;
                            end
                        end
                        if(flag) 
                            `uvm_info("tnoc_scoreboard","compare successfully at local output port",UVM_LOW)
                        else
                            `uvm_info("tnoc_scoreboard","compare failed at local output port",UVM_LOW)
                    end
                end

                //bound port
                if(matrix_exp_bound[id].q.size() != matrix_act_bound[id].q.size()) begin
                    `uvm_info("tnoc_scoreboard","ERROR! queue size not equal at bound output port",UVM_LOW)
                    `uvm_info("tnoc_scoreboard",$sformatf("expect transactions:%0d but actual transactions:%0d",matrix_exp_bound[id].q.size(),matrix_act_bound[id].q.size()),UVM_LOW)
                end else begin
                    for(int act = 0; act < matrix_act_bound[id].q.size(); act ++) begin
                        flag = 0;
                        for(int exp = 0; exp < matrix_exp_bound[id].q.size(); exp ++) begin
                            if(matrix_exp_bound[id].q[exp].compare_payload(matrix_act_bound[id].q[act])) begin
                                flag = 1;
                                matrix_exp_bound[id].q.delete(exp);
                                break;
                            end
                        end
                        if(flag) 
                            `uvm_info("tnoc_scoreboard","compare successfully at bound output port",UVM_LOW)
                        else
                            `uvm_info("tnoc_scoreboard","compare failed at bound output port",UVM_LOW)
                    end
                end
            end
        end

    endfunction

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        test_check();
    endfunction
endclass