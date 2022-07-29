class tnoc_case0 extends tnoc_base_test;

    `uvm_component_utils(tnoc_case0)
    tnoc_sequence local_seq[];
    tnoc_sequence bound_seq[];
    
    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction 

    virtual task main_phase(uvm_phase phase);
        int flag = 0;
        local_seq = new[`NOC_WIDTH*`NOC_HEIGHT];
        bound_seq = new[`NOC_WIDTH*`NOC_HEIGHT];
        for(int x = 0; x < `NOC_WIDTH; x ++) begin
            for(int y = 0; y < `NOC_HEIGHT; y ++) begin
                local_seq[y*`NOC_WIDTH+x] = new($sformatf("local_seq[%0d]",y*`NOC_WIDTH+x));
                local_seq[y*`NOC_WIDTH+x].starting_phase = phase;
                local_seq[y*`NOC_WIDTH+x].srid_x = x;
                local_seq[y*`NOC_WIDTH+x].srid_y = y;
                local_seq[y*`NOC_WIDTH+x].is_bound = 0;
                bound_seq[y*`NOC_WIDTH+x] = new($sformatf("bound_seq[%0d]",y*`NOC_WIDTH+x));
                bound_seq[y*`NOC_WIDTH+x].starting_phase = phase;
                bound_seq[y*`NOC_WIDTH+x].srid_x = x;
                bound_seq[y*`NOC_WIDTH+x].srid_y = y;
                bound_seq[y*`NOC_WIDTH+x].is_bound = 1;
            end
        end

        for(int x = 0; x < `NOC_WIDTH; x ++) begin
            for(int y = 0; y < `NOC_HEIGHT; y ++) begin
                int id = y*`NOC_WIDTH+x;
                fork
                    local_seq[id].start(env.agent[id].i_agt_local.sqr);
                join_none

                if(isIn(x,y,brid_x,brid_y)) begin
                    // `uvm_info("tnoc_scoreboard",$sformatf("x:%0d,y:%0d",x,y),UVM_LOW)
                    fork
                        bound_seq[id].start(env.agent[id].i_agt_bound.sqr);
                    join_none
                end

            end
        end
        // `uvm_fatal("tnoc_scoreboard",$sformatf("%0d",flag))
    endtask
endclass
