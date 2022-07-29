# VCS
COMPILER="vcs -full64 -cc gcc-4.8 -cpp g++-4.8 -LDFLAGS -Wl,-no-as-needed"
TIMESCALE="-timescale=1ns/1ps"
INCDIR="+incdir+../../rtl+./srcs"
UVM="-ntb_opts uvm-1.1"
TOP_MODULE="-top top_tb"
FSDB="-fsdb -P" $PLI_TAB $PLI_A
PLI_TAB=$VERDI_HOME"/share/PLI/VCS/LINUXAMD64/novas.tab"
PLI_A=$VERDI_HOME"/share/PLI/VCS/LINUXAMD64/pli.a"

make clean
$COMPILER  -sverilog -f filelist.f	\
$UVM									\
$TIMESCALE 							\
$INCDIR  								\
$TOP_MODULE							\
$FSDB 								\
+define+INJECT_RATE=0.1				    \
+define+CASE_IDX=200                    \
-R # -R means run simulation right after compilation
