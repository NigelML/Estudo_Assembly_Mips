.data
	bem_vindo_cadastro: .asciiz "Bem vindo a tela de Cadastro.\n"
	sequencia_comandos_cadastro: .asciiz "ordem de entrada de dados: cpf, id-conta, nome.\n"	
.text
.globl Cadastro
Cadastro:
#empilha o valor altual de #$ra
subi $sp, $sp, -4# necessário , pois quando uma função chama outra o registrador $ra é sobrescrito e perde o retorno original
sw $ra, 0($sp) #-4 é apenas uma convenção, eu li em um fórum

	li $v0, 4
	la $a0, bem_vindo_cadastro
	syscall
	li $v0, 4
	la $a0, sequencia_comandos_cadastro
	syscall 
	


end_cadastro:
lw $ra, 0($sp)
addi $sp, $sp, 4 
	jr $ra
