.text
main:
	li	$v0, 5
	syscall
	sw	$v0,x
	j	end_f
f:
	add	$sp,$sp,-4
	sw	$ra,4($sp)
	add	$sp,$sp,-4
	sw	$a0,4($sp)
	li	$v0, 1
	add	$v0,$v0,1
	add	$sp,$sp,4
	lw	$ra,4($sp)
	add	$sp,$sp,4
	jr	$ra
end_f:
	lw	$v0,x
	move	$a0, $v0
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
