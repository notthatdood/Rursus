; Este programa va a tener las conversiones de otros tipos a File
; Rutinas
    ; 1. Char a File: Va a tomar el caracter y crear un archivo con esa letra como nombre
    ; 2. Bool a File: Va a crear un archivo con nombre 1 o 0
    ; 3. Int a File: va a tomar los caracteres del número y crear un archivo con 
    ;eso como nombre
    ; 4. String a File: Va a crear un archivo con el string como nombre
    ; 5. Set a File: Va a tomar cada elemento del conjunto y los va a usar como 
    ;caracteres para formar el nombre del archivo

datos segment

    crErrorMsg db "Hubo un error al crear el archivo",10,13,"$"
    crSuccessMsg db "Archivo creado exitosamente",10,13,"$"
    
    char dw 'a'
    bool dw 0
    integer dw 15
    string db "abcde$"
    set dw 49,65,66,67,68,69,48,'$'
    Result dw 0
    Base dw 10
    len dw 0

    fileName db 128 dup(0)
    fileHandle dw ?
    fileBuffer db 128 dup('$')

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

;Create File
;Asume un puntero al nombre del archivo en dx y deja el handle del archivo en la variable fileHandle
crFile Proc
    pushRegs
    xor cx, cx
    mov ah, 3Ch
    int 21h
    mov fileHandle, ax
    jnc endCreate 

    mov ah, 09h
    lea dx, crErrorMsg
    int 21h    
    popRegs
    ret

    endCreate:
    mov ah, 09h
    lea dx, crSuccessMsg
    int 21h    
    popRegs
    ret
crFile EndP

charToFile proc
;Espera el caracter en la variable char
;Solo va a usar la parte inferior de ax en la conversión
;Espera el nombre del archivo en fileName
    pushRegs
    push si
    lea si, fileName
    
    mov ax, char
    mov byte ptr[si], al
    
    inc si
    mov al, '.'
    mov byte ptr[si], al

    inc si
    mov al, 't'
    mov byte ptr[si], al

    inc si
    mov al, 'x'
    mov byte ptr[si], al

    inc si
    mov al, 't'
    mov byte ptr[si], al

    inc si
    mov al, 0
    mov byte ptr[si], al

    ;lea si, fileName
    ;call printZString

    lea dx, fileName
    call crFile

    pop si
    popRegs
    ret
chartoFile endP

boolToFile proc
    ;espera el entero a convertir en integer
    ;espera el nombre del archivo en fileName
    pushRegs
    push si
    lea si, fileName

    mov ax, bool
    add al, 48
    mov byte ptr[si], al
    
    inc si
    mov al, '.'
    mov byte ptr[si], al

    inc si
    mov al, 't'
    mov byte ptr[si], al

    inc si
    mov al, 'x'
    mov byte ptr[si], al

    inc si
    mov al, 't'
    mov byte ptr[si], al

    inc si
    mov al, 0
    mov byte ptr[si], al

    ;lea si, fileName
    ;call printZString

    lea dx, fileName
    call crFile

    pop si
    popRegs
    ret
boolToFile endP

intToFile proc
    ; espera el entero a convertir en integer
    ;espera el nombre del archivo en fileName
    pushRegs
    push si
    mov ax, integer
    lea si, fileName

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

    mov al, '.'
    mov byte ptr[si], al

    inc si
    mov al, 't'
    mov byte ptr[si], al

    inc si
    mov al, 'x'
    mov byte ptr[si], al

    inc si
    mov al, 't'
    mov byte ptr[si], al

    inc si
    mov al, 0
    mov byte ptr[si], al

    ;lea si, fileName
    ;call printZString
    
    lea dx, fileName
    call crFile
    
    pop si
    popRegs
    ret
intToFile endP

stringToFile proc
    ;espera el string a convertir en la variable string
    ;el string debe ser menor a 122 caracteres
    ;espera el nombre del archivo en fileName
    pushRegs
    push di
    push si

    lea di, string
    lea si, fileName

    contSTF:
        mov al, byte ptr[di]
        cmp al, '$'
        je endSTF
        mov byte ptr[si], al
        inc di
        inc si
        jmp contSTF
    endSTF:
    mov al, '.'
    mov byte ptr[si], al

    inc si
    mov al, 't'
    mov byte ptr[si], al

    inc si
    mov al, 'x'
    mov byte ptr[si], al

    inc si
    mov al, 't'
    mov byte ptr[si], al

    inc si
    mov al, 0
    mov byte ptr[si], al

    ;lea si, fileName
    ;call printZString

    lea dx, fileName
    call crFile

    pop si
    pop di
    popRegs
    ret
stringToFile endP

setToFile proc
    ;espera el conjunto a convertir en la variable set
    ;el set debe ser menor a 122 words
    ; solo tomará en cuenta la parte inferior de cada word al hacer la conversión
    ;espera el nombre del archivo en fileName
    pushRegs
    push di
    push si

    lea di, set
    lea si, fileName

    contSetTF:
        mov ax, word ptr[di]
        cmp ax, '$'
        je endSetTF
        mov byte ptr[si], al
        inc di
        inc di
        inc si
        jmp contSetTF
    endSetTF:
    mov al, '.'
    mov byte ptr[si], al

    inc si
    mov al, 't'
    mov byte ptr[si], al

    inc si
    mov al, 'x'
    mov byte ptr[si], al

    inc si
    mov al, 't'
    mov byte ptr[si], al

    inc si
    mov al, 0
    mov byte ptr[si], al

    ;lea si, fileName
    ;call printZString

    lea dx, fileName
    call crFile

    pop si
    pop di
    popRegs
    ret
setToFile endP

main: mov ax, pila
    mov ss, ax

    mov ax, datos
    mov ds, ax

    ;call charToFile
    ;call boolToFile
    ;call intToFile
    ;call stringToFile
    ;call setToFile

    mov ax, 4C00h
    int 21h 

codigo ends

end main