.data
	array: .word 9, 7, 8, 42, 6, 4, 5, 3, 1, 2
	length: .word 10
	welcomeString: .asciiz "Bubble Sort: \n"
	beforeString: .asciiz "\nBefore Sorting: \n"
	afterString: .asciiz "\nAfter Sorting: \n"
	space: .asciiz " "
	indexStr: .asciiz "byte offset: "
	valueStr: .asciiz " value: "
	newLine: .asciiz "\n"
	
.text
	main:
		
		# Welcome message
		li $v0, 4
		la $a0, welcomeString
		syscall		
		
		# Before sorting message
		li $v0, 4
		la $a0, beforeString
		syscall		
	
		jal printArray
	
		jal bubbleSort
		
		# After sorting message
		li $v0, 4
		la $a0, afterString
		syscall		
		
		jal printArray
		
	# Exit program
	exit:
		li $v0, 10
		syscall		
		
	# Bubble Sort Subroutine
	bubbleSort:
		# $t0 : index i of outer loop
		# $t1 : length of the array
		# $t2 : index j of inner loop
		# $t3 : value of j index in comparison
		# $t4 : value of j + 1 index in comparison

		lw $t0, length
		mul $t1, $t0, 4 	# length of array (bytes)
		subi $t1, $t1, 4	# Substract 1 from length so we can compare current index and index + 1
		li $t0, 0 				# let i = 0
						
		# Outer loop				
		bubbleSortOuterLoop:
			bge $t0, $t1, exitBubbleSortOuterLoop
			
			li $t2, 0 # let j = 0
			# Inner Loop
			bubbleSortInnerLoop:
				bge $t2, $t1, exitBubbleSortInnerLoop
					
					## SWAP HERE - compare values at index j and j + 1 : swap if [j+1] < [j]
					lw $t3, array($t2) # load value at index j
					addi $t2, $t2, 4   # increment index j
 					lw $t4, array($t2) # load value at index j + 1
					subi $t2, $t2, 4	 # decrement index j
					# if $t4 < $t3 then swap
					blt $t4, $t3, bubbleSortSwap
					
					swapReturn:
						
				# Increment inner loop counter
				add $t2, $t2, 4 # j += 1
				j bubbleSortInnerLoop

			exitBubbleSortInnerLoop:		
				
			# Increment outer loop counter
			add $t0, $t0, 4 # i += 1
			j bubbleSortOuterLoop
				
		exitBubbleSortOuterLoop:
			jr $ra
			
		# swap the adjacent values in array
		bubbleSortSwap:
			sw $t4, array($t2) # store value at index j+1 at index j in array
			addi $t2, $t2, 4   # incrment j
			sw $t3, array($t2) # store value at index j at index j+1 in array
			subi $t2, $t2, 4   # decrement j
		
			j swapReturn
		
	# Print Array Subroutine
	printArray:
		# $t0 : index in loop
		# $t1 : length of the array
		# $a0 : arguments to function calls
		# $v0 : codes for syscalls
	
		lw $t0, length
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
	
