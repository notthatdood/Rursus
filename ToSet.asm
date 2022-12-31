; Este programa va a tener las conversiones de otros tipos a Set
; Rutinas
    ; 1. Char a Set: Va a crear un conjunto con el caracter como único elemento
    ; 2. Bool a Set: Va a crear un conjunto con 1 o 0 como único elemento
    ; 3. File a Set: Va a crear un conjunto con las letras del nombre del archivo
    ; 4. String a Set: Va a crear un conjunto con las letras del string
    ; 5. Int a Set: Va a crear un conjunto con el enteo como único elemento

datos segment

    char dw 'a'
    bool dw 1
    integer dw 15
    string db "abcde$"
    fileName db "filemon.txt",0
    Result dw 128 dup('$')
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
    ; imprime a la salida estándar un número que supone estar en el AX
    ; supone que es un número positivo y natural en 16 bits.
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

;imprime un conjunto, asume que el puntero al conjunto está en si 
printSet Proc
    pushRegs
    push si

    mov ax, word ptr[si]
    cmp al, '$'
    je endPS
    call printAX

    contPS:
    inc si
    inc si

    
    xor ax, ax
    mov ax, word ptr[si]
    cmp al, '$'
    je endPS
    push ax
    mov dl, ','
    mov al, 0
    mov ah, 02h
    int 21h
    pop ax
    call printAX
    jmp contPS

    endPS:

    pop si
    popRegs
    ret
printSet EndP

charToSet proc
    ;asume que el caracter a convertir se encuentra en la variable char
    ;asume el set resultante en Result
    ;solo va a tomar en cuenta la parte baja del word del caracter
    pushRegs
    xor ax, ax
    mov ax, char
    lea si, Result

    mov word ptr[si], ax
    inc si
    inc si
    mov word ptr[si], '$'
    popRegs
    ret
charToSet endP

boolToSet proc
    ;asume que el booleano a convertir se encuentra en la variable bool
    ;asume el set resultante en Result
    pushRegs
    xor ax, ax
    lea si, Result
    mov ax, bool

    mov word ptr[si], ax
    inc si
    inc si
    mov word ptr[si], '$'
    
    popRegs
    ret
boolToSet endP

fileToSet proc
    ;asume que el nombre del archivo a convertir se encuentra en la variable fileName
    ;asume el set resultante en Result
    pushRegs
    lea di, Result
    lea si, fileName
    contFTS:
        xor ax, ax
        mov al, byte ptr [si]
        cmp al, 0
        je endFTS
        mov word ptr [di], ax
        inc di
        inc di
        inc si
        jmp contFTS
    endFTS:
    
    popRegs
    ret
fileToSet endP


intToSet proc
    ;asume que el entero a convertir se encuentra en la variable integer
    ;asume el set resultante en Result
    pushRegs
    xor ax, ax
    lea si, Result
    mov ax, integer

    mov word ptr[si], ax
    inc si
    inc si
    mov word ptr[si], '$'
    
    popRegs
    ret
intToSet endP

stringToSet proc
    ;asume que el nombre del archivo a convertir se encuentra en la variable fileName
    ;asume el set resultante en Result
    pushRegs
    lea di, Result
    lea si, string
    contSTS:
        xor ax, ax
        mov al, byte ptr [si]
        cmp al, '$'
        je endSTS
        mov word ptr [di], ax
        inc di
        inc di
        inc si
        jmp contSTS
    endSTS:
    
    popRegs
    ret
stringToSet endP


main: mov ax, pila
    mov ss, ax

    mov ax, datos
    mov ds, ax

    ;call charToSet
    ;call boolToSet
    ;call fileToSet
    ;call intToSet
    call stringToSet




    lea si, Result
    call printSet

    mov ax, 4C00h
    int 21h 

codigo ends

end main