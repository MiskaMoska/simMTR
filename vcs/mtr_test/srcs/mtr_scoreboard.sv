class ScoreboardQueue;
    cibd_transaction q[$];
endclass

class ScoreboardPort;
    uvm_blocking_get_port #(cibd_transaction) exp_bp,act_bp;
endclass

class mtr_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(mtr_scoreboard)
    ScoreboardPort sport[];
    ScoreboardQueue matrix_act[],matrix_exp[];
    cibd_transaction get_act[],get_exp[];
    longint latency[$];

    function new(string name = "mtr_scoreboard",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        sport = new[4*`NOC_WIDTH*`NOC_HEIGHT];
        matrix_act = new[4*`NOC_WIDTH*`NOC_HEIGHT];
        matrix_exp = new[4*`NOC_WIDTH*`NOC_HEIGHT];
        get_act = new[4*`NOC_WIDTH*`NOC_HEIGHT];
        get_exp = new[4*`NOC_WIDTH*`NOC_HEIGHT];

        foreach(sport[i]) begin
            sport[i] = new();
            sport[i].exp_bp = new($sformatf("sport[%0d].exp_bp",i),this);
            sport[i].act_bp = new($sformatf("sport[%0d].act_bp",i),this);
        end

        foreach(matrix_act[i])
            matrix_act[i] = new();
        foreach(matrix_act[i])
            matrix_exp[i] = new();

    endfunction

    protected function void act_queue_push(input cibd_transaction trans,input int id);
        matrix_act[id].q.push_back(trans);
    endfunction

    protected function void exp_queue_push(input cibd_transaction trans,input int id);
        matrix_exp[id].q.push_back(trans);
    endfunction

    virtual task main_phase(uvm_phase phase);
        bit result;
        super.main_phase(phase);
        foreach(sport[i_item]) begin
            int i = i_item;
            fork
                while(1) begin
                    sport[i].exp_bp.get(get_exp[i]);
                    exp_queue_push(get_exp[i],i);
                end
            join_none
        end
        foreach(sport[i_item]) begin
            int i = i_item;
            fork
                while(1) begin
                    sport[i].act_bp.get(get_act[i]);
                    act_queue_push(get_act[i],i);
                end
            join_none
        end
    endtask

    protected function real get_latency();
        real lat_sum;
        for(int id = 0; id < 4 * `NOC_WIDTH * `NOC_HEIGHT; id ++) begin
            for(int j = 0; j < matrix_exp[id].q.size(); j ++) begin
                bit flag = 0;
                for(int k = 0; k < matrix_act[id].q.size(); k ++) begin
                    if(matrix_exp[id].q[j].compare_payload(matrix_act[id].q[k])) begin
                        latency.push_back(matrix_act[id].q[k].eje_time - matrix_exp[id].q[j].inj_time);
                        flag = 1;
                        break;
                    end
                end
                if(flag == 0) begin
                    `uvm_fatal("mtr_scoreboard","error")
                end
            end
        end

        // `uvm_info("mtr_scoreboard",$sformatf("latency queue len:%0d",latency.size()),UVM_LOW)
        for(int i = 0; i < latency.size(); i ++) begin
            lat_sum += latency[i];
        end

        return lat_sum / (latency.size() * `CLK_PERIOD);
    endfunction

    protected function automatic real get_throughput();
        real throughput,flit_num,max_eje_time,min_inj_time;
        bit flag = 0;

        for(int id = 0; id < 4*`NOC_WIDTH*`NOC_HEIGHT; id ++) begin
            for(int j = 0; j < matrix_act[id].q.size(); j ++) begin
                flit_num += matrix_act[id].q[j].payload.size() + 2;
            end
        end

        for(int id = 0; id < 4*`NOC_WIDTH*`NOC_HEIGHT; id ++) begin
            for(int j = 0; j < matrix_exp[id].q.size(); j ++) begin
                longint temp_inj_time = matrix_exp[id].q[j].inj_time;
                if(!flag) begin
                    min_inj_time = temp_inj_time;
                    flag = 1;
                    continue;
                end
                if(temp_inj_time < min_inj_time)
                    min_inj_time = temp_inj_time;
            end
        end

        max_eje_time = 0;
        for(int id = 0; id < 4*`NOC_WIDTH*`NOC_HEIGHT; id ++) begin
            for(int j = 0; j < matrix_act[id].q.size(); j ++) begin
                longint temp_eje_time = matrix_act[id].q[j].eje_time;
                if(temp_eje_time > max_eje_time)
                    max_eje_time = temp_eje_time;
            end
        end

        `uvm_info("mtr_scoreboard",$sformatf("flit_num:%0f",flit_num),UVM_LOW)
        `uvm_info("mtr_scoreboard",$sformatf("elapsed_time:%0f",max_eje_time-min_inj_time),UVM_LOW)
        throughput = flit_num / (max_eje_time-min_inj_time) * `CLK_PERIOD;
        return throughput;
    endfunction

    protected function automatic void test_check(); // must be placed at the end of report phase, for it will destruct receiving queue
        for(int cid = 0; cid < 4; cid ++) begin
            for(int x = 0; x < `NOC_WIDTH; x++) begin
                for(int y = 0; y < `NOC_HEIGHT; y++) begin
                    bit flag = 0;
                    int id = cid * `NOC_WIDTH * `NOC_HEIGHT + y * `NOC_WIDTH + x;
                    // `uvm_info("mtr_scoreboard",$sformatf("\n\n\nstarting verification at router (cid,rid_x,rid_y)->(%0d,%0d,%0d)",cid,x,y),UVM_LOW)

                    //port
                    if(matrix_exp[id].q.size() != matrix_act[id].q.size()) begin
                        `uvm_info("mtr_scoreboard","ERROR! queue size not equal",UVM_LOW)
                        `uvm_info("mtr_scoreboard",$sformatf("expect transactions:%0d but actual transactions:%0d",matrix_exp[id].q.size(),matrix_act[id].q.size()),UVM_LOW)
                    end else begin
                        for(int act = 0; act < matrix_act[id].q.size(); act ++) begin
                            flag = 0;
                            for(int exp = 0; exp < matrix_exp[id].q.size(); exp ++) begin
                                if(matrix_exp[id].q[exp].compare_payload(matrix_act[id].q[act])) begin
                                    flag = 1;
                                    matrix_exp[id].q.delete(exp);
                                    break;
                                end
                            end
                            if(flag) 
                                ;
                                // `uvm_info("mtr_scoreboard","compare successfully",UVM_LOW)
                            else
                                `uvm_info("mtr_scoreboard","compare failed",UVM_LOW)
                        end
                    end
                end
            end
        end
    endfunction

    virtual function void report_phase(uvm_phase phase);
        UVM_FILE report_log;
        real lat,thr;
        super.report_phase(phase);
        lat = get_latency();
        `uvm_info("mtr_scoreboard","finished getting latency",UVM_LOW)
        thr = get_throughput();
        `uvm_info("mtr_scoreboard","finished getting throughput",UVM_LOW)
        `uvm_info("mtr_scoreboard",$sformatf("\nAverage Latency:%0f\n",lat),UVM_LOW)
        `uvm_info("mtr_scoreboard",$sformatf("\nThroughput:%0f\n",thr),UVM_LOW)
        report_log = $fopen($sformatf("./log/case_%0d.log",`CASE_IDX),"a");
        $fwrite(report_log,$sformatf("[%4f,\t\t%10f,\t\t%10f],\n",`INJECT_RATE,lat,thr));
        $fclose(report_log);
        test_check();
    endfunction
endclass