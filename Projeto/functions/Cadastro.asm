.data
	bem_vindo_cadastro: .asciiz "Bem vindo a tela de Cadastro"	
.text
.globl Cadastro
Cadastro:
	li $v0, 4
	la $a0, bem_vindo_cadastro
	syscall 
jr $ra