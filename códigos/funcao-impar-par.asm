.data
	msg: .asciiz "Digite um n�mero inteiro Positivo: "
	msgPar: .asciiz "O n�mero � Par"
	msgImpar: .asciiz "O n�mero � InPar"
.text
	.main:		
		la $a0, msg
		jal msgFuncion #salta para fun��o e armazena o ENDERE�O de retorno em $ra (obs: endere�o de retorno != valor de retorno)
		jal getInt #0 VALOR de retorno est� salvo em $v0
		
		move $a0 , $v0
		li $a1 , 2 #$a0 e $a1 s�o argumentos para a fun��o a seguir 
		jal divFuncion #assim como em getInt, o valor de retorno est� em $v0
		
		beqz $v0, numeroPar
		jal numeroImpar 
	
	msgFuncion:
		li $v0, 4		
		syscall
		jr $ra #retorna para o endere�o salvo, no caso a fun��o que chamou
	getInt:
		li $v0, 5
		syscall
		jr $ra	
	divFuncion:
		div $a0, $a1
		mfhi $v0 #ser� o retorno
		jr $ra
	numeroPar:
		la $a0, msgPar
		jal msgFuncion
		jal end_program
	numeroImpar:
		la $a0, msgImpar
		jal msgFuncion
		jal end_program		
	end_program:
		li $v0, 10
		syscall