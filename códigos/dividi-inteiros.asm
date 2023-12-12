.text
	li $t0, 32 #Tamb�m s�o usandos nos exemplos de srl
	li $t1, 5
	
	div $t0, $t1 # Os Valores do resultado e do resto ficam em registradores especiais lo e hi.
	
	mflo $s0 # move o valor do resutado da divis�o, lo, para o registrador $s0.
	mfhi $s1 # move o valor do resto, hi, para $s1.
	
	#obs: estas s�o as �nicas maneiras de trabalhar com lo e hi,
	#nenhuma outra opera��o funciona com estes registradores especiais.
	
	#Shift Right Logical(divide por pot�ncias de 2)
	srl $s3, $t1 , 2 # � equivalente � $s3 = $t1/(2^2).
	srl $s4, $t0 , 4 # � equivalente � $s3 = $t1/(2^4).
	
	#obs : ele apenas armazena a parte INTEIRA da divis�o.
	#Ex: 5 / 4 = 1, o resto � ignorado.