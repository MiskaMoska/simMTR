The size of all NoCs (including the target NoCs and the interposer NoC) is fixed at 4 * 4, and the number of boundary routers on target NoC is fixed at 4. If you want other values, change to other branches.

If the boundary routers are modified, you should do the following steps before reloading the UVM test:

1. First you must have the case index of the boundary router placement to be tested and the corresponding output log file, about the index and the log file please refer to branch "cpp" of the repos in https://github.com/MiskaMoska/Fast-TRA.
2. Modify the parameters in `./table/main.py` and run it to get the BRL and the Mapping Table, the Mapping Table should be written to  `./vcs/mtr_test/srcs/route_table.sv` to replace the old one, and the BRL is used in the following steps.
3. Modify `BRL_LIST` in `./scripts/genMTR.py` with the abovementioned BRL, which means `./rtl/MTR.v` should be regenerated.
4. Modify `brid_x` and `brid_y` in `./vcs/mtr_test/srcs/test_params.svh`.

Note that `brid_x` `brid_y` should be highly consistent with `BRL_LIST` in the order of boundary routers.

If the boundary turn restrictions are modified, but the boundary routers are not modified, perform step 1 and step 2 only.
