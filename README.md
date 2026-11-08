# 8-bit CPU

A simple 8-bit CPU written in Verilog, built for practice.

## Overview

- 8-bit data path, 16-bit instructions
- 4 general-purpose registers
- ALU with Z/N/C/V status flags
- 8-bit output register

## Instruction format

```
[15:12] opcode | [11:10] rd | [9:8] rs | [7:0] imm / jump address
```

## Layout

- `rtl/` – CPU source, top module is `cpu.v`
- `test/` – testbench and `program.hex` (the program to run)

## Running

Needs [Icarus Verilog](https://steveicarus.github.io/iverilog/) and [GTKWave](https://gtkwave.sourceforge.net/).

```
make          # compile, simulate, open GTKWave
make sim      # compile and simulate only
make clean    # remove build files
```
