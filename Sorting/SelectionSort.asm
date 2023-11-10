#######################################################
################### SELECTION SORT ####################
#######################################################
# Sorts a given array using the selection sort algorithm

selectionSort:
# Arguments
	# $a1 : length of array
# Register Used
	# $t0 : length of array - 1
	# $t1 : outer loop n index counter
	# $t2 : index of smallest element
	# $t3 : inner loop i index counter
	# $t4 : stores value of array at index i
	# $t5 : stores value of array at index smallest

	subi $t0, $a1, 1 # length of array - 1
	addi $t1, $zero, 0 # let n = 0
	selectionSortOuterLoop:
			add $t2, $zero, $t1 # smallest = n
			
			addi $t3, $t1, 4 # let i = n + 1
			selectionSortInnerLoop:
				# if a[i] < a[smallest] smallest = 1
				lw $t4, array($t3)
				lw $t5, array($t2)
				blt $t4, $t5, selectionSortSetSmallest
				selectionSortReturnSetSmallest:
			
				addi $t3, $zero, 4
				blt $t3, $t0, selectionSortInnerLoop
				j selectionSortSwap
				selectionSortReturnSortSwap:
				
				addi $t1, $zero, 4 # n = n + 1
			blt $t1, $t0, selectionSortOuterLoop
			
selectionSortSetSmallest:
	add $t2, $zero, $t3
	j selectionSortReturnSetSmallest 
	
selectionSortSwap:
	add $t6, $zero, $t4
	add $t4, $zero, $t5
	add $t5, $zero, $t6
	j selectionSortReturnSortSwap
	