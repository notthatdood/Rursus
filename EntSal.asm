;Made with code adapted from BART.ASM, PRIMOS.ASM
;This program contains I/O operations for the atomic types of Rursus Language
;Rutinas
;   1. Integer:
;       a. Entrada: Me asalté la rutina buscanumero del PRIMOS.ASM
;       b. Salida: Se va a usar printAX
;   2. Character
;       a. Entrada: Se va a adaptar la rutina buscanumero
;       b. Salida: Se va a usar la rutina printChar
;   3. Boolean
;       a. Entrada: Se va a adaptar la rutina buscanumero si llega un 0 será false, de lo contrario será true
;       b. Salida: Se va a usar printAX
;   4. String?
;       a. Entrada: Se va a adaptar la rutina buscanumero
;       b. Salida: Se va a usar la rutina printDString
; No sé si string cuenta como tipo atómico por ser una cadena de caracteres pero lo incluí

datos segment

    ResInteger dw 0
    ResCharacter dw 0
    ResBoolean dw 0
    ResString db 128 dup('$')
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

printDString proc
    ; espera la dirección del dollar string en dx
    pushRegs
    mov ah, 09h
    int 21h
    popRegs
    ret
printDString endP

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

;esta me la asalte del ejemplo PRIMOS.ASM
readInt proc
; esta rutina extrae del puntero es:[si] un numero y lo deja en la variable ResInteger.  Supone que es formato like pascal.

    pushRegs
    push si   

    mov cl, byte ptr es:[si]
    xor ch, ch
    dec cx
    inc si
    inc si
    xor ax, ax

ciclobn: mov bl, byte ptr es:[si]
    sub bl, 30h    
    xor bh, bh
    mov dx, 10
    mul dx
    add ax, bx     
    inc si                           
    loop ciclobn
    mov ResInteger, ax
    pop si
    popRegs

    ret
readInt endP

printChar proc
    ;espera el caracter a imprimir en dl
    pushRegs
    mov ah, 02h
    int 21h
    popRegs
    ret
printChar endP

readChar proc
; esta rutina extrae del puntero es:[si] el primer caracter y lo deja en la variable ReadCharacter.

    pushRegs
    push si   

    mov cl, byte ptr es:[si]
    xor ch, ch
    dec cx
    inc si
    inc si

    xor ax, ax
    mov al, byte ptr es:[si]
    
    mov ResCharacter, ax
    pop si
    popRegs

    ret
readChar endP

readBool proc
; esta rutina extrae del puntero es:[si] el primer caracter y lo deja en la variable ReadCharacter.

    pushRegs
    push si   

    mov cl, byte ptr es:[si]
    xor ch, ch
    dec cx
    inc si
    inc si

    xor ax, ax
    mov al, byte ptr es:[si]
    cmp al,48
    je falseBool
    cmp al,0
    je falseBool
    mov al, 1
    jmp trueBool
    falseBool:
    mov al, 0
    trueBool:
    mov ResBoolean, ax
    pop si
    popRegs

    ret
readBool endP

readStr proc
    ; esta rutina extrae del puntero es:[si] un numero y lo deja en la variable ResString. 

    pushRegs
    push si   
    push di

    lea di, ResString
    mov cl, byte ptr es:[si]
    cmp cl, 0
    je endReadStr
    xor ch, ch
    dec cx
    inc si
    inc si
    xor ax, ax
    
cicloRS: mov bl, byte ptr es:[si]
    mov byte ptr[di], bl
    xor bh, bh
    mov dx, 10
    mul dx
    add ax, bx     
    inc si           
    inc di                
    loop cicloRS
    ;mov ResString, ax
    endReadStr:

    pop di
    pop si
    popRegs

    ret
readStr endP


main: mov ax, pila
    mov ss, ax

    mov ax, datos
    mov ds, ax

    mov si, 80h
    
    ;call readInt
    ;mov ax, ResInteger
    ;call printAX

    ;call readChar
    ;xor dx, dx
    ;mov dx, ResCharacter 
    ;call printChar

    ;call readBool
    ;mov ax, ResBoolean
    ;call printAX

    call readStr
    lea dx, ResString
    call printDString


    mov ax, 4C00h
    int 21h 

codigo ends

end main