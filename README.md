# Clock-Colors

Autores: Bruna Zamith Santos e Marcos Augusto Faglioni Junior

Trabalho executado na disciplina de Arquitetura e Organização de Computadores 2, com o objetivo de construir um jogo na linguagem Assembly utilizando a biblioteca Irvine e o montador MASM
Para mais detalhes quanto ao projeto e implementação, verificar os arquivos Relatorio_1 e Relatorio_2, o RelatórioFinal contém uma junção e algumas correções com relação aos anteriores, e este é a versão final do trabalho, e são os relatórios apresentados ao professor sobre o desenvolvimento do trabalho.	 
	
	-O método de leitura do teclado ou aguarda um tempo foi retirado de (exemplo retirado da biblioteca Irvine: http://programming.msjc.edu/asm/help/index.html?page=source%2Fabout.htm, acessado em 13/06/2017 as 10:30h):
		-Código das teclas utilizadas:

			Seta para cima:         ah = 48h     dx = 0026h
			Seta para baixo:        ah = 50h     dx = 0028h
			Seta para a esquerda:   ah = 4Bh     dx = 0025h
			Seta para a direita:    ah = 4Dh     dx = 0027h
			Enter:                  ah = 1Ch     dx = 000Dh

No arquivo TrabalhoFinalBrunaMarcos.zip existe o arquivo executavel do jogo, a pasta com o projeto acessável pelo Visual Studio e uma pasta MASM, para o montador do Windows.
