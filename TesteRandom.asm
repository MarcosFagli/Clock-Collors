Include Irvine32.inc
.data
myInt DWORD ?
myChar BYTE ?
myStr BYTE 30 dup(0)
myPrompt BYTE "Enter a string:",0
myPrompt2 BYTE "Enter a number:",0
.code
main proc
 ; Output 2 random numbers
 call Randomize ; Only call randomize once
 call Random32
 call WriteInt ; output EAX as int
 call Crlf
 mov ax, 1000
 call RandomRange
 call WriteInt ; output EAX as int, will be 0-999
 call Crlf
 
 exit
main endp
end main 