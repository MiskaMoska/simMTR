# for testbench
NOC_WIDTH = 4
NOC_HEIGHT = 4

def Instance():
    for x in range(NOC_WIDTH):
        for y in range(NOC_HEIGHT):
            id = y * NOC_WIDTH + x
            print('''
    .local_data_i_'''+str(x)+'''_'''+str(y)+'''                (i_if_l['''+str(id)+'''].data),
    .local_valid_i_'''+str(x)+'''_'''+str(y)+'''               (i_if_l['''+str(id)+'''].valid),
    .local_ready_o_'''+str(x)+'''_'''+str(y)+'''               (i_if_l['''+str(id)+'''].ready),
    .local_data_o_'''+str(x)+'''_'''+str(y)+'''                (o_if_l['''+str(id)+'''].data),
    .local_valid_o_'''+str(x)+'''_'''+str(y)+'''               (o_if_l['''+str(id)+'''].valid),
    .local_ready_i_'''+str(x)+'''_'''+str(y)+'''               (o_if_l['''+str(id)+'''].ready),
    .bound_data_i_'''+str(x)+'''_'''+str(y)+'''                (i_if_b['''+str(id)+'''].data),
    .bound_valid_i_'''+str(x)+'''_'''+str(y)+'''               (i_if_b['''+str(id)+'''].valid),
    .bound_ready_o_'''+str(x)+'''_'''+str(y)+'''               (i_if_b['''+str(id)+'''].ready),
    .bound_data_o_'''+str(x)+'''_'''+str(y)+'''                (o_if_b['''+str(id)+'''].data),
    .bound_valid_o_'''+str(x)+'''_'''+str(y)+'''               (o_if_b['''+str(id)+'''].valid),
    .bound_ready_i_'''+str(x)+'''_'''+str(y)+'''               (o_if_b['''+str(id)+'''].ready),'''
            )

def Interface():
    for x in range(NOC_WIDTH):
        for y in range(NOC_HEIGHT):
            id = y * NOC_WIDTH + x
            print('''
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent['''+str(id)+'''].i_agt_local.drv","vif",i_if_l['''+str(id)+''']);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent['''+str(id)+'''].i_agt_local.mon","vif",i_if_l['''+str(id)+''']);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent['''+str(id)+'''].o_agt_local.mon","vif",o_if_l['''+str(id)+''']);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent['''+str(id)+'''].i_agt_bound.drv","vif",i_if_b['''+str(id)+''']);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent['''+str(id)+'''].i_agt_bound.mon","vif",i_if_b['''+str(id)+''']);
    uvm_config_db #(virtual cibd_if)::set(null,"uvm_test_top.env.agent['''+str(id)+'''].o_agt_bound.mon","vif",o_if_b['''+str(id)+''']);'''
            )

if __name__ == "__main__":
    Instance()