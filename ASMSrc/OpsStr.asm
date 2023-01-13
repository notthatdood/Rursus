;Made with code adapted from https://stackoverflow.com/questions/37511492/x86-assembly-pass-parameter-to-a-function-through-stack

; Este programa va a tener las operaciones básicas para trabajar con Strings
; Se espera que todos vengan terminados en $
;Rutinas:
;   0. Scribonumerus: (printDString)
;   1. Concatenar: Va a tomar dos dollar strings y los va a juntar. (concatDString) A
;   2. Length: Va a dar el largo de un dollar string.(dStringLen) A
;   3. Find: va a tomar un caracter y buscarlo en un dollar string (findDChar)
datos segment

    Base dw 10
    len dw 0
    string1 db "abcdefg", '$'
    string2 db "hijklmnop", '$'
    Result db 128 dup('$')
    FindResult db 0
    FindPos db 0

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

printDString proc
    ; espera en el tope de la pila la dirección del string
    push bp
    mov bp, sp 
    mov dx,[bp+4]
    push ax

    mov ah, 09h
    int 21h

    pop ax
    pop bp
    ret 2
printDString endP

dStringLen proc
    ;asume la dirección del string en el tope de la pila
    ;deja el largo en la variable len
    push bp
    mov bp, sp
    mov si,[bp+4] 

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

    pop bp
    ret 2
dStringLen endP

concatDString proc
    ;asume la dirección de ambos strings en el tope de la pila
    ;deja el string concatenado en la variable Result
    push bp
    mov bp, sp
    ;mov di,[bp+4]; string2
    mov si,[bp+6]; string1 
    lea di, Result
    pushRegs

    conc1:
        mov bl, byte ptr[si]
        cmp bl,'$'
        je endConc1
        mov byte ptr[di], bl
        inc si
        inc di
        jmp conc1
    endConc1:

    ;dec di; con esto dejamos el si en el $ del string1 para cambiarlo
    mov si, [bp+4]; string2
    conc2:
        mov bl, byte ptr[si]
        cmp bl,'$'
        je endConc2
        mov byte ptr[di], bl
        inc si
        inc di
        jmp conc2
    endConc2:

    popRegs
    pop bp
    ret 4
concatDString endP

findDChar proc
    ;espera en el tope de la pila la dirección del string y en dl el caracter
    ; dejará la posición del caracter en FindPos y un 1 en Result si encontró el caracter
    ; si no lo encontró dejará un 0 en ambos
    push bp
    mov bp, sp 
    mov si,[bp+4]
    push bx
    xor bh, bh

    find:
        mov bl, byte ptr[si]
        cmp bl,'$'
        je endFind
        cmp bl, dl
        je found
        inc si
        inc di
        inc bh
        jmp find

    found:
        mov FindPos, bh
        mov bh, 1
        mov FindResult, bh
    endFind:

    pop bx
    pop bp
    ret 2
findDChar endP


main: mov ax, pila
    mov ss, ax

    mov ax, datos
    mov ds, ax

    

    ;lea si, string1
    ;lea di, string2
    ;push si
    ;push di
    ;call concatDString
    ;lea si, Result
    ;push si
    ;call printDString

    ;lea si, string1
    ;push si
    ;mov dl, 'z'
    ;call findDChar
    ;xor ax, ax
    ;mov al, FindResult
    ;call printAX
    ;call camlin
    ;mov al, FindPos
    ;call printAX

    ;lea si, string1
    ;push si
    ;call dStringLen
    ;mov ax, len
    ;call printAX

    mov ax, 4C00h
    int 21h 

codigo ends

end main