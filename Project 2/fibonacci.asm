

fibonacci:
	#handle intake of n value
	ori $v0, $zero, 5 	#value register 0 is or of zero and 5 (load code 5 into v0)
	syscall 		#looks into v0 for service code and execute (code 5 awaits integer input)
	
	addi $sp, $sp, -4	#move stack pointer by 4 bytes for a clean slot
	
	sw $v0, 0($sp)		#input int stored to memory pointer location with no offset
	
	#load stored in into register for use
	lw $t0, 0($sp)		#load word from address at stack pointer address with 0 offset into temp 2 for use

	
	#handle check of n value
	ori  $t2, $zero, 2 	#temp 2 is or of 0 and 2 (store 2 into t2)

	slt  $a0, $t0, $t2 	#set argument register 0 to 1 if t0 is less than t2 (a0 is 1 if n < 1)
	beq  $a0, 1, invalid_n	#go to label if a0 = t2 (base case check n <= 1)


	#handle setup of a and b
	ori $t1, $zero, 0	#temp 1 is or of 0 and 0 (store 2 into t1 a)
	ori $t2, $zero, 1	#temp 2 is or of 0 and 1 (store 1 into t2 b)

	#loop start and check
	addi $t0, $t0, -1	#temp 0 is addition of t0 and 01 (n - 1)

	loop_start:
		bne $t0, $zero fib_loop #if t0 is greater than 0 go to fib_loop (loop if n > 0)

	#handle return of final value b and closing of function, exit without return call for testing purposes
	addu $v1, $t2, $zero	#final return value of t2,b moved to value register 1
	addi $sp, $sp, -4	#move stack pointer by 4 bytes for a clean slot
	sw $t2, 0($sp)		#save word into stack

	addu $v0, $zero, 10	#value reg 0 is addition of zero and 10 (load code 10 into return reg 0)
	syscall			#look into v0 for service call (code 10 ends program)


#base case check of n, return and exit function if n <= 1
invalid_n:
	addu $v1, $t0, $zero 	#value register 1 is addition of temp 0 and zero (return value of t0)
	
	#ends function without return to call for testing purposes
	addu $v0, $zero, 10 	#value reg 0 is addition of zero and 10 (load code 10 into return reg 0)
	syscall 		#look into v0 for service call (code 10 ends program)
	
	
#Loop
fib_loop:
	addu $t3, $t2, $zero 	#hold tempt 2 in temp 3
	addu $t2, $t1, $t2 	#tempt 2 is addition of itself and t1 (a + b)
	addu $t1, $t3, $zero 	#t1 is t3 and zero (a = old b)
	
	addi $t0, $t0, -1 	#decrement n by 1
	j loop_start		#jump to start of loop
	
