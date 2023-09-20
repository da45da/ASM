TITLE

; This program demonstrates the assignment of registers using various means, including: single variables, constants, and arrays (both signed and unsigned, using direct-offset addressing).

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data

; PART 1
val1 SDWORD 8
val2 SDWORD -15
val3 SDWORD 20

; PART 2
Uarray WORD 1000h,2000h,3000h,4000h
Sarray SWORD -1,-2,-3,-4


.code
main PROC
	
	; PART 1
	mov eax, 0			  ; EAX = 0h
	sub eax, val2		 ; EAX = F
	add eax, 7			  ; EAX = 16h
	sub eax, val3		 ; EAX = 2h
	add eax, val1		 ; EAX = Ah
	call DumpRegs

	; PART 2
	movzx eax, Uarray
	movzx ebx, Uarray+2
	movzx ecx, Uarray+4
	movzx edx, Uarray+6
	call DumpRegs

	movsx eax, Sarray
	movsx ebx, Sarray+2
	movsx ecx, Sarray+4
	movsx edx, Sarray+6
	call DumpRegs
	exit

main ENDP
END main
