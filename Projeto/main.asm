.data
	clienteData: .space 3200
.text

.main:
	 # Chama a fun��o GetClientData
	jal GetClientData
    
	# Salva o endere�o do conte�do no clienteData
	move $s0, $v0
	
	move $a0, $s0
	jal PrintFormattedData

	
end_program:
li $v0, 10
syscall

.include "GetClientData.asm"
.include "PrintFormattedData.asm"

