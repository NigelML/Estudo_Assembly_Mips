.data
	buffer: .space 128    # buffer para armazenar a string de entrada
	mensagem_invalido: .asciiz "Comando inválido"
	msg_cadastro: .asciiz "Cadastro : "
	msg_formatar: .asciiz "Formatar : "
	msg_debito: .asciiz "Debito : "
	
	data_buffer: .space 128
	cmd_buffer: .space 16	
	cmd1: .asciiz "conta_cadastrar"
	cmd2: .asciiz "conta_format"
	cmd3: .asciiz "debito_extrato"
	
	#OBS: muitos dos dados alocados aqui vão ser usados em outras funções, caso execulte o arquivo contendo a função independentemente provavelmente ela não vai funcionar, sempre execulte o main
	#Atenção Se o mars.jar não estiver na mesma pasta que o arquivo txt é preciso inserir o caminho completo até chegar nele ex: C:/Users/_SEU-USUARIO_/Desktop/assembly-mars/texto.txt
	localArquivo: .asciiz "ClientData.txt"	
	clientData: .space 3200 #sempre coloque no final de .data, isso evita problema de invasão/estouro de memória
.text

.main:	
   # 1. Leitura da String de Entrada
    li $v0, 8            # código da syscall para ler string
    la $a0, buffer       # endereço do buffer
    li $a1, 128          # comprimento máximo da string
    syscall

    # 2. Identificação do Comando
    la $a0, buffer
    la $a1, cmd_buffer
    li $a2, 0

    command_loop:
        lb $t0, 0($a0)              
        beqz $t0, command_not_found  # Fim da string
        beq $t0, '-', get_data_buffer
        
        sb $t0, 0($a1)
        addi $a1, $a1, 1
        sb $zero, 0($a1)
                  
        addi $a0, $a0, 1

        j command_loop
  
get_data_buffer:
	la $a0, buffer
	la $a1, data_buffer
			
	find_data_loop: #encontra o inicio dos dados do comando
		lb $t0, 0($a0)
		beq $t0, '-', data_loop	      
        	addi $a0, $a0, 1
        
	j find_data_loop	
	
        #salva os dados
        #start_data_loop:       	
        data_loop:
        	lb $t0, 0($a0)
		beqz $t0, escolher_funcao  # Fim da string  
	
		sb $t0, 0($a1)
        	addi $a1, $a1, 1
        	sb $zero, 0($a1)   
        	addi $a0, $a0, 1 	
        j data_loop
                      
#Opões escolhidas pelos comandos--------------------------
escolher_funcao:
	la $a1 , cmd_buffer #vai ser passado como parametro para strcmp
	
	la $a0, cmd1 #segundo parametro para strcmp
	jal strcmp    
    	beqz $v0, conta_cadastrar
    	
    	la $a1 , cmd_buffer #tem que fazer isso novamente pois perde a referência
	la $a0, cmd2
	jal strcmp    
    	beqz $v0, conta_format
    	
    	la $a1 , cmd_buffer
	la $a0, cmd3
	jal strcmp    
    	beqz $v0, debito_extrato

    j command_not_found
	
#opções-------------------------
	conta_cadastrar:
		li $v0, 4
        	la $a0, msg_cadastro
        	syscall
        	li $v0, 4
        	la $a0, data_buffer #vai imprimir tudo colado(não tem \n)
		syscall 
		j end_program
		
	conta_format:
		li $v0, 4
        	la $a0, msg_formatar
        	syscall 
        	li $v0, 4
        	la $a0, data_buffer 
        	syscall 
		j end_program
		
	debito_extrato:
		li $v0, 4
        	la $a0, msg_debito
        	syscall 
        	li $v0, 4
        	la $a0, data_buffer
        	syscall 
        	j end_program
        			
command_not_found:
        # Comando não encontrado, imprime mensagem e sai
        li $v0, 4
        la $a0, mensagem_invalido
        syscall
        j end_program
        		
end_program:
    # Finaliza o programa
    li $v0, 10
    syscall
    
.include "string/strcmp.asm"

#COMANDOS
#conta_cadastrar-<option1>-<option2>-<option3>
#conta_format-<option1>
#debito_extrato-<option1>
#credito_extrato-<option1>
#transferir_debito-<option1>-<option2>-<option3>
#transferir_credito-<option1>-<option2>-<option3>
#pagar_fatura-<option1>-<option2>-<option3>
#sacar-<option1>-<option2>
#depositar-<option1>-<option2>
#alterar_limite-<option1>-<option2>
#conta_fechar-<option1>
#data_hora-<option1>-<option2>
#salvar
#recarregar
#formatar
