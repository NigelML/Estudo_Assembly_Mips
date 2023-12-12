# main.asm

.data
prompt_str1: .asciiz "Digite a primeira string: "
prompt_str2: .asciiz "Digite a segunda string: "
result_equal: .asciiz "As strings s�o iguais."
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
    la $a0, str1
    li $a1, 100
    syscall

    # Solicita ao usu�rio para digitar a segunda string
    li $v0, 4
    la $a0, prompt_str2
    syscall

    # L� a segunda string do usu�rio
    li $v0, 8
    la $a0, str2
    li $a1, 100
    syscall

    # Chama a fun��o strcmp
    la $a0, str1
    la $a1, str2
    jal strcmp

    # Imprime o resultado
    beqz $v0, print_equal       # Se $v0 � zero, imprime "As strings s�o iguais."
    bgtz $v0, print_greater     # Se $v0 � positivo, imprime "A primeira string � maior."
    bltz $v0, print_smaller     # Se $v0 � negativo, imprime "A primeira string � menor."

print_equal:
    li $v0, 4
    la $a0, result_equal
    syscall
    j end_program

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
# Include da implementa��o da fun��o strcmp
.include "strcmp.asm"
