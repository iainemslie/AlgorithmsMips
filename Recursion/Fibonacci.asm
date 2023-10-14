.data
	welcomeMessage: .asciiz  "************* Fibonacci Calculator *************\n\n"
	prompt: .asciiz "Enter a number to calculate it's Fibonacci Number: "
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
	jal fibonacci	
	
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
			
	# Calculate the fibonacci number
	fibonacci:
	