TITLE Lab6

; This program generates and displays 20 random strings of length 10

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data 
ranNum BYTE 10 DUP (?), 0

.code

main PROC
mov ecx, 20

L1:
    call Randomize      ; seed the random generator
    push ecx
    mov ecx, 10       ; set ecx counter for inner loop
    mov esi, OFFSET ranNum

    L2:
        mov eax, 26
        call RandomRange ; random range for range from 65-86 which is ASCII for all capital letters
        add eax, 'A'
        mov [esi], eax
        inc esi ; increment esi so previous character is not removed
        loop L2

    mov edx, OFFSET ranNum
    call WriteString
    call Crlf ; newline

    pop ecx
    loop L1
	exit

main ENDP
END main
