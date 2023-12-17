.text
.globl ClearClientData

ClearClientData:
	# Limpar o espa�o de dados clientData
	li $t0, 0          # Valor zero
	li $t1, 3200       # Tamanho do espa�o de dados

	la $a0, clientData # Endere�o inicial do espa�o de dados
	loop_clear_data:
    	lb $t1, 0($a0)   # Carrega o byte atual
    	beqz $t1, end_clear_data  # Se o byte atual for nulo, saia do loop
    	sb $t0, 0($a0)   # Armazena zero na posi��o atual
    	addi $a0, $a0, 1  # Avan�a para a pr�xima posi��o
    	j loop_clear_data  # Continue o loop  
    	
jr $ra  