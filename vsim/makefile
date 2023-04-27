TOP   = RRA_tb
TOP_F = ./../tb/RRA_tb.sv
VCS =	vcs -full64  -v2k_generate -Mupdate -sverilog -debug_access+all -j32 -assert svaext\
		-LDFLAGS -Wl,--no-as-needed\
		+libext+.v+.sv+.inc+.h -R +memcbk +lint=TFIPC-L +lint=PCWM \
		+incdir+designware \
		+nospecify +notimingchecks \
		-f ../code.f \
		-top $(TOP) $(TOP_F) \
		+v2k \
		-timescale=1ns/1ns \
		
SIMV = ./simv
VERDI = verdi -full64 -sv -ssf $(TOP).fsdb & >/dev/null
DVE  = dve -full64 -vpd $(TOP).vpd & >/dev/null
VIEW = $(DVE)

comp:
	export CODE_DIR=.. && $(VCS)

run:
	$(SIMV)

view:
	$(VIEW)

dve:
	$(DVE)

verdi:
	$(VERDI)

clean:
	@echo clean vsim
	@$(RM) -rf $(BUILDDIR) $(OBJECTS)  *.log *.vcd *.key *.report simv* csrc *.vpd *.fsdb DVEfiles verdiLog novas.* stack* *.txt