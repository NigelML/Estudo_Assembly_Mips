# main.asm

.data
source: .asciiz "MIPS memcpy test"  # String de origem
destination: .space 50               # Espa�o para o destino

.text
.globl main
main:
    # Teste da fun��o memcpy
    li $t0, 10         # N�mero de bytes a serem copiados
    la $a0, destination # Endere�o de mem�ria do destino
    la $a1, source      # Endere�o de mem�ria da origem
    move $a2, $t0       # N�mero de bytes a serem copiados

    # Chama a fun��o memcpy
    jal memcpy

    # Imprime o resultado
    li $v0, 4           # Chamada do sistema para imprimir string
    la $a0, destination  # Carrega o endere�o da string de destino
    syscall

    # Termina o programa
    li $v0, 10          # Chamada do sistema para encerrar o programa
    syscall
# Include da implementa��o da fun��o memcpy
.include "memcpy.asm"
