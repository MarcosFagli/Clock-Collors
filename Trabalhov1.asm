;Dados rferentes a utilização da biblioteca IRVINE retirado de: http://programming.msjc.edu/asm/help/index.html?page=source%2Fabout.htm
INCLUDE Irvine32.inc

.data
	tempo BYTE "TEMPO:", 0				;Nome do marcador de Tempo 
	pontuacao BYTE "PONTUACAO:", 0		;Nome do marcador de Pontuação
	biniciar Byte "INICIAR",0			;Nome do botão para iniciar o jogo
	biniciari Byte "Pressione w",0		;Nome da informação de como acessar o inicio do jogo
	bcreditos Byte "CREDITOS",0			;Nome do botão para os creditos
	bcreditosi Byte "Pressione a",0		;Nome da  informação de como acessar os créditos
	bcomoJogar Byte "COMO JOGAR",0		;Nome do botão para as instruções
	bcomoJogari Byte "Pressione s",0		;Nome da informação de como acessar as instruções
	nome BYTE "CLOCK COLORS", 0			;Nome do Jogo
	time BYTE 0							;Armazena o tempo do jogo
	score BYTE 0						;Armazena a pontuação do jogo
	
.code
main PROC
	jmp start

Bordas:
	mov eax, red+(black*16)
	call SETTEXTCOLOR
	
	mov ecx, 41							;Trecho para impressão da primeira linha da matriz do jogo, imprime 41 "!"
	mov al, '!'
L1:
	call WRITECHAR
	loop L1

	mov ecx, 16							;Trecho para impressão dos limites laterais do Jogo, imprime 14 '!' de cada lado do inicio e fim da barra impressa anteriormente
	mov dh, 1
L2:
	mov dl, 0
	call GOTOXY							;IRVINE GOTOXY - Seta o cursor na coordenada(dh, dh)
	call WRITECHAR

	mov dl, 40
	call GOTOXY
	call WRITECHAR
	inc dh
	loop L2


	mov dl, 0								;Trecho para a impressão dos marcadores de tempo e pontuação
	mov dh, 16
	call GOTOXY
	mov ecx, 41
L3:
	call WRITECHAR
	loop L3
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	ret

Plataformas:
	mov dl, 1								;Trecho para imprimir as 4 plataformas existentes no jogo (loop aninhados)
	mov dh, 4
	call GOTOXY
	mov eax, green							;IRVINE green - Seleção de cores pré definidas no IRVINE
	call SETTEXTCOLOR
	mov ecx, 4
	mov ebx, 4
L5:
	mov dl, 1
	mov dh, bl
	call GOTOXY
	add bl, 3
	push ecx
	mov ecx, 39
L4:
	mov al, ':'
	call WRITECHAR
	loop L4

	pop ecx
	loop L5
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	ret

	
TelaInicio:
	mov eax, white+(black*16)
	call SETTEXTCOLOR

	mov dl, 15								;Trecho para imprimir o nome do  jogo na tela principal
	mov dh, 2
	call GOTOXY
	mov edx, OFFSET nome
	call WRITESTRING
	
	mov dl, 17								;Trecho para imprimir a opção iniciar na tela principal
	mov dh, 5
	call GOTOXY
	mov edx, OFFSET biniciar
	call WRITESTRING
	mov dl, 15								;Trecho para imprimir a opção iniciar na tela principal
	mov dh, 6
	call GOTOXY
	mov edx, OFFSET biniciari
	call WRITESTRING
	
	mov dl, 16								;Trecho para imprimir a opção Como jogar na tela principal
	mov dh, 8
	call GOTOXY
	mov edx, OFFSET bcomoJogar
	call WRITESTRING
	mov dl, 15								;Trecho para imprimir a opção Como jogar na tela principal
	mov dh, 9
	call GOTOXY
	mov edx, OFFSET bcomoJogari
	call WRITESTRING
	
	mov dl, 17								;Trecho para imprimir a opção creditos na tela principal
	mov dh, 11
	call GOTOXY
	mov edx, OFFSET bcreditos
	call WRITESTRING
	mov dl, 15								;Trecho para imprimir a opção creditos na tela principal
	mov dh, 12
	call GOTOXY
	mov edx, OFFSET bcreditosi
	call WRITESTRING
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 0
	mov dh, 16
	call GOTOXY
	
	ret
	

TelaJogo:									
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
	

TelaIntrucoes:
	mov eax, white+(black*16)
	call SETTEXTCOLOR

	mov dl, 15								;Trecho para imprimir o nome do  jogo na tela principal
	mov dh, 2
	call GOTOXY
	mov edx, OFFSET nome
	call WRITESTRING
	
TempoTela:
	mov dl, 16
	mov dh, 1
	call GOTOXY
	movzx eax, time
	call WRITEDEC
	inc eax
	mov time, al
	mov dl, 0
	mov dh, 16
	call GOTOXY
	ret
	
	
ScoreTela:
	mov dl, 32
	mov dh, 1
	call GOTOXY
	movzx eax, score
	call WRITEDEC
	ret
	

start:
	call CLRSCR								;IRVINE CLRSCR - Limpa a tela
	call Bordas
	call Plataformas
	call TelaInicio
	
	call READCHAR
	cmp al, 'w'
	je jogo
	cmp al, 'W'
	jne prox1
	
jogo:
	call CLRSCR	
	call Bordas
	call Plataformas
	call TelaJogo
	call ScoreTela
	call TempoTela
	
	mov eax, 1000
	call DELAY
	call TempoTela
	mov eax, 1000
	call DELAY
	call TempoTela
	mov eax, 1000
	call DELAY
	call TempoTela
	mov eax, 1000
	call DELAY
	call TempoTela
	mov eax, 1000
	call DELAY
	call TempoTela
	mov eax, 1000
	call DELAY
	call TempoTela
	mov eax, 1000
	call DELAY
	call TempoTela
	mov eax, 1000
	call DELAY
	call TempoTela
	mov eax, 1000
	call DELAY
	call TempoTela
	mov eax, 1000
	call DELAY
	call TempoTela
	mov eax, 1000
	call DELAY
	call TempoTela
	mov eax, 1000
	call DELAY
	call TempoTela
	mov eax, 1000
	call DELAY
	call TempoTela
	mov eax, 1000
	call DELAY
	call TempoTela
	mov eax, 1000
	call DELAY
	call TempoTela
	jmp fim
	
prox1:	
	cmp al, 's'
	je instrucoes
	cmp al, 'S'
	jne prox2
	
instrucoes:
	call CLRSCR	
	call Bordas
	call Plataformas
	;call TelaInstrucoes
	call READCHAR
	jmp start
	
prox2:
	cmp al, 'a'
	je creditos
	cmp al, 'A'
	jne prox2

creditos:
	call CLRSCR	
	call Bordas
	call Plataformas
	;call TelaCreditos
	call READCHAR
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