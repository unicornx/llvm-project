# RUN: llvm-mc -triple riscv64-unknown-linux-gnu -filetype obj -o - %s \
# RUN:   | llvm-readobj -r - | FileCheck %s

# CHECK:      Relocations [
# CHECK-NEXT:   Section ({{.*}}) .rela.note {
# CHECK-NEXT:     0x0 R_RISCV_ADD64 extern 0x0
# CHECK-NEXT:     0x0 R_RISCV_SUB64 note 0x0
# CHECK-NEXT:   }
# CHECK-NEXT:   Section ({{.*}}) .rela.rodata {
# CHECK-NEXT:     0x0 R_RISCV_ADD64 extern 0x0
# CHECK-NEXT:     0x0 R_RISCV_SUB64 rodata 0x0
# CHECK-NEXT:   }
# CHECK-NEXT:   Section ({{.*}}) .rela.alloc_w {
# CHECK-NEXT:     0x0 R_RISCV_ADD64 extern 0x0
# CHECK-NEXT:     0x0 R_RISCV_SUB64 w 0x0
# CHECK-NEXT:     0x8 R_RISCV_ADD64 w 0x0
# CHECK-NEXT:     0x8 R_RISCV_SUB64 extern 0x0
# CHECK-NEXT:   }
# CHECK-NEXT:   Section ({{.*}}) .rela.alloc_x {
# CHECK-NEXT:     0x0 R_RISCV_ADD64 y 0x0
# CHECK-NEXT:     0x0 R_RISCV_SUB64 x 0x0
# CHECK-NEXT:   }
# CHECK-NEXT:   Section ({{.*}}) .rela.alloc_y {
# CHECK-NEXT:     0x0 R_RISCV_ADD64 x 0x0
# CHECK-NEXT:     0x0 R_RISCV_SUB64 y 0x0
# CHECK-NEXT:   }
# CHECK-NEXT:   Section ({{.*}}) .rela.nonalloc_w {
# CHECK-NEXT:     0x0 R_RISCV_ADD64 extern 0x0
# CHECK-NEXT:     0x0 R_RISCV_SUB64 nw 0x0
# CHECK-NEXT:     0x8 R_RISCV_ADD64 nw 0x0
# CHECK-NEXT:     0x8 R_RISCV_SUB64 extern 0x0
# CHECK-NEXT:   }
# CHECK-NEXT:   Section ({{.*}}) .rela.nonalloc_x {
# CHECK-NEXT:     0x0 R_RISCV_ADD64 ny 0x0
# CHECK-NEXT:     0x0 R_RISCV_SUB64 nx 0x0
# CHECK-NEXT:   }
# CHECK-NEXT:   Section ({{.*}}) .rela.nonalloc_y {
# CHECK-NEXT:     0x0 R_RISCV_ADD64 nx 0x0
# CHECK-NEXT:     0x0 R_RISCV_SUB64 ny 0x0
# CHECK-NEXT:   }
# CHECK-NEXT: ]

.section .note,"a",@note; note:
.quad extern-note
.section .rodata,"a",@progbits; rodata:
.quad extern-rodata

.section .alloc_w,"aw",@progbits; w:
.quad extern-w
.quad w-extern
.section .alloc_x,"aw",@progbits; x:
.quad y-x
.section .alloc_y,"aw",@progbits; y:
.quad x-y

.section .nonalloc_w; nw:
.quad extern-nw
.quad nw-extern
.section .nonalloc_x; nx:
.quad ny-nx
.section .nonalloc_y; ny:
.quad nx-ny

## .apple_names/.apple_types are fixed-size and do not need fixups.
## llvm-dwarfdump --apple-names does not process R_RISCV_{ADD,SUB}32 in them.
## See llvm/test/DebugInfo/Generic/accel-table-hash-collisions.ll
	.section	.apple_types
        .word 0
        .word .Ltypes0-.apple_types
.Ltypes0: