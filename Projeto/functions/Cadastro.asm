.data
	bem_vindo_cadastro: .asciiz "Bem vindo a tela de Cadastro.\n"
	sequencia_comandos_cadastro: .asciiz "ordem de entrada de dados: cpf, id-conta, nome.\n"	
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
	


end_cadastro:
lw $ra, 0($sp)
addi $sp, $sp, 4 
	jr $ra
