.data
	#array: .word 9, 7, 8, 42, 6, 4, 5, 3, 1, 2
	array: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
	searchValue: .word 11
	length: .word 10
	welcomeMessage: .asciiz "Binary Search: \n"
	beforeString: .asciiz "\nBefore Sorting: \n"
	afterString: .asciiz "\nAfter Sorting: \n"
	space: .asciiz " "
	indexStr: .asciiz "byte offset: "
	valueStr: .asciiz " value: "
	newLine: .asciiz "\n"
	indexResultStr: .asciiz "\nIndex of Search Value: "

.text
	main:
		li $v0, 4
		la $a0, welcomeMessage
		syscall
	
		# Print the array
		#la $a1, length
		#jal printArray
		
		# Sort the array
		#add $s0, $zero, $ra # Save return address
		#la $a1, length
		#jal bubbleSort
		#add $ra, $zero, $s0 # Restore return address
	
		# Call Binary Search (expects sorted array)
		la $a0, array   			# address of the array
		lw $a1, length				# length of array
		lw $a2, searchValue 	# value we're looking for
		li $a3, 4							# size of array elements (bytes)
		jal binarySearch
		
		# Print index of value
		add $s0, $zero, $v0 # store index at $a0 (divide by bytes)
		li $v0, 4
		la $a0, indexResultStr
		syscall
		add $a0, $zero, $s0
		li $v0, 1
		syscall
		
		# Print the array
		#la $a1, length
		#jal printArray
	
	exit:
		li $v0, 10
		syscall

	binarySearch:
	# Arguments:
		# $a0 : address of first element in array
		# $a1 : length of the array
		# $a2 : value we are searching for
		# $a3 : size of datatype (bytes)
	# Returns:
		# $v0 : index of value in the array (-1 if not found)
		
		# lo = 0
		li $t0, 0
		# hi = length - 1
		addi $t1, $a1, -1
		
		loLTEQHigh:
			# mid = lo + (hi - lo) / 2
			sub $t2, $t1, $t0 # (hi - lo)
			div $t3, $t2, 2 	# (hi - lo) / 2
			add $t2, $t0, $t3 # lo + (hi - lo) / 2
			
			# if (key < a[mid]) hi = mid - 1
			mul $t3, $t2, $a3 # Index of mid (bytes)
			lw $t4, array($t3) # a[mid]
			blt $a2, $t4, valueLessThanMid
			bgt $a2, $t4, valueGreaterThanMid
			beq $a2, $t4, valueEqualToMid
			returnLTGT:
				ble $t0, $t1, loLTEQHigh # while(lo <= hi)
				li $v0, -1 # Return -1 if nothing is found
				j exitBinarySearch
			
		valueLessThanMid:
			div $t5, $t3, $a3 # (divide by bytes)
			add $t1, $t5, -1
			j returnLTGT
		
		valueGreaterThanMid:
			div $t5, $t3, $a3 # (divide by bytes)
			add $t0, $t5, 1
			j returnLTGT
			
		valueEqualToMid:
			div $v0, $t3, $a3 # return index of mid (divided by bytes)
			j exitBinarySearch
		
		exitBinarySearch:
			jr $ra

.include "../Sorting/BubbleSort.asm"
.include "../Sorting/PrintArray.asm"

