.data
	bem_vindo_cadastro: .asciiz "Bem vindo a tela de Cadastro.\n"
	sequencia_comandos_cadastro: .asciiz "ordem de entrada de dados: cpf, id-conta, nome.\n"	
	abre_parenteses: .asciiz "("
	fecha_parenteses: .asciiz ")"
.text
.globl Cadastro
Cadastro:
#empilha o valor altual de #$ra
subi $sp, $sp, -4# necess�rio , pois quando uma fun��o chama outra o registrador $ra � sobrescrito e perde o retorno original
sw $ra, 0($sp) #-4 � apenas uma conven��o, eu li em um f�rum

	li $v0, 4
	la $a0, bem_vindo_cadastro
	syscall
	li $v0, 4
	la $a0, sequencia_comandos_cadastro
	syscall 	
	

 #pega cpf   	
    	li $v0, 8             # syscall para ler string
    	la $a0, cpf_buffer    # endere�o do buffer CPF
    	li $a1, 13            # comprimento m�ximo da string
    	syscall	
    	
    	la $a0, cpf_data	
	jal start_data_buffer
	
	la $a0, cpf_data
	la $a1, cpf_buffer
	
	jal strcat
	
	la $a0, cpf_data
	la $a1, fecha_parenteses
	jal strcat
	
   #pega id
    	li $v0, 8             # syscall para ler string
    	la $a0, id_buffer     # endere�o do buffer ID
    	li $a1, 8             # comprimento m�ximo da string
    	syscall
    	la $a0, id_data	
	jal start_data_buffer
	
	la $a0, id_data
	la $a1, id_buffer
	
	jal strcat
	
	la $a0, id_data
	la $a1, fecha_parenteses
	jal strcat	

  #PEGA NOME  	
    	li $v0, 8             # syscall para ler string
    	la $a0, name_buffer   # endere�o do buffer nome
    	li $a1, 32            # comprimento m�ximo da string
    	syscall  
    	
    	la $a0, name_data	
	jal start_data_buffer
	
	la $a0, name_data
	la $a1, name_buffer
	
	jal strcat
	
	la $a0, name_data
	la $a1, fecha_parenteses
	jal strcat
	
	la $a0, clientData
	la $a1, cpf_data
	jal strcat
	
	la $a0, clientData
	la $a1, cpf_data
	jal strcat
	
	la $a0, clientData
	la $a1, name_data
	jal strcat
	#limite_credito_inicial: .asciiz "1500"
	#saldo_inicial: .asciiz "0000"
	#fatura_inicial: .asciiz "0000"
	
	la $a0, clientData
	la $a1, limite_credito_inicial
	jal strcat
	
	la $a0, clientData
	la $a1, saldo_inicial
	jal strcat
	
	la $a0, clientData
	la $a1, fatura_inicial
	jal strcat
	
	la $a0, clientData
	la $a1, ponto_virgula
	jal strcat
	
end_cadastro:
lw $ra, 0($sp)
addi $sp, $sp, 4 
	jr $ra

start_data_buffer:
	# Inserir '(' no in�cio da string
	move $t0, $a0       # Endere�o da string
	li $t1, '('            # Caractere a ser inserido

	# Inserir o caractere no in�cio
	sb $t1, 0($t0)
jr $ra	
