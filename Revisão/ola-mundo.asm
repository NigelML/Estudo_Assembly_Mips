.data
	#�rea destinada para armazenar dados na mem�ria principal
	msg : .asciiz "Ol� Mundo!" #mensagem que ser� exibida
.text
	#�rea para execultar instru��es do programa
	li $v0, 4 #inicia instru��o para impress�o de string
	la $a0, msg #indica qual o endere�o da mensagem
	syscall # imprime,nesse caso, o que est� no registrador a0