.data 
	msg: .asciiz "digite um n�mero "
	par: .asciiz "o n�mero � par"
	impar: .asciiz "o n�mero � impar"
.text
	li $v0, 4
	la $a0, msg
	syscall
	
	li $v0, 5
	syscall 
	
	li $t0, 2
	div $v0, $t0
	
	mfhi $t1 # armazena em $t1 o valor de h1, resto da divis�o.
	
	#obs, tamb�m poderia escrever assim:
	#beq $t1, $zero, numeroPar. ($zero � um registrador padr�o para inteiros)
	beqz $t1, numeroPar #beqz faz uma verifica��o DIRETA se $t1 = 0
	li $v0, 4
	la $a0, impar
	syscall 
	
	li $v0, 10 #se n�o finalizar ele continua execulta numeroPar.
	syscall #s� chega aqui se for impar e finaliza o programa.
	
	numeroPar: #se for par salta para esta parte ignora a anterior e finaliza.
	li $v0, 4
	la $a0, par
	syscall 