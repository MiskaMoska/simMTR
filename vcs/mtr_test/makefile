# VCS
COMPILER = vcs -full64 -cc gcc-4.8 -cpp g++-4.8 -LDFLAGS -Wl,-no-as-needed
TIMESCALE = -timescale=1ns/1ps
INCDIR = +incdir+../../rtl+./srcs
UVM = -ntb_opts uvm-1.1
TOP_MODULE = -top top_tb
DEBUG = -debug_access+r

# Verdi
PLI_TAB = $(VERDI_HOME)/share/PLI/VCS/LINUXAMD64/novas.tab
PLI_A = $(VERDI_HOME)/share/PLI/VCS/LINUXAMD64/pli.a
FSDB = -fsdb -P $(PLI_TAB) $(PLI_A)
DEBUG = -debug_all

# Test0
# alg = tra
ci = 1695
ir = 0.07 0.08 0.09 0.10 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18
# ir = 0.16 0.17 0.18


all: run verdi test0

an:
	vlogan -full64 -sverilog +incdir+../../rtl+./srcs ./srcs/*.sv

run:
	$(COMPILER)  -sverilog -f filelist.f	\
	$(UVM)									\
	$(TIMESCALE) 							\
	$(INCDIR)  								\
	$(TOP_MODULE)							\
	$(FSDB) 								\
	+define+INJECT_RATE=0.5				    \
	-R # -R means run simulation right after compilation

test0:
	for i in $(ir); do \
	rm -rf AN.DB csrc simv.* verdiLog; \
	rm -rf .vlogansetup.args *.key vc_hdrs.h .idea; \
	rm -rf novas.conf *.log *.fsdb *.rc simv *.daidir; \
	rm -rf wave.fsdb*; \
	$(COMPILER)  -sverilog -f filelist.f	\
	$(UVM)									\
	$(TIMESCALE) 							\
	$(INCDIR)  								\
	$(TOP_MODULE)							\
	$(FSDB) 								\
	+define+INJECT_RATE=$$i				    \
	+define+CASE_IDX=$(ci)					\
	-R; \
	done

verdi:
	verdi +v2k -sverilog $(INCDIR) -f filelist.f -ssf wave.fsdb \
	# -sswr ./wave_cfg/cfg1.rc

clean:
	rm -rf AN.DB csrc simv.* verdiLog
	rm -rf .vlogansetup.args *.key vc_hdrs.h .idea
	rm -rf novas.conf *.log *.fsdb *.rc simv *.daidir
	rm -rf wave.fsdb*
