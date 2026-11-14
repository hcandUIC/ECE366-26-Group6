.data
    m:      .word 7	#m is here
    result: .word 0	#result will be stored here
.text

is_odd:
	#handle m value
	la $t8, m	#load the memory address of 'm'
	lw $t0, 0($t8)	#load the value of 'm' into $t0
        
        #division setup for repeated subtraction
	ori $t1, $zero, 2	#divisor y=2
	ori $t2, $zero, 0	#quotient = 0

div_loop:
	#loop check: while m >= 2
	slt $t3, $t0, $t1	#set $t3 to 1 if m < 2
	bne $t3, $zero, end_div	#if m < 2, exit loop
        
	#repeated subtraction
	sub $t0, $t0, $t1	#m = m - 2
	addi $t2, $t2, 1	#quotient = quotient + 1
	j div_loop	#jump to start of loop

end_div:
	#handle retun of final value. 
	#$t0 now holds the remainder (0 or 1).
	#0 means even (False), 1 means odd (True). 
	la $t9, result	#Load the memory address of 'result'
	sw $t0, 0($t9)	#Store remainder directly into memory as the boolean answer

	addu $v0, $zero, 10
	syscall