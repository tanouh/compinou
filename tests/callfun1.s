.text
main:
	li	$v0, 5
	syscall
	sw	$v0,x
f:
	add	$sp,$sp,-4
	sw	$ra,4($sp)
	lw	$v0,8($sp)
	add	$sp,$sp,-4
	sw	$v0,8($sp)
	li	$v0, 1
	add	$v0,$v0,1
	lw	$a0,8($sp)
	add	$sp,$sp,4
	j	end_f
end_f:
	lw	$ra,4($sp)
	add	$sp,$sp,4
	jr	$ra
	lw	$v0,x
	jal	f
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
