.text
main:
	li	$v0, 5
	syscall
	sw	$v0,x
	li	$v0, 5
	syscall
	sw	$v0,y
	lw	$v0,x
	add	$sp,$sp,-4
	sw	$v0,4($sp)
	li	$v0, 2
	add	$sp,$sp,-4
	sw	$v0,4($sp)
	lw	$v0,y
	lw	$a0,4($sp)
	mul	$v0,$a0,$v0
	add	$sp,$sp,4
	div	$v0,$v0,2
	lw	$a0,4($sp)
	add	$v0,$a0,$v0
	add	$sp,$sp,4
	add	$sp,$sp,-4
	sw	$v0,4($sp)
	li	$v0, 4
	add	$sp,$sp,-4
	sw	$v0,4($sp)
	lw	$v0,x
	add	$sp,$sp,-4
	sw	$v0,4($sp)
	lw	$v0,y
	lw	$a0,4($sp)
	add	$v0,$a0,$v0
	add	$sp,$sp,4
	lw	$a0,4($sp)
	mul	$v0,$a0,$v0
	add	$sp,$sp,4
	lw	$a0,4($sp)
	sub	$v0,$a0,$v0
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
y: 	.word 0
x: 	.word 0
