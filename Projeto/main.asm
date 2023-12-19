.data
	buffer: .space 128    # buffer para armazenar a string de entrada	
	mensagem_invalido: .asciiz "Comando inv�lido"
	
	msg_sonho: .asciiz "Funciona!!"
	cpf_ja_cadastrado: .asciiz "CPF j� cadastrado\n"
	id_ja_cadastrado: .asciiz "ID j� cadastrado\n"
	
	cmd_buffer: .space 32	
	option_1: .space 32
	option_2: .space 32
	option_3: .space 32	
	
	data_buffer: .space 128
	salve_data_buffer: .space 128

		
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
	
	limite_credito_inicial: .asciiz "1500)"
	saldo_inicial: .asciiz "0000)"
	fatura_inicial: .asciiz "0000)"
	
	newline: .asciiz  "\n"
	ponto_virgula: .asciiz ";"
	
	#OBS: muitos dos dados alocados aqui v�o ser usados em outras fun��es, caso execulte o arquivo contendo a fun��o independentemente provavelmente ela n�o vai funcionar, sempre execulte o main
	#Aten��o Se o mars.jar n�o estiver na mesma pasta que o arquivo txt � preciso inserir o caminho completo at� chegar nele ex: C:/Users/_SEU-USUARIO_/Desktop/assembly-mars/dados.txt
	get_localArquivo: .asciiz "data/ClientData.txt"	
	set_localArquivo: .asciiz "data/ClientData_teste.txt"	
	clientData: .space 3200 #sempre coloque no final de .data, isso evita problema de invas�o/estouro de mem�ria
.text

.main:	
	jal GetClientData # pega os dados salvos em ClientData.txt
	#aten��o o local de leitura e escrita s�o diferentes apenas para testes, por isso existe um get_localArquivo e set_localArquivo, poderia estar tudo junto, mas por quest�es didaticas ficam separados
	main_loop:	
		
		jal GetComand #fun��o que separa os comandos dos dados
		jal GetOptionData # separa os dados cada um em um espa�o de mem�ria (option_1,2,3)
		
		jal SelectOptions #seleciona e chama o comando passado anteriormente para cmd_buffer
		j command_not_found # s� chega aqui caso n�o encontrar nenhum comando 
	
#op��es
	conta_cadastrar:
		la $a0, option_1
		jal FindData # verifica se o cpf ja existe em clientData
		beqz $v0, cpf_repetido	
					
		jal Cadastro
		j update_loop
				
	conta_format:
		
		j update_loop
		
	debito_extrato:
		
		j update_loop
		
        credito_extrato:
        	
        	j update_loop
        
        transferir_debito:
        	
        	j update_loop
        
        transferir_credito:
       		
        	j update_loop
        
        pagar_fatura:
        	
        	j update_loop
        
        sacar:
        	
        	j update_loop
        
        depositar:
        	
        	j update_loop
        
        alterar_limite:
        	
        	j update_loop
        
        conta_fechar:
        	
       		j update_loop
        
        data_hora:
        	
        	j update_loop
        
        salvar: #feito 
        	jal CountCharacters # conta o numero de caracteres em clientData
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
        	
       info:  #feito
       		jal Info
       		j update_loop 
       		 
       sair: #feito
        	j end_program   	
          
        			
command_not_found:
        # Comando n�o encontrado, imprime mensagem e retorna o loop
        li $v0, 4
        la $a0, mensagem_invalido
        syscall
        la $a0, newline
	syscall	
        j update_loop

formatar_salvar:
	jal Formatar # a fun��o Formatar apaga todos os dados no arquivo .txt
	j update_loop
j main_loop 
 
update_loop: #update limpa todos os buffers principais para evitar problema quando iniciar o loop
	# Limpar o buffers
	la $a0, buffer
	li $a1, 128	
	jal ClearBuffer
	
	la $a0, cmd_buffer
	li $a1, 32	
	jal ClearBuffer
	
	la $a0, option_1
	li $a1, 32	
	jal ClearBuffer
	
	la $a0, option_2
	li $a1, 32	
	jal ClearBuffer
	
	la $a0, option_3
	li $a1, 32	
	jal ClearBuffer
	
	la $a0, data_buffer
	li $a1, 128	
	jal ClearBuffer
	
	la $a0, salve_data_buffer
	li $a1, 128	
	jal ClearBuffer
j main_loop


cpf_repetido: #aviso caso cpf ou id sejam repetidos durante o cadastro
	li $v0, 4
	la $a0, cpf_ja_cadastrado
	syscall
	j update_loop
id_repetido:
	li $v0, 4
	la $a0, id_ja_cadastrado
	syscall
	j update_loop	 
	
	     		     		
end_program:
    # Finaliza o programa
    li $v0, 10
    syscall
    

#
# Fun��es Principais
#
.include "functions/SelectOptions.asm"
.include "functions/Cadastro.asm"
.include "functions/Info.asm"
.include "functions/Formatar.asm"
#
#Fun��es para Leitura e escrita de dados
#
.include "io-data/GetClientData.asm"
.include "io-data/SetClientData.asm"
#
#Fun�oes essenciais para o funcionamento das demais 
#
.include "tools/PrintFormattedData.asm"
.include "tools/CountCharacters.asm"
.include "tools/ClearClientData.asm"
.include "tools/ClearBuffer.asm"
.include "tools/CalculaDigitoID.asm"
.include "tools/GetComand.asm"
.include "tools/GetOptionData.asm"
.include "tools/FindData.asm"

.include "string/strcmp.asm"
.include "string/strcat.asm"
