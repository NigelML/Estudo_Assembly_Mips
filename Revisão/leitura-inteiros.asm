.data
	saudacao : .asciiz "Digite um n�mero inteiro: "
	saida : .asciiz "Voc� digitou: "
.text
	li $v0, 4 #valor para imprimir uma string
	la $a0, saudacao # carregar a mensagem da mem�ria para $a0
	syscall 
	
	li $v0, 5 #valor para leitura de inteiros
	syscall  # o valor digitado fica armazenado em $v0
	
	move $t0 $v0 #para n�o perder o valor digitado ele deve ser salvo em outro registrador
	
	li $v0, 4 #valor para imprimir a string e motivo pelo qual foi usando o comando anterior
	la $a0, saida
	syscall 
	
	li $v0, 1
	move $a0, $t0
	syscall 
	
	
	
	