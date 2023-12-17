.data
	buffer: .space 128    # buffer para armazenar a string de entrada
	mensagem_invalido: .asciiz "Comando inv�lido"
	
	msg_sonho: .asciiz "Funciona!!"
	msg_cadastro: .asciiz "Cadastro : \n"
	msg_formatar: .asciiz "Formatar : \n"
	msg_debito: .asciiz "Debito : \,"
	
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
	localArquivo: .asciiz "ClientData.txt"	
	clientData: .space 3200 #sempre coloque no final de .data, isso evita problema de invas�o/estouro de mem�ria
.text

.main:	
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
		j end_program
				
	conta_format:
		j imprime_teste
		j end_program
		
	debito_extrato:
		j imprime_teste
		j end_program
		
        credito_extrato:
        	j imprime_teste
        	j end_program
        
        transferir_debito:
        	j imprime_teste
        	j end_program
        
        transferir_credito:
       		j imprime_teste
        	j end_program
        
        pagar_fatura:
        	j imprime_teste
        	j end_program
        
        sacar:
        	j imprime_teste
        	j end_program
        
        depositar:
        	j imprime_teste
        	j end_program
        
        alterar_limite:
        	j imprime_teste
        	j end_program
        
        conta_fechar:
        	j imprime_teste
       		j end_program
        
        data_hora:
        	j imprime_teste
        	j end_program
        
        salvar:
        	j imprime_teste
        	j end_program
        
        recarregar:
        	j imprime_teste
        	j end_program
        
        formatar:
        	j imprime_teste
        	j end_program
        
        sair: 
        	j imprime_teste
        	syscall 
        	
       info:  #feito
       		jal Info
        	syscall 
          
        			
command_not_found:
        # Comando n�o encontrado, imprime mensagem e sai
        li $v0, 4
        la $a0, mensagem_invalido
        syscall
        la $a0, newline
	syscall	
        j end_program
        		      		
end_program:
    # Finaliza o programa
    li $v0, 10
    syscall
    
.include "string/strcmp.asm"
.include "functions/GetComand.asm"
.include "functions/SelectOptions.asm"
.include "functions/Cadastro.asm"
.include "functions/Info.asm"


imprime_teste:		
		li $v0, 4

		la $a0, msg_sonho  
		syscall	
		        		
        	la $a0, newline
		syscall	
		
        	la $a0, cmd_buffer
        	syscall 

		j end_program
