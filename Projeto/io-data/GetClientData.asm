#Aten��o localArquivo e clienteData s�o alocados no main, execultar este c�digo separadamente n�o vai funcioonar
.text 
.globl GetClientData
GetClientData:

	#Abrindo arquivo para modo leitura
	li $v0,13 #Comando para solicitar abertura
	la $a0, get_localArquivo #Armazena endere�o do arquivo em $a0
	li $a1, 0 # 0 significa que o arquivo vai abrir para leitura, 1 para escrita
	syscall #o descritor do arquivo vai para $vo
	
	move $s0, $v0 # cria uma c�pia do descritor, $v0 vai ser usando novamente para outras coisas
	
	move $a0, $s0 #copia descritor para ser usando em $a0, � obrigat�rio usar $a0
	li $v0, 14 # ler o conte�do do arquivo que � referenciado por $a0
	la $a1, clientData #buffer que armazena o conte�do
	li $a2, 3200 # tamanho do buffer
	syscall #leitura realizada

	li $v0, 16 #comando para fechar o arquivo
	move $a0, $s0 # obrigat�rio o descritor estar em $a0
	syscall 
	
	move $v0, $a1
	jr $ra



	
