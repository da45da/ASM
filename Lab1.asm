TITLE Lab1

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
