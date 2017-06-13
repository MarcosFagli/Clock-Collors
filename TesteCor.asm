;Dados rferentes a utilização da biblioteca IRVINE retirado de: http://programming.msjc.edu/asm/help/index.html?page=source%2Fabout.htm
INCLUDE Irvine32.inc

.data
	coresDisp WORD white, yellow, blue

.code
main PROC

	mov esi, offset coresDisp
	mov eax, [esi+4]
	call SETTEXTCOLOR
	
	
exit
main ENDP
END main