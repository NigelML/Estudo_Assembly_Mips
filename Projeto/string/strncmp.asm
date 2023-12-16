# Fun��o strncmp em Assembly MIPS
# $a0: Endere�o de mem�ria da primeira string (str1)
# $a1: Endere�o de mem�ria da segunda string (str2)
# $a2: N�mero m�ximo de caracteres a serem comparados (num)
# $v0: Valor de retorno

.text
.globl strncmp

strncmp:
    # Loop para comparar caracteres at� encontrar a diferen�a, caractere nulo ou num ser alcan�ado
compare_loop:
    # Carrega o byte da primeira string em $t0
    lb $t0, 0($a0)

    # Carrega o byte da segunda string em $t1
    lb $t1, 0($a1)

    # Compara os bytes
    bne $t0, $t1, compare_done   # Se os bytes s�o diferentes, termina o loop
    beqz $t0, compare_done      # Se o byte � nulo, as strings s�o iguais
    sub $a2, $a2, 1              # Decrementa num
    beqz $a2, compare_done       # Se num atingiu zero, termina o loop

    # Avan�a para o pr�ximo byte nas duas strings
    addi $a0, $a0, 1
    addi $a1, $a1, 1
    
    j compare_loop               # Salta de volta para o in�cio do loop

compare_done:
    # Se chegou aqui, as strings s�o iguais at� num caracteres ou at� o caractere nulo
    sub $v0, $t0, $t1   
    jr $ra                        # Retorna ao endere�o de chamada    

