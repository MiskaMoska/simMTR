`timescale 1ns/1ps
`include "uvm_macros.svh"

import uvm_pkg::*;
`include "params.vh"
`include "test_params.svh"
`include "route_table.sv"
`include "cibd_if.sv"
`include "cibd_transaction.sv"
`include "mtr_sequence.sv"
`include "cibd_sequencer.sv"
`include "cibd_driver.sv"
`include "cibd_monitor.sv"
`include "cibd_agent.sv"
`include "mtr_model.sv"
`include "mtr_scoreboard.sv"
`include "mtr_env.sv"
`include "mtr_base_test.sv"
`include "mtr_case0.sv"

module top_tb;
reg clk;
reg rstn;

cibd_if i_if[4*`NOC_WIDTH*`NOC_HEIGHT](clk,rstn); //for port i_agt
cibd_if o_if[4*`NOC_WIDTH*`NOC_HEIGHT](clk,rstn); //for port o_agt

MTR #(
    .CID                         (0)
)dut(
    .clk                         (clk),
    .rstn                        (rstn),

    .data_i_0_0_0                (i_if[0].data),
    .valid_i_0_0_0               (i_if[0].valid),
    .ready_o_0_0_0               (i_if[0].ready),
    .data_o_0_0_0                (o_if[0].data),
    .valid_o_0_0_0               (o_if[0].valid),
    .ready_i_0_0_0               (o_if[0].ready),

    .data_i_0_0_1                (i_if[4].data),
    .valid_i_0_0_1               (i_if[4].valid),
    .ready_o_0_0_1               (i_if[4].ready),
    .data_o_0_0_1                (o_if[4].data),
    .valid_o_0_0_1               (o_if[4].valid),
    .ready_i_0_0_1               (o_if[4].ready),

    .data_i_0_0_2                (i_if[8].data),
    .valid_i_0_0_2               (i_if[8].valid),
    .ready_o_0_0_2               (i_if[8].ready),
    .data_o_0_0_2                (o_if[8].data),
    .valid_o_0_0_2               (o_if[8].valid),
    .ready_i_0_0_2               (o_if[8].ready),

    .data_i_0_0_3                (i_if[12].data),
    .valid_i_0_0_3               (i_if[12].valid),
    .ready_o_0_0_3               (i_if[12].ready),
    .data_o_0_0_3                (o_if[12].data),
    .valid_o_0_0_3               (o_if[12].valid),
    .ready_i_0_0_3               (o_if[12].ready),

    .data_i_0_1_0                (i_if[1].data),
    .valid_i_0_1_0               (i_if[1].valid),
    .ready_o_0_1_0               (i_if[1].ready),
    .data_o_0_1_0                (o_if[1].data),
    .valid_o_0_1_0               (o_if[1].valid),
    .ready_i_0_1_0               (o_if[1].ready),

    .data_i_0_1_1                (i_if[5].data),
    .valid_i_0_1_1               (i_if[5].valid),
    .ready_o_0_1_1               (i_if[5].ready),
    .data_o_0_1_1                (o_if[5].data),
    .valid_o_0_1_1               (o_if[5].valid),
    .ready_i_0_1_1               (o_if[5].ready),

    .data_i_0_1_2                (i_if[9].data),
    .valid_i_0_1_2               (i_if[9].valid),
    .ready_o_0_1_2               (i_if[9].ready),
    .data_o_0_1_2                (o_if[9].data),
    .valid_o_0_1_2               (o_if[9].valid),
    .ready_i_0_1_2               (o_if[9].ready),

    .data_i_0_1_3                (i_if[13].data),
    .valid_i_0_1_3               (i_if[13].valid),
    .ready_o_0_1_3               (i_if[13].ready),
    .data_o_0_1_3                (o_if[13].data),
    .valid_o_0_1_3               (o_if[13].valid),
    .ready_i_0_1_3               (o_if[13].ready),

    .data_i_0_2_0                (i_if[2].data),
    .valid_i_0_2_0               (i_if[2].valid),
    .ready_o_0_2_0               (i_if[2].ready),
    .data_o_0_2_0                (o_if[2].data),
    .valid_o_0_2_0               (o_if[2].valid),
    .ready_i_0_2_0               (o_if[2].ready),

    .data_i_0_2_1                (i_if[6].data),
    .valid_i_0_2_1               (i_if[6].valid),
    .ready_o_0_2_1               (i_if[6].ready),
    .data_o_0_2_1                (o_if[6].data),
    .valid_o_0_2_1               (o_if[6].valid),
    .ready_i_0_2_1               (o_if[6].ready),

    .data_i_0_2_2                (i_if[10].data),
    .valid_i_0_2_2               (i_if[10].valid),
    .ready_o_0_2_2               (i_if[10].ready),
    .data_o_0_2_2                (o_if[10].data),
    .valid_o_0_2_2               (o_if[10].valid),
    .ready_i_0_2_2               (o_if[10].ready),

    .data_i_0_2_3                (i_if[14].data),
    .valid_i_0_2_3               (i_if[14].valid),
    .ready_o_0_2_3               (i_if[14].ready),
    .data_o_0_2_3                (o_if[14].data),
    .valid_o_0_2_3               (o_if[14].valid),
    .ready_i_0_2_3               (o_if[14].ready),

    .data_i_0_3_0                (i_if[3].data),
    .valid_i_0_3_0               (i_if[3].valid),
    .ready_o_0_3_0               (i_if[3].ready),
    .data_o_0_3_0                (o_if[3].data),
    .valid_o_0_3_0               (o_if[3].valid),
    .ready_i_0_3_0               (o_if[3].ready),

    .data_i_0_3_1                (i_if[7].data),
    .valid_i_0_3_1               (i_if[7].valid),
    .ready_o_0_3_1               (i_if[7].ready),
    .data_o_0_3_1                (o_if[7].data),
    .valid_o_0_3_1               (o_if[7].valid),
    .ready_i_0_3_1               (o_if[7].ready),

    .data_i_0_3_2                (i_if[11].data),
    .valid_i_0_3_2               (i_if[11].valid),
    .ready_o_0_3_2               (i_if[11].ready),
    .data_o_0_3_2                (o_if[11].data),
    .valid_o_0_3_2               (o_if[11].valid),
    .ready_i_0_3_2               (o_if[11].ready),

    .data_i_0_3_3                (i_if[15].data),
    .valid_i_0_3_3               (i_if[15].valid),
    .ready_o_0_3_3               (i_if[15].ready),
    .data_o_0_3_3                (o_if[15].data),
    .valid_o_0_3_3               (o_if[15].valid),
    .ready_i_0_3_3               (o_if[15].ready),

    .data_i_1_0_0                (i_if[16].data),
    .valid_i_1_0_0               (i_if[16].valid),
    .ready_o_1_0_0               (i_if[16].ready),
    .data_o_1_0_0                (o_if[16].data),
    .valid_o_1_0_0               (o_if[16].valid),
    .ready_i_1_0_0               (o_if[16].ready),

    .data_i_1_0_1                (i_if[20].data),
    .valid_i_1_0_1               (i_if[20].valid),
    .ready_o_1_0_1               (i_if[20].ready),
    .data_o_1_0_1                (o_if[20].data),
    .valid_o_1_0_1               (o_if[20].valid),
    .ready_i_1_0_1               (o_if[20].ready),

    .data_i_1_0_2                (i_if[24].data),
    .valid_i_1_0_2               (i_if[24].valid),
    .ready_o_1_0_2               (i_if[24].ready),
    .data_o_1_0_2                (o_if[24].data),
    .valid_o_1_0_2               (o_if[24].valid),
    .ready_i_1_0_2               (o_if[24].ready),

    .data_i_1_0_3                (i_if[28].data),
    .valid_i_1_0_3               (i_if[28].valid),
    .ready_o_1_0_3               (i_if[28].ready),
    .data_o_1_0_3                (o_if[28].data),
    .valid_o_1_0_3               (o_if[28].valid),
    .ready_i_1_0_3               (o_if[28].ready),

    .data_i_1_1_0                (i_if[17].data),
    .valid_i_1_1_0               (i_if[17].valid),
    .ready_o_1_1_0               (i_if[17].ready),
    .data_o_1_1_0                (o_if[17].data),
    .valid_o_1_1_0               (o_if[17].valid),
    .ready_i_1_1_0               (o_if[17].ready),

    .data_i_1_1_1                (i_if[21].data),
    .valid_i_1_1_1               (i_if[21].valid),
    .ready_o_1_1_1               (i_if[21].ready),
    .data_o_1_1_1                (o_if[21].data),
    .valid_o_1_1_1               (o_if[21].valid),
    .ready_i_1_1_1               (o_if[21].ready),

    .data_i_1_1_2                (i_if[25].data),
    .valid_i_1_1_2               (i_if[25].valid),
    .ready_o_1_1_2               (i_if[25].ready),
    .data_o_1_1_2                (o_if[25].data),
    .valid_o_1_1_2               (o_if[25].valid),
    .ready_i_1_1_2               (o_if[25].ready),

    .data_i_1_1_3                (i_if[29].data),
    .valid_i_1_1_3               (i_if[29].valid),
    .ready_o_1_1_3               (i_if[29].ready),
    .data_o_1_1_3                (o_if[29].data),
    .valid_o_1_1_3               (o_if[29].valid),
    .ready_i_1_1_3               (o_if[29].ready),

    .data_i_1_2_0                (i_if[18].data),
    .valid_i_1_2_0               (i_if[18].valid),
    .ready_o_1_2_0               (i_if[18].ready),
    .data_o_1_2_0                (o_if[18].data),
    .valid_o_1_2_0               (o_if[18].valid),
    .ready_i_1_2_0               (o_if[18].ready),

    .data_i_1_2_1                (i_if[22].data),
    .valid_i_1_2_1               (i_if[22].valid),
    .ready_o_1_2_1               (i_if[22].ready),
    .data_o_1_2_1                (o_if[22].data),
    .valid_o_1_2_1               (o_if[22].valid),
    .ready_i_1_2_1               (o_if[22].ready),

    .data_i_1_2_2                (i_if[26].data),
    .valid_i_1_2_2               (i_if[26].valid),
    .ready_o_1_2_2               (i_if[26].ready),
    .data_o_1_2_2                (o_if[26].data),
    .valid_o_1_2_2               (o_if[26].valid),
    .ready_i_1_2_2               (o_if[26].ready),

    .data_i_1_2_3                (i_if[30].data),
    .valid_i_1_2_3               (i_if[30].valid),
    .ready_o_1_2_3               (i_if[30].ready),
    .data_o_1_2_3                (o_if[30].data),
    .valid_o_1_2_3               (o_if[30].valid),
    .ready_i_1_2_3               (o_if[30].ready),

    .data_i_1_3_0                (i_if[19].data),
    .valid_i_1_3_0               (i_if[19].valid),
    .ready_o_1_3_0               (i_if[19].ready),
    .data_o_1_3_0                (o_if[19].data),
    .valid_o_1_3_0               (o_if[19].valid),
    .ready_i_1_3_0               (o_if[19].ready),

    .data_i_1_3_1                (i_if[23].data),
    .valid_i_1_3_1               (i_if[23].valid),
    .ready_o_1_3_1               (i_if[23].ready),
    .data_o_1_3_1                (o_if[23].data),
    .valid_o_1_3_1               (o_if[23].valid),
    .ready_i_1_3_1               (o_if[23].ready),

    .data_i_1_3_2                (i_if[27].data),
    .valid_i_1_3_2               (i_if[27].valid),
    .ready_o_1_3_2               (i_if[27].ready),
    .data_o_1_3_2                (o_if[27].data),
    .valid_o_1_3_2               (o_if[27].valid),
    .ready_i_1_3_2               (o_if[27].ready),

    .data_i_1_3_3                (i_if[31].data),
    .valid_i_1_3_3               (i_if[31].valid),
    .ready_o_1_3_3               (i_if[31].ready),
    .data_o_1_3_3                (o_if[31].data),
    .valid_o_1_3_3               (o_if[31].valid),
    .ready_i_1_3_3               (o_if[31].ready),

    .data_i_2_0_0                (i_if[32].data),
    .valid_i_2_0_0               (i_if[32].valid),
    .ready_o_2_0_0               (i_if[32].ready),
    .data_o_2_0_0                (o_if[32].data),
    .valid_o_2_0_0               (o_if[32].valid),
    .ready_i_2_0_0               (o_if[32].ready),

    .data_i_2_0_1                (i_if[36].data),
    .valid_i_2_0_1               (i_if[36].valid),
    .ready_o_2_0_1               (i_if[36].ready),
    .data_o_2_0_1                (o_if[36].data),
    .valid_o_2_0_1               (o_if[36].valid),
    .ready_i_2_0_1               (o_if[36].ready),

    .data_i_2_0_2                (i_if[40].data),
    .valid_i_2_0_2               (i_if[40].valid),
    .ready_o_2_0_2               (i_if[40].ready),
    .data_o_2_0_2                (o_if[40].data),
    .valid_o_2_0_2               (o_if[40].valid),
    .ready_i_2_0_2               (o_if[40].ready),

    .data_i_2_0_3                (i_if[44].data),
    .valid_i_2_0_3               (i_if[44].valid),
    .ready_o_2_0_3               (i_if[44].ready),
    .data_o_2_0_3                (o_if[44].data),
    .valid_o_2_0_3               (o_if[44].valid),
    .ready_i_2_0_3               (o_if[44].ready),

    .data_i_2_1_0                (i_if[33].data),
    .valid_i_2_1_0               (i_if[33].valid),
    .ready_o_2_1_0               (i_if[33].ready),
    .data_o_2_1_0                (o_if[33].data),
    .valid_o_2_1_0               (o_if[33].valid),
    .ready_i_2_1_0               (o_if[33].ready),

    .data_i_2_1_1                (i_if[37].data),
    .valid_i_2_1_1               (i_if[37].valid),
    .ready_o_2_1_1               (i_if[37].ready),
    .data_o_2_1_1                (o_if[37].data),
    .valid_o_2_1_1               (o_if[37].valid),
    .ready_i_2_1_1               (o_if[37].ready),

    .data_i_2_1_2                (i_if[41].data),
    .valid_i_2_1_2               (i_if[41].valid),
    .ready_o_2_1_2               (i_if[41].ready),
    .data_o_2_1_2                (o_if[41].data),
    .valid_o_2_1_2               (o_if[41].valid),
    .ready_i_2_1_2               (o_if[41].ready),

    .data_i_2_1_3                (i_if[45].data),
    .valid_i_2_1_3               (i_if[45].valid),
    .ready_o_2_1_3               (i_if[45].ready),
    .data_o_2_1_3                (o_if[45].data),
    .valid_o_2_1_3               (o_if[45].valid),
    .ready_i_2_1_3               (o_if[45].ready),

    .data_i_2_2_0                (i_if[34].data),
    .valid_i_2_2_0               (i_if[34].valid),
    .ready_o_2_2_0               (i_if[34].ready),
    .data_o_2_2_0                (o_if[34].data),
    .valid_o_2_2_0               (o_if[34].valid),
    .ready_i_2_2_0               (o_if[34].ready),

    .data_i_2_2_1                (i_if[38].data),
    .valid_i_2_2_1               (i_if[38].valid),
    .ready_o_2_2_1               (i_if[38].ready),
    .data_o_2_2_1                (o_if[38].data),
    .valid_o_2_2_1               (o_if[38].valid),
    .ready_i_2_2_1               (o_if[38].ready),

    .data_i_2_2_2                (i_if[42].data),
    .valid_i_2_2_2               (i_if[42].valid),
    .ready_o_2_2_2               (i_if[42].ready),
    .data_o_2_2_2                (o_if[42].data),
    .valid_o_2_2_2               (o_if[42].valid),
    .ready_i_2_2_2               (o_if[42].ready),

    .data_i_2_2_3                (i_if[46].data),
    .valid_i_2_2_3               (i_if[46].valid),
    .ready_o_2_2_3               (i_if[46].ready),
    .data_o_2_2_3                (o_if[46].data),
    .valid_o_2_2_3               (o_if[46].valid),
    .ready_i_2_2_3               (o_if[46].ready),

    .data_i_2_3_0                (i_if[35].data),
    .valid_i_2_3_0               (i_if[35].valid),
    .ready_o_2_3_0               (i_if[35].ready),
    .data_o_2_3_0                (o_if[35].data),
    .valid_o_2_3_0               (o_if[35].valid),
    .ready_i_2_3_0               (o_if[35].ready),

    .data_i_2_3_1                (i_if[39].data),
    .valid_i_2_3_1               (i_if[39].valid),
    .ready_o_2_3_1               (i_if[39].ready),
    .data_o_2_3_1                (o_if[39].data),
    .valid_o_2_3_1               (o_if[39].valid),
    .ready_i_2_3_1               (o_if[39].ready),

    .data_i_2_3_2                (i_if[43].data),
    .valid_i_2_3_2               (i_if[43].valid),
    .ready_o_2_3_2               (i_if[43].ready),
    .data_o_2_3_2                (o_if[43].data),
    .valid_o_2_3_2               (o_if[43].valid),
    .ready_i_2_3_2               (o_if[43].ready),

    .data_i_2_3_3                (i_if[47].data),
    .valid_i_2_3_3               (i_if[47].valid),
    .ready_o_2_3_3               (i_if[47].ready),
    .data_o_2_3_3                (o_if[47].data),
    .valid_o_2_3_3               (o_if[47].valid),
    .ready_i_2_3_3               (o_if[47].ready),

    .data_i_3_0_0                (i_if[48].data),
    .valid_i_3_0_0               (i_if[48].valid),
    .ready_o_3_0_0               (i_if[48].ready),
    .data_o_3_0_0                (o_if[48].data),
    .valid_o_3_0_0               (o_if[48].valid),
    .ready_i_3_0_0               (o_if[48].ready),

    .data_i_3_0_1                (i_if[52].data),
    .valid_i_3_0_1               (i_if[52].valid),
    .ready_o_3_0_1               (i_if[52].ready),
    .data_o_3_0_1                (o_if[52].data),
    .valid_o_3_0_1               (o_if[52].valid),
    .ready_i_3_0_1               (o_if[52].ready),

    .data_i_3_0_2                (i_if[56].data),
    .valid_i_3_0_2               (i_if[56].valid),
    .ready_o_3_0_2               (i_if[56].ready),
    .data_o_3_0_2                (o_if[56].data),
    .valid_o_3_0_2               (o_if[56].valid),
    .ready_i_3_0_2               (o_if[56].ready),

    .data_i_3_0_3                (i_if[60].data),
    .valid_i_3_0_3               (i_if[60].valid),
    .ready_o_3_0_3               (i_if[60].ready),
    .data_o_3_0_3                (o_if[60].data),
    .valid_o_3_0_3               (o_if[60].valid),
    .ready_i_3_0_3               (o_if[60].ready),

    .data_i_3_1_0                (i_if[49].data),
    .valid_i_3_1_0               (i_if[49].valid),
    .ready_o_3_1_0               (i_if[49].ready),
    .data_o_3_1_0                (o_if[49].data),
    .valid_o_3_1_0               (o_if[49].valid),
    .ready_i_3_1_0               (o_if[49].ready),

    .data_i_3_1_1                (i_if[53].data),
    .valid_i_3_1_1               (i_if[53].valid),
    .ready_o_3_1_1               (i_if[53].ready),
    .data_o_3_1_1                (o_if[53].data),
    .valid_o_3_1_1               (o_if[53].valid),
    .ready_i_3_1_1               (o_if[53].ready),

    .data_i_3_1_2                (i_if[57].data),
    .valid_i_3_1_2               (i_if[57].valid),
    .ready_o_3_1_2               (i_if[57].ready),
    .data_o_3_1_2                (o_if[57].data),
    .valid_o_3_1_2               (o_if[57].valid),
    .ready_i_3_1_2               (o_if[57].ready),

    .data_i_3_1_3                (i_if[61].data),
    .valid_i_3_1_3               (i_if[61].valid),
    .ready_o_3_1_3               (i_if[61].ready),
    .data_o_3_1_3                (o_if[61].data),
    .valid_o_3_1_3               (o_if[61].valid),
    .ready_i_3_1_3               (o_if[61].ready),

    .data_i_3_2_0                (i_if[50].data),
    .valid_i_3_2_0               (i_if[50].valid),
    .ready_o_3_2_0               (i_if[50].ready),
    .data_o_3_2_0                (o_if[50].data),
    .valid_o_3_2_0               (o_if[50].valid),
    .ready_i_3_2_0               (o_if[50].ready),

    .data_i_3_2_1                (i_if[54].data),
    .valid_i_3_2_1               (i_if[54].valid),
    .ready_o_3_2_1               (i_if[54].ready),
    .data_o_3_2_1                (o_if[54].data),
    .valid_o_3_2_1               (o_if[54].valid),
    .ready_i_3_2_1               (o_if[54].ready),

    .data_i_3_2_2                (i_if[58].data),
    .valid_i_3_2_2               (i_if[58].valid),
    .ready_o_3_2_2               (i_if[58].ready),
    .data_o_3_2_2                (o_if[58].data),
    .valid_o_3_2_2               (o_if[58].valid),
    .ready_i_3_2_2               (o_if[58].ready),

    .data_i_3_2_3                (i_if[62].data),
    .valid_i_3_2_3               (i_if[62].valid),
    .ready_o_3_2_3               (i_if[62].ready),
    .data_o_3_2_3                (o_if[62].data),
    .valid_o_3_2_3               (o_if[62].valid),
    .ready_i_3_2_3               (o_if[62].ready),

    .data_i_3_3_0                (i_if[51].data),
    .valid_i_3_3_0               (i_if[51].valid),
    .ready_o_3_3_0               (i_if[51].ready),
    .data_o_3_3_0                (o_if[51].data),
    .valid_o_3_3_0               (o_if[51].valid),
    .ready_i_3_3_0               (o_if[51].ready),

    .data_i_3_3_1                (i_if[55].data),
    .valid_i_3_3_1               (i_if[55].valid),
    .ready_o_3_3_1               (i_if[55].ready),
    .data_o_3_3_1                (o_if[55].data),
    .valid_o_3_3_1               (o_if[55].valid),
    .ready_i_3_3_1               (o_if[55].ready),

    .data_i_3_3_2                (i_if[59].data),
    .valid_i_3_3_2               (i_if[59].valid),
    .ready_o_3_3_2               (i_if[59].ready),
    .data_o_3_3_2                (o_if[59].data),
    .valid_o_3_3_2               (o_if[59].valid),
    .ready_i_3_3_2               (o_if[59].ready),

    .data_i_3_3_3                (i_if[63].data),
    .valid_i_3_3_3               (i_if[63].valid),
    .ready_o_3_3_3               (i_if[63].ready),
    .data_o_3_3_3                (o_if[63].data),
    .valid_o_3_3_3               (o_if[63].valid),
    .ready_i_3_3_3               (o_if[63].ready)
);


initial
begin
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[0].i_agt.drv","vif",i_if[0]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[0].i_agt.mon","vif",i_if[0]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[0].o_agt.mon","vif",o_if[0]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[4].i_agt.drv","vif",i_if[4]);  
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[4].i_agt.mon","vif",i_if[4]);  
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[4].o_agt.mon","vif",o_if[4]);  

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[8].i_agt.drv","vif",i_if[8]);  
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[8].i_agt.mon","vif",i_if[8]);  
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[8].o_agt.mon","vif",o_if[8]);  

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[12].i_agt.drv","vif",i_if[12]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[12].i_agt.mon","vif",i_if[12]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[12].o_agt.mon","vif",o_if[12]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[1].i_agt.drv","vif",i_if[1]);  
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[1].i_agt.mon","vif",i_if[1]);  
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[1].o_agt.mon","vif",o_if[1]);  

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[5].i_agt.drv","vif",i_if[5]);  
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[5].i_agt.mon","vif",i_if[5]);  
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[5].o_agt.mon","vif",o_if[5]);  

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[9].i_agt.drv","vif",i_if[9]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[9].i_agt.mon","vif",i_if[9]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[9].o_agt.mon","vif",o_if[9]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[13].i_agt.drv","vif",i_if[13]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[13].i_agt.mon","vif",i_if[13]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[13].o_agt.mon","vif",o_if[13]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[2].i_agt.drv","vif",i_if[2]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[2].i_agt.mon","vif",i_if[2]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[2].o_agt.mon","vif",o_if[2]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[6].i_agt.drv","vif",i_if[6]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[6].i_agt.mon","vif",i_if[6]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[6].o_agt.mon","vif",o_if[6]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[10].i_agt.drv","vif",i_if[10]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[10].i_agt.mon","vif",i_if[10]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[10].o_agt.mon","vif",o_if[10]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[14].i_agt.drv","vif",i_if[14]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[14].i_agt.mon","vif",i_if[14]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[14].o_agt.mon","vif",o_if[14]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[3].i_agt.drv","vif",i_if[3]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[3].i_agt.mon","vif",i_if[3]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[3].o_agt.mon","vif",o_if[3]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[7].i_agt.drv","vif",i_if[7]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[7].i_agt.mon","vif",i_if[7]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[7].o_agt.mon","vif",o_if[7]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[11].i_agt.drv","vif",i_if[11]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[11].i_agt.mon","vif",i_if[11]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[11].o_agt.mon","vif",o_if[11]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[15].i_agt.drv","vif",i_if[15]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[15].i_agt.mon","vif",i_if[15]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[15].o_agt.mon","vif",o_if[15]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[16].i_agt.drv","vif",i_if[16]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[16].i_agt.mon","vif",i_if[16]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[16].o_agt.mon","vif",o_if[16]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[20].i_agt.drv","vif",i_if[20]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[20].i_agt.mon","vif",i_if[20]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[20].o_agt.mon","vif",o_if[20]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[24].i_agt.drv","vif",i_if[24]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[24].i_agt.mon","vif",i_if[24]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[24].o_agt.mon","vif",o_if[24]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[28].i_agt.drv","vif",i_if[28]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[28].i_agt.mon","vif",i_if[28]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[28].o_agt.mon","vif",o_if[28]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[17].i_agt.drv","vif",i_if[17]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[17].i_agt.mon","vif",i_if[17]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[17].o_agt.mon","vif",o_if[17]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[21].i_agt.drv","vif",i_if[21]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[21].i_agt.mon","vif",i_if[21]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[21].o_agt.mon","vif",o_if[21]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[25].i_agt.drv","vif",i_if[25]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[25].i_agt.mon","vif",i_if[25]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[25].o_agt.mon","vif",o_if[25]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[29].i_agt.drv","vif",i_if[29]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[29].i_agt.mon","vif",i_if[29]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[29].o_agt.mon","vif",o_if[29]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[18].i_agt.drv","vif",i_if[18]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[18].i_agt.mon","vif",i_if[18]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[18].o_agt.mon","vif",o_if[18]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[22].i_agt.drv","vif",i_if[22]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[22].i_agt.mon","vif",i_if[22]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[22].o_agt.mon","vif",o_if[22]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[26].i_agt.drv","vif",i_if[26]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[26].i_agt.mon","vif",i_if[26]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[26].o_agt.mon","vif",o_if[26]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[30].i_agt.drv","vif",i_if[30]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[30].i_agt.mon","vif",i_if[30]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[30].o_agt.mon","vif",o_if[30]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[19].i_agt.drv","vif",i_if[19]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[19].i_agt.mon","vif",i_if[19]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[19].o_agt.mon","vif",o_if[19]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[23].i_agt.drv","vif",i_if[23]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[23].i_agt.mon","vif",i_if[23]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[23].o_agt.mon","vif",o_if[23]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[27].i_agt.drv","vif",i_if[27]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[27].i_agt.mon","vif",i_if[27]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[27].o_agt.mon","vif",o_if[27]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[31].i_agt.drv","vif",i_if[31]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[31].i_agt.mon","vif",i_if[31]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[31].o_agt.mon","vif",o_if[31]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[32].i_agt.drv","vif",i_if[32]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[32].i_agt.mon","vif",i_if[32]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[32].o_agt.mon","vif",o_if[32]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[36].i_agt.drv","vif",i_if[36]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[36].i_agt.mon","vif",i_if[36]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[36].o_agt.mon","vif",o_if[36]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[40].i_agt.drv","vif",i_if[40]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[40].i_agt.mon","vif",i_if[40]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[40].o_agt.mon","vif",o_if[40]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[44].i_agt.drv","vif",i_if[44]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[44].i_agt.mon","vif",i_if[44]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[44].o_agt.mon","vif",o_if[44]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[33].i_agt.drv","vif",i_if[33]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[33].i_agt.mon","vif",i_if[33]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[33].o_agt.mon","vif",o_if[33]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[37].i_agt.drv","vif",i_if[37]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[37].i_agt.mon","vif",i_if[37]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[37].o_agt.mon","vif",o_if[37]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[41].i_agt.drv","vif",i_if[41]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[41].i_agt.mon","vif",i_if[41]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[41].o_agt.mon","vif",o_if[41]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[45].i_agt.drv","vif",i_if[45]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[45].i_agt.mon","vif",i_if[45]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[45].o_agt.mon","vif",o_if[45]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[34].i_agt.drv","vif",i_if[34]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[34].i_agt.mon","vif",i_if[34]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[34].o_agt.mon","vif",o_if[34]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[38].i_agt.drv","vif",i_if[38]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[38].i_agt.mon","vif",i_if[38]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[38].o_agt.mon","vif",o_if[38]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[42].i_agt.drv","vif",i_if[42]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[42].i_agt.mon","vif",i_if[42]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[42].o_agt.mon","vif",o_if[42]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[46].i_agt.drv","vif",i_if[46]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[46].i_agt.mon","vif",i_if[46]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[46].o_agt.mon","vif",o_if[46]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[35].i_agt.drv","vif",i_if[35]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[35].i_agt.mon","vif",i_if[35]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[35].o_agt.mon","vif",o_if[35]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[39].i_agt.drv","vif",i_if[39]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[39].i_agt.mon","vif",i_if[39]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[39].o_agt.mon","vif",o_if[39]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[43].i_agt.drv","vif",i_if[43]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[43].i_agt.mon","vif",i_if[43]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[43].o_agt.mon","vif",o_if[43]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[47].i_agt.drv","vif",i_if[47]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[47].i_agt.mon","vif",i_if[47]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[47].o_agt.mon","vif",o_if[47]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[48].i_agt.drv","vif",i_if[48]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[48].i_agt.mon","vif",i_if[48]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[48].o_agt.mon","vif",o_if[48]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[52].i_agt.drv","vif",i_if[52]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[52].i_agt.mon","vif",i_if[52]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[52].o_agt.mon","vif",o_if[52]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[56].i_agt.drv","vif",i_if[56]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[56].i_agt.mon","vif",i_if[56]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[56].o_agt.mon","vif",o_if[56]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[60].i_agt.drv","vif",i_if[60]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[60].i_agt.mon","vif",i_if[60]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[60].o_agt.mon","vif",o_if[60]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[49].i_agt.drv","vif",i_if[49]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[49].i_agt.mon","vif",i_if[49]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[49].o_agt.mon","vif",o_if[49]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[53].i_agt.drv","vif",i_if[53]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[53].i_agt.mon","vif",i_if[53]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[53].o_agt.mon","vif",o_if[53]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[57].i_agt.drv","vif",i_if[57]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[57].i_agt.mon","vif",i_if[57]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[57].o_agt.mon","vif",o_if[57]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[61].i_agt.drv","vif",i_if[61]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[61].i_agt.mon","vif",i_if[61]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[61].o_agt.mon","vif",o_if[61]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[50].i_agt.drv","vif",i_if[50]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[50].i_agt.mon","vif",i_if[50]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[50].o_agt.mon","vif",o_if[50]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[54].i_agt.drv","vif",i_if[54]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[54].i_agt.mon","vif",i_if[54]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[54].o_agt.mon","vif",o_if[54]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[58].i_agt.drv","vif",i_if[58]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[58].i_agt.mon","vif",i_if[58]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[58].o_agt.mon","vif",o_if[58]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[62].i_agt.drv","vif",i_if[62]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[62].i_agt.mon","vif",i_if[62]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[62].o_agt.mon","vif",o_if[62]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[51].i_agt.drv","vif",i_if[51]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[51].i_agt.mon","vif",i_if[51]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[51].o_agt.mon","vif",o_if[51]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[55].i_agt.drv","vif",i_if[55]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[55].i_agt.mon","vif",i_if[55]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[55].o_agt.mon","vif",o_if[55]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[59].i_agt.drv","vif",i_if[59]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[59].i_agt.mon","vif",i_if[59]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[59].o_agt.mon","vif",o_if[59]);

    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[63].i_agt.drv","vif",i_if[63]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[63].i_agt.mon","vif",i_if[63]);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent[63].o_agt.mon","vif",o_if[63]);
end

initial
begin
    init_connect_table(ctab);
    init_bound_table(inbtab,outbtab);
    $fsdbDumpfile("wave.fsdb");
    $fsdbDumpvars(0,MTR);
    run_test("mtr_case0");
end

initial
begin
    clk = 0;
    forever
    begin
        #(`CLK_PERIOD/2) clk = ~clk;
    end
end

initial
begin
    rstn = 1'b0;
    #37;
    rstn = 1'b1;
end

endmodule