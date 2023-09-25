.text
main:
	li	$v0, 5
	syscall
	sw	$v0,x
	lw	$v0,x
	add	$v0,$v0,5
	add	$sp,$sp,-4
	sw	$v0,4($sp)
	lw	$v0,4($sp)
	add	$sp,$sp,-4
	sw	$v0,4($sp)
	lw	$v0,8($sp)
	lw	$a0,4($sp)
	add	$v0,$a0,$v0
	add	$sp,$sp,4
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
x: 	.word 0
