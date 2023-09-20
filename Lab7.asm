TITLE Lab7

; I confirm that I will keep the content of this assignment confidential. I confirm that I have not received any unauthorized assistance in preparing for or writing this assignment. I acknowledge that a mark of 0 may be assigned for copied work.
; Damian Attia-Barillas
; 110076913
; Due Nov 28, 2022
; This program 

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib


.data
    N DWORD 20 ; size of the array
    empty DWORD 1 ; variable used for checking if stack is empty or not
    Array DWORD 20 DUP(?) ; the Array
    temp DWORD ? ; needed for array size when adding in reverse order from stack
    poppingTmp DWORD ? ; will pop the return address when proc is called from stack
    tmp DWORD ?
    poppingPrint DWORD ? ; will pop the return address when proc is called from stack for printing
    ChooseOption DWORD 100
    GreetPrompt BYTE "0 create an Array || 1 move array to stack || 2 move stack to array || 3 reverse an Array || -1 exit", 10,13,10,13, "What do you want to do now? > ", 0
    sizeofN BYTE "What is the size N of Array? > ", 0
    valueArray BYTE "What are the ", 0
    valuesArray2 BYTE " values in Array? > ", 0
    printSize BYTE "Size of Array is N = ", 0
    printValue BYTE "Array = ", 0
    stackIs BYTE "Stack is ", 0
    beforeAtS BYTE " before ArrayToStack", 0
    afterAtS BYTE " after ArrayToStack", 0
    beforeStA BYTE " before StackToArray", 0
    afterStA BYTE " after StackToArray", 0
    beforeRev BYTE " before StackReverse", 0
    afterRev BYTE " after StackReverse", 0
    emptyStack BYTE "Stack is empty", 0
    notEmpty BYTE "Stack is not empty", 0
    errorStack BYTE "Error - Stack is empty: Cannot perform StackToArray", 0
    goodBye BYTE "Exiting assignment 7", 0
    invalidEntry BYTE "Invalid entry, please try again!", 0
    space BYTE " ", 0
    disp EQU <mov edx, offset>

.code
main PROC
    mainLoop::
       lea esi, Array
       disp GreetPrompt ; print greeting string
       call WriteString
       call ReadInt
       mov ChooseOption, eax
       call CRLF

       cmp ChooseOption, 0 ; if 0 is entered jump to CreateArray
       je CreateArray

       cmp ChooseOption, 1 ; if 1, ArrayToStack
       je ArrayToStack

       cmp ChooseOption, 2 ; if 2, StackToArray
       je StackToArray

       cmp ChooseOption, 3 ; if 3, StackReverse
       je StackReverse

       cmp ChooseOption, -1 ; if < -1, invalid
       jl Invalid

       cmp ChooseOption, 3 ; if > 3, invalid 
       jg Invalid

       cmp ChooseOption, -1  ; if -1, exit
       jne mainLoop
    disp goodBye 
    call WriteString
    call Crlf
    sub ebx, ebx ; clear ebx
    call DumpRegs ; call dumpregs
	exit
main ENDP

Invalid PROC ; will print invalid and then jump to beginning
    disp invalidEntry
    call WriteString
    call CRLF
    jmp mainLoop

Invalid ENDP

CreateArray PROC ; will create the Array given user input
    pop poppingTmp
    disp sizeofN
    call WriteString
    call ReadInt
    jo Invalid ; if overflow
    mov N, eax
    cmp eax, 1 ; if value < 1 
    jl Invalid
    cmp eax, 20 ; if value > 20
    jg Invalid

    ; else
    call Crlf
    mov ecx, N ; loop counter
    populate: ; fill array values
        disp valueArray
        call WriteString
        mov eax, N ; update the size of Array
        call WriteDec
        disp valuesArray2
        call WriteString
        call ReadInt ; take user input
        call Crlf
        mov [esi], eax
        add esi, 4
    loop populate

    disp printSize ; print size of array
    call WriteString
    mov eax, N ; mov size into eax
    call WriteDec ; print size of eax
    call Crlf
    
    mov esi, offset Array 
    disp printValue ; print string
    call WriteString 
    call PrintArray ; print values inside Array
    call Crlf
    call StackEmpty ; print whether stack is empty or not
    push poppingTmp 
    jmp mainLoop
CreateArray ENDP

PrintArray PROC ; print the array values
    pop poppingPrint
    mov ecx, N ; mov the size of Array into ecx
    print:
        mov eax, [esi] ; using esi as array incrementer
        call WriteDec ; print the value inside the array
        disp space
        call WriteString ; add a space
        add esi, TYPE Array
    loop print
    push poppingPrint
    ret
PrintArray ENDP

StackEmpty PROC ; check if stack is empty
    cmp empty, 1 ; 
    jne StackNotEmpty ; if not, jump to not empty prompt
    disp emptyStack
    call WriteString
    call Crlf
    call Crlf
    ret

    StackNotEmpty: 
        disp notEmpty
        call WriteString
        call CRLF
    call CRLF
    ret
StackEmpty ENDP

ArrayToStack PROC ; take values from array and push to stack
    pop poppingTmp
    
    disp printValue
    call WriteString
    call PrintArray
    disp beforeAtS
    call WriteString
    call Crlf

    mov ecx, N ; loop counter
    mov esi, offset Array ; move array to esi
    arrayLoop:
        push [esi] ; push to stack
        add esi, 4
    loop arrayLoop

    mov empty, 0 ; stack is full 

    disp printValue
    call WriteString
    call PrintArray ; print array values after moving
    disp afterAtS
    call WriteString
    call Crlf

    call StackEmpty ; check if stack is empty
    push poppingTmp
    jmp mainLoop
ArrayToStack ENDP

StackToArray PROC ; will move contents from stack back to array
    cmp empty, 1 ; if stack is empty
    je return
    jmp continue

    return:
        disp errorStack ; print error
        call WriteString
        call Crlf
        call Crlf
        jmp mainLoop ; jump to beginning of loop

    continue: ; else 
        pop poppingTmp
        disp stackIs
        call WriteString

        mov ecx, N ; move size into ecx
        mov esi, offset Array
        ; 4 * (N - 1) for making sure stack to array is not in reverse order
        mov eax, N ; move the size of Array into eax
        sub eax, 1 ; sub 1
        mov edx, 4
        mul edx ; multiply by 4
        mov temp, eax ; set the value of tmp to eax

        mov ecx, N ; loop
        add esi, temp ; mov value of tmp to esi reverse order

        moveToArray:
            pop eax ;; pop the value and store it into eax will also print stack
            call WriteDec
            disp space
            call WriteString
            mov [esi], eax 
            sub esi, 4 ; sub instead of add since order is reverse
        loop moveToArray

        disp beforeStA    
        call WriteString
        call Crlf
        disp printValue
        call WriteString

        mov esi, offset Array
        call PrintArray ; print values in Array
        disp afterStA
        call WriteString
        call CRLF
        mov empty, 1 ; stack is now empty
        call StackEmpty ; check if stack is empty
        push poppingTmp
        jmp mainLoop

StackToArray ENDP

StackReverse PROC ; will reverse the array
    pop poppingTmp
    disp printValue
    call WriteString
    call PrintArray
    call Crlf

    mov ecx, N ; counter for looping
    lea esi, offset Array ; move array 
    reverse:
        push[esi]  ; push values into stack
        add esi, 4
        loop reverse

    mov empty, 0 ; stack is now not empty
    call StackEmpty

    lea esi, offset Array ; move array contents
    mov ecx, N ; counter for looping
    reverse2:
        pop eax ; pop value from stack
        mov [esi], eax ; move value from esi to eax
        add esi, 4
        loop reverse2
    
    lea esi, Array
    disp printValue
    call WriteString
    call PrintArray ; print contents of Array
    call Crlf

    mov empty, 1 ; stack is not empty
    call StackEmpty ; check if it's empty
    push poppingTmp
    jmp mainLoop

StackReverse ENDP

END main
