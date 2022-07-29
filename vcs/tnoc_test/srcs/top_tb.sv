`timescale 1ns/1ps
`include "uvm_macros.svh"

import uvm_pkg::*;
`include "params.vh"
`include "test_params.svh"
`include "utils.sv"
`include "cibd_if.sv"
`include "cibd_transaction.sv"
`include "tnoc_sequence.sv"
`include "cibd_sequencer.sv"
`include "cibd_driver.sv"
`include "cibd_monitor.sv"
`include "cibd_agent.sv"
`include "tnoc_model.sv"
`include "tnoc_scoreboard.sv"
`include "tnoc_env.sv"
`include "tnoc_base_test.sv"
`include "tnoc_case0.sv"



module top_tb;
reg clk;
reg rstn;

cibd_if i_if_l[`NOC_WIDTH*`NOC_HEIGHT](clk,rstn); //for local port i_agt
cibd_if o_if_l[`NOC_WIDTH*`NOC_HEIGHT](clk,rstn); //for local port o_agt
cibd_if i_if_b[`NOC_WIDTH*`NOC_HEIGHT](clk,rstn); //for bound port i_agt
cibd_if o_if_b[`NOC_WIDTH*`NOC_HEIGHT](clk,rstn); //for bound port o_agt

TargetNoC #(
    .CID                             (0)
)dut(
    .clk                             (clk),
    .rstn                            (rstn),
    .local_data_i_0_0                (i_if_l[0].data),
    .local_valid_i_0_0               (i_if_l[0].valid),
    .local_ready_o_0_0               (i_if_l[0].ready),
    .local_data_o_0_0                (o_if_l[0].data),
    .local_valid_o_0_0               (o_if_l[0].valid),
    .local_ready_i_0_0               (o_if_l[0].ready),
    .bound_data_i_0_0                (i_if_b[0].data),
    .bound_valid_i_0_0               (i_if_b[0].valid),
    .bound_ready_o_0_0               (i_if_b[0].ready),
    .bound_data_o_0_0                (o_if_b[0].data),
    .bound_valid_o_0_0               (o_if_b[0].valid),
    .bound_ready_i_0_0               (o_if_b[0].ready),

    .local_data_i_0_1                (i_if_l[4].data),
    .local_valid_i_0_1               (i_if_l[4].valid),
    .local_ready_o_0_1               (i_if_l[4].ready),
    .local_data_o_0_1                (o_if_l[4].data),
    .local_valid_o_0_1               (o_if_l[4].valid),
    .local_ready_i_0_1               (o_if_l[4].ready),
    .bound_data_i_0_1                (i_if_b[4].data),
    .bound_valid_i_0_1               (i_if_b[4].valid),
    .bound_ready_o_0_1               (i_if_b[4].ready),
    .bound_data_o_0_1                (o_if_b[4].data),
    .bound_valid_o_0_1               (o_if_b[4].valid),
    .bound_ready_i_0_1               (o_if_b[4].ready),

    .local_data_i_0_2                (i_if_l[8].data),
    .local_valid_i_0_2               (i_if_l[8].valid),
    .local_ready_o_0_2               (i_if_l[8].ready),
    .local_data_o_0_2                (o_if_l[8].data),
    .local_valid_o_0_2               (o_if_l[8].valid),
    .local_ready_i_0_2               (o_if_l[8].ready),
    .bound_data_i_0_2                (i_if_b[8].data),
    .bound_valid_i_0_2               (i_if_b[8].valid),
    .bound_ready_o_0_2               (i_if_b[8].ready),
    .bound_data_o_0_2                (o_if_b[8].data),
    .bound_valid_o_0_2               (o_if_b[8].valid),
    .bound_ready_i_0_2               (o_if_b[8].ready),

    .local_data_i_0_3                (i_if_l[12].data),
    .local_valid_i_0_3               (i_if_l[12].valid),
    .local_ready_o_0_3               (i_if_l[12].ready),
    .local_data_o_0_3                (o_if_l[12].data),
    .local_valid_o_0_3               (o_if_l[12].valid),
    .local_ready_i_0_3               (o_if_l[12].ready),
    .bound_data_i_0_3                (i_if_b[12].data),
    .bound_valid_i_0_3               (i_if_b[12].valid),
    .bound_ready_o_0_3               (i_if_b[12].ready),
    .bound_data_o_0_3                (o_if_b[12].data),
    .bound_valid_o_0_3               (o_if_b[12].valid),
    .bound_ready_i_0_3               (o_if_b[12].ready),

    .local_data_i_1_0                (i_if_l[1].data),
    .local_valid_i_1_0               (i_if_l[1].valid),
    .local_ready_o_1_0               (i_if_l[1].ready),
    .local_data_o_1_0                (o_if_l[1].data),
    .local_valid_o_1_0               (o_if_l[1].valid),
    .local_ready_i_1_0               (o_if_l[1].ready),
    .bound_data_i_1_0                (i_if_b[1].data),
    .bound_valid_i_1_0               (i_if_b[1].valid),
    .bound_ready_o_1_0               (i_if_b[1].ready),
    .bound_data_o_1_0                (o_if_b[1].data),
    .bound_valid_o_1_0               (o_if_b[1].valid),
    .bound_ready_i_1_0               (o_if_b[1].ready),

    .local_data_i_1_1                (i_if_l[5].data),
    .local_valid_i_1_1               (i_if_l[5].valid),
    .local_ready_o_1_1               (i_if_l[5].ready),
    .local_data_o_1_1                (o_if_l[5].data),
    .local_valid_o_1_1               (o_if_l[5].valid),
    .local_ready_i_1_1               (o_if_l[5].ready),
    .bound_data_i_1_1                (i_if_b[5].data),
    .bound_valid_i_1_1               (i_if_b[5].valid),
    .bound_ready_o_1_1               (i_if_b[5].ready),
    .bound_data_o_1_1                (o_if_b[5].data),
    .bound_valid_o_1_1               (o_if_b[5].valid),
    .bound_ready_i_1_1               (o_if_b[5].ready),

    .local_data_i_1_2                (i_if_l[9].data),
    .local_valid_i_1_2               (i_if_l[9].valid),
    .local_ready_o_1_2               (i_if_l[9].ready),
    .local_data_o_1_2                (o_if_l[9].data),
    .local_valid_o_1_2               (o_if_l[9].valid),
    .local_ready_i_1_2               (o_if_l[9].ready),
    .bound_data_i_1_2                (i_if_b[9].data),
    .bound_valid_i_1_2               (i_if_b[9].valid),
    .bound_ready_o_1_2               (i_if_b[9].ready),
    .bound_data_o_1_2                (o_if_b[9].data),
    .bound_valid_o_1_2               (o_if_b[9].valid),
    .bound_ready_i_1_2               (o_if_b[9].ready),

    .local_data_i_1_3                (i_if_l[13].data),
    .local_valid_i_1_3               (i_if_l[13].valid),
    .local_ready_o_1_3               (i_if_l[13].ready),
    .local_data_o_1_3                (o_if_l[13].data),
    .local_valid_o_1_3               (o_if_l[13].valid),
    .local_ready_i_1_3               (o_if_l[13].ready),
    .bound_data_i_1_3                (i_if_b[13].data),
    .bound_valid_i_1_3               (i_if_b[13].valid),
    .bound_ready_o_1_3               (i_if_b[13].ready),
    .bound_data_o_1_3                (o_if_b[13].data),
    .bound_valid_o_1_3               (o_if_b[13].valid),
    .bound_ready_i_1_3               (o_if_b[13].ready),

    .local_data_i_2_0                (i_if_l[2].data),
    .local_valid_i_2_0               (i_if_l[2].valid),
    .local_ready_o_2_0               (i_if_l[2].ready),
    .local_data_o_2_0                (o_if_l[2].data),
    .local_valid_o_2_0               (o_if_l[2].valid),
    .local_ready_i_2_0               (o_if_l[2].ready),
    .bound_data_i_2_0                (i_if_b[2].data),
    .bound_valid_i_2_0               (i_if_b[2].valid),
    .bound_ready_o_2_0               (i_if_b[2].ready),
    .bound_data_o_2_0                (o_if_b[2].data),
    .bound_valid_o_2_0               (o_if_b[2].valid),
    .bound_ready_i_2_0               (o_if_b[2].ready),

    .local_data_i_2_1                (i_if_l[6].data),
    .local_valid_i_2_1               (i_if_l[6].valid),
    .local_ready_o_2_1               (i_if_l[6].ready),
    .local_data_o_2_1                (o_if_l[6].data),
    .local_valid_o_2_1               (o_if_l[6].valid),
    .local_ready_i_2_1               (o_if_l[6].ready),
    .bound_data_i_2_1                (i_if_b[6].data),
    .bound_valid_i_2_1               (i_if_b[6].valid),
    .bound_ready_o_2_1               (i_if_b[6].ready),
    .bound_data_o_2_1                (o_if_b[6].data),
    .bound_valid_o_2_1               (o_if_b[6].valid),
    .bound_ready_i_2_1               (o_if_b[6].ready),

    .local_data_i_2_2                (i_if_l[10].data),
    .local_valid_i_2_2               (i_if_l[10].valid),
    .local_ready_o_2_2               (i_if_l[10].ready),
    .local_data_o_2_2                (o_if_l[10].data),
    .local_valid_o_2_2               (o_if_l[10].valid),
    .local_ready_i_2_2               (o_if_l[10].ready),
    .bound_data_i_2_2                (i_if_b[10].data),
    .bound_valid_i_2_2               (i_if_b[10].valid),
    .bound_ready_o_2_2               (i_if_b[10].ready),
    .bound_data_o_2_2                (o_if_b[10].data),
    .bound_valid_o_2_2               (o_if_b[10].valid),
    .bound_ready_i_2_2               (o_if_b[10].ready),

    .local_data_i_2_3                (i_if_l[14].data),
    .local_valid_i_2_3               (i_if_l[14].valid),
    .local_ready_o_2_3               (i_if_l[14].ready),
    .local_data_o_2_3                (o_if_l[14].data),
    .local_valid_o_2_3               (o_if_l[14].valid),
    .local_ready_i_2_3               (o_if_l[14].ready),
    .bound_data_i_2_3                (i_if_b[14].data),
    .bound_valid_i_2_3               (i_if_b[14].valid),
    .bound_ready_o_2_3               (i_if_b[14].ready),
    .bound_data_o_2_3                (o_if_b[14].data),
    .bound_valid_o_2_3               (o_if_b[14].valid),
    .bound_ready_i_2_3               (o_if_b[14].ready),

    .local_data_i_3_0                (i_if_l[3].data),
    .local_valid_i_3_0               (i_if_l[3].valid),
    .local_ready_o_3_0               (i_if_l[3].ready),
    .local_data_o_3_0                (o_if_l[3].data),
    .local_valid_o_3_0               (o_if_l[3].valid),
    .local_ready_i_3_0               (o_if_l[3].ready),
    .bound_data_i_3_0                (i_if_b[3].data),
    .bound_valid_i_3_0               (i_if_b[3].valid),
    .bound_ready_o_3_0               (i_if_b[3].ready),
    .bound_data_o_3_0                (o_if_b[3].data),
    .bound_valid_o_3_0               (o_if_b[3].valid),
    .bound_ready_i_3_0               (o_if_b[3].ready),

    .local_data_i_3_1                (i_if_l[7].data),
    .local_valid_i_3_1               (i_if_l[7].valid),
    .local_ready_o_3_1               (i_if_l[7].ready),
    .local_data_o_3_1                (o_if_l[7].data),
    .local_valid_o_3_1               (o_if_l[7].valid),
    .local_ready_i_3_1               (o_if_l[7].ready),
    .bound_data_i_3_1                (i_if_b[7].data),
    .bound_valid_i_3_1               (i_if_b[7].valid),
    .bound_ready_o_3_1               (i_if_b[7].ready),
    .bound_data_o_3_1                (o_if_b[7].data),
    .bound_valid_o_3_1               (o_if_b[7].valid),
    .bound_ready_i_3_1               (o_if_b[7].ready),

    .local_data_i_3_2                (i_if_l[11].data),
    .local_valid_i_3_2               (i_if_l[11].valid),
    .local_ready_o_3_2               (i_if_l[11].ready),
    .local_data_o_3_2                (o_if_l[11].data),
    .local_valid_o_3_2               (o_if_l[11].valid),
    .local_ready_i_3_2               (o_if_l[11].ready),
    .bound_data_i_3_2                (i_if_b[11].data),
    .bound_valid_i_3_2               (i_if_b[11].valid),
    .bound_ready_o_3_2               (i_if_b[11].ready),
    .bound_data_o_3_2                (o_if_b[11].data),
    .bound_valid_o_3_2               (o_if_b[11].valid),
    .bound_ready_i_3_2               (o_if_b[11].ready),

    .local_data_i_3_3                (i_if_l[15].data),
    .local_valid_i_3_3               (i_if_l[15].valid),
    .local_ready_o_3_3               (i_if_l[15].ready),
    .local_data_o_3_3                (o_if_l[15].data),
    .local_valid_o_3_3               (o_if_l[15].valid),
    .local_ready_i_3_3               (o_if_l[15].ready),
    .bound_data_i_3_3                (i_if_b[15].data),
    .bound_valid_i_3_3               (i_if_b[15].valid),
    .bound_ready_o_3_3               (i_if_b[15].ready),
    .bound_data_o_3_3                (o_if_b[15].data),
    .bound_valid_o_3_3               (o_if_b[15].valid),
    .bound_ready_i_3_3               (o_if_b[15].ready)
);


initial
begin
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[0].i_agt_local.drv","vif",i_if_l[0]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[0].i_agt_local.mon","vif",i_if_l[0]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[0].o_agt_local.mon","vif",o_if_l[0]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[0].i_agt_bound.drv","vif",i_if_b[0]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[0].i_agt_bound.mon","vif",i_if_b[0]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[0].o_agt_bound.mon","vif",o_if_b[0]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[4].i_agt_local.drv","vif",i_if_l[4]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[4].i_agt_local.mon","vif",i_if_l[4]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[4].o_agt_local.mon","vif",o_if_l[4]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[4].i_agt_bound.drv","vif",i_if_b[4]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[4].i_agt_bound.mon","vif",i_if_b[4]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[4].o_agt_bound.mon","vif",o_if_b[4]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[8].i_agt_local.drv","vif",i_if_l[8]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[8].i_agt_local.mon","vif",i_if_l[8]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[8].o_agt_local.mon","vif",o_if_l[8]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[8].i_agt_bound.drv","vif",i_if_b[8]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[8].i_agt_bound.mon","vif",i_if_b[8]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[8].o_agt_bound.mon","vif",o_if_b[8]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[12].i_agt_local.drv","vif",i_if_l[12]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[12].i_agt_local.mon","vif",i_if_l[12]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[12].o_agt_local.mon","vif",o_if_l[12]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[12].i_agt_bound.drv","vif",i_if_b[12]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[12].i_agt_bound.mon","vif",i_if_b[12]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[12].o_agt_bound.mon","vif",o_if_b[12]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[1].i_agt_local.drv","vif",i_if_l[1]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[1].i_agt_local.mon","vif",i_if_l[1]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[1].o_agt_local.mon","vif",o_if_l[1]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[1].i_agt_bound.drv","vif",i_if_b[1]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[1].i_agt_bound.mon","vif",i_if_b[1]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[1].o_agt_bound.mon","vif",o_if_b[1]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[5].i_agt_local.drv","vif",i_if_l[5]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[5].i_agt_local.mon","vif",i_if_l[5]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[5].o_agt_local.mon","vif",o_if_l[5]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[5].i_agt_bound.drv","vif",i_if_b[5]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[5].i_agt_bound.mon","vif",i_if_b[5]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[5].o_agt_bound.mon","vif",o_if_b[5]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[9].i_agt_local.drv","vif",i_if_l[9]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[9].i_agt_local.mon","vif",i_if_l[9]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[9].o_agt_local.mon","vif",o_if_l[9]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[9].i_agt_bound.drv","vif",i_if_b[9]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[9].i_agt_bound.mon","vif",i_if_b[9]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[9].o_agt_bound.mon","vif",o_if_b[9]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[13].i_agt_local.drv","vif",i_if_l[13]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[13].i_agt_local.mon","vif",i_if_l[13]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[13].o_agt_local.mon","vif",o_if_l[13]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[13].i_agt_bound.drv","vif",i_if_b[13]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[13].i_agt_bound.mon","vif",i_if_b[13]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[13].o_agt_bound.mon","vif",o_if_b[13]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[2].i_agt_local.drv","vif",i_if_l[2]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[2].i_agt_local.mon","vif",i_if_l[2]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[2].o_agt_local.mon","vif",o_if_l[2]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[2].i_agt_bound.drv","vif",i_if_b[2]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[2].i_agt_bound.mon","vif",i_if_b[2]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[2].o_agt_bound.mon","vif",o_if_b[2]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[6].i_agt_local.drv","vif",i_if_l[6]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[6].i_agt_local.mon","vif",i_if_l[6]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[6].o_agt_local.mon","vif",o_if_l[6]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[6].i_agt_bound.drv","vif",i_if_b[6]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[6].i_agt_bound.mon","vif",i_if_b[6]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[6].o_agt_bound.mon","vif",o_if_b[6]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[10].i_agt_local.drv","vif",i_if_l[10]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[10].i_agt_local.mon","vif",i_if_l[10]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[10].o_agt_local.mon","vif",o_if_l[10]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[10].i_agt_bound.drv","vif",i_if_b[10]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[10].i_agt_bound.mon","vif",i_if_b[10]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[10].o_agt_bound.mon","vif",o_if_b[10]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[14].i_agt_local.drv","vif",i_if_l[14]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[14].i_agt_local.mon","vif",i_if_l[14]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[14].o_agt_local.mon","vif",o_if_l[14]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[14].i_agt_bound.drv","vif",i_if_b[14]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[14].i_agt_bound.mon","vif",i_if_b[14]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[14].o_agt_bound.mon","vif",o_if_b[14]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[3].i_agt_local.drv","vif",i_if_l[3]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[3].i_agt_local.mon","vif",i_if_l[3]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[3].o_agt_local.mon","vif",o_if_l[3]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[3].i_agt_bound.drv","vif",i_if_b[3]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[3].i_agt_bound.mon","vif",i_if_b[3]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[3].o_agt_bound.mon","vif",o_if_b[3]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[7].i_agt_local.drv","vif",i_if_l[7]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[7].i_agt_local.mon","vif",i_if_l[7]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[7].o_agt_local.mon","vif",o_if_l[7]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[7].i_agt_bound.drv","vif",i_if_b[7]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[7].i_agt_bound.mon","vif",i_if_b[7]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[7].o_agt_bound.mon","vif",o_if_b[7]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[11].i_agt_local.drv","vif",i_if_l[11]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[11].i_agt_local.mon","vif",i_if_l[11]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[11].o_agt_local.mon","vif",o_if_l[11]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[11].i_agt_bound.drv","vif",i_if_b[11]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[11].i_agt_bound.mon","vif",i_if_b[11]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[11].o_agt_bound.mon","vif",o_if_b[11]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[15].i_agt_local.drv","vif",i_if_l[15]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[15].i_agt_local.mon","vif",i_if_l[15]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[15].o_agt_local.mon","vif",o_if_l[15]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[15].i_agt_bound.drv","vif",i_if_b[15]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[15].i_agt_bound.mon","vif",i_if_b[15]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[15].o_agt_bound.mon","vif",o_if_b[15]);
end

initial
begin
    $fsdbDumpfile("wave.fsdb");
    $fsdbDumpvars(0,TargetNoC);
    run_test("tnoc_case0");
end

initial
begin
    clk = 0;
    forever
    begin
        #2 clk = ~clk;
    end
end

initial
begin
    rstn = 1'b0;
    #37;
    rstn = 1'b1;
end

endmodule