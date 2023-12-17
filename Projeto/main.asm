.data
	buffer: .space 128    # buffer para armazenar a string de entrada
	mensagem_invalido: .asciiz "Comando inv�lido"
	
	msg_sonho: .asciiz "Funciona!!"
	
	cmd_buffer: .space 32
		
	cmd1: .asciiz "conta_cadastrar"
	cmd2: .asciiz "conta_format"
	cmd3: .asciiz "debito_extrato"
	cmd4: .asciiz "credito_extrato"
	cmd5: .asciiz "transferir_debito"
	cmd6: .asciiz "transferir_credito"
	cmd7: .asciiz "pagar_fatura"
	cmd8: .asciiz "sacar"
	cmd9: .asciiz "depositar"
	cmd10: .asciiz "alterar_limite"
	cmd11: .asciiz "conta_fechar"
	cmd12: .asciiz "data_hora"
	cmd13: .asciiz "salvar"
	cmd14: .asciiz "recarregar"
	cmd15: .asciiz "formatar"
	cmd16: .asciiz "sair"
	cmd17: .asciiz "info"
	
	newline: .asciiz  "\n"
	
	#OBS: muitos dos dados alocados aqui v�o ser usados em outras fun��es, caso execulte o arquivo contendo a fun��o independentemente provavelmente ela n�o vai funcionar, sempre execulte o main
	#Aten��o Se o mars.jar n�o estiver na mesma pasta que o arquivo txt � preciso inserir o caminho completo at� chegar nele ex: C:/Users/_SEU-USUARIO_/Desktop/assembly-mars/texto.txt
	get_localArquivo: .asciiz "data/ClientData.txt"	
	set_localArquivo: .asciiz "data/ClientData_teste.txt"	
	clientData: .space 3200 #sempre coloque no final de .data, isso evita problema de invas�o/estouro de mem�ria
.text

.main:	
	main_loop:
		jal GetClientData	
		#jal PrintFormattedData		
	
		#j end_program
		# 1. Leitura da String de Entrada
		li $v0, 8            # c�digo da syscall para ler string
		la $a0, buffer       # endere�o do buffer
		li $a1, 128          # comprimento m�ximo da string
		syscall
	
		la $a0, buffer ## provavelmente NESTE(NESTE!!!) caso nem precise, pois $a0 ja aponta para buffer, mas assim fica mais f�cil de entender
		la $a1, cmd_buffer
		jal GetComand
	
		la $a0, cmd_buffer
		jal SelectOptions

		j command_not_found#s� entra aqui se nenhuma op��o for selecionada
	
#op��es
	conta_cadastrar:
		jal Cadastro
		j update_loop
				
	conta_format:
		j imprime_teste
		j update_loop
		
	debito_extrato:
		j imprime_teste
		j update_loop
		
        credito_extrato:
        	j imprime_teste
        	j update_loop
        
        transferir_debito:
        	j imprime_teste
        	j update_loop
        
        transferir_credito:
       		j imprime_teste
        	j update_loop
        
        pagar_fatura:
        	j imprime_teste
        	j update_loop
        
        sacar:
        	j imprime_teste
        	j update_loop
        
        depositar:
        	j imprime_teste
        	j update_loop
        
        alterar_limite:
        	j imprime_teste
        	j update_loop
        
        conta_fechar:
        	j imprime_teste
       		j update_loop
        
        data_hora:
        	j imprime_teste
        	j update_loop
        
        salvar: #feito #precisa de alguns testes
        	jal CountCharacters
        	beqz  $v0 formatar_salvar # se clientData = 0 significa que foi usado o comando formatar
        	jal SetClientData
        	j update_loop
        
        recarregar: #"feito" ainda precisa de mais testes
        	jal ClearClientData
        	jal GetClientData        	
        	j update_loop
        
        formatar: #feito    	
        	jal ClearClientData #apaga os dados do buffer clienteData, mas n�o muda o arquivo txt  	
        	j update_loop
        
        sair: #feito
        	j end_program 
        	
       info:  #feito
       		jal Info
       		j update_loop    	
          
        			
command_not_found:
        # Comando n�o encontrado, imprime mensagem e sai
        li $v0, 4
        la $a0, mensagem_invalido
        syscall
        la $a0, newline
	syscall	
        j update_loop

formatar_salvar:
	jal Formatar
	j end_program  

update_loop:
	# Limpar o buffer
	la $t0, buffer       # endere�o do buffer
	li $t1, 128          # comprimento m�ximo do buffer

	clear_buffer_loop:
    	sb $zero, 0($t0)   # escreve zero no byte atual do buffer
    	addi $t0, $t0, 1   # move para o pr�ximo byte
    	addi $t1, $t1, -1  # decrementa o contador
    	bnez $t1, clear_buffer_loop  # repete at� que todos os bytes sejam zerados
j main_loop

 		      		
end_program:
    # Finaliza o programa
    li $v0, 10
    syscall
    
.include "string/strcmp.asm"
.include "functions/GetComand.asm"
.include "functions/SelectOptions.asm"
.include "functions/Cadastro.asm"
.include "functions/Info.asm"
.include "functions/Formatar.asm"
.include "io-data/GetClientData.asm"
.include "io-data/SetClientData.asm"
.include "tools/PrintFormattedData.asm"
.include "tools/CountCharacters.asm"
.include "tools/ClearClientData.asm"


imprime_teste:	# essa parte � apenas para testes	
		li $v0, 4

		la $a0, msg_sonho  
		syscall	
		        		
        	la $a0, newline
		syscall	
		
        	la $a0, cmd_buffer
        	syscall 

		j end_program
