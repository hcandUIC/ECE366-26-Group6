.data
    n:      .word 7      # Input n stored in memory
    result: .word 0      # Final result stored here (1 = True/Odd, 0 = False/Even)

.text
.globl main
.globl is_fibonacci_odd

main:
is_fibonacci_odd:
	la   $t8, n
	lw   $a0, 0($t8)        # Load n into argument register $a0

	jal  fibonacci          # Compute nth Fibonacci number -> returns in $v0

	addu $a0, $v0, $zero    # Pass Fibonacci result as m into $a0
	jal  is_odd             # Check if m is odd -> returns 1 or 0 in $v0

	la   $t9, result
	sw   $v0, 0($t9)        # Store final boolean result in memory

	addu $v0, $zero, 10     # Exit cleanly
	syscall

# ---------------------------------------------------------
# Function: fibonacci(n)
# Input:  $a0 = n
# Output: $v0 = nth Fibonacci number
# ---------------------------------------------------------
fibonacci:
	addu $t0, $a0, $zero    # Move argument n from $a0 into $t0

	# Check base case (n <= 1)
	ori  $t2, $zero, 2      # $t2 = 2
	slt  $t3, $t0, $t2      # $t3 = 1 if n < 2
	bne  $t3, $zero, invalid_n

	# Setup a and b
	ori  $t1, $zero, 0      # a = 0
	ori  $t2, $zero, 1      # b = 1
	addi $t0, $t0, -1       # counter = n - 1

loop_start:
	bne  $t0, $zero, fib_loop

	# Return b in $v0
	addu $v0, $t2, $zero
	jr   $ra

invalid_n:
	# Return n itself in $v0
	addu $v0, $t0, $zero
	jr   $ra

fib_loop:
	addu $t3, $t2, $zero    # temp = b
	addu $t2, $t1, $t2      # b = a + b
	addu $t1, $t3, $zero    # a = temp
	addi $t0, $t0, -1       # counter--
	j    loop_start

# ---------------------------------------------------------
# Function: is_odd(m)
# Input:  $a0 = m
# Output: $v0 = 1 if odd (True), 0 if even (False)
# ---------------------------------------------------------
is_odd:
	addu $t0, $a0, $zero    # Move argument m from $a0 into $t0

	# Division setup for repeated subtraction
	ori  $t1, $zero, 2      # divisor y = 2
	ori  $t2, $zero, 0      # quotient = 0

div_loop:
	slt  $t3, $t0, $t1      # set $t3 to 1 if m < 2
	bne  $t3, $zero, end_div

	sub  $t0, $t0, $t1      # m = m - 2
	addi $t2, $t2, 1        # quotient = quotient + 1
	j    div_loop

end_div:
	# $t0 holds remainder (0 or 1); return it in $v0
	addu $v0, $t0, $zero
	jr   $ra