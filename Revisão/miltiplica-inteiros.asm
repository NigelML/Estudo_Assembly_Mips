.text
	li $t0, 2 # note que tamb�m ser� usando no exemplo de sll
	li $t1, 50
	
	mul $s0, $t0, $t1 # Equivalente � $s0 = $t0 * $t1
	li $v0, 1
	
	move $a0, $s0
	syscall 
	
	#Sheft Left L�gico (multiplica por pot�ncias de 2)
	sll $s1, $t0, 10 #� equivalente �: $t0 * (2^10)= 2048. (obs: $t0 = 2)
