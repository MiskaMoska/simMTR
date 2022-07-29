class Agent;
    cibd_agent i_agt_local,i_agt_bound,o_agt_local,o_agt_bound;
endclass

class FIFO;
    uvm_tlm_analysis_fifo #(cibd_transaction)
    drv_mdl_fifo_local,mdl_sb_fifo_local,mon_sb_fifo_local,
    drv_mdl_fifo_bound,mdl_sb_fifo_bound,mon_sb_fifo_bound; 
endclass

class tnoc_env extends uvm_env;
    `uvm_component_utils(tnoc_env)

    Agent agent[];
    FIFO fifo[];
    tnoc_model mdl;
    tnoc_scoreboard sb;

    // UVM_FILE drv_w_log,drv_e_log,drv_n_log,drv_s_log,drv_l_log,drv_b_log;
    // UVM_FILE mon_w_log,mon_e_log,mon_n_log,mon_s_log,mon_l_log;
    // UVM_FILE expect_w_log,expect_e_log,expect_n_log,expect_s_log,expect_l_log;
    // UVM_FILE actual_w_log,actual_e_log,actual_n_log,actual_s_log,actual_l_log;
    UVM_FILE report_log;
    // UVM_FILE expect_l_log,expect_b_log;
    // UVM_FILE actual_l_log,actual_b_log;
    

    function new(string name = "tnoc_env",uvm_component parent = null);
        super.new(name,parent);
    endfunction


    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = new[`NOC_WIDTH*`NOC_HEIGHT];
        fifo = new[`NOC_WIDTH*`NOC_HEIGHT];

        foreach(agent[i]) begin
            agent[i] = new();
            agent[i].i_agt_local = cibd_agent::type_id::create($sformatf("agent[%0d].i_agt_local",i),this);
            agent[i].i_agt_local.is_active = UVM_ACTIVE;
            agent[i].o_agt_local = cibd_agent::type_id::create($sformatf("agent[%0d].o_agt_local",i),this);
            agent[i].o_agt_local.is_active = UVM_PASSIVE;
            agent[i].i_agt_bound = cibd_agent::type_id::create($sformatf("agent[%0d].i_agt_bound",i),this);
            agent[i].i_agt_bound.is_active = UVM_ACTIVE;
            agent[i].o_agt_bound = cibd_agent::type_id::create($sformatf("agent[%0d].o_agt_bound",i),this);
            agent[i].o_agt_bound.is_active = UVM_PASSIVE;
        end

        `uvm_info("tnoc_env","all i_agts are built",UVM_LOW)
        `uvm_info("tnoc_env","all o_agts are built",UVM_LOW)
        
        mdl = tnoc_model::type_id::create("mdl",this);
        sb = tnoc_scoreboard::type_id::create("sb",this);

        `uvm_info("tnoc_env","mdl is built",UVM_LOW)
        `uvm_info("tnoc_env","sb is built",UVM_LOW)

        foreach(fifo[i]) begin
            fifo[i] = new();
            fifo[i].drv_mdl_fifo_local = new($sformatf("fifo[%0d].drv_mdl_fifo_local",i),this);
            fifo[i].mdl_sb_fifo_local = new($sformatf("fifo[%0d].mdl_sb_fifo_local",i),this);
            fifo[i].mon_sb_fifo_local = new($sformatf("fifo[%0d].mon_sb_fifo_local",i),this);
            fifo[i].drv_mdl_fifo_bound = new($sformatf("fifo[%0d].drv_mdl_fifo_bound",i),this);
            fifo[i].mdl_sb_fifo_bound = new($sformatf("fifo[%0d].mdl_sb_fifo_bound",i),this);
            fifo[i].mon_sb_fifo_bound = new($sformatf("fifo[%0d].mon_sb_fifo_bound",i),this);
        end

    endfunction


    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        for(int i = 0; i < `NOC_WIDTH*`NOC_HEIGHT; i++)
        begin
            agent[i].i_agt_local.ap.connect(fifo[i].drv_mdl_fifo_local.analysis_export); //TLM
            agent[i].i_agt_bound.ap.connect(fifo[i].drv_mdl_fifo_bound.analysis_export); //TLM
            mdl.mport[i].bp_local.connect(fifo[i].drv_mdl_fifo_local.blocking_get_export); //TLM
            mdl.mport[i].bp_bound.connect(fifo[i].drv_mdl_fifo_bound.blocking_get_export); //TLM

            mdl.mport[i].ap_local.connect(fifo[i].mdl_sb_fifo_local.analysis_export); //TLM
            mdl.mport[i].ap_bound.connect(fifo[i].mdl_sb_fifo_bound.analysis_export); //TLM
            sb.sport[i].exp_bp_local.connect(fifo[i].mdl_sb_fifo_local.blocking_get_export); //TLM
            sb.sport[i].exp_bp_bound.connect(fifo[i].mdl_sb_fifo_bound.blocking_get_export); //TLM
            
            agent[i].o_agt_local.ap.connect(fifo[i].mon_sb_fifo_local.analysis_export); //TLM
            agent[i].o_agt_bound.ap.connect(fifo[i].mon_sb_fifo_bound.analysis_export); //TLM
            sb.sport[i].act_bp_local.connect(fifo[i].mon_sb_fifo_local.blocking_get_export); //TLM
            sb.sport[i].act_bp_bound.connect(fifo[i].mon_sb_fifo_bound.blocking_get_export); //TLM
        end

        // drv_w_log = $fopen("./log/drv_w_log","w");
        // drv_e_log = $fopen("./log/drv_e_log","w");
        // drv_n_log = $fopen("./log/drv_n_log","w");
        // drv_s_log = $fopen("./log/drv_s_log","w");
        // drv_l_log = $fopen("./log/drv_l_log","w");
        // drv_l_log = $fopen("./log/drv_l_log","w");
        // drv_b_log = $fopen("./log/drv_b_log","w");
        // // mon_w_log = $fopen("mon_w_log","w");
        // // mon_e_log = $fopen("mon_e_log","w");
        // // mon_n_log = $fopen("mon_n_log","w");
        // // mon_s_log = $fopen("mon_s_log","w");
        // // mon_l_log = $fopen("mon_l_log","w");
        // // expect_w_log = $fopen("expect_w","w");
        // // expect_e_log = $fopen("expect_e","w");
        // // expect_n_log = $fopen("expect_n","w");
        // // expect_s_log = $fopen("expect_s","w");
        // expect_l_log = $fopen("./log/expect_l_log","w");
        // expect_b_log = $fopen("./log/expect_b_log","w");
        // // actual_w_log = $fopen("actual_w","w");
        // // actual_e_log = $fopen("actual_e","w");
        // // actual_n_log = $fopen("actual_n","w");
        // // actual_s_log = $fopen("actual_s","w");
        // actual_l_log = $fopen("./log/actual_l_log","w");
        // actual_b_log = $fopen("./log/actual_b_log","w");
        report_log = $fopen("./log/report_log","w");

        // this.i_agt[0].drv.set_report_severity_file_hier(UVM_INFO, drv_n_log);
        // this.i_agt[1].drv.set_report_severity_file_hier(UVM_INFO, drv_w_log);
        // this.i_agt[2].drv.set_report_severity_file_hier(UVM_INFO, drv_s_log);
        // this.i_agt[3].drv.set_report_severity_file_hier(UVM_INFO, drv_e_log);
        // this.i_agt[4].drv.set_report_severity_file_hier(UVM_INFO, drv_l_log);
        // this.i_agt[5].drv.set_report_severity_file_hier(UVM_INFO, drv_b_log);
        // // this.o_agt[0].mon.set_report_severity_file_hier(UVM_INFO, mon_w_log);
        // // this.o_agt[1].mon.set_report_severity_file_hier(UVM_INFO, mon_e_log);
        // // this.o_agt[2].mon.set_report_severity_file_hier(UVM_INFO, mon_n_log);
        // // this.o_agt[3].mon.set_report_severity_file_hier(UVM_INFO, mon_s_log);
        // // this.o_agt[4].mon.set_report_severity_file_hier(UVM_INFO, mon_l_log);
        // // this.sb.set_report_id_file("expect_w",expect_w_log);
        // // this.sb.set_report_id_file("expect_e",expect_e_log);
        // // this.sb.set_report_id_file("expect_n",expect_n_log);
        // // this.sb.set_report_id_file("expect_s",expect_s_log);
        // this.sb.set_report_id_file("expect_l",expect_l_log);
        // this.sb.set_report_id_file("expect_b",expect_b_log);
        // // this.sb.set_report_id_file("actual_w",actual_w_log);
        // // this.sb.set_report_id_file("actual_e",actual_e_log);
        // // this.sb.set_report_id_file("actual_n",actual_n_log);
        // // this.sb.set_report_id_file("actual_s",actual_s_log);
        // this.sb.set_report_id_file("actual_l",actual_l_log);
        // this.sb.set_report_id_file("actual_b",actual_b_log);
        this.sb.set_report_id_file("tnoc_scoreboard",report_log);

        // this.i_agt[0].drv.set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY | UVM_LOG);
        // this.i_agt[1].drv.set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY | UVM_LOG);
        // this.i_agt[2].drv.set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY | UVM_LOG);
        // this.i_agt[3].drv.set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY | UVM_LOG);
        // this.i_agt[4].drv.set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY | UVM_LOG);
        // this.i_agt[5].drv.set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY | UVM_LOG);
        // // this.o_agt[0].mon.set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY | UVM_LOG);
        // // this.o_agt[1].mon.set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY | UVM_LOG);
        // // this.o_agt[2].mon.set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY | UVM_LOG);
        // // this.o_agt[3].mon.set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY | UVM_LOG);
        // // this.o_agt[4].mon.set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY | UVM_LOG);
        // // this.sb.set_report_id_action("expect_w",UVM_DISPLAY | UVM_LOG);
        // // this.sb.set_report_id_action("expect_e",UVM_DISPLAY | UVM_LOG);
        // // this.sb.set_report_id_action("expect_n",UVM_DISPLAY | UVM_LOG);
        // // this.sb.set_report_id_action("expect_s",UVM_DISPLAY | UVM_LOG);
        // this.sb.set_report_id_action("expect_l",UVM_DISPLAY | UVM_LOG);
        // this.sb.set_report_id_action("expect_b",UVM_DISPLAY | UVM_LOG);
        // // this.sb.set_report_id_action("actual_w",UVM_DISPLAY | UVM_LOG);
        // // this.sb.set_report_id_action("actual_e",UVM_DISPLAY | UVM_LOG);
        // // this.sb.set_report_id_action("actual_n",UVM_DISPLAY | UVM_LOG);
        // // this.sb.set_report_id_action("actual_s",UVM_DISPLAY | UVM_LOG);
        // this.sb.set_report_id_action("actual_l",UVM_DISPLAY | UVM_LOG);
        // this.sb.set_report_id_action("actual_b",UVM_DISPLAY | UVM_LOG);
        this.sb.set_report_id_action("tnoc_scoreboard",UVM_DISPLAY | UVM_LOG);
    endfunction

    // virtual task main_phase(uvm_phase phase); 
    //     start sequence,if it is started in top_tb,this code is not needed
    //     cibd_sequence seq;
    //     phase.raise_objection(this);
    //     seq = cibd_sequence::type_id::create("seq"); //sequence is newed in main phase
    //     seq.start(i_agt.sqr); //tell sequence to send transaction to which sequencer
    //     phase.drop_objection(this);
    // endtask

    virtual function void final_phase(uvm_phase phase);
        super.final_phase(phase);
    //     $fclose(drv_w_log);
    //     $fclose(drv_e_log);
    //     $fclose(drv_n_log);
    //     $fclose(drv_s_log);
    //     $fclose(drv_l_log);
    //     $fclose(drv_b_log);
    // //     $fclose(mon_w_log);
    // //     $fclose(mon_e_log);
    // //     $fclose(mon_n_log);
    // //     $fclose(mon_s_log);
    // //     $fclose(mon_l_log);
    // //     $fclose(expect_w_log);
    // //     $fclose(expect_e_log);
    // //     $fclose(expect_n_log);
    // //     $fclose(expect_s_log);
    //     $fclose(expect_l_log);
    //     $fclose(expect_b_log);
    // //     $fclose(actual_w_log);
    // //     $fclose(actual_e_log);
    // //     $fclose(actual_n_log);
    // //     $fclose(actual_s_log);
    //     $fclose(actual_l_log);
    //     $fclose(actual_b_log);
        $fclose(report_log);
    endfunction
endclass