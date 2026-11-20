.data
	n: .word 7
	result: .word 0
	
.text
.globl main
.globl is_fibonacci_odd

main:
is_fibonacci_odd:
	la $t8, n
	lw $a0, 0($t8)
	
	jal fibonacci
	
	addu $a0, $v0, $zero
	
	jal is_odd
	
	la $t9, result
	sw $v0, 0($t9)
	
	addu $v0, $zero, 10
	syscall