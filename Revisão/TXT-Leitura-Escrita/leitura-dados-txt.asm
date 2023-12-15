.data
	#Aten��o Se o mars.jar n�o estiver na mesma pasta que o arquivo txt � preciso inserir o caminho completo at� chegar nele ex: C:/Users/_SEU-USUARIO_/Desktop/assembly-mars/texto.txt
	localArquivo: .asciiz "texto.txt"
	conteudo: .space 1024
	
.text 
	#Abrindo arquivo para modo leitura
	li $v0,13 #Comando para solicitar abertura
	la $a0, localArquivo #Armazena endere�o do arquivo em $a0
	li $a1, 0 # 0 significa que o arquivo vai abrir para leitura, 1 para escrita
	syscall #o descritor do arquivo vai para $vo
	
	move $s0, $v0 # cria uma c�pia do descritor, $v0 vai ser usando novamente para outras coisas
	
	move $a0, $s0 #copia descritor para ser usando em $a0, � obrigat�rio usar $a0
	li $v0, 14 # ler o conte�do do arquivo que � referenciado por $a0
	la $a1, conteudo #buffer que armazena o conte�do
	li $a2, 1024 # tamanho do buffer
	syscall #leitura realizada
	
	#imprimir arquivo
	li $v0,4
	move $a0, $a1 #conte�do foi salvo em $a1 e precisa ser passado para $a0 para imprimir
	syscall 
	
	li $v0, 16 #comando para fechar o arquivo
	move $a0, $s0 # obrigat�rio o descritor estar em $a0
	syscall 
	
