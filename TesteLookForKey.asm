INCLUDE Irvine32.inc
INCLUDE Macros.inc

.code
main PROC  ; Read and display each key until <Esc> is input.

    mWriteLn "  ASCII     Virtual-scan  Virtual-key   Keyboard flags"
    call Crlf

LookForKey:
    mov  eax,50          ; sleep, to allow OS to time slice
    call Delay           ; (otherwise, some key presses are lost)

    call ReadKey         ; look for keyboard input
    jz   LookForKey      ; no key pressed yet

    mShow  al,h
    mShow  ah,h
    mShow  dx,h
    mShow  ebx,hnn

    cmp    dx,VK_ESCAPE  ; time to quit?
    jne    LookForKey    ; no, go get next key.

    exit
main ENDP
END main