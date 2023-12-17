.text
.globl ClearBuffer
ClearBuffer:

	# Limpar o buffer
	move $t0, $a0       # endere�o do buffer
	move $t1, $a1          # comprimento m�ximo do buffer

	clear_buffer_loop:
    	sb $zero, 0($t0)   # escreve zero no byte atual do buffer
    	addi $t0, $t0, 1   # move para o pr�ximo byte
    	addi $t1, $t1, -1  # decrementa o contador
    	bnez $t1, clear_buffer_loop  # repete at� que todos os bytes sejam zerados
jr $ra