# main.asm

.data
prompt_dest: .asciiz "Digite a string de destino: "
prompt_source: .asciiz "Digite a string de origem: "
result_concatenated: .asciiz "Strings concatenadas: "

destination: .space 100   # Espa�o para a string de destino
source: .space 100        # Espa�o para a string de origem

.text
.globl main



main:
    # Solicita ao usu�rio para digitar a string de destino
    li $v0, 4
    la $a0, prompt_dest
    syscall

    # L� a string de destino do usu�rio
    li $v0, 8
    li $a1, 100
    la $a0, destination
    syscall

    # Solicita ao usu�rio para digitar a string de origem
    li $v0, 4
    la $a0, prompt_source
    syscall

    # L� a string de origem do usu�rio
    li $v0, 8
    li $a1, 100
    la $a0, source
    syscall

    # Chama a fun��o strcat
    la $a0, destination
    la $a1, source
    jal strcat

    # Imprime o resultado
    li $v0, 4
    la $a0, result_concatenated
    syscall

    # Imprime a string concatenada
    li $v0, 4
    la $a0, destination
    syscall

    # Termina o programa
    li $v0, 10
    syscall
# Include da implementa��o da fun��o strcat
.include "strcat.asm"