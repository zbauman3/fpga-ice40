#!/bin/bash
yosys -p 'synth_ice40 -top blinky -json blinky.ys.json' blinky.v
nextpnr-ice40 --hx8k --package cb132 --json blinky.ys.json --pcf blinky.pcf --asc blinky.asc
icepack blinky.asc blinky.bin
iceprog blinky.bin
echo "Build complete: blinky.bin"