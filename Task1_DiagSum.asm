.data
N:
.word 4
matrix:
.word 1, 0, 0, 8
.word 0, 3, 4, 0
.word 0, 2, 5, 0
.word 1, 0, 0, 7
str_start:
.word 83, 116, 97, 114, 116, 32, 111, 102, 32, 112, 114, 111, 103, 114, 97, 109, 10, 0
str_md:
.word 77, 97, 105, 110, 32, 100, 105, 97, 103, 111, 110, 97, 108, 32, 115, 117, 109, 32, 61, 32, 10, 0
str_ad:
.word 65, 110, 116, 105, 32, 100, 105, 97, 103, 111, 110, 97, 108, 32, 115, 117, 109, 32, 61, 32, 10, 0
str_end:
.word 69, 110, 100, 32, 111, 102, 32, 112, 114, 111, 103, 114, 97, 109, 46, 10, 0
.text

main:
call start

la a0, N
lw a0, 0(a0)  # s0 = N
la a1, matrix # matrix[0][0] pointer
   
call diag_sum
add s0, x0, a0
add s1, x0, a1

la a2, str_md
call print_str
add a1, x0, s0
call print_int
la a2, str_ad
call print_str
add a1, x0, s1
call print_int

call exit

#-------------------------------------------
diag_sum: #in a0 - N a1 - matrix pointer out a0 - summd a1 - sumad
add t0, x0, a0 # N
add t1, x0, a1 # matrix pointer
add a0, x0, x0 # sum_md
add a1, x0, x0 # sum_ad
add t2, x0, x0 # increment in loop
#li t0, 3
for_loop:
slli t3, t2, 2 # 4*i
add t3, t3, t2 # 4*i+i = 5*i
slli t3, t3, 2 # 5*i * 4
add  t3, t1, t3 # 5*i * 4+matrix pointer
lw t4, 0(t3)
add a0, a0, t4

slli t3, t2, 1 # 2*i
add t3, t3, t2 # 2*i+i
addi t3, t3, 3 # 3*i+3
slli t3, t3, 2 # (3*i+3) * 4
add  t3, t1, t3 # (3*i+3) * 4+matrix pointer
lw t4, 0(t3)
add a1, a1, t4

addi t2, t2, 1
bne t0, t2, for_loop
ret

print_int: #prints int from a1
li a0, 1
ecall
li a0, 11
li a1, 10 # \n
ecall
ret

print_str: #prints str pointer to which is in a2
li a0, 11
lw a1, 0(a2) 
while_not_endl:
ecall
addi a2, a2, 4
lw a1, 0(a2)
bne a1, x0, while_not_endl
ret

start:
la a2, str_start
addi sp, sp, -4  
sw ra, 0(sp)     
call print_str
lw ra, 0(sp)     
addi sp, sp, 4   
ret

exit:
la a2, str_end
call print_str
li a0, 10
ecall