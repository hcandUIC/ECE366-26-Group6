.data
    n:      .word 7      # n is here
    result: .word 0      # The result will be stored here
.text

fibonacci:
	#handle intake of n value
	la $t8, n           # Load the memory address of 'n'
	lw $t0, 0($t8)      # Load the value of 'n' into $t0
#changed to work with .data	
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
	la $t9, result       # Load the memory address of 'result'
    	sw $t2, 0($t9)       # Store final answer into memory

    	addu $v0, $zero, 10
    	syscall
#changed due to data being saved incorrectly 
#base case check of n, return and exit function if n <= 1
invalid_n:
    la $t9, result
    sw $t0, 0($t9)       # Store 'n' itself (from $t0) into memory
    
    addu $v0, $zero, 10  # Load exit code 10 into $v0
    syscall
#changed due to wrong register and missing exit	
#Loop
fib_loop:
	addu $t3, $t2, $zero 	#hold tempt 2 in temp 3
	addu $t2, $t1, $t2 	#tempt 2 is addition of itself and t1 (a + b)
	addu $t1, $t3, $zero 	#t1 is t3 and zero (a = old b)
	
	addi $t0, $t0, -1 	#decrement n by 1
	j loop_start		#jump to start of loop
	
