.data
	pergunta: .asciiz "Qual � seu nome? "
	saudacao: .asciiz "Ol� "
	nome: .space 25 #define um espa�amento maximo para a string
.text
	li $v0, 4
	la $a0, pergunta
	syscall 
	
	li $v0, 8 #valor de leitura de string
	la $a0, nome #armazena a string tanto em $a0 quanto em nome
	la $a1, 25 #avisa quantos caracteres seram lidos
	syscall 
	#obs: seria melhor, computacionalmente,
	#salvar o valor atual de $a0 em outro registrador
	#pois ser� substituido na proxima instru��o
	#o valor n�o ser� perdido,nesse caso, pois est� salvo, tamb�m, em nome
	li $v0, 4
	la $a0, saudacao 
	syscall 
	
	li $v0, 4
	la $a0, nome #imprime o que est� armazenado em nome
	syscall 