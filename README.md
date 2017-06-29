# Clock-Collors
Trabalho executado na disciplina Arquitetura e Organização de Computadores 2 com o objetivo de construir um jogo na linguagem Assembly utilizando a biblioteca Irvine e o montador MASM
Para mais detalhes quanto ao projeto e implementação, verificar os arquivos Relatorio_1 e Relatorio_2, que são os relatórios apresentados ao professor sobre o desenvolvimento do trabalho.

Até a presente data 13/06, os arquivos Trabalhov1, TesteRandom, TesteLookForKey e TesteCor  não estão documentandos - até a finalização do projeto os arquivos dverão estar documentados (10/07/2017)
[Atualiazação (29/06/2017)] o Arquivo Trabalhov1 esta sendo documentado, assim, parte das funções devem ja ter sido documentadas- Sendo:

	-TesteRandom gera um número aleatório utilizando a biblioteca Irvine que gera um número pseudo-aleatório; 
	-O arquivo TesteCor invoca uma cor de um vetor de cores armazendos na memória, definidas na biblioteca Irvine;
	-O arquivo TesteLookForKey lê uma letra do teclado ou aguarda um tempo (exemplo retirado da biblioteca Irvine: http://programming.msjc.edu/asm/help/index.html?page=source%2Fabout.htm, acessado em 13/06/2017 as 10:30h):
		-Código das teclas utilizadas:

			Seta para cima:         ah = 48h     dx = 0026h
			Seta para baixo:        ah = 50h     dx = 0028h
			Seta para a esquerda:   ah = 4Bh     dx = 0025h
			Seta para a direita:    ah = 4Dh     dx = 0027h
			Enter:                  ah = 1Ch     dx = 000Dh

No arquivo Trabalhov1.rar existe o arquivo executavel do jogo, alguns navegadores e sistemas operacionais detectam virus em arquivos .exe, assim, caso deseje baixar somente o .exe, e sua plataforma não esteja liberando o download, baixe o Trabalhov1.rar, descompacte e execute o arquivo.
