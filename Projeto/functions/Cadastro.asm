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

start_data_buffer:
	# Inserir '(' no in�cio da string
	la $t0, salve_data_buffer       # Endere�o da string
	li $t1, '('            # Caractere a ser inserido

	# Inserir o caractere no in�cio
	sb $t1, 0($t0)

	li $v0, 4
	la $a0 salve_data_buffer
	syscall
	 
lw $ra, 0($sp)
addi $sp, $sp, 4 
jr $ra	
