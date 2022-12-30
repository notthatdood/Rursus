;Este es un programa del juego de othello 
;Fabricio Arce Hernández
;Andres Sanchez Rojas
;Autoevaluación
;Modo gráfico: A
;IA: B, Es "aleatorio", no busca la jugada óptima
;Validaciones: A
;Condicion de victoria: A
;Marcador: B, No indica en el juego de quien es el marcador

;--------------------------------------------------Manual de usuario--------------------------------------------------
;Al iniciar se presiona B para elegir la ficha inicial negra (black) o cualquier otra para blanco
;Para iniciar una nueva partida presiona N
;Para Salir del juego presione ESC
;Para que la computadora haga una jugada presione A
;Para la ayuda presione F1
;Para el acerca de presione F2
;El puntaje superior es de las fichas blancas y el inferior es de las fichas negras

;----------------------------------------------------Pseudocodigo-----------------------------------------------------

;Algoritmo de juego automático: Toma la fila en la que se encuentra el cursor y comienza a buscar la siguiente jugada válida comenzando desde ahí

;for (i in filas, i=CursorY, i++)
;   for (j in columnas, j=0, j++)
;       if (jugadaValida(i, j, turno))
;           modificador(i, j, turno)
;           cambiarAdyacentes(i, j, turno)
;           loggearJugada(i, j, turno)
;
;jugadaValida: Revisa si es válido poner la pieza en la posición indicada para el jugador de turno
;modificador: función que modifica el número en la matriz con el del jugador de turno en la posición indicada
;cambiarAdyacentes: Revisar las fichas al rededor de la que se colocó y cambiar el color de las correspondientes
;loggearJugada: Escribe la jugada realizada en el log 
;

datos segment

  matriz   dw 0, 0, 0, 0, 0, 0, 0, 0
           dw 0, 0, 0, 0, 0, 0, 0, 0
           dw 0, 0, 0, 0, 0, 0, 0, 0
           dw 0, 0, 0, -1, 1, 0, 0, 0
           dw 0, 0, 0, 1, -1, 0, 0, 0
           dw 0, 0, 0, 0, 0, 0, 0, 0
           dw 0, 0, 0, 0, 0, 0, 0, 0
           dw 0, 0, 0, 0, 0, 0, 0, 0

  choose db "escriba B para negro, cualquier otra cosa para blanco",10,13,"$"

  HandleS dw ?    
  gameLog db "Log"
  num     db '0'
          db".TXT",0

  ayuda db "Presione N para una nueva partida, para Salir del juego presione ESC, para que la computadora haga una jugada presione A, para el acerca de presione F2",10,13,"$"

  acercaDe db "Arquitectura de computadores, Fabricio Arce Hernandez y Andres Sanchez Rojas, Tarea corta de ASM, Fecha: 15/12/2020",10,13,"$"

  deColor   db "Color: "
  n1        db 'B'
            db " a posicion: "
  nY        db '0'
            db ", "
  nX        db '0'
            db 10,13      

  FilDisk  dw 0;en el proc turno
  ColDisk  dw 0

  DiskX    dw 0;en el proc drawDisk
  DiskY    dw 0

  LH_Color db 2   ;ParÃ¡metros para el procedimiento LineH
  LH_Col1  dw ? 
  LH_Col2  dw ?
  LH_Fil   dw ?  

  LV_Color db 15   ;ParÃ¡metros para el procedimiento LineV
  LV_Fil1  dw ? 
  LV_Fil2  dw ?
  LV_Col   dw ?

  black db 0
  white db 0
  
  GameState  dw 0
  direccion  db ?
  jugadaVal  db 0
  turno      dw -1
  noMovCount db 0

  FichasW db 32
  FichasB db 32

datos ends

pushRegs macro
    push ax
    push bx
    push cx
    push dx
endm

Pausa Macro N
local Cic1,Cic2
     push cx
     mov cx, N
cic1: push cx
     mov cx, N
cic2: nop
     loop cic2
     pop cx
     loop cic1
     pop cx
EndM

popRegs macro
    pop dx
    pop cx
    pop bx
    pop ax
endm

pila segment stack 'stack'
   dw 256 dup(?)
pila endS

codigo segment
       Assume CS:codigo,DS:datos,SS:pila

;-------------------------------------------------------Dibuja---------------------------------------------------------
printAX proc
; imprime a la salida estándar un número que supone estar en el AX
; supone que es un número positivo y natural en 16 bits.
; lo imprime en decimal.  
    
    push AX
    push BX
    push CX
    push DX

    xor cx, cx
    mov bx, 10
ciclo1PAX: xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne ciclo1PAX
    mov ah, 02h
ciclo2PAX: pop DX
    add dl, 30h
    int 21h
    loop ciclo2PAX

    pop DX
    pop CX
    pop BX
    pop AX
    ret
printAX endP

AcercaD proc
    mov ax, 00h
    int 10h

    mov ax, 0012h   ; se pone el modo grÃ¡fico de 640x480 a 16 colores
    int 10h

    mov LH_Color, 1
    call drawBoard

    mov ah, 09h 
    lea dx, acercaDe
    int 21h

    pausa 3000

    mov ax, 0012h   ; se pone el modo grÃ¡fico de 640x480 a 16 colores
    int 10h

    mov LH_Color, 2

    call drawBoard
    call paintDisks

    ret
    AcercaD endP
Aiuda proc
    mov ax, 00h
    int 10h

    mov ax, 0012h   ; se pone el modo grÃ¡fico de 640x480 a 16 colores
    int 10h

    mov LH_Color, 1
    call drawBoard

    mov ah, 09h 
    lea dx, ayuda
    int 21h

    pausa 3000

    mov ax, 0012h   ; se pone el modo grÃ¡fico de 640x480 a 16 colores
    int 10h

    mov LH_Color, 2

    call drawBoard
    call paintDisks

    ret
    Aiuda endP

lineH Proc
; Despliega una linea del color LH_Color que va de la columna LH_Col1 a la columna LH_Col2 en la fila LH_Fil

  push ax
  push bx
  push cx
  push dx

  mov ax, LH_Col1
  cmp ax, LH_Col2
  jle LHsigue
  xchg ax, LH_Col2 
  xchg ax, LH_Col1
LHsigue:
  xor bx, bx
  mov ah, 0Ch
  mov al, LH_Color
  mov dx, LH_Fil
  mov cx, LH_Col1
cicloLH:
  cmp cx, LH_Col2
  jg salirLH
  int 10h
  inc cx
  jmp cicloLH
salirLH:
  pop dx
  pop cx
  pop bx
  pop ax
  ret 
lineH EndP
lineV Proc
; Despliega una linea del color LV_Color que va de la fila LV_Fil1 a la fila LV_Fil2 en la columna LV_Col

  push ax
  push bx
  push cx
  push dx

  mov ax, LV_Fil1
  cmp ax, LV_Fil2
  jle LVsigue
  xchg ax, LV_Fil2 
  xchg ax, LV_Fil1 
LVsigue:

  xor bx, bx
  mov ah, 0Ch
  mov al, LV_Color
  mov dx, LV_Fil1
  mov cx, LV_Col
cicloLV:
  cmp dx, LV_Fil2
  jg salirLV
  int 10h
  inc dx
  jmp cicloLV
salirLV:
  pop dx
  pop cx
  pop bx
  pop ax
  ret 
lineV EndP

drawBoard proc
    xor ax, ax
    mov LH_Col1, 0
    mov LH_Col2, 480
    mov LH_Fil, 0

    

    mov LV_Fil1, 0
    mov LV_Fil2, 480
    mov LV_Col, 0

paintBoard:
    cmp LH_Fil, 480
    je endPaint
    inc LH_Fil
    call LineH
    jmp paintBoard

endPaint:

    xor ax, ax
    mov LH_Col1, 0
    mov LH_Col2, 480
    mov LH_Fil, 0

    

    mov LV_Fil1, 0
    mov LV_Fil2, 480
    mov LV_Col, 0
    mov LH_Color, 15
    call LineH
    call LineV

drawLines:
    
    cmp LV_Col, 480
    je endLines
    add LV_Col, 60
    add LH_Fil, 60
    call LineV
    call LineH
    jmp drawLines

endLines:

ret
drawBoard endP

drawDisk proc
pushRegs
    mov ax, DiskX
    mov bl, 60
    mul bl
    mov LH_Col1, ax
    add LH_Col1, 15
    add ax, 45
    mov LH_Col2, ax

    mov ax, DiskY
    mov bl, 60
    mul bl
    mov LH_Fil, ax
    add LH_Fil,15
    add ax, 45
    
loopDisk:
    cmp LH_Fil, ax
    je endDisk
    inc LH_Fil
    call LineH
    jmp loopDisk

endDisk: 
popRegs
ret
drawDisk endP
axezador proc 
; supone los indices en cl y ch (fil y col)
; retorna en el ax el contenido
; supone en [si] un ptr a la matriz.
; supone los tamaños en dh y dl

    push bx
    push cx
    push dx
    push si

    cmp cl, 7
    jg notValid

    cmp cl, 0
    jl notValid
    
    cmp ch, 7
    jg notValid
    
    cmp ch, 0
    jl notValid
    
    mov al, cl
    mul dh
    mov bl, ch
    xor bh, bh
    add ax, bx
    shl ax, 1
    add si, ax
    mov ax, word ptr [si]
    jmp endAx

    notValid:
    xor ax, ax

    endAx:    

    pop si
    pop dx
    pop cx
    pop bx
    ret

axezador endp

Modificador proc 
; supone los indices en cl y ch (fil y col)
; Almacena en la celda el contenido del ax
; supone en [si] un ptr a la matriz.
; supone los tamaños en dh y dl

    push bx
    push cx
    push dx
    push si

    push ax

    mov al, cl
    mul dh
    mov bl, ch
    xor bh, bh
    add ax, bx
    shl ax, 1
    add si, ax

    pop ax
    mov word ptr [si], ax    

    pop SI
    pop DX
    pop CX
    pop BX
    ret

Modificador endp

paintDisks proc
pushRegs
lea si, matriz
mov dl, 8
mov dh, 8
mov cl, -1

loopOne:
    cmp cl, 7
    je endPaintDisk
    inc cl
    mov ch, -1
    loopTwo:
        cmp ch, 7
        je loopOne
        inc ch
        call axezador

        cmp ax, 0
        jl whiteDisk
        jg blackDisk
        jmp loopTwo

    whiteDisk:
        mov LH_Color, 15
        mov al, cl
        xor ah, ah
        mov DiskY, ax
        mov al, ch
        xor ah, ah
        mov DiskX, ax
        call drawDisk
        jmp loopTwo

    blackDisk:
        mov LH_Color, 0
        mov al, cl
        xor ah, ah
        mov DiskY, ax
        mov al, ch
        xor ah, ah
        mov DiskX, ax
        call drawDisk
        jmp loopTwo

    endPaintDisk:
popRegs
ret
paintDisks endP

turn proc
    pushRegs
    lea si, matriz
    mov dl, 8
    mov dh, 8


    getdot:

        mov LH_Color, 2
        call drawDisk

        call paintDisks;optimizar

        mov ax, ColDisk 
        mov DiskX, ax

        mov ax, FilDisk 
        mov DiskY, ax


        mov LH_Color, 14
        call drawDisk
        mov ah, 16
        int 16h

        cmp al, 97
        jne ene
        call Kortana
        jmp finito

        ene:
        cmp al, 110
        jne escape
        mov GameState, 2
        jmp finito
        escape:
        cmp al, 27  ; ESC se sale del programa
        jne F1
        mov GameState, 4
        jmp finito

        F1: cmp ah, 3Bh
            jne F2
            call Aiuda
            jmp getdot

        F2: cmp ah, 3Ch
            jne siguerevisando
            call AcercaD
            jmp getdot

        siguerevisando:
            cmp al, 32
            jne flechas
            jmp turnOver


    
        flechas: cmp ah, 72
                jne flecha2
                jmp arriba
        flecha2: cmp ah, 80
                jne flecha3
                jmp abajo
        flecha3: cmp ah, 75
                jne flecha4
                jmp izquierda
        flecha4: cmp ah, 77
                jne noinstruct
                jmp derecha
                
        noinstruct: jmp getdot

        arriba: cmp FilDisk, 0
                jle arr1
                dec FilDisk 
                jmp getdot
        arr1:  mov FilDisk, 0
                jmp getdot

        abajo:  cmp FilDisk, 7
                jge aba1
                inc FilDisk 
                jmp getdot
        aba1:   mov FilDisk,7
                jmp getdot

        izquierda: cmp ColDisk, 0
                jle izq1
                dec ColDisk 
                jmp getdot
        izq1:   mov ColDisk, 0
                jmp getdot
        derecha: cmp ColDisk, 7
                jge der1
                inc ColDisk 
                jmp getdot 
        der1:   mov ColDisk, 7
                jmp getdot


    turnOver: 
        
        cmp turno, 1
        je blackTurn
        mov LH_Color, 15
        call validacion1
        cmp jugadaVal,1
        je jugadaVB
        jmp jugadaNVB

    jugadaVB:
        sub FichasW, 1
        mov ax, DiskX
        mov cx, DiskY
        mov ch, al
        mov ax, turno
        call Modificador
        call drawDisk
        call Cambiacol
        mov jugadaVal, 0
        call writeLog
        neg turno
        jmp finito

    jugadaNVB:
        jmp getdot

    blackTurn:
        mov LH_Color, 0
        call validacion1
        cmp jugadaVal,1
        je jugadaVN
        jmp jugadaNVN

    jugadaVN:
        dec FichasB
        mov ax, DiskX
        mov cx, DiskY
        mov ch, al
        mov ax, turno
        call Modificador
        call drawDisk
        call Cambiacol
        mov jugadaVal, 0
        call writeLog
        neg turno
        jmp finito
        

    jugadaNVN:
        jmp getdot

    noMoves:
        inc GameState
    finito:

    popRegs
    ret
turn endP

veriFull proc
pushRegs
mov white, 0
mov black, 0
lea si, matriz
mov dl, 8
mov dh, 8
mov cl, -1

loopFullY:
    cmp cl, 7
    je Full
    inc cl
    mov ch, -1
    loopFullX:
        cmp ch, 7
        je loopFullY
        inc ch
        call axezador

        cmp ax, 0
        je NotFull
        jl whiteAdd
        inc black
        jmp loopFullX

        whiteAdd:
            inc white
        
        jmp loopFullX

    Full:
        inc GameState
        jmp siguePartida

    NotFull:
        cmp FichasB, 0
        jle pierdeBlack

        cmp FichasW, 0
        jle pierdeWhite
        jmp siguePartida
        pierdeBlack:
            inc GameState
            mov black, 0
            mov white, 10
            jmp siguePartida
        pierdeWhite:
            inc GameState
            mov black, 10
            mov white, 0
        siguePartida:
popRegs
ret
veriFull endP

Counter proc
pushRegs
mov white, 0
mov black, 0
lea si, matriz
mov dl, 8
mov dh, 8
mov cl, -1

loopCountY:
    cmp cl, 7
    je endCount
    inc cl
    mov ch, -1
    loopCountX:
        cmp ch, 7
        je loopCountY
        inc ch
        call axezador

        cmp ax, 0
        jl whiteInc
        jg blackInc
        
        jmp loopCountX
        
        blackInc:
            inc black
            jmp continue
        whiteInc:
            inc white
        continue:
        
        jmp loopCountX
    endCount:

popRegs
ret
Counter endP

;-----------------------------------------------------Validaciones-----------------------------------------------------
validacion1 proc
    pushRegs
    mov ax, DiskX
    mov cx, DiskY
    mov ch, al
    
    call axezador   
    cmp ax, 0
    je otrasval
    jmp novalida

    otrasval:
        call validacion2
    novalida:
        popRegs
        ret
        validacion1 endP
validacion2 proc
    pushRegs
    verificaIzq:
        dec ch
        call axezador  ;Saca el elemento de la izquierda  
        neg turno      ;Turno contrario
        cmp ax, turno  ;Revisa que el elemento en la matriz sea igual al turno contrario
        popRegs
        jne verificaDer
        ;Si no salta hace val3
        mov direccion, 1
        call validacion3 ;Siempre sale con turno contrario
        cmp jugadaVal, 0 ;Revisa que la jugada sea valida
        je verificaDer
        jmp salirV2

    verificaDer:
        pushRegs
        inc ch
        call axezador   ;Saca el elemento de la derecha   
        cmp ax, turno   ;Revisa que el elemento en la matriz sea igual al turno contrario
        popRegs
        jne verificarArriba
        ;Si no salta hace val3
        mov direccion, 2
        call validacion3 ;Siempre sale con turno contrario
        cmp jugadaVal, 0 ;Revisa que la jugada sea valida
        je verificarArriba
        jmp salirV2

    verificarArriba:
        pushRegs
        dec cl
        call axezador   ;Saca el elemento de arriba
        cmp ax, turno   ;Revisa que el elemento en la matriz sea igual al turno contrario
        popRegs
        jne verificarAbajo
        ;Si no salta hace val3
        mov direccion, 3
        call validacion3 ;Siempre sale con turno contrario
        cmp jugadaVal, 0 ;Revisa que la jugada sea valida
        je verificarAbajo
        jmp salirV2

    verificarAbajo:     
        pushRegs
        inc cl
        call axezador   ;Saca el elemento de abajo  
        cmp ax, turno   ;Revisa que el elemento en la matriz sea igual al turno contrario
        popRegs
        jne verifDIarriba
        ;Si no salta hace val3
        mov direccion, 4
        call validacion3 ;Siempre sale con turno contrario
        cmp jugadaVal, 0 ;Revisa que la jugada sea valida
        je verifDIarriba
        jmp salirV2

    verifDIarriba: 
        pushRegs
        dec cl
        dec ch
        call axezador   ;Saca el elemento de la diagonal izquierda arriba
        cmp ax, turno   ;Revisa que el elemento en la matriz sea igual al turno contrario
        popRegs
        jne verifDDarriba
        ;Si no salta hace val3
        mov direccion, 5
        call validacion3 ;Siempre sale con turno contrario
        cmp jugadaVal, 0 ;Revisa que la jugada sea valida
        je verifDDarriba
        jmp salirV2

    verifDDarriba: 
        pushRegs
        dec cl
        inc ch
        call axezador   ;Saca el elemento de la diagonal derecha arriba
        cmp ax, turno   ;Revisa que el elemento en la matriz sea igual al turno contrario 
        popRegs
        jne verifDIabajo
        ;Si no salta hace val3
        mov direccion, 6
        call validacion3 ;Siempre sale con turno contrario
        cmp jugadaVal, 0 ;Revisa que la jugada sea valida
        je verifDIabajo
        jmp salirV2

    verifDIabajo: 
        pushRegs
        inc cl
        dec ch
        call axezador   ;Saca el elemento de la diagonal izquierda abajo
        cmp ax, turno   ;Revisa que el elemento en la matriz sea igual al turno contrario
        popRegs        
        jne verifDDabajo
        ;Si no salta hace val3
        mov direccion, 7
        call validacion3 ;Siempre sale con turno contrario

        cmp jugadaVal, 0 ;Revisa que la jugada sea valida
        je verifDDabajo
        jmp salirV2

    verifDDabajo: 
        pushRegs
        inc cl
        inc ch
        call axezador   ;Saca el elemento de la diagonal derecha abajo
        cmp ax, turno   ;Revisa que el elemento en la matriz sea igual al turno contrario 
        popRegs
        jne salirV2
        ;Si no salta hace val3
        mov direccion, 8
        call validacion3 ;Siempre sale con turno contrario

    salirV2:
        neg turno 
        ret
validacion2 endP
validacion3 proc
pushRegs
    mov jugadaVal,0
    neg turno ;turno correcto
;----------------------------------------------Comparacion------------------------------------------------

    direc1:cmp direccion,1
        jne direc2
        jmp V3direc1

    direc2:cmp direccion,2
        jne direc3
        jmp V3direc2

    direc3:cmp direccion,3
        jne direc4
        jmp V3direc3

    direc4:cmp direccion,4
        jne direc5
        jmp V3direc4

    direc5:cmp direccion,5
        jne direc6
        jmp V3direc5

    direc6:cmp direccion,6
        jne direc7
        jmp V3direc6

    direc7:cmp direccion,7
        jne direc8
        jmp V3direc7

    direc8:cmp direccion,8
        je SaltoConejo
        jmp salirV3

SaltoConejo:
    jmp V3direc8

;----------------------------------------------Realiza V3-------------------------------------------------
    V3direc1: dec ch
        call axezador
        cmp ax, 0
        je SaltoConejo2
        cmp ax, turno
        jne V3direc1
        mov jugadaVal,1
        jmp salirV3

    V3direc2: inc ch
        call axezador
        cmp ax, 0
        je SaltoConejo2
        cmp ax, turno
        jne V3direc2
        mov jugadaVal,1
        jmp salirV3

    V3direc3: dec cl
        call axezador
        cmp ax, 0
        je SaltoConejo2
        cmp ax, turno
        jne V3direc3
        mov jugadaVal,1
        jmp salirV3

    V3direc4: inc cl
        call axezador
        cmp ax, 0
        je SaltoConejo2
        cmp ax, turno
        jne V3direc4
        mov jugadaVal,1
        jmp salirV3

SaltoConejo2:
    mov jugadaVal,0
    jmp salirV3

    V3direc5: dec cl
        dec ch
        call axezador
        cmp ax, 0
        je SaltoConejo2
        cmp ax, turno
        jne V3direc5
        mov jugadaVal,1
        jmp salirV3

    V3direc6: dec cl
        inc ch
        call axezador
        cmp ax, 0
        je SaltoConejo2
        cmp ax, turno
        jne V3direc6
        mov jugadaVal,1
        jmp salirV3

    V3direc7: inc cl
        dec ch
        call axezador
        cmp ax, 0
        je SaltoConejo2
        cmp ax, turno
        jne V3direc7
        mov jugadaVal,1
        jmp salirV3

    V3direc8: inc cl
        inc ch
        call axezador
        cmp ax, 0
        je salirV3
        cmp ax, turno
        jne V3direc8
        mov jugadaVal,1    

    salirV3:
        neg turno
        popRegs
        ret 
validacion3 endP

;-----------------------------------------------------Cambia color-----------------------------------------------------
Cambiacol proc
    pushRegs
    mov ax, DiskX
    mov cx, DiskY
    mov ch, al
    verificaIzqC:
        dec ch
        call axezador  ;Saca el elemento de la izquierda  
        neg turno      ;Turno contrario
        cmp ax, turno  ;Revisa que el elemento en la matriz sea igual al turno contrario
        popRegs
        jne verificaDerC
        ;Si no salta hace val3
        mov direccion, 1
        call Cambiacol2  ;Siempre sale con turno contrario
        


    verificaDerC:
        pushRegs
        inc ch
        call axezador   ;Saca el elemento de la derecha   
        cmp ax, turno   ;Revisa que el elemento en la matriz sea igual al turno contrario
        popRegs
        jne verificarArribaC
        ;Si no salta hace val3
        mov direccion, 2
        call Cambiacol2 ;Siempre sale con turno contrario
        


    verificarArribaC:
        pushRegs
        dec cl
        call axezador   ;Saca el elemento de arriba
        cmp ax, turno   ;Revisa que el elemento en la matriz sea igual al turno contrario
        popRegs
        jne verificarAbajoC
        ;Si no salta hace val3
        mov direccion, 3
        call Cambiacol2 ;Siempre sale con turno contrario
        


    verificarAbajoC:     
        pushRegs
        inc cl
        call axezador   ;Saca el elemento de abajo  
        cmp ax, turno   ;Revisa que el elemento en la matriz sea igual al turno contrario
        popRegs
        jne verifDIarribaC
        ;Si no salta hace val3
        mov direccion, 4
        call Cambiacol2 ;Siempre sale con turno contrario


    verifDIarribaC: 
        pushRegs
        dec cl
        dec ch
        call axezador   ;Saca el elemento de la diagonal izquierda arriba
        cmp ax, turno   ;Revisa que el elemento en la matriz sea igual al turno contrario
        popRegs
        jne verifDDarribaC
        ;Si no salta hace val3
        mov direccion, 5
        call Cambiacol2 ;Siempre sale con turno contrario


    verifDDarribaC: 
        pushRegs
        dec cl
        inc ch
        call axezador   ;Saca el elemento de la diagonal derecha arriba
        cmp ax, turno   ;Revisa que el elemento en la matriz sea igual al turno contrario 
        popRegs
        jne verifDIabajoC
        ;Si no salta hace val3
        mov direccion, 6
        call Cambiacol2 ;Siempre sale con turno contrario

    verifDIabajoC: 
        pushRegs
        inc cl
        dec ch
        call axezador   ;Saca el elemento de la diagonal izquierda abajo
        cmp ax, turno   ;Revisa que el elemento en la matriz sea igual al turno contrario
        popRegs        
        jne verifDDabajoC
        ;Si no salta hace val3
        mov direccion, 7
        call Cambiacol2 ;Siempre sale con turno contrario

    verifDDabajoC: 
        pushRegs
        inc cl
        inc ch
        call axezador   ;Saca el elemento de la diagonal derecha abajo
        cmp ax, turno   ;Revisa que el elemento en la matriz sea igual al turno contrario 
        popRegs
        jne salirCcol;Si no salta hace val3
        mov direccion, 8
        call Cambiacol2 ;Siempre sale con turno contrario


    salirCcol:
        neg turno 
        ret
        Cambiacol endP

Cambiacol2 proc
    pushRegs
    
    neg turno ;turno correcto
;----------------------------------------------Comparacion-------------------------------------------------------------

    direcC1:cmp direccion,1
        jne direcC2
        jmp CCdirec1

    direcC2:cmp direccion,2
        jne direcC3
        jmp CCdirec2

    direcC3:cmp direccion,3
        jne direcC4
        jmp CCdirec3

    direcC4:cmp direccion,4
        jne direcC5
        jmp CCdirec4

    direcC5:cmp direccion,5
        jne direcC6
        jmp CCdirec5

    direcC6:cmp direccion,6
        jne direcC7
        jmp CCdirec6

    direcC7:cmp direccion,7
        jne direcC8
        jmp CCdirec7

    direcC8:cmp direccion,8
        je SaltoConejoCC1
        jmp salirCC

SaltoConejoCC1:
    jmp CCdirec8

;----------------------------------------------Realiza V3-------------------------------------------------------------
    CCdirec1: dec ch
        call axezador
        cmp ax, 0
        je SaltoConejoCC2
        cmp ax, turno
        jne CCdirec1
        mov jugadaVal,1

        loopCC1: inc ch
            call axezador
            cmp ax, turno 
            jne pintaCC1
            jmp salirCC
            pintaCC1:
                mov ax, turno
                call Modificador
                call drawDisk
                jmp loopCC1

    CCdirec2: inc ch
        call axezador
        cmp ax, 0
        je SaltoConejoCC2
        cmp ax, turno
        jne CCdirec2

        loopCC2: dec ch
            call axezador
            cmp ax, turno 
            jne pintaCC2
            jmp salirCC
            pintaCC2:
                mov ax, turno
                call Modificador
                call drawDisk
                jmp loopCC2

    CCdirec3: dec cl
        call axezador
        cmp ax, 0
        je SaltoConejoCC2
        cmp ax, turno
        jne CCdirec3

        loopCC3: inc cl
            call axezador
            cmp ax, turno 
            jne pintaCC3
            jmp salirCC
            pintaCC3:
                mov ax, turno
                call Modificador
                call drawDisk
                jmp loopCC3

SaltoConejoCC2:
    mov jugadaVal,0
    jmp salirCC

    CCdirec4: inc cl
        call axezador
        cmp ax, 0
        je SaltoConejoCC2
        cmp ax, turno
        jne CCdirec4

        loopCC4: dec cl
            call axezador
            cmp ax, turno 
            jne pintaCC4
            jmp salirCC
            pintaCC4:
                mov ax, turno
                call Modificador
                call drawDisk
                jmp loopCC4

    CCdirec5: dec cl
        dec ch
        call axezador
        cmp ax, 0
        je SaltoConejoCC2
        cmp ax, turno
        jne CCdirec5

        loopCC5: inc cl
            inc ch
            call axezador
            cmp ax, turno 
            jne pintaCC5
            jmp salirCC
            pintaCC5:
                mov ax, turno
                call Modificador
                call drawDisk
                jmp loopCC5

    CCdirec6: dec cl
        inc ch
        call axezador
        cmp ax, 0
        je SaltoConejoCC2
        cmp ax, turno
        jne CCdirec6

        loopCC6: inc cl
            dec ch
            call axezador
            cmp ax, turno 
            jne pintaCC6
            jmp salirCC
            pintaCC6:
                mov ax, turno
                call Modificador
                call drawDisk
                jmp loopCC6

    CCdirec7: inc cl
        dec ch
        call axezador
        cmp ax, 0
        je salirCC
        cmp ax, turno
        jne CCdirec7

        loopCC7: dec cl
            inc ch
            call axezador
            cmp ax, turno 
            jne pintaCC7
            jmp salirCC
            pintaCC7:
                mov ax, turno
                call Modificador
                call drawDisk
                jmp loopCC7

    CCdirec8: inc cl
        inc ch
        call axezador
        cmp ax, 0
        je salirCC
        cmp ax, turno
        jne CCdirec8
        loopCC8: dec cl
            dec ch
            call axezador
            cmp ax, turno 
            jne pintaCC8
            jmp salirCC
            pintaCC8:
                mov ax, turno
                call Modificador
                call drawDisk
                jmp loopCC8

    salirCC:
        neg turno
        popRegs
        ret 
        Cambiacol2 endP

writeLog proc
pushRegs
    

    cmp turno, 0
    jl turnoB
    jg turnoN
    turnoB:
        mov n1, 'B'
        jmp cont
    turnoN:
        mov n1, 'N'
    cont:

    mov ax, DiskX
    add nX, al
    mov ax, DiskY
    add nY, al
    mov ah, 40h
    mov cx, 27
    lea dx, deColor
    mov bx, handleS
    int 21h
    mov nX, '0'
    mov nY, '0'
    
    
popRegs
ret
writeLog endP

hayMove proc
pushRegs
lea si, matriz
mov dl, 8
mov dh, 8
mov cl, -1

loopMoveY:
    cmp cl, 7
    je noMove
    inc cl
    mov ch, -1
    loopMoveX:
        cmp ch, 7
        je loopMoveY
        inc ch
        
        mov al, cl
        xor ah, ah
        mov DiskY, ax

        mov al, ch
        xor ah, ah
        mov DiskX, ax

        call validacion1

        cmp jugadaVal, 1
        je validMove
        ;aquí se revisa si la posición tiene jugadas válidas
        jmp loopMoveX


    validMove:
        mov LH_Color, 5
        mov noMovCount,0
        jmp final

    noMove:
    
        inc noMovCount
        neg turno

    final:
        mov jugadaVal, 0
popRegs
ret
hayMove endP

clearBoard proc
pushRegs
mov FichasB, 32
mov FichasW, 32

mov ah, 3Eh ; cerrar el archivo de salida
mov bx, handleS
int 21h

lea si, matriz
mov dl, 8
mov dh, 8
mov cl, -1

loopClearY:
     
    cmp cl, 7
    je cleared
    inc cl
    mov ch, -1
    loopClearX:
        cmp ch, 7
        je loopClearY
        inc ch
        xor ax, ax
        call modificador
        jmp loopClearX

    cleared:
    mov cl, 3
    mov ch, 3
    mov ax, -1
    call modificador
    mov cl, 3
    mov ch, 4
    mov ax, 1
    call modificador
    mov cl, 4
    mov ch, 3
    mov ax, 1
    call modificador
    mov cl, 4
    mov ch, 4
    mov ax, -1
    call modificador
    mov GameState, 0
    mov turno, -1
    mov DiskX, 0
    mov DiskY, 0
    mov LH_Color,2
    call drawBoard
    call paintDisks

    inc num
    mov ah, 3Ch  ; crear el archivo de salida 
    lea dx, gameLog
    xor cx, cx
    int 21h
    mov handleS, ax
popRegs
ret
clearBoard endp

Kortana proc
pushRegs
lea si, matriz
mov dl, 8
mov dh, 8

mov ax, FilDisk 
mov cl, al
loopAutoY:
    cmp cl, 7
    je  reinicio
    jmp continua

    reinicio:
        mov cl, -1
    continua:

    inc cl
    mov ch, -1
    loopAutoX:
        cmp ch, 7
        je loopAutoY
        inc ch
        
        mov al, cl
        xor ah, ah
        mov DiskY, ax

        mov al, ch
        xor ah, ah
        mov DiskX, ax

        call validacion1

        cmp jugadaVal, 1
        je play
         ;aquí se revisa si la posición tiene jugadas válidas
        jmp loopAutoX


    play:
        cmp turno, 1
        jne noUno
        dec FichasB
        jmp kachow
        noUno:
        dec FichasW
        kachow:


        mov ax, DiskX
        mov cx, DiskY
        mov ch, al
        mov ax, turno
        call Modificador
        ;call drawDisk
        call Cambiacol
        mov jugadaVal, 0
        call writeLog
        neg turno
    noplay:
popRegs
ret
Kortana endP
;--------------------------------------------------------Main----------------------------------------------------------
main: mov ax, pila
      mov ss, ax
      mov ax, datos
      mov ds, ax

      mov ah, 3Ch  ; crear el archivo de salida 
      lea dx, gameLog
      xor cx, cx
      int 21h
      mov handleS, ax

      newJuego:
      mov ax, 00h  
      int 10h

      mov ax, 0012h   ; se pone el modo grÃ¡fico de 640x480 a 16 colores
      int 10h

      mov LH_Color, 1
      call drawBoard

      mov ah, 09h 
      lea dx, choose
      int 21h

      mov ah, 16
      int 16h

      cmp al, 98
      jne startWhite
      mov turno, 1
      startWhite:
      

      mov LH_Color, 2

      call drawBoard

      call paintDisks

      mov DiskX, 0
      mov DiskY, 0

      gameloop:
        


        call veriFull
        call Counter
        mov dl, 62
        mov dh, 5
        mov ah, 02h  ; se restaura el modo texto usual antes de salir
        int 10h

        mov al, white
        xor ah, ah
        call printAX

        mov dl, 62
        mov dh, 10
        mov ah, 02h  ; se restaura el modo texto usual antes de salir
        int 10h

        mov al, black
        xor ah, ah
        call printAX

        cmp GameState, 0
        jne noOneMoves

        call hayMove
        cmp noMovCount, 1
        je skip
        jg tied

        call turn
        cmp GameState, 0
        jne noOneMoves
        
        skip:
        
        jmp gameloop

        noOneMoves:
        cmp GameState, 2
        je newGame
        jg fin
        jl checkWin

        newGame:
            call clearBoard
            mov DiskX, 0
            mov DiskY, 0
            jmp newJuego

        checkWin:
        mov al, white
        cmp black, al
        jl whiteWin
        je tied

            mov LH_Color, 0
            call drawBoard
            jmp fin
        whiteWin:
            mov LH_Color, 15
            call drawBoard
            jmp fin
        tied: 
            mov LH_Color, 10
            call drawBoard

fin:
      mov ah, 3Eh ; cerrar el archivo de salida
      mov bx, handleS
      int 21h

      pausa 2000

      mov ax, 0003h  ; se restaura el modo texto usual antes de salir
      int 10h

      mov ax, 4C00h
      int 21h 


codigo ends

end main