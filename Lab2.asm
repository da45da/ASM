TITLE Lab2

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

greet EQU <"Hello there",0>
disp EQU <mov edx, offset>
lving TEXTEQU <"Farewell",0>

.data

; part 1

b BYTE 32d
sb SBYTE -42
w WORD 400
sw SWORD -420h
d DWORD 0AFh
sd SDWORD -32Ah
q QWORD 1000000d
sq SQWORD -1000001d

; part 2

start BYTE greet
closure BYTE lving

.code
main PROC

	disp start
	call writestring
	
	disp closure
	call writestring
; Writes the string literals defined using EQU and TEXTEQU

	exit

main ENDP
END main
