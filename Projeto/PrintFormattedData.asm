.text
.globl PrintFormattedData

PrintFormattedData:
    # $a0: Endere�o do buffer

    # Inicializa o �ndice
    li $t0, 0
    move $s0, $a0

print_loop:
    lb $t1, 0($s0)     # Carrega o byte do buffer
    beqz $t1, print_done  # Se encontrou o caractere nulo, termina o loop

    # Verifica se � um caractere especial e realiza as substitui��es
    beq $t1, '(', replace_open_paren
    beq $t1, ')', replace_close_paren
    beq $t1, ';', replace_semicolon
    beq $t1, 0xA, replace_newline

    # Imprime o caractere original
    li $v0, 11           # C�digo do sistema para imprimir caractere
    move $a0, $t1
    syscall

    # Avan�a para o pr�ximo byte
    addi $s0, $s0, 1
    j print_loop

replace_open_paren:
    li $t1, ' '           # Substitui '(' por espa�o
    j print_char

replace_close_paren:
    li $t1, ' '           # Substitui ')' por espa�o
    j print_char

replace_semicolon:
    li $t1, 0xA           # Substitui ';' por quebra de linha
    j print_char

replace_newline:
    # Pula caracteres de nova linha
    addi $s0, $s0, 1
    j print_loop

print_char:
    # Imprime o caractere substitu�do
    li $v0, 11           # C�digo do sistema para imprimir caractere
    move $a0, $t1
    syscall

    # Avan�a para o pr�ximo byte
    addi $s0, $s0, 1
    j print_loop

print_done:
    jr $ra              # Retorna ao endere�o de chamada
