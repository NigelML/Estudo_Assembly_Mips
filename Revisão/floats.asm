.data
	msg: .asciiz "Digite um n�mero float "
	zero: .float 0.0
.text
	li $v0, 4
	la $a0, msg
	syscall 
	
	li $v0, 6 #valor para leitura de float, o valor vai para $f0
	syscall 
	
	lwc1 $f1, zero #lwc1 � usado para elementos de 32bits, equivalente � $f1 = 0.0
	add.s $f12, $f1, $f0 # somando floats, equivalenhte � $f12 = $f1 + $f0
	# obs: cambiarra necess�ria para passar o valor desejado para $f12, de outra forma ocorre erro
	#A impress�o de float imprime o valor armazenado em $f12 
	
	li $v0, 2 #chamada para imprimir floats
	syscall 