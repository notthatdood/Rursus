; Este programa va a tener las conversiones de otros tipos a Bool
; Rutinas:
    ; 1. Int a Bool: Si es 0 o 1 lo va a dejar quieto, si es mayor a 1 se le asignará un 1, si es menor a 0 será 0
    ; 2. Char a Bool: Si el caracter no tiene por valor 0 va a ser 1, de lo contrario va a ser 0
    ; 3. File a Bool: Se va a tomar la primera letra del string se le aplicará el mismo proceso que a los Char
    ; 4. String a Bool: va a tomar el la primera letra del nombre y se le aplicará el mismo proceso que a los Char
    ; 5. Set a Bool: va a tomar el primer elemento del conjunto y le va a aplicar la misma operación de los Char

datos segment

    integer dw -15
    char dw 'a'
    fileName db "filemon.txt",0
    string db "zabcde$"
    set dw 0,2,3,4,5,6,7,8,9,0,11,12,13,14,15,16,17,85,'$'
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

intToBool proc
    ; Espera el entero a revisar en la variable integer
    pushRegs
    mov ax, integer
    cmp ax, 0
    jle intFalse
    cmp ax, 1
    jge intTrue

    intTrue:
    mov ax, 1
    mov Result, ax
    popRegs
    ret
    intFalse:
    mov ax, 0
    mov Result, ax
    popRegs
    ret
intToBool endP

charToBool proc
    ;Espera el caracter a revisar en la variable char
    pushRegs
    mov ax, char
    cmp ax, 0
    je charFalse
    cmp ax, 1
    jge charTrue

    charTrue:
    mov ax, 1
    mov Result, ax
    popRegs
    ret
    charFalse:
    mov ax, 0
    mov Result, ax
    popRegs
    ret
charToBool endP

fileToBool proc
    ; Va a tomar el valor del primer caracter del nombre del file
    ; si es 0 va a quedar así, si no; va a ser 1
    ; Espera el nombre del archivo en la variable fileName
    pushRegs
    lea si, fileName
    xor ax, ax
    mov al, byte ptr [si]
    cmp ax, 0
    je fileFalse
    cmp ax, 1
    jge fileTrue

    fileTrue:
    mov ax, 1
    mov Result, ax
    popRegs
    ret
    fileFalse:
    mov ax, 0
    mov Result, ax
    ret
fileToBool endP

stringToBool proc
    ; Va a colocar en Result el primer caracter del string
    ; Espera el string en la variable string
    pushRegs
    lea si, string
    xor ax, ax
    mov al, byte ptr [si]
    cmp ax, 0
    je stringFalse
    cmp ax, 1
    jge stringTrue

    stringTrue:
    mov ax, 1
    mov Result, ax
    popRegs
    ret
    stringFalse:
    mov ax, 0
    mov Result, ax
    popRegs
    ret
stringToBool endP

setToBool proc
    pushRegs
    lea si, set
    xor ax, ax
    mov ax, word ptr [si]
    cmp ax, 0
    je setFalse
    cmp ax, 1
    jge setTrue

    setTrue:
    mov ax, 1
    mov Result, ax
    popRegs
    ret
    setFalse:
    mov ax, 0
    mov Result, ax

    popRegs
    ret
setToBool endP

main: mov ax, pila
    mov ss, ax

    mov ax, datos
    mov ds, ax

    ;call intToBool
    ;mov ax, Result
    ;call printAX

    ;call charToBool
    ;mov ax, Result
    ;call printAX

    ;call fileToBool
    ;mov ax, Result
    ;call printAX

    ;call stringToBool
    ;mov ax, Result
    ;call printAX

    ;call setToBool
    ;mov ax, Result
    ;call printAX
    
    

    mov ax, 4C00h
    int 21h 

codigo ends

end main