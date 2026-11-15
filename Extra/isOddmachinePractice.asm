	
	
IsOdd:
	# ======= Begining of value intake and move to memory =========
	
	# intake
	ori $v0, $zero, 5	#save 5 into v0, 5 is read integer code
	syscall 		#look into v0 for read int code, wait for m 
	
	# save in memory
	addi $sp, $sp, -4	# move stack pointer to ensure empty slot, 4 bytes or 32 bits
	sw $v0, 0($sp)		# save m into memory
	add $s0, $sp, $zero 	# save memory address of where m is stored
	# ====== end of intake and memory assaignment ======
	
	
	# ====== begining of main code ======
	
	# --- Remainder calculation and assaignment ---
	jal division		# jump to division function for calculation set return address
	or $t0, $zero, $v1	# remainder variable R = return value of division
	
	bne $t0, $zero, true	# if R != 0 , go to true
	beq $t0, $zero,  false	# if R = 0, go to false
	
	# --- Remainder Check ---
	false: 
		ori $v1, $zero, 0	# set return value to 0 for false, m is even
	
		# --- program end --
		ori $v0, $zero, 10	# set v0 to 10 for syscall
		syscall			# Read v0 with code 10 for exit instruction to close out program, for testing purposes
	true:
		ori $v1, $zero, 1	# set return value to 1 for true, m is odd
		
		# --- program end --
		ori $v0, $zero, 10	# set v0 to 10 for syscall
		syscall			# Read v0 with code 10 for exit instruction to close out program, for testing purposes
	# ====== End of main code ======


# ====== Division fuction start ======
division:
	
	# --- load value of m ---
	or $sp, $zero, $s0	# load memory address of m value into stack pointer
	lw $a0, 0($sp)		# load value at the stack pointer into argument register 0, x = m
	
	# --- variable set ---
	sub $t0, $t0, $t0	# t0 is variable for quotient q = 0
	ori $a1, $zero, 2	# argument 1 register set to 1 instead of 2 for simpler loop check, y = 1
				# coding in 2 instead of memory read since isodd would only be using 2 for y
	
	# --- loop check ---
	loopCheck:
	slt $t1, $a0, $a1	# set t1 to 1 only if x < 2 , 0 if x >= 2
	beq $t1, $zero, subLoop	# branch t1 = 0 , x >= 2
	
	# --- Set Return Value and end ---
	or $v1, $zero, $a0	# return a0 through v1 , v1 = final x
	jr $ra			#return to caller
	
	# --- Subtraction loop ---
	subLoop:
		sub $a0 , $a0, $a1	# x = x - 2
		addi $t0, $t0, 1	# q = q + 1
		
		j loopCheck		# go back to check
# ====== Emd Division function ======
	
	
	






	
	
