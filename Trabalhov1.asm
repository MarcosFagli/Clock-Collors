;Dados rferentes a utilização da biblioteca IRVINE retirado de: http://programming.msjc.edu/asm/help/index.html?page=source%2Fabout.htm
INCLUDE Irvine32.inc

.data
	tempo BYTE "TEMPO:", 0				;Nome do marcador de Tempo 
	pontuacao BYTE "PONTUACAO:", 0		;Nome do marcador de Pontuação
	biniciar BYTE "INICIAR",0			;Nome do botão para iniciar o jogo
	bcreditos BYTE "CREDITOS",0			;Nome do botão para os creditos
	bcomoJogar BYTE "COMO JOGAR",0		;Nome do botão para as instruções
	nome BYTE "CLOCK COLORS", 0			;Nome do Jogo
	time BYTE 0							;Armazena o tempo do jogo
	score BYTE 0						;Armazena a pontuação do jogo
	posSeta BYTE 0						;Armazena a posição da seta no menu 
	tMaxX BYTE 60						;Armazena a quantidade de colunas do ecrã do jogo
	tMaxY BYTE 26						;Armazena a quantidade de linhas do ecrã do jogo
	distPlat BYTE 5						;Armazena a distancia entre as plataformas
	platInicial WORD 8					;Armazena qual é a altura Y da plataforma mais alta
	
	;Os dados seguintes salvos na memória tem por objetivo armazenar o texto a ser exibido nas instrucões
	mInstrucoes1 BYTE "ESTE JOGO CONSITE EM GUIAR O ETEVALDO ATE A",0
	mInstrucoes2 BYTE "PLATAFORA MAIS ALTA QUE O JOGADOR CONSEGUIR CHEGAR",0
	mInstrucoes3 BYTE "EM 90 SEGUNDOS.",0
	
	mInstrucoes4 BYTE "NESSA AVENTURA O ETEVALDO SO PODE PULAR SE A",0 
	mInstrucoes5 BYTE "PLATAFORMA IMEDIATAMENTE ACIMA DELE ESTIVER COM",0 
	mInstrucoes6 BYTE "UMA DAS CORES SELECIONADAS.",0
	
	mInstrucoes7 BYTE "PARA CADA PLATAFORMA EXISTIRA OITO POSSIVEIS",0
	mInstrucoes8 BYTE "CORES, E NO TOTAL SERA SELECIONADA DUAS DESSAS CORES",0
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
	mcreditos3 BYTE "MINISTRADA PELO DOCENTE LUCIANO NERIS, NA UNIVERSIDADE",0
	mcreditos4 BYTE "FEDERAL DE SAO CARLOS - UFSCAR, COM ENTREGA NO",0	
	mcreditos5 BYTE "PRIMEIRO SEMESTRE DE 2017.",0
	
	mcreditos6 BYTE "PROJETO LICENCIADO POR GLP-3.0 E DISPONIVEL NO GITHUB",0
	mcreditos7 BYTE "EM: GITHUB.COM/MARCOSFAGLI/CLOCK-COLLORS",0
	
	mcreditos8 BYTE "DESENVOLVEDORES E MEMBROS DO GRUPO:",0			
	mcreditos9 BYTE "BRUNA ZAMITH SANTOS",0			
	mcreditos10 BYTE "RA 628093",0
	mcreditos11 BYTE "MARCOS AUGUSTO FAGLIONI JUNIOR",0			
	mcreditos12 BYTE "RA 628301",0
	
	
	
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
	
	mov dh, bh
	mov dl, bl
	inc dh
	dec dl
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
	
	mov dh, bh
	mov dl, bl
	sub dh, 1
	call GOTOXY
	
	mov al, ' '
	call WRITECHAR
	
	mov dl, bl
	dec dl
	mov dh, bh
	call GOTOXY
	
	mov ecx, 3
LDP1:
	mov al, ' '
	call WRITECHAR
	loop LDP1
	
	mov dh, bh
	mov dl, bl
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
	mov ebx, 6
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

TelaJogo PROC
;Imprime uma seta na posição desejada
;Recebe:	
;
;
;Retorna:										
	mov eax, red							;IRVINE red - Seleção de cores pré definidas no IRVINE
	call SETTEXTCOLOR						;IRVINE SETTEXTCOLOR - Seta a cor do texto e a cor do fundo da fonte
	mov dl, 9
	mov dh, 1
	call GOTOXY
	mov edx, OFFSET tempo
	call WRITESTRING
	mov dl, 21
	mov dh, 1
	call GOTOXY
	mov edx, OFFSET pontuacao
	call WRITESTRING
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
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
	mov dh, 8
	call GOTOXY
	mov edx, OFFSET mInstrucoes15
	call WRITESTRING
	mov dl, 5
	mov dh, 11
	call GOTOXY
	mov edx, OFFSET mInstrucoes16
	call WRITESTRING
	mov dl, 3
	mov dh, 12
	call GOTOXY
	mov edx, OFFSET mInstrucoes17
	call WRITESTRING
	mov dl, 5
	mov dh, 15
	call GOTOXY
	mov edx, OFFSET mInstrucoes18
	call WRITESTRING
	mov dl, 3
	mov dh, 16
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
	
	mov dl, 0
	mov dh, tMaxY
	call GOTOXY
	
LTC2:
    mov  eax, 50
    call Delay
    call ReadKey
    jz   LTC2
	
	ret
TelaCreditos ENDP

TempoTela PROC
;Imprime uma seta na posição desejada
;Recebe:	
;
;
;Retorna:	
	mov dl, 16
	mov dh, 1
	call GOTOXY
	movzx eax, time
	call WRITEDEC
	inc eax
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
	mov dl, 32
	mov dh, 1
	call GOTOXY
	movzx eax, score
	call WRITEDEC
	ret
ScoreTela ENDP


	
main PROC
	call CLRSCR								;IRVINE CLRSCR - Limpa a tela
start:
	call LimpaTela
	call Bordas
	call Plataformas
	call TelaInicio
	mov posSeta, 0
	
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
    call Delay           					; (otherwise, some key presses are lost)
    call ReadKey         					;Busca por entradas no teclado
    jz   AguardaTecla1      					;Nenhuma tecla pressionada ainda
	cmp  dx,000Dh  							;Compara a entrada do teclado com "enter"
	je LS1
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
	call LimpaTela	
	call Bordas
	call Plataformas
	call TelaJogo
	call ScoreTela
	call TempoTela
	
	
	mov bl, 15
	mov bh, 15
	call ImpPerso
	
	mov eax, 1000
	call DELAY
	call TempoTela
	
	mov bl, 15
	mov bh, 15
	call delPerso
	
	mov eax, 1000
	call DELAY
	call TempoTela
	
	
	jmp fim
	
instrucoes:
	call TelaInstrucoes
	jmp start
	
creditos:
	call TelaCreditos
	jmp start

fim:
	mov dl, 0
	mov dh, 17
	call GOTOXY
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	

exit
main ENDP
END main
