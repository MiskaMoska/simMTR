# for testbench
NOC_WIDTH = 4
NOC_HEIGHT = 4

def Instance():
    for c in range(4):
        for x in range(NOC_WIDTH):
            for y in range(NOC_HEIGHT):
                id = c * NOC_WIDTH * NOC_HEIGHT + y * NOC_WIDTH + x
                print('''
    .data_i_'''+str(c)+'''_'''+str(x)+'''_'''+str(y)+'''                (i_if['''+str(id)+'''].data),
    .valid_i_'''+str(c)+'''_'''+str(x)+'''_'''+str(y)+'''               (i_if['''+str(id)+'''].valid),
    .ready_o_'''+str(c)+'''_'''+str(x)+'''_'''+str(y)+'''               (i_if['''+str(id)+'''].ready),
    .data_o_'''+str(c)+'''_'''+str(x)+'''_'''+str(y)+'''                (o_if['''+str(id)+'''].data),
    .valid_o_'''+str(c)+'''_'''+str(x)+'''_'''+str(y)+'''               (o_if['''+str(id)+'''].valid),
    .ready_i_'''+str(c)+'''_'''+str(x)+'''_'''+str(y)+'''               (o_if['''+str(id)+'''].ready),'''
                )

def Interface():
    for c in range(4):
        for x in range(NOC_WIDTH):
            for y in range(NOC_HEIGHT):
                id = c * NOC_WIDTH * NOC_HEIGHT + y * NOC_WIDTH + x
                print('''
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent['''+str(id)+'''].i_agt.drv","vif",i_if['''+str(id)+''']);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent['''+str(id)+'''].i_agt.mon","vif",i_if['''+str(id)+''']);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent['''+str(id)+'''].o_agt.mon","vif",o_if['''+str(id)+''']);'''
                )

if __name__ == "__main__":
    Interface()