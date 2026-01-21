all: program

# NEED TO FIND A WAY TO MAKE SOURCE FILES DEPENDENCIES AUTOMATICALLY
build/project.ys.json: files.f synth.ys rtl/*.sv
	mkdir -p build
	yosys -q ./synth.ys

build/project.asc: build/project.ys.json constraints/top.pcf
	nextpnr-ice40 -q --hx8k --package cb132 --json build/project.ys.json --pcf constraints/top.pcf --asc build/project.asc

build/project.bin: build/project.asc
	icepack build/project.asc build/project.bin

program: build/project.bin
	iceprog build/project.bin

lint: 
	cat ./files.f | xargs -I{} verible-verilog-lint {}

clean:
	rm -rf build