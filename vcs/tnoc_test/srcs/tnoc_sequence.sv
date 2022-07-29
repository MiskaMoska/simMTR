class tnoc_sequence extends uvm_sequence #(cibd_transaction);

    `uvm_object_utils(tnoc_sequence)

    cibd_transaction tr;
    int srid_x,srid_y;
    bit is_bound; //whether transmitted at bound port 

    function new(string name = "tnoc_sequence");
        super.new(name);
    endfunction

    virtual task body();
        if(starting_phase != null) begin
            starting_phase.raise_objection(this);
        end
        #100
        repeat(`PKT_NUM) begin
            tr = new("tr");
            if(is_bound) begin
                assert(tr.randomize());
                tr.outbound = 0;
            end else begin
                assert(tr.randomize() with {if(tr.rtdrid_x == srid_x){tr.rtdrid_y != srid_y;}});
                if(!isIn(tr.rtdrid_x,tr.rtdrid_y,brid_x,brid_y))
                    tr.outbound = 0;
            end
            start_item(tr);
            finish_item(tr);
        end
        #1000000
        if(starting_phase != null) begin
            starting_phase.drop_objection(this);
        end
    endtask

endclass