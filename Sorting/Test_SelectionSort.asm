.data
	array: .word 9, 7, 8, 42, 6, 4, 5, 3, 1, 2
	length: .word 10
	welcomeString: .asciiz "Selection Sort: \n"
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
		
		la $a1, length
		jal printArray
	
		la $a1, length
		jal selectionSort
		
		# After sorting message
		li $v0, 4
		la $a0, afterString
		syscall		
		
		jal printArray
		
	# Exit program
	exit:
		li $v0, 10
		syscall
		
.include "./SelectionSort.asm"
.include "../Utilities/PrintArray.asm"
