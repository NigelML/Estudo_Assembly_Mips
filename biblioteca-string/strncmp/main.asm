# main.asm

.data
prompt_str1: .asciiz "Digite a primeira string: "
prompt_str2: .asciiz "Digite a segunda string: "
prompt_num: .asciiz "Digite o n�mero de caracteres a serem comparados: "
result_equal: .asciiz "As strings s�o iguais at� o n�mero especificado de caracteres."
result_different: .asciiz "As strings s�o diferentes at� o n�mero especificado de caracteres. \n"
result_greater: .asciiz "A primeira string � MAIOR."
result_smaller: .asciiz "A primeira string � MENOR."

str1: .space 100   # Espa�o para a primeira string
str2: .space 100   # Espa�o para a segunda string

.text
.globl main

main:
    # Solicita ao usu�rio para digitar a primeira string
    li $v0, 4
    la $a0, prompt_str1
    syscall

    # L� a primeira string do usu�rio
    li $v0, 8
    li $a1, 100
    la $a0, str1
    syscall

    # Solicita ao usu�rio para digitar a segunda string
    li $v0, 4
    la $a0, prompt_str2
    syscall

    # L� a segunda string do usu�rio
    li $v0, 8
    li $a1, 100
    la $a0, str2
    syscall

    # Solicita ao usu�rio para digitar o n�mero de caracteres a serem comparados
    li $v0, 4
    la $a0, prompt_num
    syscall

    # L� o n�mero de caracteres do usu�rio
    li $v0, 5
    syscall
    move $a2, $v0   # Armazena o n�mero de caracteres em $a2

    # Chama a fun��o strncmp
    la $a0, str1
    la $a1, str2
    jal strncmp
    move $a3, $v0
    # Imprime o resultado
    beqz $v0, print_equal       # Se $v0 � zero, imprime "As strings s�o iguais at� o n�mero especificado de caracteres."
    bnez $v0, print_different   # Se $v0 � n�o zero, imprime "As strings s�o diferentes at� o n�mero especificado de caracteres."

print_equal:
    li $v0, 4
    la $a0, result_equal
    syscall
    j end_program

print_different:    
    li $v0, 4
    la $a0, result_different
    syscall
    bgtz $a3, print_greater     # Se $v0 � positivo, imprime "A primeira string � maior."
    bltz $a3, print_smaller     # Se $v0 � negativo, imprime "A primeira string � menor."

print_greater:
    li $v0, 4
    la $a0, result_greater
    syscall
    j end_program

print_smaller:
    li $v0, 4
    la $a0, result_smaller
    syscall
    
end_program:
    # Termina o programa
    li $v0, 10
    syscall
    
# Include da implementa��o da fun��o strncmp
.include "strncmp.asm"
