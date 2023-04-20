# RUN: llvm-mc -triple riscv64-unknown-linux-gnu -filetype obj -o - %s \
# RUN:   | llvm-readobj -r - | FileCheck %s

# CHECK:  .relasx {
# CHECK-NEXT:    0x0 R_RISCV_ADD64 y 0x0
# CHECK-NEXT:    0x0 R_RISCV_SUB64 x 0x0
# CHECK:  }

	.section	sx,"aw",@progbits
x:
	.quad y-x

	.section	sy,"aw",@progbits
y:
	.quad x-y

