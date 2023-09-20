TITLE

; This program demonstrates the assignment of registers using various means, including: single variables, constants, and arrays (both signed and unsigned, using direct-offset addressing).

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
b BYTE 255

.code
main PROC

; part 1
mov ebx, 1
mov edx, 0
mov eax, 1
mov ecx, 7

L1:
call DumpRegs
add edx, ebx 
mov ebx, eax  
mov eax, edx 
loop L1

; part 2
mov al, b; sets al with the max value of an unsigned byte
call DumpRegs
add al, 1; moves al one beyond the max value it can hold, setting the carry flag because an unsigned value is carried out of bounds
call DumpRegs
sub ax, ax; resets ax, clearing the carry flag because there can't be anything to carry in ax if we remove its stored value
call DumpRegs

exit

main ENDP
END main
