.text
main:
	li	$v0, 5
	add	$sp,$sp,-4
	sw	$v0,4($sp)
	sw	$v0,4($sp)
	add	$sp,$sp,-4
	sw	$v0,4($sp)
	sw	$v0,4($sp)
	lw	$a0,4($sp)
	add	$v0,$a0,$v0
	add	$sp,$sp,4
	move	$a0, $v0
	li	$v0, 1
	syscall
	li	$v0, 11
	li	$a0, 10
	syscall
end:

  	li $v0, 10

  	syscall
.data
