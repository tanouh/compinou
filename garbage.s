.data
x:		.word	3

.text
main:
lw	$t0, x		# load contents of RAM location into register $t0:  $t0 = var1
	li	$t1, 5		#  $t1 = 5   ("load immediate")
	sw	$t1, x

	
lw $a0 x
addi $a0 $a0 1
ori $v0 $zero 1
syscall
ori $v0 $zero 11

ori $a0 $zero 10
syscall
addi $a0 $a0 1
ori $v0 $zero 1
syscall


end:
ori $v0 $zero 11
ori $a0 $zero 10
syscall
ori $v0 $zero 10
syscall
