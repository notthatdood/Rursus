; Este programa va a tener las operaciones básicas para trabajar con enteros
; Se espera que todos sean de menos de 16 bits, para la multiplicación ambos deben ser de menos de 8 bits
;Rutinas:
;   1. Suma: Va a tomar dos números enteros positivos y los va a sumar. 
;   2. Resta: Va a tomar dos números positivos y los va a restar.
;   3. Multiplicación: Va a tomar dos números enteros positivos y los va a restar
;   4. División: Va a tomar dos números enteros positivos y los va a dividir
;   5. Mostrar: falta la rutina para mostrar en pantalla números negativos

datos segment

    Base dw 10
    Num1 dw 13
    Num2 dw -7
    MulNum1 db 2
    MulNum2 db 5
    Divisor db 3
    Result dw 0
    Remainder db 0

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

printAXAux proc     
    ; imprime a la salida estandar un numero que supone estar en el AX
    ; supone que es un numero entero en 16 bits. 
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
printAXAux endP

printAX proc
    ; Decide si un número es positivo o negativo y se imprime en la salida principal
    ; Números superiores a 32767 serán considerados como negativos
    pushRegs
    cmp ax, 0
    jl esNegativo
    call printAXAux
    popRegs
    ret

    esNegativo:
        push ax
        mov ah, 02h
        mov dl, '-'
        int 21h
        pop ax
        mov bx, 65535
        sub bx, ax
        inc bx
        mov ax, bx
        call printAXAux
    popRegs
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

suma proc
    ; Asume que los dos números a ser operados van a estar en Num1 y Num2, asume que son enteros
    pushRegs
    xor ax, ax
    add ax, Num1
    add ax, Num2
    mov Result, ax
    popRegs
    ret
suma endP

resta proc
    ; Asume que los dos números a ser operados van a estar en Num1 y Num2, asume que son enteros
    pushRegs
    xor ax, ax
    mov ax, Num1
    sub ax, Num2
    mov Result, ax
    popRegs
    ret
resta endP

mult proc
    ; Asume que los dos números a ser operados van a estar en MulNum1 y MulNum2, asume que son enteros y son
    ; de maximo un byte 
    pushRegs
    xor ax, ax
    mov al, MulNum1
    imul MulNum2
    mov Result, ax
    popRegs
    ret
mult endP

divi proc
    ; Asume que el dividendo se encuentra en Num1 y el divisor en Divisor
    pushRegs
    mov ax, Num1
    idiv Divisor
    mov Remainder, ah
    xor ah, ah
    mov Result, ax
    popRegs
    ret
divi endP

rem proc
    pushRegs
    mov ax, Num1
    idiv Divisor
    xor bx, bx
    mov bl, ah
    mov Result, bx
    popRegs
    ret
rem endP

main: mov ax, pila
    mov ss, ax

    mov ax, datos
    mov ds, ax

    ;Cada "puñito" de instrucciones es una prueba, solo descomentar una a la vez para ver los resultados claramente
    
    ;call suma
    ;mov ax, Result
    ;call printAX

    ;call resta
    ;mov ax, Result
    ;call printAX

    ;call mult
    ;mov ax, Result
    ;call printAX

    ;call divi
    ;mov ax, Result
    ;call printAX
    ;call CamLin
    ;xor ax, ax
    ;mov al, Remainder
    ;call printAX

    ;call rem 
    ;mov ax, Result
    ;call printAX

    mov ax, 40000
    call printAX

    mov ax, 4C00h
    int 21h 

codigo ends

end main