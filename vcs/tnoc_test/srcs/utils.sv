function automatic bit isIn(bit [3:0] x,bit [3:0] y,ref bit [3:0] array_x[`BR_NUM],ref bit [3:0] array_y[`BR_NUM]);
    bit flag = 0;
    for(int i = 0; i < `BR_NUM; i ++) begin
        if((x == array_x[i]) && (y == array_y[i])) begin
            flag = 1; break;
        end
    end
    return flag;
endfunction