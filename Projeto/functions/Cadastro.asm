.data
	bem_vindo_cadastro: .asciiz "Bem vindo a tela de Cadastro.\n"
	sequencia_comandos_cadastro: .asciiz "ordem de entrada de dados: cpf, id-conta, nome.\n"	
	abre_parenteses: .asciiz "("
	fecha_parenteses: .asciiz ")"
.text
.globl Cadastro
Cadastro:
#empilha o valor altual de #$ra
subi $sp, $sp, -4# necessário , pois quando uma função chama outra o registrador $ra é sobrescrito e perde o retorno original
sw $ra, 0($sp) #-4 é apenas uma convenção, eu li em um fórum

start_data_buffer:
	# Inserir '(' no início da string
	la $t0, salve_data_buffer       # Endereço da string
	li $t1, '('            # Caractere a ser inserido

	# Inserir o caractere no início
	sb $t1, 0($t0)

	li $v0, 4
	la $a0 salve_data_buffer
	syscall
	 
lw $ra, 0($sp)
addi $sp, $sp, 4 
jr $ra	
