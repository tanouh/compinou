.text
main:
	li	$v0, 5
	syscall
	sw	$v0,x
	lw	$v0,x
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
