; Este programa va a tener las conversiones de otros tipos a Char
; Rutinas:
    ; 1. Int a Char: Va a tomar el valor en ascii del caracter, si el número se excede, se le asignará un 127
    ; 2. Bool a Char: '1' (49) si es verdadero '0' (48) si es falso
    ; 3. File a Char: va a tomar la primera letra del nombre
    ; 4. String a Char: va a tomar la primera letra del string
    ; 5. Set a Char: va a tomar el primer elemento del conjunto y le va a aplicar la misma operación de los Int


datos segment

    integer dw 67
    bool dw 1
    fileName db "filemon.txt",0
    string db "zabcde$"
    set dw 65,2,3,4,5,6,7,8,9,0,11,12,13,14,15,16,17,85
    lenSet db 18
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

intToChar proc
    pushRegs
    mov ax, integer
    mov bx, 127
    cmp ax, bx
    jl intTodoBien 
    mov ax, bx
    intTodoBien:
    mov Result, ax
    popRegs
    ret
intToChar endP

boolToChar proc
    pushRegs
    mov ax, bool
    add ax, 48
    mov Result, ax
    popRegs
    ret
boolToChar endP

fileToChar proc
    ; Va a colocar en Result el primer caracter del nombre del archivo
    ; Espera el nombre del archivo en la variable fileName
    pushRegs
    lea si, fileName
    xor ax, ax
    mov al, byte ptr [si]
    mov Result, ax
    popRegs
    ret
fileToChar endP

stringToChar proc
    ; Va a colocar en Result el primer caracter del string
    ; Espera el strign en la variable string
    pushRegs
    lea si, string
    xor ax, ax
    mov al, byte ptr [si]
    mov Result, ax
    popRegs
    ret
stringToChar endP

setToChar proc
    ; Va a colocar en Result el primer valor del conjunto si es menor a 128, de lo contrario se le asignará
    ; como valor 127
    ; Espera el strign en la variable string
    pushRegs
    lea si, set
    xor ax, ax
    mov al, byte ptr [si]
    mov Result, ax
    popRegs
    ret
setToChar endP

main: mov ax, pila
    mov ss, ax

    mov ax, datos
    mov ds, ax

    ;call intToChar
    ;mov ax, Result
    ;mov dl, al
    ;mov ah, 02h
    ;int 21h

    ;call boolToChar
    ;mov ax, Result
    ;mov dl, al
    ;mov ah, 02h
    ;int 21h

    ;call fileToChar
    ;mov ax, Result
    ;mov dl, al
    ;mov ah, 02h
    ;int 21h

    ;call stringToChar
    ;mov ax, Result
    ;mov dl, al
    ;mov ah, 02h
    ;int 21h

    ;call setToChar
    ;mov ax, Result
    ;mov dl, al
    ;mov ah, 02h
    ;int 21h

    ;mov ax, 4C00h
    ;int 21h 

codigo ends

end main