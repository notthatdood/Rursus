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
    set1 dw 1,2,3,4,5,6,7,8,9,0,11,12,13,14,15,16,17,85
    lenSet1 db 18
    set2 dw 11,1,12,13,14,15,5,16,17,18,176,19,10,20
    lenSet2 db 14
    dos db 2
    resSet dw  128 dup(?)
    lenResSet db 0
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


;imprime un arreglo, asume que el puntero al arreglo está en si y su len en la variable len en el data segment
printSet Proc
    pushRegs
    mov cl, 0
    printing:
        cmp cl,0
        je sincoma
        mov dl, ','
        mov al, 0
        mov ah, 02h
        int 21h
        sincoma:
            mov ax, word ptr [si]
            call printAX
            inc si
            inc si
            inc cl
            cmp cl, len
            jl printing
    popRegs
    ret
printSet EndP



;asume que en si y di hay pointers a ambos conjuntos
;asume el tamaño de los conjuntos en las variables lenSet1 y lenSet2
;va a tomar los elementos de ambos y unirlos 
;el resultado va en la variable resSet
joinSet Proc
    pushRegs
    push di
    push si
    call copySet
    mov cx, 0
    lea si, resSet
    push si
    ;recorre el segundo conjunto y va agregando los elementos no repetidos al primero
    joinlp1:
        pop si
        push si
        cmp cl, lenSet2
        jge finJoin
        mov ch, 0
        mov bx, word ptr [di]
        inc di
        inc di
        ;recorre el primer conjunto buscando si se repite el elemento y lo agrega al final si no
        joinlp2:
            mov ax, word ptr [si]
            cmp ax, bx
            je skipElementU
            inc si
            inc si
            inc ch
            cmp ch, lenResSet
            jge addElementU
            jmp joinlp2
            addElementU:
                inc lenResSet
                inc cl
                mov word ptr [si], bx
                jmp joinlp1
            skipElementU:
                inc cl
                jmp joinlp1
    finJoin:
    pop si
    pop si
    pop di
    popRegs
    ret
joinSet EndP

;asume que en si está el pointer al conjunto 1
;asume el tamaño del conjunto en la variable lenSet1
;es una función auxiliar para copiar el primer conjunto a uno nuevo
copySet Proc
    pushRegs
    push si
    push di

    mov cx, 0
    lea di, resSet
    copylp:
        mov ax, word ptr[si]
        mov word ptr[di], ax
        inc lenResSet
        inc si 
        inc si
        inc di
        inc di
        inc cl
        cmp cl, lenSet1
        jge finCopy
        jmp copylp
    finCopy:

    pop di
    pop si
    popRegs
    ret
copySet EndP

;asume que en si y di hay pointers a ambos conjuntos
;asume el tamaño de los conjuntos en las variables lenSet1 y lenSet2
;va a tomar los elementos de ambos e intersecarlos
;el resultado va en la variable resSet
interSet Proc
    pushRegs
    push si
    push di
    mov cx, 0
    lea dx, resSet
    interlp1:
        pop di
        push di
        cmp cl, lenSet1
        jge finInter
        mov ch, 0 
        mov ax, word ptr[si]
        inc si
        inc si
        interlp2:
            mov bx, word ptr[di]
            cmp ax, bx
            je skipElementI
            inc di
            inc di
            inc ch
            cmp ch, lenSet2
            jge addElementI
            jmp interlp2
            addElementI:
                push si 
                mov si, dx
                inc lenResSet
                mov word ptr[si], ax
                inc dx
                inc dx
                inc cl
                pop si
                jmp interlp1

            skipElementI:
                ;call printAX
                inc cl
                jmp interlp1
    
    finInter:

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

    mov al, lenResSet
    mov len, al 

    lea si, resSet
    call printSet
    call camLin
    call camLin
;fin de la llamada de union
;inicio de la llamada de intersección
    mov ax, 0
    mov lenResSet, 0
    lea si, set1
    lea di, set2

    call interSet

    mov al, lenResSet
    mov len, al 
    lea si, resSet
    call printSet
;fin de la llamadad de intersección
    



    mov ax, 4C00h
    int 21h 

codigo ends

end main