.data
buffer:     .space  128   # Buffer para armazenar a entrada do teclado

.text
main:
    li      $v0, 8           # Código do sistema para leitura de string
    la      $a0, buffer      # Carrega o endereço do buffer em $a0
    li      $a1, 128         # Define o tamanho máximo da string
    syscall                 # Chama a syscall

    # Agora, $a0 contém o endereço do buffer com a string lida

    # Percorre a string para encontrar o caractere 'Enter' (0xA) ou o caractere nulo (0x00)
    la      $t0, 0xA         # Carrega o valor ASCII de 'Enter' em $t0
find_enter_or_null:
    lb      $t1, 0($a0)      # Carrega o byte atual da string em $t1
    beq     $t1, $t0, found_enter  # Se encontrou 'Enter', pula para found_enter
    beqz    $t1, found_enter  # Se encontrou o caractere nulo, pula para found_enter
    addi    $a0, $a0, 1       # Avança para o próximo byte da string
    j       find_enter_or_null  # Continua procurando

found_enter:
    # Agora, $a0 contém o endereço do buffer e encontramos 'Enter' ou o caractere nulo

    # Escreve a string no display (0xffff000c)
    li      $v0, 4           # Código do sistema para imprimir string
    la      $a0, buffer      # Carrega o endereço do buffer em $a0
    syscall                 # Chama a syscall

    # Fim do programa
    li      $v0, 10          # Código do sistema para encerrar o programa
    syscall                 # Chama a syscall
