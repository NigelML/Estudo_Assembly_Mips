.data
	#OBS: muitos dos dados alocados aqui v�o ser usados em outras fun��es, caso execulte o arquivo contendo a fun��o independentemente provavelmente ela n�o vai funcionar, sempre execulte o main
	#Aten��o Se o mars.jar n�o estiver na mesma pasta que o arquivo txt � preciso inserir o caminho completo at� chegar nele ex: C:/Users/_SEU-USUARIO_/Desktop/assembly-mars/texto.txt
	localArquivo: .asciiz "ClientData.txt"	
	clientData: .space 3200 #sempre coloque no final de .data, isso evita problema de invas�o/estouro de mem�ria
.text

.main:	
	jal GetClientData #acessa localArquivo(,txt) e insere os dados em clientData		    	    
	
	jal PrintFormattedData #acessa clientData
	
	#jal SetClientData #acessa localArquivo(.txt) e salva os dados de clienData
	
	
	
end_program:
li $v0, 10
syscall




.include "GetClientData.asm"
.include "PrintFormattedData.asm"
.include "CountCharacters.asm"
.include "SetClientData.asm"

#empilha o valor altual de #$ra
#subi $sp, $sp, -4# necess�rio , pois quando uma fun��o chama outra $ra � sobrescrito e perde o retorno
#sw $ra, 0($sp) #-4 � apenas uma conven��o, ei li em um f�rum

#lw $ra, 0($sp)
#addi $sp, $sp, 4