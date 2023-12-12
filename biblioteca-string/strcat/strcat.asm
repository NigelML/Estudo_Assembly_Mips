# Fun��o strcat em Assembly MIPS
# $a0: Endere�o de mem�ria da string de destino (destination)
# $a1: Endere�o de mem�ria da string de origem (source)
# $v0: Endere�o de mem�ria da string de destino ap�s a concatena��o

.text
.globl strcat

strcat:
    # Salva o endere�o de mem�ria da string de destino para retorno
    move $v0, $a0

    # Encontra o final da string de destino
    move $t0, $a0
find_null_dest:
    lb $t1, 0($t0)     # Carrega o byte da string de destino em $t1
    beqz $t1, copy_source  # Se encontrar o caractere nulo, copia a string de origem
    beq $t1, 10, copy_source  # Se encontrar o caractere de nova linha, copia a string de origem

    addi $t0, $t0, 1   # Avan�a para o pr�ximo byte na string de destino
    j find_null_dest   # Salta de volta para o in�cio do loop


copy_source:
    # Loop para copiar bytes da string de origem para a string de destino
    move $t2, $a1
copy_loop:
    lb $t1, 0($t2)     # Carrega o byte da string de origem em $t1
    sb $t1, 0($t0)     # Armazena o byte na string de destino

    beqz $t1, copy_done   # Se encontrar o caractere nulo, termina o loop

    addi $t0, $t0, 1      # Avan�a para o pr�ximo byte na string de destino
    addi $t2, $t2, 1      # Avan�a para o pr�ximo byte na string de origem
    j copy_loop           # Salta de volta para o in�cio do loop

copy_done:
    jr $ra                # Retorna ao endere�o de chamada
