.text
.globl fibs

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
	
