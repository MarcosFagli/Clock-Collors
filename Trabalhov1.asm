;Dados referentes a utilização da biblioteca IRVINE retirado de: http://programming.msjc.edu/asm/help/index.html?page=source%2Fabout.htm
;Este jogo refere-se ao trabalho final apresentado a disciplina de Laboratório de Arquitetura e Organização de Computadores do Deparatamento de Computação da Universidade Federal de São Carlos -  UFSCar
;Docente responsável: Professor Doutor Luciano Neris
;Autores:
;	Bruna Zamith Santos		Ra 628093
;	Marcos Augusto Faglioni Junior		Ra 628301
INCLUDE Irvine32.inc

.data
	cor BYTE "COR SORTEADA:",0			;Nome do marcador das cores selecionadas
	tempo BYTE "TEMPO:", 0				;Nome do marcador de Tempo 
	pontuacao BYTE "PONTUACAO:", 0		;Nome do marcador de Pontuação
	biniciar BYTE "INICIAR",0			;Nome do botão para iniciar o jogo
	bcreditos BYTE "CREDITOS",0			;Nome do botão para os creditos
	bcomoJogar BYTE "COMO JOGAR",0		;Nome do botão para as instruções
	nome BYTE "CLOCK COLORS", 0			;Nome do Jogo
	timeMax BYTE 90						;Armazena o tempo maximo de jogo
	time BYTE 90						;Armazena o tempo do jogo
	score BYTE 0						;Armazena a pontuação do jogo
	posSeta BYTE 0						;Armazena a posição da seta no menu 
	posSeta1 BYTE 0						;Armazena a posição da seta no menu 
	tMaxX BYTE 60						;Armazena a quantidade de colunas do ecrã do jogo
	tMaxY BYTE 26						;Armazena a quantidade de linhas do ecrã do jogo
	posXB BYTE 30						;Armazena a posição X do personagem
	posYB BYTE 24						;Armazena a posição Y do personagem
	distPlat BYTE 5						;Armazena a distancia entre as plataformas
	armadilhas BYTE 60 DUP(?)			;Armazena as coordenadas x das armadilhas (são 3 armadilhas por plataforma)
	platInicial WORD 8					;Armazena qual é a altura Y da plataforma mais alta
	cont BYTE 0							;Contador auxiliar para trocar as cores da plataforma
	contTime BYTE 0						;Contador auxiliar para o tempo
	coresDisp WORD yellow, blue, green, 
					cyan, red, magenta, 
					white, lightRed 	;Vetor de Cores Disponíveis para as plataformas (cores pre definidas pela biblioteca Irvine)
	corSele WORD 2 DUP(?)				;Vetor de cores sorteadas para as plataformas
	corPlatAtual WORD 1 DUP(?)			;Armazena a cor atual da plataforma imediatamente acima do personagem
	nArmadilhas BYTE 15					;Numero de armadilhas por plataforma
	
	;Os dados seguintes salvos na memória tem por objetivo armazenar o texto a ser exibido nas instrucões
	mInstrucoes1 BYTE "ESTE JOGO CONSISTE EM GUIAR O ETEVALDO ATE A",0
	mInstrucoes2 BYTE "PLATAFORMA MAIS ALTA QUE O JOGADOR CONSEGUIR CHEGAR",0
	mInstrucoes3 BYTE "EM 90 SEGUNDOS.",0
	
	mInstrucoes4 BYTE "NESSA AVENTURA, O ETEVALDO SO PODE PULAR SE A",0 
	mInstrucoes5 BYTE "PLATAFORMA IMEDIATAMENTE ACIMA DELE ESTIVER COM",0 
	mInstrucoes6 BYTE "UMA DAS DUAS CORES SORTEADAS.",0
	
	mInstrucoes7 BYTE "PARA CADA PLATAFORMA EXISTIRAO OITO POSSIVEIS",0
	mInstrucoes8 BYTE "CORES, E NO TOTAL SERAO SELECIONADAS DUAS DESSAS CORES",0
	mInstrucoes9 BYTE "QUE LIBERARAO A PASSAGEM DO ET PARA A PLATAFORMA ACIMA.",0
	
	mInstrucoes10 BYTE "ALEM DE RESPEITAR AS CORES, DEVE-SE TOMAR CUIDADO",0
	mInstrucoes11 BYTE "PARA QUE NAO PULE ONDE EXISTE UM BURACO BRANCO. ESTE",0
	mInstrucoes12 BYTE "LEVERA O ETEVALDO PARA OUTRA DIMENSAO, FAZENDO O",0
	mInstrucoes13 BYTE "JOGADOR PERDER.",0
	
	mInstrucoes14 BYTE "PARA GUIAR O ET NESSE JOGO BASTA:",0			
	mInstrucoes15 BYTE "-PRESSIONAR A SETA PARA CIMA PARA PULAR;",0			
	mInstrucoes16 BYTE "-PRESSIONAR AS SETAS PARA A DIREITA OU ESQUERDA",0
	mInstrucoes17 BYTE "PARA SE MOVIMENTAR LATERALMENTE;",0			
	mInstrucoes18 BYTE "-TAMBEM E POSSIVEL DAR SAIR DO JOGO A QUALQUER",0
	mInstrucoes19 BYTE "MOMENTO, PRESSIONANDO 'Q'.",0
	
	;Os dados seguintes salvos na memória tem por objetivo armazenar o texto a ser exibido nos crédito
	mcreditos1 BYTE "JOGO DESENVOLVIDO PARA A DISCIPLINA DE LABORATORIO DE",0
	mcreditos2 BYTE "ARQUITETURA E ORGANIZACAO DE COMPUTADORES, MINISTRADA",0
	mcreditos3 BYTE "PELO DOCENTE LUCIANO NERIS, NA UNIVERSIDADE FEDERAL",0
	mcreditos4 BYTE "DE SAO CARLOS - UFSCAR, COM ENTREGA NO PRIMEIRO",0	
	mcreditos5 BYTE "SEMESTRE DE 2017.",0
	
	mcreditos6 BYTE "PROJETO LICENCIADO POR GLP-3.0 E DISPONIVEL NO GITHUB",0
	mcreditos7 BYTE "EM: GITHUB.COM/MARCOSFAGLI/CLOCK-COLLORS",0
	
	mcreditos8 BYTE "DESENVOLVEDORES E MEMBROS DO GRUPO:",0			
	mcreditos9 BYTE "BRUNA ZAMITH SANTOS",0			
	mcreditos10 BYTE "RA 628093",0
	mcreditos11 BYTE "MARCOS AUGUSTO FAGLIONI JUNIOR",0			
	mcreditos12 BYTE "RA 628301",0
	
	;Dados para a tela de derrota
	mPerdeu1 BYTE "VOCE PERDEU!",0
	mPerdeu21 BYTE "VOCE FOI DESCUIDADO E O ETEVALDO SOFREU",0
	mPerdeu22 BYTE "COM AS CONSEQUENCIAS",0
	mPerdeu3 BYTE "SUA PONTUACAO: ",0
	mPerdeu4 BYTE "SEU TEMPO: ",0
	mPerdeu5 BYTE "JOGAR NOVAMENTE",0
	mPerdeu6 BYTE "SAIR",0

	;Dados para a tela de fim de jogo por tempo
	mPerdeuTempo1 BYTE "SEU TEMPO ACABOU!",0
	
.code
LimpaTela PROC
;Imprime uma seta na posição desejada
;Recebe:	
;
;
;Retorna:
	mov eax, black+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 0
	mov dh, 0
	call GOTOXY
	
	movzx ecx, tMaxY							
	
LLP1:					
	mov dl, 0
	mov dh, cl
	call GOTOXY
	
	push ecx
	
	movzx ecx, tMaxX
LLP2:
	mov al, ' '
	call WRITECHAR
	loop LLP2
	
	pop ecx
	loop LLP1
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 0								
	mov dh, 0
	call GOTOXY
	
	ret
LimpaTela ENDP

ImpPerso PROC
;Imprime o personagem na tela
;     @
;    /#\
;    / \
;Recebe: bl - Coordenada y (correspondente a coluna) que o personagem aparece, considere o centro do boneco (posição desejada do caracter '#')
;        bh - Coordenada x (correspondente a linha) que o personagem aparece, considere o centro do boneco (posição desejada do caracter '#')
;Retorna: Sem retorno
	mov eax, lightGreen+(black*16)
	call SETTEXTCOLOR
	
	mov dh, bh
	mov dl, bl
	sub dh, 1
	call GOTOXY
	
	mov al, '@'
	call WRITECHAR
	
	mov dl, bl
	dec dl
	mov dh, bh
	call GOTOXY
	
	mov al, '/'
	call WRITECHAR
	mov al, '#'
	call WRITECHAR
	mov al, '\'
	call WRITECHAR
	
	mov dl, bl
	dec dl
	mov dh, bh
	inc dh
	call GOTOXY
	
	mov al, '/'
	call WRITECHAR
	mov al, ' '
	call WRITECHAR
	mov al, '\'
	call WRITECHAR
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 0								
	mov dh, tMaxY
	call GOTOXY
	
	ret
ImpPerso ENDP


delPerso PROC
;Imprime uma seta na posição desejada
;Recebe:	
;
;
;Retorna:	
	mov eax, black+(black*16)
	call SETTEXTCOLOR
	
	mov dl, posXB
	mov dh, posYB
	dec dh
	call GOTOXY
	
	mov al, ' '
	call WRITECHAR
	
	mov dl, posXB
	dec dl
	mov dh, posYB
	call GOTOXY
	
	mov ecx, 3
LDP1:
	mov al, ' '
	call WRITECHAR
	loop LDP1
	
	mov dh, posYB
	mov dl, posXB
	inc dh
	dec dl
	call GOTOXY
	
	mov ecx, 3
LDP2:
	mov al, ' '
	call WRITECHAR
	loop LDP2
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 0								
	mov dh, tMaxY
	call GOTOXY
	
	ret
delPerso ENDP


PrintSeta PROC
;Imprime uma seta na posição desejada
;Recebe:	
;
;
;Retorna:	
	push dx
	
	mov ax, 0
	mov al, posSeta
	movzx dx, distPlat
	mul dx
	add ax, platInicial
	
	mov dl, 20								
	mov dh, al
	call GOTOXY
	
	mov eax, black+(black*16)
	call SETTEXTCOLOR
	
	mov al, ' '
	call WRITECHAR
	call WRITECHAR
	
	pop dx
	
	cmp dx, 0026h
	jne LPS1
	cmp posSeta, 0000h
	jbe LPS2
	dec posSeta
LPS1:	
	cmp dx, 0028h
	jne LPS2
	cmp posSeta, 0002h
	jae LPS2
	inc posSeta
LPS2:
	
	mov ax, 0
	mov al, posSeta
	movzx dx, distPlat
	mul dx
	add ax, platInicial
	
	mov dl, 20								
	mov dh, al
	call GOTOXY
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov al, '-'
	call WRITECHAR
	mov al, '>'
	call WRITECHAR
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
	ret
PrintSeta ENDP	

Bordas PROC
;Imprime uma seta na posição desejada
;Recebe:	
;
;
;Retorna:	
	mov eax, red+(black*16)
	call SETTEXTCOLOR
	
	movzx ecx, tMaxX							;Trecho para impressão da primeira linha da matriz do jogo, imprime tMaxX "!"
	mov al, '!'
L1:
	call WRITECHAR
	loop L1

	movzx ecx, tMaxY							;Trecho para impressão dos limites laterais do Jogo, imprime tMaxY '!' de cada lado do inicio e fim da barra impressa anteriormente
	mov dh, 1
L2:
	mov dl, 0
	call GOTOXY								;IRVINE GOTOXY - Seta o cursor na coordenada(dh, dh)
	call WRITECHAR

	mov dl, tMaxX
	dec dl
	call GOTOXY
	call WRITECHAR
	inc dh
	loop L2


	mov dl, 0								
	mov dh, tMaxY
	call GOTOXY
	movzx ecx, tMaxX
L3:
	call WRITECHAR
	loop L3
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	ret
Bordas ENDP	
	
Plataformas PROC
;Imprime uma seta na posição desejada
;Recebe:	
;
;
;Retorna:	
	mov eax, green							;IRVINE green - Seleção de cores pré definidas no IRVINE
	call SETTEXTCOLOR
	mov ecx, 4
	mov bx, platInicial
	sub bx, 2
LP1:
	mov dl, 1
	mov dh, bl
	call GOTOXY
	add bl, distPlat
	push ecx
	movzx eax, tMaxX
	sub eax, 2
	mov ecx, eax
LP2:
	mov al, ':'
	call WRITECHAR
	loop LP2

	pop ecx
	loop LP1
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	ret
Plataformas ENDP
	
TelaInicio PROC
;Imprime uma seta na posição desejada
;Recebe:	
;
;
;Retorna:	
	mov eax, white+(black*16)
	call SETTEXTCOLOR

	mov dl, 24								;Trecho para imprimir o nome do  jogo na tela principal
	mov dh, 3
	call GOTOXY
	mov edx, OFFSET nome
	call WRITESTRING
	
	movzx eax, platInicial
	mov dl, 26								;Trecho para imprimir a opção iniciar na tela principal
	mov dh, al 
	call GOTOXY
	mov edx, OFFSET biniciar
	call WRITESTRING
	
	add al, distPlat
	mov dl, 25								;Trecho para imprimir a opção Como jogar na tela principal
	mov dh, al
	call GOTOXY
	mov edx, OFFSET bcomoJogar
	call WRITESTRING
	
	add al, distPlat
	mov dl, 26								;Trecho para imprimir a opção creditos na tela principal
	mov dh, al
	call GOTOXY
	mov edx, OFFSET bcreditos
	call WRITESTRING
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
	ret
TelaInicio ENDP

SorteiaCores PROC
;Imprime uma seta na posição desejada
;Recebe:	
;
;
;Retorna:
    call Randomize              ;Sets seed
    mov  eax,9					;Keeps the range 0 - 8

    call RandomRange
    mov  corSele,ax            ;First random number

L1: mov  eax,9
	call RandomRange
    cmp ax, corSele          ;Checks if the second number is the same as the first
    je L1                   		;If it is, repeat call
    mov corSele[TYPE corSele],ax            ;Second random number
	
	;Salva primeira cor
	mov bx, corSele
	imul bx, TYPE corSele
	mov ax, [coresDisp + bx]
	mov corSele, ax
	
	;Salva segunda cor
	mov bx, corSele[TYPE corSele]
	imul bx, TYPE corSele
	mov ax, [coresDisp + bx]
	mov corSele[TYPE corSele], ax

	ret
SorteiaCores ENDP

ProcSetaDir PROC
;Imprime uma seta na posição desejada
;Recebe:	
;
;
;Retorna:
	movzx eax, tMaxX
	sub eax, 3
	cmp posXB, al
	jae fimProcDir
	
	call delPerso
	
	inc posXB
	mov bl, posXB
	mov al, tMaxY
	sub al, 2
	mov bh, al 
	call ImpPerso
	
fimProcDir:
	ret
ProcSetaDir ENDP

ProcSetaEsq PROC
;Imprime uma seta na posição desejada
;Recebe:	
;
;
;Retorna:
	cmp posXB, 2
	jbe fimProcEsq
	
	call delPerso
	
	dec posXB
	mov bl, posXB
	mov al, tMaxY
	sub al, 2
	mov bh, al 
	call ImpPerso
	
fimProcEsq:
	ret	
ProcSetaEsq ENDP

Colisao PROC
	movzx ecx, nArmadilhas
	mov edi, 0
	
L1:
	mov dl, armadilhas[edi]
	cmp dl, posXB
	je colidiu
	inc edi
	loop L1
	
	mov eax, 1
	jmp quit
	
colidiu:
	mov eax, 0
	
quit:
	ret
Colisao ENDP

PrcSetaCima PROC
;Imprime uma seta na posição desejada
;Recebe:	
;
;
;Retorna:
	call Colisao
	cmp eax, 0
	je diferente

	mov ax, corPlatAtual
	cmp ax, corSele
	je igual
	mov ax, corPlatAtual
	cmp ax, (corSele+2)
	jne diferente
	
	movzx ecx, nArmadilhas
	mov ebx, OFFSET armadilhas
	
igual:

	inc score
	call ApagaArm
	mov ebx, 0
	movzx eax, nArmadilhas
	mov edx, 3
	mul edx
	inc eax
	movzx edx, nArmadilhas
	mov ecx, eax
	
shiftByte:
	mov al, armadilhas[edx]
	mov armadilhas[ebx], al 
	inc edx
	inc ebx
	loop shiftByte
	
	
	movzx ecx, nArmadilhas
	mov edx, LENGTHOF armadilhas
	sub edx, ecx
L1:
	call Randomize             			;Sets seed
    movzx eax, tMaxX					;Keeps the range 0 - 8
	sub eax, 4
	
    call RandomRange
	inc al								;Incrementar para a armadilha não aparecer na lateral do jogo 
    mov  armadilhas[edx], al            ;First random number
	inc edx
	mov eax, 10
	call Delay
	loop L1
	
	call DesenhaArm
	
	mov eax, 1
	jmp fim
	
diferente:
	mov eax, 0

fim:
	ret
	
PrcSetaCima ENDP


TelaJogo PROC
;Imprime uma seta na posição desejada
;Recebe:	
;
;
;Retorna:	
	call LimpaTela	
	call Bordas
	call Plataformas
	call TempoTela
	call ScoreTela
	call CriaArmInicio

	mov eax, red							;IRVINE red - Seleção de cores pré definidas no IRVINE
	call SETTEXTCOLOR						;IRVINE SETTEXTCOLOR - Seta a cor do texto e a cor do fundo da fonte
	mov dl, 6
	mov dh, 1
	call GOTOXY
	mov edx, OFFSET tempo
	call WRITESTRING
	mov dl, 19
	mov dh, 1
	call GOTOXY
	mov edx, OFFSET pontuacao
	call WRITESTRING
	mov dl, 35
	mov dh, 1
	call GOTOXY
	mov edx, OFFSET cor
	call WRITESTRING
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov bl, posXB
	mov bh, posYB
	call ImpPerso
	
	call SorteiaCores
	call CorSelPlat
	
LTJ1:
	mov cont, 0
	inc contTime
	cmp contTime, 2
	jnae LTJ3
	call ScoreTela
	call TempoTela
	mov contTime, 0
LTJ3:
	call TrocaCorPlat
LTJ2:
	mov eax, 50
	inc cont
	cmp cont, 10
	ja LTJ1
	cmp time, 0
	jbe fimTempo
    call Delay
    call ReadKey
    jz LTJ2

	cmp  dx, 0026h
	je setaCima
	cmp dx, 0025h
	je setaEsq
	cmp dx, 0027h
	je setaDir
	cmp dx, 0051h
	je fimTelaJogo
	jmp LTJ2
	
setaCima:
	call PrcSetaCima
	cmp eax, 0
	je fimPerdeuObs					;Alterar para fimTelaJogo
	call CorSelPlat
	jmp LTJ2
	
setaEsq:
	call ProcSetaEsq
	jmp LTJ2
	
setaDir:
	call ProcSetaDir
	jmp LTJ2
	
fimPerdeuObs:
	mov eax, 0
	ret
	
fimTelaJogo:	
	mov eax, 1
	ret
	
fimTempo:
	mov eax, 2
	ret
TelaJogo ENDP

TelaInstrucoes PROC
;Imprime uma seta na posição desejada
;Recebe:	
;
;
;Retorna:	
LTI3:
	call LimpaTela
	call Bordas

	mov eax, green+(black*16)
	call SETTEXTCOLOR

	mov dl, 18
	mov dh, 2
	call GOTOXY
	
	mov edx, OFFSET nome
	call WRITESTRING
	
	mov al, '/'
	call WRITECHAR
	
	mov edx, OFFSET bcomoJogar
	call WRITESTRING
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 5
	mov dh, 4
	call GOTOXY
	mov edx, OFFSET mInstrucoes1
	call WRITESTRING
	mov dl, 3
	mov dh, 5
	call GOTOXY
	mov edx, OFFSET mInstrucoes2
	call WRITESTRING
	mov dl, 3
	mov dh, 6
	call GOTOXY
	mov edx, OFFSET mInstrucoes3
	call WRITESTRING
	
	mov dl, 5
	mov dh, 8
	call GOTOXY
	mov edx, OFFSET mInstrucoes4
	call WRITESTRING
	mov dl, 3
	mov dh, 9
	call GOTOXY
	mov edx, OFFSET mInstrucoes5
	call WRITESTRING
	mov dl, 3
	mov dh, 10
	call GOTOXY
	mov edx, OFFSET mInstrucoes6
	call WRITESTRING
	
	mov dl, 5
	mov dh, 12
	call GOTOXY
	mov edx, OFFSET mInstrucoes7
	call WRITESTRING
	mov dl, 3
	mov dh, 13
	call GOTOXY
	mov edx, OFFSET mInstrucoes8
	call WRITESTRING
	mov dl, 3
	mov dh, 14
	call GOTOXY
	mov edx, OFFSET mInstrucoes9
	call WRITESTRING

	mov dl, 5
	mov dh, 16
	call GOTOXY
	mov edx, OFFSET mInstrucoes10
	call WRITESTRING
	mov dl, 3
	mov dh, 17
	call GOTOXY
	mov edx, OFFSET mInstrucoes11
	call WRITESTRING
	mov dl, 3
	mov dh, 18
	call GOTOXY
	mov edx, OFFSET mInstrucoes12
	call WRITESTRING
	mov dl, 3
	mov dh, 19
	call GOTOXY
	mov edx, OFFSET mInstrucoes13
	call WRITESTRING
	
	movzx eax, tMaxX
	sub eax, 5
	mov dl, al	
	movzx eax, tMaxY
	sub eax, 2
	mov dh, al
	call GOTOXY
	
	mov eax, green+(black*16)
	call SETTEXTCOLOR
	
	mov al, '-'
	call WRITECHAR
	mov al, '>'
	call WRITECHAR
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
LTI1:
    mov  eax,50
    call Delay
    call ReadKey
    jz   LTI1
	cmp  dx, 0027h
	jne LTI1
	
	call LimpaTela
	call Bordas
	
	mov eax, green+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 18
	mov dh, 2
	call GOTOXY
	
	mov edx, OFFSET nome
	call WRITESTRING
	
	mov al, '/'
	call WRITECHAR
	
	mov edx, OFFSET bcomoJogar
	call WRITESTRING
	
	mov dl, 13
	mov dh, 4
	call GOTOXY
	mov edx, OFFSET mInstrucoes14
	call WRITESTRING
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 5
	mov dh, 7
	call GOTOXY
	mov edx, OFFSET mInstrucoes15
	call WRITESTRING
	mov dl, 5
	mov dh, 10
	call GOTOXY
	mov edx, OFFSET mInstrucoes16
	call WRITESTRING
	mov dl, 3
	mov dh, 11
	call GOTOXY
	mov edx, OFFSET mInstrucoes17
	call WRITESTRING
	mov dl, 5
	mov dh, 14
	call GOTOXY
	mov edx, OFFSET mInstrucoes18
	call WRITESTRING
	mov dl, 3
	mov dh, 15
	call GOTOXY
	mov edx, OFFSET mInstrucoes19
	call WRITESTRING
	
	mov dl, 3
	movzx eax, tMaxY
	sub eax, 2
	mov dh, al
	call GOTOXY
	
	mov eax, green+(black*16)
	call SETTEXTCOLOR
	
	mov al, '<'
	call WRITECHAR
	mov al, '-'
	call WRITECHAR
	
	movzx eax, tMaxX
	sub eax, 5
	mov dl, al	
	movzx eax, tMaxY
	sub eax, 2
	mov dh, al
	call GOTOXY
	
	mov al, '-'
	call WRITECHAR
	mov al, '>'
	call WRITECHAR
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY

LTI2:
    mov  eax,50
    call Delay
    call ReadKey
    jz   LTI2
	cmp  dx, 0025h
	je LTI3
	cmp dx, 0027h
	jne LTI2
	
	ret
TelaInstrucoes ENDP

TelaCreditos PROC
;Imprime uma seta na posição desejada
;Recebe:	
;
;
;Retorna:	
	call LimpaTela
	call Bordas

	mov eax, green+(black*16)
	call SETTEXTCOLOR

	mov dl, 18
	mov dh, 2
	call GOTOXY
	
	mov edx, OFFSET nome
	call WRITESTRING
	
	mov al, '/'
	call WRITECHAR
	
	mov edx, OFFSET bcreditos
	call WRITESTRING
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 5
	mov dh, 4
	call GOTOXY
	mov edx, OFFSET mcreditos1
	call WRITESTRING
	mov dl, 3
	mov dh, 5
	call GOTOXY
	mov edx, OFFSET mcreditos2
	call WRITESTRING
	mov dl, 3
	mov dh, 6
	call GOTOXY
	mov edx, OFFSET mcreditos3
	call WRITESTRING
	mov dl, 3
	mov dh, 7
	call GOTOXY
	mov edx, OFFSET mcreditos4
	call WRITESTRING
	mov dl, 3
	mov dh, 8
	call GOTOXY
	mov edx, OFFSET mcreditos5
	call WRITESTRING
	
	mov dl, 5
	mov dh, 10
	call GOTOXY
	mov edx, OFFSET mcreditos6
	call WRITESTRING
	mov dl, 3
	mov dh, 11
	call GOTOXY
	mov edx, OFFSET mcreditos7
	call WRITESTRING
	
	mov eax, green+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 12
	mov dh, 16
	call GOTOXY
	mov edx, OFFSET mcreditos8
	call WRITESTRING
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 3
	mov dh, 18
	call GOTOXY
	mov edx, OFFSET mcreditos9
	call WRITESTRING
	mov dl, 30
	mov dh, 19
	call GOTOXY
	mov edx, OFFSET mcreditos10
	call WRITESTRING
	mov dl, 3
	mov dh, 21
	call GOTOXY
	mov edx, OFFSET mcreditos11
	call WRITESTRING
	mov dl, 30
	mov dh, 22
	call GOTOXY
	mov edx, OFFSET mcreditos12
	call WRITESTRING
	
	movzx eax, tMaxX
	sub eax, 5
	mov dl, al	
	movzx eax, tMaxY
	sub eax, 2
	mov dh, al
	call GOTOXY
	
	mov eax, green+(black*16)
	call SETTEXTCOLOR
	
	mov al, '-'
	call WRITECHAR
	mov al, '>'
	call WRITECHAR
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
LTI1:
    mov  eax,50
    call Delay
    call ReadKey
    jz   LTI1
	cmp  dx, 0027h
	jne LTI1
	
	ret
TelaCreditos ENDP

SetaTelaPerdeu PROC
;Imprime uma seta na posição desejada
;Recebe:	
;
;
;Retorna:	
	push dx

	mov dl, 15
	mov dh, 18
	call GOTOXY
	mov eax, black+(black*16)
	call SETTEXTCOLOR
	mov al, ' '
	call WRITECHAR
	call WRITECHAR
	
	mov dl, 15
	mov dh, 21
	call GOTOXY
	mov eax, black+(black*16)
	call SETTEXTCOLOR
	mov al, ' '
	call WRITECHAR
	call WRITECHAR
	
	pop dx
	
	cmp dx, 0026h
	jne LPS1
	cmp posSeta1, 0000h
	jbe LPS2
	dec posSeta1
LPS1:	
	cmp dx, 0028h
	jne LPS2
	cmp posSeta1, 0001h
	jae LPS2
	inc posSeta1
LPS2:
	
	cmp posSeta1, 0
	je seta1
	mov dh, 21
	jmp setasai
seta1:	
	mov dh, 18
setasai:
	
	mov dl, 15
	call GOTOXY
	
	mov eax, green+(black*16)
	call SETTEXTCOLOR
	
	mov al, '-'
	call WRITECHAR
	mov al, '>'
	call WRITECHAR
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	ret
SetaTelaPerdeu ENDP

TelaPerdeu PROC
;Imprime uma seta na posição desejada
;Recebe:	
;
;
;Retorna:
	call LimpaTela
	call Bordas
	
	mov eax, green+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 23
	mov dh, 3
	call GOTOXY

	mov edx, OFFSET mPerdeu1
	call WRITESTRING
	
	mov dl, 15
	mov dh, 18
	call GOTOXY

	mov al, '-'
	call WRITECHAR
	mov al, '>'
	call WRITECHAR
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 10
	mov dh, 7
	call GOTOXY
	
	mov edx, OFFSET mPerdeu21
	call WRITESTRING
	
	mov dl, 19
	mov dh, 8
	call GOTOXY
	
	mov edx, OFFSET mPerdeu22
	call WRITESTRING
	
	mov dl, 22
	mov dh, 11
	call GOTOXY
	
	mov edx, OFFSET mPerdeu3
	call WRITESTRING
	
	movzx eax, score
	call WRITEDEC
	
	mov dl, 24
	mov dh, 13
	call GOTOXY
	
	mov edx, OFFSET mPerdeu4
	call WRITESTRING
	
	movzx eax, timemax
	sub al, time
	call WRITEDEC	
	
	mov dl, 22
	mov dh, 18
	call GOTOXY
	
	mov edx, OFFSET mPerdeu5
	call WRITESTRING
	
	mov dl, 27
	mov dh, 21
	call GOTOXY
	
	mov edx, OFFSET mPerdeu6
	call WRITESTRING
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
	ret
TelaPerdeu ENDP

TelaAcabaTempo PROC
;Imprime uma seta na posição desejada
;Recebe:	
;
;
;Retorna:
	call LimpaTela
	call Bordas
	
	mov eax, green+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 21
	mov dh, 6
	call GOTOXY

	mov edx, OFFSET mPerdeuTempo1
	call WRITESTRING
	
	mov dl, 15
	mov dh, 18
	call GOTOXY
	
	mov al, '-'
	call WRITECHAR
	mov al, '>'
	call WRITECHAR
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	
	mov dl, 22
	mov dh, 11
	call GOTOXY
	
	mov edx, OFFSET mPerdeu3
	call WRITESTRING
	
	movzx eax, score
	call WRITEDEC
	
	mov dl, 24
	mov dh, 13
	call GOTOXY
	
	mov edx, OFFSET mPerdeu4
	call WRITESTRING
	
	movzx eax, timemax
	call WRITEDEC	
	
	mov dl, 22
	mov dh, 18
	call GOTOXY
	
	mov edx, OFFSET mPerdeu5
	call WRITESTRING
	
	mov dl, 27
	mov dh, 21
	call GOTOXY
	
	mov edx, OFFSET mPerdeu6
	call WRITESTRING
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
	ret
TelaAcabaTempo ENDP

TempoTela PROC
;Imprime uma seta na posição desejada
;Recebe:	
;
;
;Retorna:	
	mov dl, 13
	mov dh, 1
	call GOTOXY
	movzx eax, time
	call WRITEDEC
	dec eax
	mov time, al
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	ret
TempoTela ENDP
	
ScoreTela PROC
;Imprime uma seta na posição desejada
;Recebe:	
;
;
;Retorna:	
	mov dl, 30
	mov dh, 1
	call GOTOXY
	movzx eax, score
	call WRITEDEC
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
	ret
ScoreTela ENDP

CorSelPlat PROC
;Imprime uma seta na posição desejada
;Recebe:	
;
;
;Retorna:	
	mov dl, 49
	mov dh, 1
	call GOTOXY

	movzx eax, corSele
	mov edx, 00000016
	mul edx
	call SETTEXTCOLOR
	
	mov al, ' '
	call WRITECHAR
	
	mov dl, 51
	mov dh, 1
	call GOTOXY
	
	movzx eax, (corSele+2)
	mov edx, 00000016
	mul edx
	call SETTEXTCOLOR
	
	mov al, ' '
	call WRITECHAR
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY

	ret
CorSelPlat ENDP
	
ApagaArm PROC
	mov eax, black+(black*16)							;IRVINE green - Seleção de cores pré definidas no IRVINE
	call SETTEXTCOLOR

	mov ecx, 4
	mov bx, 21
	sub bx, 2
	mov esi, 0
	
LP1:
	mov dh, bl
	push ecx
	
	movzx ecx, nArmadilhas
	
LP2:
	mov dl,armadilhas[esi]
	call GOTOXY
	inc esi
	mov al, ' '
	call WRITECHAR
	loop LP2

	pop ecx
	sub bl, distPlat
	loop LP1
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
	ret
ApagaArm ENDP	
	
DesenhaArm PROC
	mov eax, white+(black*16)							;IRVINE green - Seleção de cores pré definidas no IRVINE
	call SETTEXTCOLOR

	mov ecx, 4
	mov bx, 21
	sub bx, 2
	mov esi, 0
	
LP1:
	mov dh, bl
	push ecx
	
	movzx ecx, nArmadilhas
	
LP2:
	mov dl,armadilhas[esi]
	call GOTOXY
	inc esi
	mov al, '&'
	call WRITECHAR
	loop LP2

	pop ecx
	sub bl, distPlat
	loop LP1
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
	ret
DesenhaArm ENDP

CriaArmInicio PROC
	mov ecx, LENGTHOF armadilhas
	mov ebx, 0
L1:
	call Randomize             			;Sets seed
    movzx eax, tMaxX					;Keeps the range 0 - 8
	sub eax, 4
	
    call RandomRange
	inc al
    mov  armadilhas[ebx], al            ;First random number
	inc ebx
	mov eax, 10
	call Delay
	loop L1
	
	call DesenhaArm
	
	ret
CriaArmInicio ENDP


TrocaCorPlat PROC
	call Randomize              ;Sets seed
    mov  eax, 9					;Keeps the range 0 - 8

    call RandomRange
	imul ax, TYPE coresDisp
	mov bx, [coresDisp + ax]	
	
	mov corPlatAtual, bx

	movzx eax, bx
	call SETTEXTCOLOR

	mov al, tMaxY
	sub al, 5
	mov dl, 1
	mov dh, al
	call GOTOXY

	movzx eax, tMaxX
	sub eax, 2
	mov ecx, eax	
LTCP1:
	mov al, ':'
	call WRITECHAR
	loop LTCP1
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
	ret
TrocaCorPlat ENDP
	
main PROC
	call CLRSCR								;IRVINE CLRSCR - Limpa a tela
start:
	call LimpaTela
	call Bordas
	call Plataformas
	call TelaInicio
	mov posSeta, 0
	mov posSeta1, 0
	mov time, 90
	mov score, 0
	
	mov dl, 20							
	mov dh, BYTE PTR [platInicial]
	call GOTOXY
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR

	mov al, '-'
	call WRITECHAR
	mov al, '>'
	call WRITECHAR
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
AguardaTecla1:
    mov  eax,50          					;Tempo para o SO esperar
    call Delay           					;(otherwise, some key presses are lost)
    call ReadKey         					;Busca por entradas no teclado
    jz   AguardaTecla1      				;Nenhuma tecla pressionada ainda
	cmp  dx,000Dh  							;Compara a entrada do teclado com "enter"
	je LS1
	cmp dx, 0051h
	je fim
	call PrintSeta
    jne  AguardaTecla1    					;Se a tecla não for enter, volta para o label AguardaTecla1
	
LS1:
	cmp posSeta, 0000h
	je jogo
	cmp posSeta, 0001h
	je instrucoes
	cmp posSeta, 0002h
	je creditos
	
jogo:
	call TelaJogo
	cmp eax, 0
	je fim1
	cmp eax, 1
	je start
	cmp eax, 2
	je fim2
	jmp start
	
instrucoes:
	call TelaInstrucoes
	jmp start
	
creditos:
	call TelaCreditos
	jmp start

	
fim1:
	call TelaPerdeu
AguardaTecla2:
    mov  eax,50
    call Delay 
    call ReadKey
    jz   AguardaTecla2
	cmp  dx,000Dh
	je saiAguardaTecla2
	call SetaTelaPerdeu
    jne  AguardaTecla2
saiAguardaTecla2:
	cmp posSeta1, 0
	je start
	jmp fim

	
fim2:
	call TelaAcabaTempo
AguardaTecla3:
    mov  eax,50
    call Delay 
    call ReadKey
    jz   AguardaTecla3
	cmp  dx,000Dh
	je saiAguardaTecla3
	call SetaTelaPerdeu
    jne  AguardaTecla3
saiAguardaTecla3:
	cmp posSeta1, 0
	je start
	jmp fim
	
fim:
	movzx eax, tMaxY
	inc eax
	mov dl, 0
	mov dh, al 
	call GOTOXY
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	exit
main ENDP
END main
