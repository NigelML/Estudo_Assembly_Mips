.data
	.eqv BASE_MMIO 0xffff0000
	# Registrador de Controle do Transmissor (Bit de Pronto)
	.eqv RCT 0x0008
	.eqv CONTROLE_TRANSMISSOR RCT($s0)

	# Registrador de Dados do Transmissor (Tecla Exibida - ASCII)
	.eqv RDT 0x000c
	.eqv DADOS_TRANSMISSOR RDT($s0)
	
	# Registrador de Controle do Receptor (Bit de Pronto)
	.eqv RCR 0x0000
	.eqv CONTROLE_RECEPTOR RCR($s0)

	# Registrador de Dados do Receptor (Tecla Pressionada - ASCII)
	.eqv RDR 0x0004
	.eqv DADOS_RECEPTOR RDR($s0)
.text
.globl main

main:
	li $s0, BASE_MMIO # Obtém o endereço base da área MMIO

	loop_esperaTecla:
		lw $t0, CONTROLE_RECEPTOR # Obtém o registrador de controle do receptor
		andi $t0, $t0, 1 # Isola o bit de pronto
		beq $t0, $zero, loop_esperaTecla # A tecla está disponível? Se não, loop

		lbu $a0, DADOS_RECEPTOR # Obtém o valor da tecla

	loop_esperaExibicao:
		lw $t1, CONTROLE_TRANSMISSOR # Obtém o registrador de controle do transmissor
		andi $t1, $t1, 1 # Isola o bit de pronto
		beq $t1, $zero, loop_esperaExibicao # A exibição está pronta? Se não, loop

		sb $a0, DADOS_TRANSMISSOR # Envia a tecla para a exibição

		li $v0, 11
		syscall  #syscall pode ser ignorado, ja que não vai usar o console padrão
		#se manter o syscall vai atualizar nas duas telas de saída
j loop_esperaTecla
