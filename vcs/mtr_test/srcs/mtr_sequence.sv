class mtr_sequence extends uvm_sequence #(cibd_transaction);

    `uvm_object_utils(mtr_sequence)

    cibd_transaction tr;
    bit [3:0] scid,srid_x,srid_y; //source node info
    bit [3:0] dcid,drid_x,drid_y; //destination node info
    bit is_bound; //whether transmitted at bound port 

    function new(string name = "mtr_sequence");
        super.new(name);
    endfunction

    virtual task body();
        bit [7:0] inb_rid; //the rid of the the target noc's boundary node through which the packet transfers to destination
        bit [7:0] outb_rid; //the rid of the source noc's boundary node through which the packet transfers to the interposer noc
        bit [7:0] inoc_rid; //the rid of the interposer noc's routing node through which the packet transfers to the target noc
        if(starting_phase != null) begin
            starting_phase.raise_objection(this);
        end
        #100
        repeat(`PKT_NUM) begin
            tr = new("tr");
            assert(tr.randomize() with {
                if(tr.dcid == this.scid && tr.drid_x == this.srid_x)
                    tr.drid_y != srid_y;
            })
            if(tr.dcid != this.scid) begin 
                tr.outbound = 1;
                inb_rid = look_up_inbtab(tr.drid_x,tr.drid_y);
                inoc_rid = look_up_ctab(tr.dcid,inb_rid[7:4],inb_rid[3:0]);

                tr.inb_rid_x = inb_rid[7:4];
                tr.inb_rid_y = inb_rid[3:0];

                tr.itpdrid_x = inoc_rid[7:4];
                tr.itpdrid_y = inoc_rid[3:0];
                outb_rid = look_up_outbtab(srid_x,srid_y);
                tr.rtdrid_x = outb_rid[7:4];
                tr.rtdrid_y = outb_rid[3:0];
            end else begin
                tr.outbound = 0;
                tr.rtdrid_x = tr.drid_x;
                tr.rtdrid_y = tr.drid_y;
            end
            start_item(tr);
            finish_item(tr);
            // `uvm_send(tr)
        end
        #1000000
        if(starting_phase != null) begin
            starting_phase.drop_objection(this);
        end
    endtask

endclass