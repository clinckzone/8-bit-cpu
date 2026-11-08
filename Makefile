TEST_DIR := test
RTL      := $(wildcard rtl/*.v)
TB       := $(TEST_DIR)/cpu_tb.v
SIM      := $(TEST_DIR)/cpu.sim
VCD      := $(TEST_DIR)/cpu.vcd
PROGRAM  := $(TEST_DIR)/program.hex
SAVE     := $(TEST_DIR)/cpu_test1.gtkw

.PHONY: all compile sim wave clean

all: wave

compile: $(SIM)

sim: $(VCD)

# Opens the waveform with the saved signal layout if there is one.
wave: $(VCD)
	gtkwave $(VCD) $(wildcard $(SAVE)) &

$(SIM): $(TB) $(RTL)
	iverilog -g2012 -o $@ $^

# Run from the test folder so program.hex and cpu.vcd resolve there.
$(VCD): $(SIM) $(PROGRAM)
	cd $(TEST_DIR) && vvp cpu.sim

clean:
	rm -f $(SIM) $(VCD)
