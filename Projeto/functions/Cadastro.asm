.data
	abre_parenteses: .asciiz "("
	fecha_parenteses: .asciiz ")"
.text
.globl Cadastro
Cadastro:
#empilha o valor altual de #$ra
subi $sp, $sp, -4# necess�rio , pois quando uma fun��o chama outra o registrador $ra � sobrescrito e perde o retorno original
sw $ra, 0($sp) #-4 � apenas uma conven��o, eu li em um f�rum

#start_data_buffer:
	# Inserir '(' no in�cio da string
	#la $t0, salve_data_buffer       # Endere�o da string
	#li $t1, '('            # Caractere a ser inserido

	# Inserir o caractere no in�cio
	#sb $t1, 0($t0)
	
	la $a0, salve_data_buffer
	la $a1, option_1
	jal strcat
	
	la $a0, salve_data_buffer
	la $a1, fecha_parenteses
	jal strcat
	#
	la $a0, salve_data_buffer
	la $a1, option_2
	jal strcat
	
	la $a0, salve_data_buffer
	la $a1, fecha_parenteses
	jal strcat
	
	la $a0, salve_data_buffer
	la $a1, option_3
	jal strcat
	
	la $a0, salve_data_buffer
	la $a1, fecha_parenteses
	jal strcat
	
	la $a0, salve_data_buffer
	la $a1, saldo_inicial
	jal strcat
	
	la $a0, salve_data_buffer
	la $a1, fatura_inicial
	jal strcat
	
	la $a0, salve_data_buffer
	la $a1, limite_credito_inicial
	jal strcat
	
	la $a0, salve_data_buffer
	la $a1, ponto_virgula
	jal strcat
	
	la $a0, clientData
	la $a1, salve_data_buffer
	jal strcat
	
lw $ra, 0($sp)
addi $sp, $sp, 4 
jr $ra	
