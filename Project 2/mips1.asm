.data
    msg: .asciiz "Hello, World!\n"   # Store string in memory

.text
.globl main
main:
    li $v0, 4                        # Syscall 4: print string
    la $a0, msg                      # Load address of msg into $a0
    syscall                          # Execute print

    li $v0, 10                       # Syscall 10: exit program
    syscall                          # Execute exit
