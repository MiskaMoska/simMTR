# the number of the target NoCs is fixed at 4
# the number of boundary routers at each target NoCs is fixed at 4
# the size of target NoC and interposer NoC is fixed, too
# ----- target NoC size: 4*4
# ----- interposer NoC size: 4*4

DATA_WIDTH = 64
INOC_WIDTH = 4
INOC_HEIGHT = 4
BR_LIST = [(3, 1), (0, 2), (1, 2), (2, 2)]

data_width = str(DATA_WIDTH)
print('`include "params.vh"')

################################################################################
#   port list
################################################################################
print('''module MTR(
    input       wire                            clk,
    input       wire                            rstn,''')

for cid in range(4):
    for x in range(4):
        for y in range(4):
            suffix = str(cid)+'''_'''+str(x)+'''_'''+str(y)
            last = True if cid == 3 and x == 3 and y == 3 else False
            print('''
    input       wire        [`DW-1:0]           data_i_'''+suffix+''',
    input       wire                            valid_i_'''+suffix+''',
    output      wire                            ready_o_'''+suffix+''',
    output      wire        [`DW-1:0]           data_o_'''+suffix+''',
    output      wire                            valid_o_'''+suffix+''',
    input       wire                            ready_i_'''+suffix+('''\n''' if last else ''',''')
            )
print(");")


################################################################################
#   net signals
################################################################################
for x in range(4):
    for y in range(4):
        num = str(y*INOC_WIDTH+x)
        print("wire     [`DW-1:0]       bound_itp_data_i_"+num+";")
        print("wire                     bound_itp_valid_i_"+num+";")
        print("wire                     bound_itp_ready_o_"+num+";")
        print("wire     [`DW-1:0]       bound_itp_data_o_"+num+";")
        print("wire                     bound_itp_valid_o_"+num+";")
        print("wire                     bound_itp_ready_i_"+num+";")

        print("wire     [`DW-1:0]       bound_trg_data_i_"+num+";")
        print("wire                     bound_trg_valid_i_"+num+";")
        print("wire                     bound_trg_ready_o_"+num+";")
        print("wire     [`DW-1:0]       bound_trg_data_o_"+num+";")
        print("wire                     bound_trg_valid_o_"+num+";")
        print("wire                     bound_trg_ready_i_"+num+";")

################################################################################
#   interposer noc instance
################################################################################
print('''
InterposerNoC inoc(
    
    .clk                        (clk),
    .rstn                       (rstn),
    '''
    )

for x in range(4):
    for y in range(4):
        suffix = str(x) + '''_''' + str(y)
        num = str(y*INOC_WIDTH+x)
        last = True if x == 3 and y == 3 else False
        print('''
    .data_i_'''+suffix+'''                 (bound_itp_data_i_'''+num+'''),
    .valid_i_'''+suffix+'''                (bound_itp_valid_i_'''+num+'''),
    .ready_o_'''+suffix+'''                (bound_itp_ready_o_'''+num+'''),
    .data_o_'''+suffix+'''                 (bound_itp_data_o_'''+num+'''),
    .valid_o_'''+suffix+'''                (bound_itp_valid_o_'''+num+'''),
    .ready_i_'''+suffix+'''                (bound_itp_ready_i_'''+num+''')'''+('''\n''' if last else ''',''')
    )

print(");")

################################################################################
#   target noc instances
################################################################################
for cid in range(4):
    print('''
TargetNoC tnoc'''+str(cid)+'''(
    
    .clk                             (clk),
    .rstn                            (rstn),'''
    )
    for x in range(4):
        for y in range(4):
            flag = 0
            suffix = str(x) + '''_''' + str(y)
            full_suffix = str(cid) + '''_''' + suffix
            last = True if x == 3 and y == 3 else False
            num = ""
            if (x,y,) in BR_LIST: # if this is a boundary node
                flag = 1
                rx = BR_LIST.index((x,y,)) % 2 + (cid % 2) * 2
                ry = BR_LIST.index((x,y,)) // 2 + (cid // 2) * 2
                num = str(rx + ry * 4)
            print(''' 
    .local_data_i_'''+suffix+'''                (data_i_'''+full_suffix+'''),
    .local_valid_i_'''+suffix+'''               (valid_i_'''+full_suffix+'''),
    .local_ready_o_'''+suffix+'''               (ready_o_'''+full_suffix+'''),
    .local_data_o_'''+suffix+'''                (data_o_'''+full_suffix+'''),
    .local_valid_o_'''+suffix+'''               (valid_o_'''+full_suffix+'''),
    .local_ready_i_'''+suffix+'''               (ready_i_'''+full_suffix+'''),

    .bound_data_i_'''+suffix+'''                (''' + (('''bound_trg_data_i_'''+num) if flag else (data_width + ''''b0''')) + '''),
    .bound_valid_i_'''+suffix+'''               (''' + (('''bound_trg_valid_i_'''+num) if flag else '''1'b0''') + '''),
    .bound_ready_o_'''+suffix+'''               (''' + (('''bound_trg_ready_o_'''+num) if flag else ''' ''') + '''),
    .bound_data_o_'''+suffix+'''                (''' + (('''bound_trg_data_o_'''+num) if flag else ''' ''') + '''),
    .bound_valid_o_'''+suffix+'''               (''' + (('''bound_trg_valid_o_'''+num) if flag else ''' ''') + '''),
    .bound_ready_i_'''+suffix+'''               (''' + (('''bound_trg_ready_i_'''+num) if flag else '''1'b0''') + ''')'''+('''\n''' if last else ''',''')
        )
    print(");")


################################################################################
#   bound_link instances
################################################################################
for i in range(16):
    print('''
bound_link bl'''+str(i)+'''(
    .clk                       (clk),
    .rstn                      (rstn),
    .trg_data_i                (bound_trg_data_o_'''+str(i)+'''),
    .trg_valid_i               (bound_trg_valid_o_'''+str(i)+'''),
    .trg_ready_o               (bound_trg_ready_i_'''+str(i)+'''),
    .trg_data_o                (bound_trg_data_i_'''+str(i)+'''),
    .trg_valid_o               (bound_trg_valid_i_'''+str(i)+'''),
    .trg_ready_i               (bound_trg_ready_o_'''+str(i)+'''),
    .itp_data_i                (bound_itp_data_o_'''+str(i)+'''),
    .itp_valid_i               (bound_itp_valid_o_'''+str(i)+'''),
    .itp_ready_o               (bound_itp_ready_i_'''+str(i)+'''),
    .itp_data_o                (bound_itp_data_i_'''+str(i)+'''),
    .itp_valid_o               (bound_itp_valid_i_'''+str(i)+'''),
    .itp_ready_i               (bound_itp_ready_o_'''+str(i)+''')
);''')

print("endmodule")