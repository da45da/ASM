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
    array DWORD 1, 2, 3, 4, 5

.code
main PROC
	lea esi, OFFSET array
    mov eax, 0
    mov ecx, 4

    L1:
    add eax, [esi]
    add esi, 4
    loop L1

    call DumpRegs

	exit

main ENDP
END main
