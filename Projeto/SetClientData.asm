.data	
	
.text
.globl SetClientData
SetClientData:
	#empilha o valor altual de #$ra
	subi $sp, $sp, -4# necess�rio , pois quando uma fun��o chama outra o registrador $ra � sobrescrito e perde o retorno original
	sw $ra, 0($sp) #-4 � apenas uma conven��o, eu li em um f�rum
	
	#abri arquivo, se n�o existir ele cria um
	li $v0, 13
	la $a0, localArquivo
	li $a1, 1 #1 significa modo de escrita, 0 � modo de leitura
	syscall #descritor foi salvo em $v0
	
	move $s0, $v0  #c�pia do descritor
	
	la $a0, clientData #necess�rio passar clietData para $a0 como argumento
	jal CountCharacters #fun��o para contar a quantidade de bytes
	move $t1, $v0 #salva o tamanho de clientData em bytes
	
	#escrevendo arquivo	
	li $v0, 15
	move $a0, $s0
	la $a1, clientData #passa o conte�do para $a1
	move $a2, $t1 #passa qual � o tamanho do arquivo
	syscall 
	
	#fechar arquivo
	li $v0, 16
	move $a0, $s0
	syscall
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
jr $ra