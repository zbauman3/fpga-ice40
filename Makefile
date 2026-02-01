all: program

# Include location also set in synth.ys
INCLUDE_FILES := $(shell find ./rtl/include -type f -name '*.vh' -o -name '*.svh')
RTL_FILES := $(shell cat ./files.f)

update-files:
	find ./rtl -type f -name '*.v' -o -name '*.sv' > files.f

build/project.ys.json: synth.ys $(RTL_FILES) $(INCLUDE_FILES) 
	@echo "Synthesizing design..."
	mkdir -p build
	yosys -q ./synth.ys

build/project.asc: build/project.ys.json constraints/top.pcf
	@echo "Placing and routing design..."
	nextpnr-ice40 -q --hx8k --package cb132 --json build/project.ys.json --pcf constraints/top.pcf --asc build/project.asc

build/project.bin: build/project.asc
	@echo "Packing design..."
	icepack build/project.asc build/project.bin

program: build/project.bin
	@echo "Programming FPGA..."
	iceprog build/project.bin

lint: 
	verible-verilog-lint $(RTL_FILES) $(INCLUDE_FILES)

clean:
	rm -rf build