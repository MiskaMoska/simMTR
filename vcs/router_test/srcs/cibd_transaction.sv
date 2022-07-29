class cibd_transaction extends uvm_sequence_item;

    rand bit [3:0] rtdrid_x,rtdrid_y;
    rand bit outbound;
    rand bit [`DW-3:0] payload[];

    `uvm_object_utils_begin(cibd_transaction)
        `uvm_field_int(rtdrid_x,UVM_ALL_ON)
        `uvm_field_int(rtdrid_y,UVM_ALL_ON)
        `uvm_field_int(outbound,UVM_ALL_ON)
        `uvm_field_array_int(payload,UVM_ALL_ON)
    `uvm_object_utils_end


    function new(string name = "cibd_transaction");
        super.new(name);
    endfunction


    virtual function void pack(ref bit[`DW-1:0] data_q[$]);
        bit[`DW-1:0] temp_data;
        data_q = {}; //clear the queue
        temp_data = (`HEAD << (`DW-2)) | (this.rtdrid_x << `RTDRID_X_L) | (this.rtdrid_y << `RTDRID_Y_L) |
                    (this.outbound << `OUTBOUND_M); //head flit

        data_q.push_back(temp_data);
        for(int i = 0; i < this.payload.size(); i++)
        begin
            temp_data = (`BODY << (`DW-2)) | this.payload[i]; //body flit
            data_q.push_back(temp_data);
        end
        data_q.push_back((`TAIL << (`DW-2)) | {(`DW-2){1'b1}}); //tail flit
    endfunction


    virtual function void unpack(ref bit[`DW-1:0] data_q[$]);
        int i = 0;
        bit[`DW-1:0] temp_data;
        temp_data = data_q.pop_front(); //head flit
        if(temp_data[`DW-1:`DW-2] != `HEAD)
            `uvm_error("cibd_monitor","the first received data is not head flit");
        
        this.rtdrid_x = temp_data >> `RTDRID_X_L;
        this.rtdrid_y = temp_data >> `RTDRID_Y_L;
        this.outbound = temp_data >> `OUTBOUND_M;

        this.payload = new[data_q.size()-1];
        while(data_q.size() > 1)
        begin
            this.payload[i] = data_q.pop_front(); //body flit
            i++;
        end
        data_q.pop_front(); //tail flit
    endfunction

    virtual function int compare_payload(cibd_transaction tr);
        if(this.payload.size() != tr.payload.size())
            return 0;
        for(int i = 0; i < tr.payload.size(); i++) begin
            if(this.payload[i] != tr.payload[i]) return 0;
        end
        return 1;
    endfunction

    constraint payload_const{
        payload.size >= 1;
        payload.size <= `PKT_MAX_LEN-2;
    }

    constraint id_const{}
endclass