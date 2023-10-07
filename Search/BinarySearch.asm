####################################################
################## BINARY SEARCH ###################
####################################################
# Finds the index of a given value in a sorted array

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