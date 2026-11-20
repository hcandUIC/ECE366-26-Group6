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
	
	
	
	
#  ======= FIBONACCI FUNCTION  =======	
fibs:
	#  ======= Call with value in a0  =======

	# ======= Valid N check =========
	ori $t0, $zero, 2 	# t0 set to 2

	slt  $t1, $a0, $t0 	# Set 
	beq  $t1, 1, invalid_n	# if a0 was less than 2 (=<1), then jump to label

	# ======= Main Check loop =========
	ori $a1, $zero, 0	# a1 is 0 ,  a = 0
	ori $a2, $zero, 1	# a2 is 1 ,  b = 1

	addi $a0, $a0, -1	# a0 is a0 - 1, (n -1)
	
	loop_check:
		bne $a0, $zero fib_loop # branch while a0 > 0 , i in range (n - 1)

	# ======= Return to caller and set return value =========
	or $v0, $zero, $a2	# set return value to a2, (return b)
	jr $ra			# jump back to main caller

# ======= Invalid n =========
invalid_n:
	or $v0, $a0, $zero 	# return value set to n
	jr $ra			# jump back to caller
	
# ======= fibs loop =========
fib_loop:
	addu $t0, $a2, $zero 	# temp hold of current b
	addu $a2, $a1, $a2 	# new b a2 = a1 + a2,  (b = a + b)
	addu $a1, $t0, $zero 	# new a is old b (a = temp)
	
	addi $a0, $a0, -1 	# iterate loop (i --)
	j loop_check		# jump back to loop check
#  ======= END FIBONACCI FUNCTION  =======	 



#  ======= IS ODD FUNCTION  =======	
		
is_odd:
	# Call with value in a0
	or $s0, $zero, $ra	# put current return address in s0
	
	# --- Remainder calculation and assaignment ---
	jal division		# jump to division function for calculation, then set return address register 
	or $t0, $zero, $v1	# remainder variable R = return value of division
	or $ra, $zero, $s0	# Set Return Addres register back to original address to return to main caller
	
	bne $t0, $zero, true	# if R != 0 , go to true
	beq $t0, $zero,  false	# if R = 0, go to false
	
	# --- Even or Odd Check  ---	
	false: 
		ori $v0, $zero, 0	# set return value to 0 for false, m is even
		jr  $ra			# jump back to caller
		
	true:
		ori $v0, $zero, 1	# set return value to 1 for true, m is odd
		jr  $ra			# jump back to caller
	# ====== End of main code ======

# ====== DIvision by subtraction start ======
division:
	
	# --- variable set ---
	sub $t0, $t0, $t0	# t0 is variable for quotient q = 0
	ori $a1, $zero, 2	# argument 2 = 2 , y = 2
				# coding in 2 instead of memory read since isodd would only be using 2 for y
	
	# --- loop check ---
	loopCheck:
	slt $t1, $a0, $a1	# set t1 to 1 only if x < 2 , 0 if x >= 2
	beq $t1, $zero, subLoop	# branch t1 = 0 , x >= 2
	
	# --- Set Return Value and end ---
	or  $v1, $zero, $a0	# return a0 through v1 , v1 = final x
	jr  $ra			#return to caller
	
	# --- Subtraction loop ---
	subLoop:
		sub  $a0 , $a0, $a1	# x = x - 2
		addi $t0, $t0, 1	# q = q + 1
		
		j loopCheck		# go back to check
# ====== Emd Division function ======
	
	
	






	
	

