.data
	espaco: .byte ' '
.text 
	li $v0, 5
	syscall 
	
	move $t0, $v0
	move $t1 , $zero
	
	loop: # label que ser� usada para salto, este nome (loop), n�o � obrigat�rio
		bgt $t1, $t0, end #faz a compara��o no come�o e salta se for necess�rio
		li $v0, 1
		move $a0, $t1
		syscall 
		
		li $v0, 4
		la $a0 , espaco
		syscall 
		
		addi $t1, $t1, 1
	j loop # comando para salto, usado para voltar ao inicio do loop
	
	end:
		li $v0, 10 # finaliza o programa, nesse caso n�o � necess�rio, coloquei apenas por exemplo
		syscall 
				