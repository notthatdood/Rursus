; Este programa va a tener las conversiones de otros tipos a Int
; Rutinas
    ; 1. Char a Int: Va a tomar el valor en ascii del caracter
    ; 2. Bool a Int: 1 si es verdadero 0 si es falso
    ; 3. File a Int: va a tomar el largo del nombre del archivo como el resultado
    ; 4. String a Int: va a tomar el largo del string como el resultado
    ; 5. Set a Int: va a tomar el tamaño del conjunto como resultado

datos segment

    char dw 'a'
    bool dw 1
    fileName db "filemon.txt",0
    string db "abcde$"
    set dw 1,2,3,4,5,6,7,8,9,0,11,12,13,14,15,16,17,85
    lenSet db 18
    Result dw 0
    Base dw 10
    len dw 0

datos endS

; estas dos macros son para no perder los valores en los registros durante un proc
popRegs macro
    pop dx
    pop cx
    pop bx
    pop ax
endm

pushRegs macro
    push ax
    push bx
    push cx
    push dx
endm

pila segment stack 'stack'
    dw 256 dup(?)
pila endS

codigo segment
    Assume CS:codigo,DS:datos,SS:pila

printAX proc 
; imprime a la salida estandar un numero que supone estar en el AX
; supone que es un numero positivo y natural en 16 bits.
; lo imprime en la base que indica la variable Base del Data Segment.  
    
    push AX
    push BX
    push CX                           
    push DX

    xor cx, cx
    mov bx, Base
ciclo1PAX: xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne ciclo1PAX
    mov ah, 02h
ciclo2PAX: pop DX
    add dl, 30h
    cmp dl, 39h
    jbe prnPAX
    add dl, 7
prnPAX: int 21h
    loop ciclo2PAX 

    pop DX
    pop CX
    pop BX
    pop AX
    ret
printAX endP

CamLin Proc
    push ax
    push dx
    mov dl, 13
    mov ah, 02h
    int 21h
    mov dl, 10
    int 21h
    pop dx
    pop ax
    ret
CamLin EndP

printZString proc
    ;imprime a la salida estandar un string en formato asciiz
    ;asume la dirección del string en si
    pushRegs
    contZPrint:
        mov dl, byte ptr [si]
        inc si
        mov ah, 02h
        int 21h
        cmp dl, 0
        jne contZPrint

    popRegs
    ret
printZString endP


zStringLen proc
    ;asume la dirección del string en si deja el resultado en len
    pushRegs
    xor cx, cx
    contZLen:
        inc cx
        mov al, byte ptr [si]
        inc si
        cmp al, 0
        jne contZLen
    dec cx
    mov len, cx
    popRegs
    ret
zStringLen endP

dStringLen proc
    ;asume la dirección del string en si deja el resultado en len
    pushRegs
    xor cx, cx
    contDLen:
        inc cx
        mov al, byte ptr [si]
        inc si
        cmp al, '$'
        jne contDLen
    dec cx
    mov len, cx
    popRegs
    ret
dStringLen endP

charToInt proc
    ; Va a tomar el valor del caracter en la tabla ascii y colocarlo en Result
    pushRegs
    mov ax, char
    mov Result, ax
    popRegs
    ret
charToInt endP

boolToInt proc
    ; Va a colocar en result un 1 si era verdadero y un 0 si no
    ; En realidad solo copia el valor del bool en Result que siempre va a ser 1 o 0
    pushRegs
    mov ax, bool
    mov Result, ax
    popRegs
    ret
boolToInt endP

fileToInt proc
    ; Va a colocar en result el largo del nombre del archivo
    ; Espera el nombre del archivo en la variable fileName
    pushRegs
    lea si, fileName
    call zStringLen
    mov ax, len
    mov Result, ax
    popRegs
    ret
fileToInt endP

stringToInt proc
    ; Deja en result el tamaño del string
    ; Espera el string en la variable llamada string
    pushRegs
    lea si, string
    call dStringLen
    mov ax, len
    mov Result, ax
    popRegs
    ret
stringToInt endP

setToInt proc
    ; Deja en result el tamaño del conjunto
    ; espera el tamaño del conjunto en lenSet
    pushRegs
    xor ax, ax
    mov al, lenSet
    mov Result, ax
    popRegs
    ret
setToInt endP


main: mov ax, pila
    mov ss, ax

    mov ax, datos
    mov ds, ax
    ;Cada "puñito" de instrucciones es una prueba, solo descomentar una a la vez para ver los resultados claramente

    ;call charToInt
    ;mov ax, Result
    ;call printAX
    
    ;call boolToInt
    ;mov ax, Result
    ;call printAX

    ;lea si, fileName
    ;call zStringLen
    ;mov ax, len
    ;call printAX

    ;lea si, string
    ;call dStringLen
    ;mov ax, len
    ;call printAX

    ;lea si, fileName
    ;call printZString

    ;call fileToInt
    ;mov ax, Result
    ;call printAX

    ;call stringToInt
    ;mov ax, Result
    ;call printAX

    ;call setToInt
    ;mov ax, Result
    ;call printAX

    mov ax, 4C00h
    int 21h 

codigo ends

end main