; Este programa va a tener las operaciones básicas para trabajar con caracteres
; Se van a trabajar en words
; pasar a mayúsculas, a minúsculas, is alpha, is digit, todas son unarias y en prefijo.

; Rutinas:
;   1. isAlpha: Va a retornar 0 si no es dígito 1 si sí lo es
;   2. isDigit: Va a retornar 0 si no es dígito 1 si sí lo es
;   3. toMayus: Va a verificar que el caracter sea una letra y la convierte
;   a mayúscula si no es mayúscula ya
;   4. toLower: Va a verificar que el caracter sea una letra y la convierte
;   a minúscula si no es minúscula ya
;   

datos segment

    char dw 'a'
    Base dw 10
    Result dw 0

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

printAXChar proc
    pushRegs
    xor dl, dl
    mov dl, al
    mov ah, 02h
    int 21h
    popRegs
    ret
printAXChar endP

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

isDigit proc
    ; Revisa si un caracter es un numero o no
    ; Espera el caracter a revisar en char y deja el resultado en Result
    pushRegs
    cmp char, 48
    jl DigFalse 
    cmp char, 57
    jg DigFalse
    mov Result, 1
    popRegs
    ret

    DigFalse:
        mov Result, 0
        popRegs
        ret
isDigit endP

isAlpha proc
    ; Revisa si un caracter es una letra o no
    ; Espera el caracter a revisar en char y deja el resultado en Result
    pushRegs
    cmp char, 65
    jl AlpFalse 
    cmp char, 90
    jg IsMin
    jmp AlpTrue

    IsMin:
        cmp char, 97
        jl AlpFalse 
        cmp char, 122
        jg AlpFalse
        

    AlpTrue:
        mov Result, 1
        popRegs
        ret

    AlpFalse:
        mov Result, 0
        popRegs
        ret
isAlpha endP

toMayus proc
    pushRegs
    ; Espera el caracter a convertir en char y deja el resultado ahi mismo
    ; si ya era mayúscula o no es una letra, no se va a cambiar el valor
    cmp char, 97
    jl notMin 
    cmp char, 122
    jg notMin
    mov ax, 32
    sub char, ax

    notMin:

    popRegs
    ret
toMayus endP

toLower proc
    pushRegs
    ; Espera el caracter a convertir en char y deja el resultado ahi mismo
    ; si ya era mayúscula o no es una letra, no se va a cambiar el valor
    cmp char, 65
    jl notMay 
    cmp char, 90
    jg notMay
    mov ax, 32
    add char, ax

    notMay:

    popRegs
    ret
toLower endP

main: mov ax, pila
    mov ss, ax

    mov ax, datos
    mov ds, ax

    ;Cada "puñito" de instrucciones es una prueba, solo descomentar una a la vez 
    ;para ver los resultados claramente

    ;call isAlpha
    ;mov ax, Result
    ;call printAX
    
    ;mov char, '1'
    ;call isAlpha
    ;mov ax, Result
    ;call printAX

    ;mov char, '1'
    ;call isDigit
    ;mov ax, Result
    ;call printAX

    ;mov char, 'a'
    ;call isDigit
    ;mov ax, Result
    ;call printAX

    ;mov char, 'a'
    ;call toMayus
    ;mov ax, char
    ;call printAXChar

    ;mov char, 'z'
    ;call toMayus
    ;mov ax, char
    ;call printAXChar

    ;mov char, 'Z'
    ;call toMayus
    ;mov ax, char
    ;call printAXChar

    ;mov char, '#'
    ;call toMayus
    ;mov ax, char
    ;call printAXChar

    ;mov char, 'A'
    ;call toLower
    ;mov ax, char
    ;call printAXChar

    ;mov char, 'Z'
    ;call toLower
    ;mov ax, char
    ;call printAXChar

    ;mov char, 'q'
    ;call toLower
    ;mov ax, char
    ;call printAXChar

    ;mov char, '#'
    ;call toLower
    ;mov ax, char
    ;call printAXChar

    mov ax, 4C00h
    int 21h 

codigo ends

end main