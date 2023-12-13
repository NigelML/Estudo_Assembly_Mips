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
	li $s0, BASE_MMIO # Obt�m o endere�o base da �rea MMIO

	loop_esperaTecla:
		lw $t0, CONTROLE_RECEPTOR # Obt�m o registrador de controle do receptor
		andi $t0, $t0, 1 # Isola o bit de pronto
		beq $t0, $zero, loop_esperaTecla # A tecla est� dispon�vel? Se n�o, loop

		lbu $a0, DADOS_RECEPTOR # Obt�m o valor da tecla

	loop_esperaExibicao:
		lw $t1, CONTROLE_TRANSMISSOR # Obt�m o registrador de controle do transmissor
		andi $t1, $t1, 1 # Isola o bit de pronto
		beq $t1, $zero, loop_esperaExibicao # A exibi��o est� pronta? Se n�o, loop

		sb $a0, DADOS_TRANSMISSOR # Envia a tecla para a exibi��o

		li $v0, 11
		syscall  #syscall pode ser ignorado, ja que n�o vai usar o console padr�o
		#se manter o syscall vai atualizar nas duas telas de sa�da
j loop_esperaTecla
