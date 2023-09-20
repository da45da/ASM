TITLE Lab1

; I confirm that I will keep the content of this assignment confidential. I confirm that I have not received any unauthorized assistance in preparing for or writing this assignment. I acknowledge that a mark of 0 may be assigned for copied work.: 
; Damian Attia-Barillas:  
; 110076913:
; Due Sept 23, 2022:
; This program does the required operations to run 7h + 3h - 2h and ouput the result as a hexadecimal number:

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.code
main PROC

	mov eax, 7h
    add eax, 3h
    sub eax, 2h
    
    call writehex
    ; writes the value in EAX as a hexadecimal number

	exit

main ENDP
END main
