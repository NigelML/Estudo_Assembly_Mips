# Fun��o memcpy em Assembly MIPS
# $a0: Endere�o de mem�ria do destino (destination)
# $a1: Endere�o de mem�ria da origem (source)
# $a2: N�mero de bytes a serem copiados (num)
# $v0: Valor de retorno (endere�o de mem�ria do destino)

.text
.globl memcpy

memcpy:
    # Salva o endere�o de mem�ria do destino para retorno
    move $v0, $a0

    # Loop para copiar bytes at� atingir o n�mero especificado
copy_loop:
    bnez $a2, continue_copy  # Se $a2 n�o � zero, continua a c�pia

    # Se $a2 � zero, termina o loop
    jr $ra                  # Retorna ao endere�o de chamada

continue_copy:
    lb $t0, 0($a1)           # Carrega o byte da origem em $t0
    sb $t0, 0($a0)           # Armazena o byte no destino

    addi $a0, $a0, 1         # Avan�a para o pr�ximo byte no destino
    addi $a1, $a1, 1         # Avan�a para o pr�ximo byte na origem
    addi $a2, $a2, -1        # Decrementa o contador de bytes a serem copiados
    j copy_loop              # Salta de volta para o in�cio do loop
