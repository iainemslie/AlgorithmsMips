.data
	welcomeMessage: .asciiz  "************* Factorial Calculator *************\n\n"
	prompt: .asciiz "Enter a number to calculate it's factorial: "
	result: .asciiz "\nResult: "

.text
	# Welcome message
	addi $v0, $zero,  4
	la $a0, welcomeMessage
	syscall

	# Prompt the user to enter a number
	addi $v0, $zero, 4
	la $a0, prompt
	syscall
	
	# Get input from the user
	li $v0, 5
	syscall
	
	# Pass input as argument
	add $a0, $zero $v0
	
	# Call factorial subroutine
	jal factorial
	
	
	add $t0, $zero, $v0 # Store return value
	# Print the result
	addi $v0, $zero, 4
	la $a0, result
	syscall
	
	addi $v0, $zero, 1
	add $a0, $zero, $t0
	syscall
	
	# End program
	exit:
		li $v0, 10
		syscall
			
	# Calculate the factorial
	factorial:
		subu $sp, $sp, 8 # make room for two bytes on stack
		sw $ra, ($sp)    # store return address on stack
		sw $s0, 4($sp)   # increment stack pointer by one byte and store $s0
		
		# Base case
		li $v0, 1									# Load return value with 1
		beq $a0, 0, factorialDone	# If argument passed in is zero then unwind
		
		# findFactorial(theNumber - 1)
		move $s0, $a0							# set $s0 = $a0
		sub $a0, $a0, 1						# decrement current value
		jal factorial
		
		# The magic happens here
		mul $v0, $s0, $v0					
		
		factorialDone:
			lw $ra, ($sp)						# Load return address from stack
			lw $s0, 4($sp)					# Load $s0 from stack
			addu $sp, $sp, 8				# Increase stack pointer by 2 bytes
			jr $ra									# return