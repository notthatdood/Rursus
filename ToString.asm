; Este programa va a tener las conversiones de otros tipos a string
; Rutinas
    ; 1. Char a String: Se va a crear un dollarString con el caracter como su único elemento
    ; 2. Bool a String: Se va a crear un dollarString con el caracter '1' o '0' como su único elemento
    ; 3. File a String: Se va a crear un dollarString con el nombre del archivo
    ; 4. Set a String: Se va a crear un dollarString con los valores del set, se manejarán como caracteres
    ; 5. Int a String: Se ca a crear un dollarString con el valor del int, se manejará como un caracter

datos segment

    char dw 'a'
    bool dw 0
    integer dw 15
    string db "abcde$"
    fileName db "filemon.txt",0
    set dw 49,65,66,67,68,69,48,'$'
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

charToString proc
    ;asume que el caracter a convertir se encuentra en la variable char
    ;asume el string resultante en Result
    ;solo va a tomar en cuenta la parte baja del word del caracter
    pushRegs
    xor ax, ax
    mov ax, char
    lea si, Result

    mov byte ptr[si], al
    inc si
    mov byte ptr[si], '$'
    popRegs
    ret
charToString endP

boolToString proc
    ;asume que el caracter a convertir se encuentra en la variable char
    ;asume el string resultante en Result
    pushRegs
    xor ax, ax
    mov ax, bool
    lea si, Result
    add ax, 48

    mov byte ptr[si], al
    inc si
    mov byte ptr[si], '$'
    popRegs
    ret
boolToString endP

fileToString proc
    ;asume que el nombre del archivo a convertir se encuentra en la variable fileName
    ;asume el string resultante en Result
    pushRegs
    lea di, Result
    lea si, fileName
    contFTS:
        xor ax, ax
        mov al, byte ptr [si]
        cmp al, 0
        je endFTS
        mov byte ptr [di], al
        inc di
        inc si
        jmp contFTS
    endFTS:

    popRegs
    ret
fileToString endP

intToString proc
    ;asume que el caracter a convertir se encuentra en la variable integer
    ;asume el string resultante en Result
    pushRegs
    push si
    mov ax, integer
    lea si, Result

    xor cx, cx
    mov bx, Base
    ciclo1ITF: xor dx, dx
        div bx
        push dx
        inc cx
        cmp ax, 0
        jne ciclo1ITF
    ciclo2ITF: pop DX
        add dl, 30h
        cmp dl, 39h
        jbe prnITF
        add dl, 7
    prnITF: mov byte ptr[si],dl
        inc si
        loop ciclo2ITF 

    ;inc si
    mov al, '$'
    mov byte ptr[si], al
    
    pop si
    popRegs
    ret
intToString endP

setToString proc
    pushRegs

    lea di, Result
    lea si, set
    contSTS:
        xor ax, ax
        mov ax, word ptr [si]
        cmp ax, '$'
        je endSTS
        mov byte ptr [di], al
        inc di
        inc si
        inc si
        jmp contSTS
    endSTS:

    popRegs
    ret
setToString endP

main: mov ax, pila
    mov ss, ax

    mov ax, datos
    mov ds, ax

    ;call charToString
    ;call boolToString
    ;call fileToString
    ;call intToString
    call setToString

    lea dx, Result
    mov ah, 09h
    int 21h

    mov ax, 4C00h
    int 21h 

codigo ends

end main