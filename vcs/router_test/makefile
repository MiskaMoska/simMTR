# VCS
COMPILER = vcs -full64 -cc gcc-4.8 -cpp g++-4.8 -LDFLAGS -Wl,-no-as-needed
TIMESCALE = -timescale=1ns/1ps
INCDIR = +incdir+../../rtl+./srcs
UVM = -ntb_opts uvm-1.1
TOP_MODLE = -top top_tb
DEBUG = -debug_access+r

# Verdi
PLI_TAB = $(VERDI_HOME)/share/PLI/VCS/LINUXAMD64/novas.tab
PLI_A = $(VERDI_HOME)/share/PLI/VCS/LINUXAMD64/pli.a
FSDB = -fsdb -P $(PLI_TAB) $(PLI_A)
DEBUG = -debug_all

all: an run verdi

an:
	vlogan -full64 +incdir+../../rtl ../../rtl/*

run:
	$(COMPILER)  -sverilog -f filelist.f	\
	$(UVM)									\
	$(TIMESCALE) 							\
	$(INCDIR)  								\
	$(TOP_MODULE)							\
	$(FSDB) -R # -R means run simulation right after compilation

verdi:
	verdi +v2k -sverilog $(INCDIR) -f filelist.f -ssf wave.fsdb -sswr ./wave_cfg/cfg4.rc

clean:
	rm -rf AN.DB csrc simv.* verdiLog
	rm -rf .vlogansetup.args *.key vc_hdrs.h .idea
	rm -rf novas.conf *.log *.fsdb *.rc simv *.daidir
	rm -rf ./log/*
