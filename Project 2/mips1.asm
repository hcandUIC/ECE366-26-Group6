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
    li $t0, 0           # $t0 will hold F(n-2), starting at 0 ie a
    li $t1, 1           # $t1 will hold F(n-1), starting at 1 ie b
    li $t2, 10          # Loop counter ie n