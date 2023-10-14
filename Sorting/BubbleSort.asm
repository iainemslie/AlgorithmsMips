####################################################
################### BUBBLE SORT ####################
####################################################
# Sorts a given array using the bubble sort algorithm

bubbleSort:
# Arguments
	# $a1 : length of array
# Registers Used
	# $t0 : index i of outer loop
	# $t1 : length of the array
	# $t2 : index j of inner loop
	# $t3 : value of j index in comparison
	# $t4 : value of j + 1 index in comparison

	lw $t0, ($a1) 		# Store length of array
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
	


