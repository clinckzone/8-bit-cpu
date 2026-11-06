# 8-bit CPU

A simple 8-bit CPU written in Verilog, built for practice.

## Overview

- 8-bit data path, 16-bit instructions
- 4 general-purpose registers
- ALU with Z/N/C/V status flags
- 8-bit output register

## Instruction format

```
[15:12] opcode | [11:10] rd | [9:8] rs | [7:0] imm
```

Jumps use bits `[11:4]` as the target address.

## Layout

All source files live in `rtl/`. The top-level module is `cpu.v`.
