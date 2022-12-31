;Este es un programa que va a ofrecer operaciones básicas de conjuntos
;Andres Sanchez Rojas
;Autoevaluación
;
;Intersección: B necesito el largo de los conjuntos en las variables
;Unión: B necesito el largo de los conjuntos en las variables
;
;

datos segment

    base dw 10
    len db 0
    set1 dw 1,2,3,4,5,6,7,8,9,0,11,12,13,14,15,16,17,85,'$'
    set2 dw 11,1,12,13,14,15,5,16,17,18,176,19,10,20,'$'
    dos db 2
    resSet dw 128 dup('$')
datos endS

;sección de macros

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
; imprime a la salida est�ndar un n�mero que supone estar en el AX
; supone que es un n�mero positivo y natural en 16 bits.
; lo imprime en la base que indca la variable Base del Data Segment.  
    
    push AX
    push BX
    push CX                           
    push DX

    xor cx, cx
    mov bx, base
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

camLin Proc
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
camLin EndP

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

;asume que en si y di hay pointers a ambos conjuntos
;va a tomar los elementos de ambos y unirlos 
;el resultado va en la variable resSet
joinSet Proc
    pushRegs
    push di
    push si
    call copySet
    lea si, resSet
    push si
    ;recorre el segundo conjunto y va agregando los elementos no repetidos al primero
    joinlp1:
        pop si
        push si
        mov bx, word ptr [di]
        cmp bx, '$'
        je finJoin
        inc di
        inc di
        ;recorre el primer conjunto buscando si se repite el elemento y lo agrega al final si no
        joinlp2:
            mov ax, word ptr [si]
            cmp ax, bx
            je skipElementU
            inc si
            inc si
            cmp ax, '$'
            je addElementU
            jmp joinlp2
            addElementU:
                dec si
                dec si
                mov word ptr [si], bx
                inc si 
                inc si
                mov bx, '$'
                mov word ptr [si], bx
                jmp joinlp1
            skipElementU:
                jmp joinlp1
    finJoin:
    pop si
    pop si
    pop di
    popRegs
    ret
joinSet EndP

;asume que en si está el pointer al conjunto
;es una función auxiliar para copiar el primer conjunto a uno nuevo
copySet Proc
    pushRegs
    push si
    push di


    lea di, resSet
    mov ax, word ptr[si]
    mov word ptr[di], ax

    copylp:
        inc si 
        inc si
        inc di
        inc di
        mov ax, word ptr[si]
        mov word ptr[di], ax
        cmp al, '$'
        jge finCopy
        jmp copylp
    finCopy:

    pop di
    pop si
    popRegs
    ret
copySet EndP

;asume que en si y di hay pointers a ambos conjuntos
;va a tomar los elementos de ambos e intersecarlos
;el resultado va en la variable resSet
interSet Proc
    pushRegs
    push si
    push di
    lea dx, resSet
    interlp1:
        pop di
        push di
        mov ax, word ptr[si]
        cmp ax, '$'
        je finInter
        inc si
        inc si
        interlp2:
            mov bx, word ptr[di]
            cmp ax, bx
            je skipElementI
            inc di
            inc di
            cmp bx, '$' 
            jge addElementI
            jmp interlp2
            addElementI:
                push si 
                mov si, dx
                mov word ptr[si], ax
                inc dx
                inc dx
                pop si
                jmp interlp1

            skipElementI:
                jmp interlp1
    
    finInter:
    mov si, dx
    mov ax, '$'
    mov word ptr[si], ax

    pop di
    pop si
    popRegs
    ret
interSet EndP






main: mov ax, pila
    mov ss, ax

    mov ax, datos
    mov ds, ax

; solo usar uno a la vez, si se usa uno después del otro le va a caer encima al conjunto de respuesta

;inicio de la llamada de union
    lea si, set1
    lea di, set2

    call joinSet

    lea si, resSet
    call printSet

;fin de la llamada de union
    
    call camLin
    call camLin

;inicio de la llamada de intersección
    lea si, set1
    lea di, set2

    call interSet

    lea si, resSet
    call printSet

;fin de la llamadad de intersección

    mov ax, 4C00h
    int 21h 

codigo ends

end main