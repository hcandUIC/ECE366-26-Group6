.data
    msg:   .asciiz "Fibonacci Sequence: "

.text
.globl main

main:
    # Printing
    li $v0, 4           # Syscall code 4: Print string
    la $a0, msg         # Load address of the message
    syscall

    # Initialize variables
    li $t0, 0           # a
    li $t1, 1           # b
    li $t2, 10          # n
fib_loop:
    # Print the current Fibonacci number ($t0)
    li $v0, 1           # Syscall code 1: Print integer
    move $a0, $t0       # Move F(n-2) into $a0 for printing
    syscall


