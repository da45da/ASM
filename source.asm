TITLE

; Name: 
; Date: 
; ID: 
; Description: 

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
    
	; data declarations go here

.code
main PROC
	
	mov ebx, 00000000h
	mov  bx,0FFFFh

and  bx,6Bh
	call DumpRegs ; displays registers in console
	exit

main ENDP
END main
