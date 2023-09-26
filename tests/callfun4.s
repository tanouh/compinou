.text
main:
	li	$v0, 5
	syscall
	sw	$v0,x
	li	$v0, 5
	syscall
	sw	$v0,y
	li	$v0, 5
	syscall
	sw	$v0,z
	j	end_f
f:
	add	$sp,$sp,-4
	sw	$ra,4($sp)
	add	$sp,$sp,-4
	sw	$a0,4($sp)
	li	$v0, 2
	add	$sp,$sp,-4
	sw	$v0,4($sp)
	lw	$v0,8($sp)
	add	$sp,$sp,-4
	sw	$v0,4($sp)
	lw	$v0,x
	lw	$a0,4($sp)
	add	$v0,$a0,$v0
	add	$sp,$sp,4
	add	$sp,$sp,-4
	sw	$v0,4($sp)
	lw	$v0,8($sp)
	lw	$a0,4($sp)
	add	$v0,$a0,$v0
	add	$sp,$sp,4
	add	$sp,$sp,-4
	sw	$v0,4($sp)
	lw	$v0,z
	lw	$a0,4($sp)
	add	$v0,$a0,$v0
	add	$sp,$sp,4
	add	$v0,$v0,10
	add	$sp,$sp,4
	add	$sp,$sp,4
	lw	$ra,4($sp)
	add	$sp,$sp,4
	jr	$ra
end_f:
	lw	$v0,y
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
z: 	.word 0
y: 	.word 0
x: 	.word 0
