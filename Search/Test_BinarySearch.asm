.data
	array: .word 9, 7, 8, 42, 6, 4, 5, 3, 1, 2
	#array: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
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
	searchValueStr: .asciiz "\nSearch Value: "

.text
	main:
		li $v0, 4
		la $a0, welcomeMessage
		syscall
	
		# Print the array
		la $a1, length
		jal printArray
		
		# Sort the array
		add $s0, $zero, $ra # Save return address
		la $a1, length
		jal bubbleSort
		add $ra, $zero, $s0 # Restore return address
	
		# Call Binary Search (expects sorted array)
		la $a0, array   			# address of the array
		lw $a1, length				# length of array
		lw $a2, searchValue 	# value we're looking for
		li $a3, 4							# size of array elements (bytes)
		jal binarySearch
		add $s0, $zero, $v0 # store index at $a0 (divide by bytes)
		
		# Print search value
		li $v0, 4
		la $a0, searchValueStr
		syscall
		li $v0, 1
		add $a0, $zero, $a2
		syscall
		
		# Print index of value
		li $v0, 4
		la $a0, indexResultStr
		syscall
		add $a0, $zero, $s0
		li $v0, 1
		syscall
	
	exit:
		li $v0, 10
		syscall


.include "./BinarySearch.asm"
.include "../Sorting/BubbleSort.asm"
.include "../Utilities/PrintArray.asm"

