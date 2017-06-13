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
	
.code

PrintSeta PROC
;Imprime uma seta na posição desejada
;Recebe:	
;
;
;Retorna:	
	push dx
	
	mov ax, 0
	mov al, posSeta
	mov dx, 3
	mul dx
	add ax, 5
	
	mov dl, 10								
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
	mov dx, 3
	mul dx
	add ax, 5
	
	mov dl, 10								
	mov dh, al
	call GOTOXY
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov al, '-'
	call WRITECHAR
	mov al, '>'
	call WRITECHAR
	
	mov dl, 0
	mov dh, 16
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
Bordas ENDP	
	
Plataformas PROC
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
Plataformas ENDP
	
TelaInicio PROC
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
	
	mov dl, 16								;Trecho para imprimir a opção Como jogar na tela principal
	mov dh, 8
	call GOTOXY
	mov edx, OFFSET bcomoJogar
	call WRITESTRING
	
	mov dl, 17								;Trecho para imprimir a opção creditos na tela principal
	mov dh, 11
	call GOTOXY
	mov edx, OFFSET bcreditos
	call WRITESTRING
	
	mov eax, white+(black*16)
	call SETTEXTCOLOR
	
	mov dl, 0
	mov dh, 16
	call GOTOXY
	
	ret
TelaInicio ENDP

TelaJogo PROC									
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

TelaIntrucoes PROC
	mov eax, white+(black*16)
	call SETTEXTCOLOR

	mov dl, 15								;Trecho para imprimir o nome do  jogo na tela principal
	mov dh, 2
	call GOTOXY
	mov edx, OFFSET nome
	call WRITESTRING
TelaIntrucoes ENDP
	
TempoTela PROC
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
TempoTela ENDP
	
ScoreTela PROC
	mov dl, 32
	mov dh, 1
	call GOTOXY
	movzx eax, score
	call WRITEDEC
	ret
ScoreTela ENDP


	
main PROC

start:
	call CLRSCR								;IRVINE CLRSCR - Limpa a tela
	call Bordas
	call Plataformas
	call TelaInicio
	
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
	call CLRSCR	
	call Bordas
	call Plataformas
	call TelaJogo
	call ScoreTela
	call TempoTela
	
	mov eax, 1000
	call DELAY
	call TempoTela
	jmp fim
	
instrucoes:
	call CLRSCR	
	call Bordas
	call Plataformas
	;call TelaInstrucoes
	call READCHAR
	jmp start
	
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
