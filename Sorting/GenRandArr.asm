.data
	array_size: .byte 40
	byte_size: .byte 4
	array_buffer: .space 40
.text
	addi $v0, $zero, 41
	syscall
	
	lb $a0, array_size
	lb $a1, byte_size
	la $a2, array_buffer
	jal generate_random_array
	
	# Terminate program
	addi $v0, $zero, 10
	syscall
	
generate_random_array:
# Arguments
	# $a0 : length of the array (bytes)
	# $a1 : size of array data type
  # $a2 : address of first array element
  add $t0, $zero, $a0 # save value of $a0
  
  addi $t1, $zero, 0 # index = 0
  generate_random_array_loop:
  
  # Generate random number
  addi $a0, $zero, 41
  syscall
  
  add $a2, $a2, $a1 # Index
  sb $a0, ($a2)
  
  addi $t1, $t1, 4 # index += sizeof(datatype)
  bne $t0, $t1, generate_random_array_loop
  
  jr $ra