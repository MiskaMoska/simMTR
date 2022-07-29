class mtr_case0 extends mtr_base_test;

    `uvm_component_utils(mtr_case0)
    mtr_sequence seq[];
    
    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction 

    virtual task main_phase(uvm_phase phase);
        int flag = 0;
        seq = new[4*`NOC_WIDTH*`NOC_HEIGHT];
        for(int c = 0; c < 4; c ++) begin
            for(int x = 0; x < `NOC_WIDTH; x ++) begin
                for(int y = 0; y < `NOC_HEIGHT; y ++) begin
                    int id = c*`NOC_WIDTH*`NOC_HEIGHT+y*`NOC_WIDTH+x;
                    seq[id] = new($sformatf("seq[%0d]",id));
                    seq[id].starting_phase = phase;
                    seq[id].scid = c;
                    seq[id].srid_x = x;
                    seq[id].srid_y = y;
                end
            end
        end

        for(int c = 0; c < 4; c ++) begin
            for(int x = 0; x < `NOC_WIDTH; x ++) begin
                for(int y = 0; y < `NOC_HEIGHT; y ++) begin
                    int id = c*`NOC_WIDTH*`NOC_HEIGHT+y*`NOC_WIDTH+x;
                    fork
                        seq[id].start(env.agent[id].i_agt.sqr);
                    join_none
                end
            end
        end
        // `uvm_fatal("mtr_scoreboard",$sformatf("%0d",flag))
    endtask
endclass
