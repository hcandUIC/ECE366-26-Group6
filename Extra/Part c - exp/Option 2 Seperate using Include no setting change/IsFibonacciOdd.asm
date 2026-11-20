.include "is_odd.asm"
.include "fibs.asm"

.data	
input: 
	.asciiz  "Enter a postive integer to check: \n"

isOdd:
	.asciiz  "The Fibonacci number is Odd \n"

isEven:
	.asciiz  "The Fibonacci number is NOT odd \n"

.text
.globl main

main:
	# ======= Intro prompt =========
	ori  $v0, $zero, 4 	# set v0 to 4
	la   $a0, input	# load memory address of message into a0
	syscall 		# code 4 "a0 = address of null-terminated string to print"
	
	# ======= N value input and memory save =========
	ori  $v0, $zero, 5 	# set v0 to 5
	syscall 		# system call looks into v0 for code 5 "read integer"
				# input value stored in v0 once its entered
				
	addi $sp, $sp, -4	# Move stack pointer for clean block
	or   $s7, $zero, $sp	# Save memory address at stack pointer (s7 =  address of n)
	sw   $v0, 0($sp)	# Move input value into address at stack pointer, no offset (n into memory)
	
	# ======= Load n from memory =========
	or   $sp, $zero, $s7 	# move stack pointer to address at s7
	lw   $a0, 0($sp)	# load n from memory (n = input int)
	
	# ======= Fibonacci(n) =========
	or   $a0, $v0, $zero	# a0 = n
	jal  fibs		# Jump to fibonacci function with n = a0
	or   $a0, $zero, $v0	# Store return of fibs into a0, (m = fibs(n))
	
	# ======= Check if odd =========
	jal  is_odd             # jump to is_odd function; -> returns 1 or 0 in $v0
	or $s0, $zero, $v0	# save return value (s0 = is_odd(m))
	
	# ======= Final value to memory =========
	or   $sp, $zero, $s7	# Reload memory address of n into stack pointer
	addi $sp, $sp, -4	# Move stack pointer by 4 bytes for a clean slot
	sw   $s0, 0($sp)        # Store final result into memory (s0 -> New Memory Address)
	
	# ======= True/False check for output (Text output for testing purposes)=========
	bgtz  $s0, odd		# Branch to true if s0 >0 (output 1 means true)
	
	ori  $v0, $zero, 4 	# set v0 to 4
	la   $a0, isEven	# load memory address of message into a0
	syscall 		# code 4 "a0 = address of null-terminated string to print"
	
	ori $v0, $zero, 10     # Exit cleanly
	syscall

odd:
	ori  $v0, $zero, 4 	# set v0 to 4
	la   $a0, isOdd		# load memory address of message into a0
	syscall 		# system call looks into v0 for code 4 "a0 = address of null-terminated string to print"
				
	ori $v0, $zero, 10     # Exit cleanly
	syscall
