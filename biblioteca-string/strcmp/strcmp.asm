# Fun��o strcmp em Assembly MIPS
# $a0: Endere�o de mem�ria da primeira string (str1)
# $a1: Endere�o de mem�ria da segunda string (str2)
# $v0: Valor de retorno

.text
.globl strcmp

strcmp:
    # Loop para comparar caracteres at� encontrar a diferen�a ou caractere nulo
compare_loop:
    lb $t0, 0($a0)          # Carrega o byte da primeira string em $t0
    lb $t1, 0($a1)          # Carrega o byte da segunda string em $t1

    bne $t0, $t1, compare_done # Se os bytes s�o diferentes, termina o loop

    beqz $t0, strings_equal   # Se o byte � nulo, as strings s�o iguais

    addi $a0, $a0, 1          # Avan�a para o pr�ximo byte na primeira string
    addi $a1, $a1, 1          # Avan�a para o pr�ximo byte na segunda string
    j compare_loop            # Salta de volta para o in�cio do loop

compare_done:
    # Calcula o valor de retorno
    sub $t0, $t0, $t1         # Subtrai os valores ASCII dos caracteres

strings_equal:
    move $v0, $t0
    jr $ra                    # Retorna ao endere�o de chamada
