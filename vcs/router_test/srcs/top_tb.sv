`timescale 1ns/1ps
`include "uvm_macros.svh"

import uvm_pkg::*;
`include "params.vh"
`include "test_params.svh"
`include "cibd_if.sv"
`include "cibd_transaction.sv"
// `include "router_sequence.sv"
`include "cibd_sequencer.sv"
`include "router_vsqr.sv"
`include "cibd_driver.sv"
`include "cibd_monitor.sv"
`include "cibd_agent.sv"
`include "router_model.sv"
`include "router_scoreboard.sv"
`include "router_env.sv"
`include "router_base_test.sv"
`include "router_case0.sv"



module top_tb;
reg clk;
reg rstn;

cibd_if i_if_w(clk,rstn); //for i_agt
cibd_if i_if_e(clk,rstn); //for i_agt
cibd_if i_if_n(clk,rstn); //for i_agt
cibd_if i_if_s(clk,rstn); //for i_agt
cibd_if i_if_l(clk,rstn); //for i_agt
cibd_if i_if_b(clk,rstn); //for i_agt

cibd_if o_if_w(clk,rstn); //for o_agt
cibd_if o_if_e(clk,rstn); //for o_agt
cibd_if o_if_n(clk,rstn); //for o_agt
cibd_if o_if_s(clk,rstn); //for o_agt
cibd_if o_if_l(clk,rstn); //for o_agt
cibd_if o_if_b(clk,rstn); //for o_agt

router #(
    .LocalRID_X                  (`LOCAL_ID_X),
    .LocalRID_Y                  (`LOCAL_ID_Y)
)dut(
    .clk                         (clk),
    .rstn                        (rstn),
    .west_valid_i                (i_if_w.valid),
    .west_data_i                 (i_if_w.data),
    .west_ready_o                (i_if_w.ready),
    .west_valid_o                (o_if_w.valid),
    .west_data_o                 (o_if_w.data),
    .west_ready_i                (o_if_w.ready),
    .east_valid_i                (i_if_e.valid),
    .east_data_i                 (i_if_e.data),
    .east_ready_o                (i_if_e.ready),
    .east_valid_o                (o_if_e.valid),
    .east_data_o                 (o_if_e.data),
    .east_ready_i                (o_if_e.ready),
    .north_valid_i               (i_if_n.valid),
    .north_data_i                (i_if_n.data),
    .north_ready_o               (i_if_n.ready),
    .north_valid_o               (o_if_n.valid),
    .north_data_o                (o_if_n.data),
    .north_ready_i               (o_if_n.ready),
    .south_valid_i               (i_if_s.valid),
    .south_data_i                (i_if_s.data),
    .south_ready_o               (i_if_s.ready),
    .south_valid_o               (o_if_s.valid),
    .south_data_o                (o_if_s.data),
    .south_ready_i               (o_if_s.ready),
    .local_valid_i               (i_if_l.valid),
    .local_data_i                (i_if_l.data),
    .local_ready_o               (i_if_l.ready),
    .local_valid_o               (o_if_l.valid),
    .local_data_o                (o_if_l.data),
    .local_ready_i               (o_if_l.ready),
    .bound_valid_i               (i_if_b.valid),
    .bound_data_i                (i_if_b.data),
    .bound_ready_o               (i_if_b.ready),
    .bound_valid_o               (o_if_b.valid),
    .bound_data_o                (o_if_b.data),
    .bound_ready_i               (o_if_b.ready)
);


initial
begin
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[0].drv","vif",i_if_n);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[1].drv","vif",i_if_w);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[2].drv","vif",i_if_s);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[3].drv","vif",i_if_e);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[4].drv","vif",i_if_l);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[5].drv","vif",i_if_b);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[0].mon","vif",i_if_n);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[1].mon","vif",i_if_w);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[2].mon","vif",i_if_s);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[3].mon","vif",i_if_e);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[4].mon","vif",i_if_l);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.i_agt[5].mon","vif",i_if_b);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[0].mon","vif",o_if_n);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[1].mon","vif",o_if_w);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[2].mon","vif",o_if_s);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[3].mon","vif",o_if_e);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[4].mon","vif",o_if_l);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.o_agt[5].mon","vif",o_if_b);
end

initial
begin
    $fsdbDumpfile("wave.fsdb");
    $fsdbDumpvars(0,router);
    run_test("router_case0");
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