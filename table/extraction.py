import re

def extract(brn,path,idx):
    '''
    This function extracts the boundary router list and boundary turn restriction list from an output log file
    The log file must adopt the format that Fast-TRA/cpp defines,
    see branch "cpp" of the project at https://github.com/MiskaMoska/Fast-TRA.git

    brn:    boundary router number
    path:   output log file path
    idx:    the placement index of the case to be tested
    '''
    with open(path,'r') as f:
        for i,line in enumerate(f):
            try:
                if int(line[0:20]) == idx:
                    bi = line[80:].split()
                    break
            except:
                pass
    
    # extract brl
    brl = []
    for i in bi[0:brn]:
        brl.append((int(i[1]),int(i[3])))

    # extract btrl
    btrl = []
    for tr in bi[brn:]:
        nl = re.findall(r"\d+",tr)
        ll = re.findall(r"[a-z]+\w[a-z]+",tr)
        source = (int(nl[0]),int(nl[1]),ll[0],)
        target = (int(nl[2]),int(nl[3]),ll[1],)
        btrl.append((source,target,))

    return brl,btrl
