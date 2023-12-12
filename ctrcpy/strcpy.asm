# Fun��o strcpy em Assembly MIPS
# $a0: Endere�o de mem�ria do destino (destination)
# $a1: Endere�o de mem�ria da origem (source)
# $v0: Valor de retorno (endere�o de mem�ria do destino)

.text
.globl strcpy

strcpy:
    # Salva o endere�o de mem�ria do destino para retorno
    move $v0, $a0

    # Loop para copiar bytes at� encontrar o caractere nulo ('\0')
copy_loop:
    lb $t0, 0($a1)        # Carrega o byte da origem em $t0
    sb $t0, 0($a0)        # Armazena o byte no destino

    beqz $t0, copy_done   # Se o byte for nulo, termina o loop

    addi $a0, $a0, 1      # Avan�a para o pr�ximo byte no destino
    addi $a1, $a1, 1      # Avan�a para o pr�ximo byte na origem
    j copy_loop           # Salta de volta para o in�cio do loop

copy_done:
    jr $ra                # Retorna ao endere�o de chamada
