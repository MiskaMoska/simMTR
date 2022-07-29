class cibd_driver extends uvm_driver #(cibd_transaction);

    `uvm_component_utils(cibd_driver);

    virtual cibd_if drv_if;
    uvm_analysis_port #(cibd_transaction) ap; //TLM
    static int send_cnt = 0;

    function new(string name = "cibd_driver",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual cibd_if)::get(this,"","vif",drv_if))
            `uvm_fatal("cibd_driver","virtual interface must be set for cibd_driver!!!");
        ap = new("ap",this);  //TLM
    endfunction

    virtual task main_phase(uvm_phase phase);
        longint temp_time;
        cibd_transaction tr_to_dut,tr_to_ni;
        cibd_transaction ni_queue[$];
        int pkt_len;

        // `uvm_info("cibd_driver","main_phase is called",UVM_LOW);
        // phase.raise_objection(this);
        drv_if.data <= 64'b0;
        drv_if.valid <= 1'b0;

        while(!drv_if.rstn)
            @(posedge drv_if.clk);

        fork
            while(1)
            begin
                @(posedge drv_if.clk);
                if(ni_queue.size() > 0 && drv_if.ready) begin
                    tr_to_dut = ni_queue.pop_front();
                    drive_one_pkt(tr_to_dut);
                end
            end

            while(1)
            begin
                seq_item_port.get_next_item(req); //apply to sequencer for a transaction
                tr_to_ni = req;
                temp_time = $time;
                req.inj_time = temp_time;
                pkt_len = req.payload.size() + 2;
                ap.write(req); //TLM driver to model
                ni_queue.push_back(tr_to_ni); //drive to NI
                seq_item_port.item_done(); //confirm to sequenser 
                
                repeat(pkt_len / `INJECT_RATE - pkt_len) begin
                    @(posedge drv_if.clk);
                end
            end
        join
        // phase.drop_objection(this);
    endtask

    // virtual task main_phase(uvm_phase phase);
    //     longint temp_time;
    //     int pkt_len;
    //     `uvm_info("cibd_driver","main_phase is called",UVM_LOW);

    //     drv_if.data <= 64'b0;
    //     drv_if.valid <= 1'b0;

    //     while(!drv_if.rstn)
    //         @(posedge drv_if.clk);

    //     while(1)
    //     begin
    //         seq_item_port.get_next_item(req); //apply to sequencer for a transaction
    //         temp_time = $time;
    //         req.inj_time = temp_time;
    //         pkt_len = req.payload.size() + 2;
    //         ap.write(req); //TLM driver to model
    //         drive_one_pkt(req);
    //         seq_item_port.item_done(); //confirm to sequenser 
            
    //         repeat(pkt_len / `INJECT_RATE - pkt_len) begin
    //             @(posedge drv_if.clk);
    //         end
    //     end
    // endtask

    virtual task drive_one_pkt(cibd_transaction tr);
        bit [`DW-1:0] temp_data;
        bit [`DW-1:0] data_q[$];

        tr.pack(data_q);

        // while(1) //wait for ready
        // begin
        //     @(posedge drv_if.clk);
        //     if(drv_if.ready) break;
        // end

        drv_if.valid <= 1'b1;

        while(1)
        begin
            if(drv_if.ready)
            begin
                temp_data = data_q.pop_front();
                drv_if.data <= temp_data; 
                if(temp_data[`DW-1:`DW-2] == `TAIL) //is tail flit
                    break;
            end
            @(posedge drv_if.clk);
        end

        while(1) //waiting for tail flit to finish transfer 
        begin
            @(posedge drv_if.clk);
            if(drv_if.ready)
            begin
                drv_if.valid <= 1'b0;
                break;
            end
        end

        send_cnt ++;
        `uvm_info("cibd_driver",$sformatf("finish driving %0d/%0d pkt",send_cnt,4*`NOC_WIDTH*`NOC_HEIGHT*`PKT_NUM),UVM_LOW);
        // `uvm_info("cibd_driver",{"\n",tr.sprint()},UVM_LOW)

    endtask
endclass