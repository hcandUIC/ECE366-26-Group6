	
	
IsOdd:
	# ======= Load argument value from memory =========
	ori $s0 $zero, $ra	# save current return address into s0
	
	or $sp, $zero, $a0	# Move stack pointer to memory address of a0
	lw $a0, 0($sp)		# a0 becomes value stored in address instead of address
	# ====== end of load=====
	
	# --- Remainder calculation and assaignment ---
	jal division		# jump to division function for calculation, then set return address register 
	or $t0, $zero, $v1	# remainder variable R = return value of division
	
	bne $t0, $zero, true	# if R != 0 , go to true
	beq $t0, $zero,  false	# if R = 0, go to false
	
	# --- Even or Odd Check  ---
	ori $ra, $zero, $s1	# Set Return Addres register back to original address to return to main caller
	
	false: 
		ori $v0, $zero, 0	# set return value to 0 for false, m is even
		jr $ra			# jump back to caller
		
	true:
		ori $v0, $zero, 1	# set return value to 1 for true, m is odd
		jr $ra			# jump back to caller
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
	or $v1, $zero, $a0	# return a0 through v1 , v1 = final x
	jr $ra			#return to caller
	
	# --- Subtraction loop ---
	subLoop:
		sub $a0 , $a0, $a1	# x = x - 2
		addi $t0, $t0, 1	# q = q + 1
		
		j loopCheck		# go back to check
# ====== Emd Division function ======
	
	
	






	
	
