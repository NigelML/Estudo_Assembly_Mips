.data
result_buffer: .space 32  # Buffer para armazenar os resultados

.text
.globl FindData
FindData:
subi $sp, $sp, -4# necess�rio , pois quando uma fun��o chama outra o registrador $ra � sobrescrito e perde o retorno original
sw $ra, 0($sp) #-4 � apenas uma conven��o

			
		
	move $s0, $a0 #armazena o dado para compara��o
	la $s1, clientData #armazena o banco de dados para percorrer		 	
	li $v0, 1 # valor indica que inicialmente � falso, se for verdadeiro no final muda para 0
		
	la $a0, result_buffer #limpar o buffer caso tenha algo armazenado
	li $a1, 32
	jal ClearBuffer
	
	find_comp_data_loop_start:		
		la $t1,result_buffer		
	find_comp_data_loop:
		lb $t0, 0($s1)#armazena o caractere de s1 em t0
	           	
    		beqz $t0, compara_find_data      # Se chegou ao final da string, termina
    		beq $t0, ';', compara_find_data # Se encontrou o caractere ';', processa os dados
    		beq $t0, ')', compara_find_data # Se encontrou o caractere ')', processa os dados
    	
    		sb $t0, 0($t1)
    		addi $t1, $t1, 1
    		sb $zero, 0($t1) # adiciona o zero no final da string, indica que ela acabou
 		addi $s1, $s1, 1 
 		j find_comp_data_loop
 		
	compara_find_data:
		move $a0, $s0, #o dado inicial para compara��o
		la $a1, result_buffer #o dado retirado do banco para compara��o
		move $t4, $t0 #salva o valor atual de t0, pois ele vai mudar em strcmp
		
		jal strcmp
		beqz $v0, end_find_data #se for igual a o s�o iguais
		beqz $t4, end_find_data #se $t0 for nulo significa que o os dados acabaram
		
		la $a0, result_buffer
		li $a1, 32
		jal ClearBuffer	
		move $t0, $t4
		addi $s1, $s1, 1 
		j find_comp_data_loop_start
		
end_find_data:
lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra



