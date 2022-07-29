This section is used to generate the routing table for inter-chip routing

1. Set the expected boundary router list and boundary turn restriction list in main.py
2. Run main.py to get the corresponding connection table and the boundary mapping tables and SystemVerilog code segment
3. The code segment can be used in ../vcs/mtr/srcs/route_table.sv and is used to guide the inter-chip routing when running simulation