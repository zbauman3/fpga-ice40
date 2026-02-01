# FPGA-ICE40

A playground repo for working with the [iCE40](https://www.latticesemi.com/ice40) family of FPGAs.

The toolchain uses:
- [yosys](https://github.com/YosysHQ/yosys) for synthesis
- [nextpnr](https://github.com/YosysHQ/nextpnr) for place and routing
- [Project IceStorm](https://github.com/YosysHQ/icestorm) for packing and programming
- [Verible Verilog](https://chipsalliance.github.io/verible/) for linting / formatting

This was setup / developed against:
- [Alchitry CU V1](https://alchitry.com/boards/cu/) dev board
- [Alchitry IO V1](https://alchitry.com/boards/io/) I/O dev board


## Usage

Install `yosys`, `nextpnr`, `icestorm` and `verible` in accordance with their documentation from above.

- [files.f](./files.f) contains a list of all source files
- [synth.ys](./synth.ys) contains the `yosys` script instructions
- [constraints/top.pcf](./constraints/top.pcf) contains the input constraints
- [Makefile](./Makefile) ties everything to gether
  - `update-files` will update the `files.f` with any changes to source files
  - `lint` runs `verible-verilog-lint` on all source and include files
  - `clean` removes build output
  - `all` runs synthesis, place and route, package, and program