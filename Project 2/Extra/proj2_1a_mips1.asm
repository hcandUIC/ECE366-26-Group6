
.data
    prompt:  .asciiz "Enter n: "
    result:  .asciiz "Fibonacci number: "

.text
.globl main

main:
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall

    move $a0, $v0

    jal Fibonacci

    move $s0, $v0

    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $s0
    syscall

    li $v0, 10
    syscall

Fibonacci:

    ble $a0, 1, FIB_BASE

    li $t0, 0
    li $t1, 1
    li $t2, 0

    addi $t3, $a0, -1

FIB_LOOP:
    bge $t2, $t3, FIB_DONE

    move $t4, $t1

    add $t1, $t0, $t1

    move $t0, $t4

    addi $t2, $t2, 1

    j FIB_LOOP

FIB_BASE:
    move $v0, $a0
    jr $ra

FIB_DONE:
    move $v0, $t1
    jr $ra
