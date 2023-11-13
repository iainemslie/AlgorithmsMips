.data
	welcome_message: .asciiz "String Reversal\n"
	prompt_message: .asciiz "Enter a string to reverse: "
	input_buffer_size: .byte 100
	input_buffer: .space 100
	
.text
	# Print welcome message
	la $a0, welcome_message
	add $v0, $zero, 4
	syscall
	
	## Prompt for input
	la $a0, prompt_message
	add $v0, $zero, 4
	syscall
	
	## Get input
	la $a0, input_buffer
	lb $a1, input_buffer_size
	add $v0, $zero, 8
	syscall
	
	jal reverse_string
	
	# Print welcome message
	la $a0, input_buffer
	add $v0, $zero, 4
	syscall
	
	# terminate program
	add $v0, $zero, 10
	syscall
	
reverse_string:
# Arguments: 
	# $a0 : Address of string
	
	la $t0, ($a0) # Store ref to start of string buffer
	la $t8, ($a0) # Store address of string (for counter)
	add $t1, $zero, 10 # ascii newline char
	add $fp, $zero, $sp # Store ref to top of stack
	reverse_string_loop: 
	lb $t2, ($t8) # load byte
	
	sb $t2, ($sp)
	addi $sp, $sp, 1
	
	addi $t8, $t8, 1 # increment address
	bne $t1, $t2, reverse_string_loop # while current index value != newline
	
	subi $sp, $sp, 1
	
	reverse_string_pop_stack_loop:
	subi $sp, $sp, 1 # Decrement stack pointer
	lb $t2, ($sp) # Load char from stack

	sb $t2, ($t0) # Store char from stack in string buffer
	add $t0, $t0, 1 # Increment address by one byte
	
	bne $fp, $sp, reverse_string_pop_stack_loop
	sb $t1, ($t8)
	
	
	jr $ra