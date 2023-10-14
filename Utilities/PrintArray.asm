####################################################
################### PRINT ARRAY ####################
####################################################
# Prints a given array through iteration

printArray:
# Arguments
	# $a1 : length of array
# Registers used
	# $t0 : index in loop
	# $t1 : length of the array
	# $a0 : arguments to function calls
	# $v0 : codes for syscalls

	lw $t0, ($a1) 	# Load length of array
	mul $t1, $t0, 4	# length of array (bytes)
	li $t0, 0 			# let i = 0	
		
	arrayLoop:	
		# loop while index <= length
		bge $t0, $t1, exitArrayLoop

		# print index str
		li $v0, 4
		la $a0, indexStr
		syscall			

		# print index
		li $v0, 1
		add $a0, $zero, $t0
		syscall
		
		# print value str
		li $v0, 4
		la $a0, valueStr
		syscall
			
		# print the value at index i
		li $v0, 1
		lw $a0, array($t0)
		syscall
		
		# print a newline
		li $v0, 4
		la $a0, newLine
		syscall
	
		# Increment loop counter
		add $t0, $t0, 4 # i += 1
		j arrayLoop
	
	exitArrayLoop:
		jr $ra
