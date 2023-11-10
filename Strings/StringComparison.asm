.data
	welcome_string: .asciiz "**** String Comparison ****\n"
	string_entry_prompt: .asciiz "Enter a string: "
	equal_string: .asciiz "strings are equal"
	not_equal_string: .asciiz "strings are not equal"
	input_buffer_size: .byte 100
	input_buffer1: .space 100
	input_buffer2: .space 100

.text
	# Print Welcome String
	addi $v0, $zero, 4
	la $a0, welcome_string
	syscall
	
	# Print Prompt
	addi $v0, $zero, 4
	la $a0, string_entry_prompt
	syscall
	
	### Read the first string
	la $a0, input_buffer1
	lbu $a1, input_buffer_size
	addi $v0, $zero, 8
	syscall
	
	# Print Prompt
	addi $v0, $zero, 4
	la $a0, string_entry_prompt
	syscall

	### Read the second string
	la $a0, input_buffer2
	lbu $a1, input_buffer_size
	addi $v0, $zero, 8
	syscall
	
	# Call the string comparison function
	jal strncmp
	
	jal strncmp_result
		
	# Terminate the program
	addi $v0, $zero, 10
	syscall
	
strncmp_result:
	beq $v0, -1, strncmp_result_not_equal
	addi $v0, $zero, 4
	la $a0, equal_string
	syscall
	jr $ra
	
strncmp_result_not_equal:
	addi $v0, $zero, 4
	la $a0, not_equal_string
	syscall
	jr $ra
	
strncmp:
	lb $t0, input_buffer_size
	addi $t1, $zero, 0 # index

	addi $v0, $zero, 0

	strncmp_loop:
		# compare bytes in both strings at index
		lb $t2, input_buffer1($t1)
		lb $t3, input_buffer2($t1)
		bne $t2, $t3, strncmp_loop_not_equal
		
		addi $t1, $t1, 1
		bne $t0, $t1, strncmp_loop
	
	strncmp_exit:
		jr $ra

	strncmp_loop_not_equal:
		addi $v0, $zero, -1
		j strncmp_exit