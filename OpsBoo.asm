; Este programa va a tener las operaciones básicas para trabajar con booleanos
; Se espera que vengan almacenados en words, 0 va a ser falso y cualquier otra cosa va a ser verdadero 
;and, or, xor, not
; Rutinas:
;   1. and: Va a hacer un and lógico 
;   2. or: va a hacer un or lógico
;   3. xor: va a hacer un xor lógico
;   4. not: va a invertir el valor que tenga el booleano
;   
datos segment
    bool1 dw 1
    bool2 dw 0
    Result dw 0
    Base dw 10

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

logicAnd proc
    ; va a hacer un and lógico entre el bool1 y el bool2 y deja el 
    ;resultado en Result
    pushRegs
    cmp bool1, 0
    je lAndFalse
    cmp bool2, 0
    je lAndFalse
    mov Result, 1
    popRegs
    ret

    lAndFalse:
        mov Result, 0
    popRegs
    ret
logicAnd endP

logicOr proc
    ; va a hacer un or lógico entre el bool1 y el bool2 y deja el 
    ;resultado en Result
    pushRegs
    cmp bool1, 1
    je lOrTrue
    cmp bool2, 1
    je lOrTrue
    mov Result, 0
    popRegs
    ret

    lOrTrue:
        mov Result, 1

    popRegs
    ret
logicOr endP

logicXor proc
    pushRegs
    cmp bool1, 1
    je verifyTrue
    cmp bool2, 1
    jne xorFalse
    mov Result, 1
    popRegs
    ret

    verifyTrue:
        cmp bool2, 0
        jne xorFalse
        mov Result, 1
        popRegs
        ret
    xorFalse:
        mov Result, 0
    popRegs
    ret
logicXor endP

main: mov ax, pila
    mov ss, ax

    mov ax, datos
    mov ds, ax

    ;call logicAnd
    ;mov ax, Result
    ;call printAX

    ;call logicOr
    ;mov ax, Result
    ;call printAX

    ;call logicXor
    ;mov ax, Result
    ;call printAX

    mov ax, 4C00h
    int 21h 

codigo ends

end main