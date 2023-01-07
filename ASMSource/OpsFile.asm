;Este es un programa que contiene las operaciones de archivos necesarias para Rursus
;Andres Sanchez Rojas
;
;
;Usa código de los ejemplos GATODIR.ASM, SIZE.ASM y REVES.ASM
;
;
;Autoevaluación
;
;Open: A
;Close: A
;Write: A
;Read: B Decidí cerrar y volver a abrir el archivo para regresar a la posición inicial
;Create: A
;Asociar: E No la hice, no supe como ver y menos editar los metadatos del archivo
;

datos segment

    base dw 10
    fileName db "filemon.txt",0
    fileSize dw ?
    fileHandle dw ?
    fileBuffer db "Este archivo se llama filemon",10,13
    bufferSize dw 31

    readBuffer db 128 dup('$')

    opErrorMsg db "Hubo un error al abrir el archivo",10,13,"$"
    opSuccessMsg db "Archivo abierto exitosamente",10,13,"$"

    clErrorMsg db "Hubo un error al cerrar el archivo",10,13,"$"
    clSuccessMsg db "Archivo cerrado exitosamente",10,13,"$"

    wErrorMsg db "Hubo un error al escribir al archivo",10,13,"$"
    wSuccessMsg db "Archivo escrito exitosamente",10,13,"$"

    rErrorMsg db "Hubo un error al leer el archivo",10,13,"$"
    rSuccessMsg db "Archivo leido exitosamente",10,13,"$"

    crErrorMsg db "Hubo un error al crear el archivo",10,13,"$"
    crSuccessMsg db "Archivo creado exitosamente",10,13,"$"

    assErrorMsg db "Hubo un error al asociar el archivo",10,13,"$"
    assSuccessMsg db "Archivo asociado exitosamente",10,13,"$"



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

;Open file
;Asume un puntero al nombre del archivo en dx
opFile Proc
    pushRegs
    mov ah, 3Dh ; abrir el archivo de entrada 
    mov al, 2
    int 21h
    jnc endOpen
    
    call printAX

    mov ah, 09h
    lea dx, opErrorMsg
    int 21h    
    popRegs
    ret
    
    endOpen:
    mov fileHandle, ax
    mov ah, 09h
    lea dx, opSuccessMsg
    int 21h 

    popRegs
    ret
opFile EndP


;Close file
clFile Proc
    pushRegs
    mov ah, 3Eh ; cerrar el archivo de entrada
    mov bx, fileHandle
    mov fileHandle, ax
    int 21h 
    jnc endClose

    call printAX
    mov ah, 09h
    lea dx, clErrorMsg
    int 21h    
    popRegs
    ret
    
    endClose:
    mov ah, 09h
    lea dx, clSuccessMsg
    int 21h  

    popRegs
    ret
clFile EndP


;Write file
;Abre un archivo en modo de escritura y le escribe el mensaje especificado en el fileBuffer con el tamaño especificado en bufferSize
;Asume un puntero al nombre del archivo en dx y asume el handle del archivo en la variable fileHandle
wFile Proc
    pushRegs
    mov ah, 40h
    mov cx, bufferSize
    lea dx, fileBuffer
    mov bx, fileHandle
    int 21h
    jnc endWrite

    mov ah, 09h
    lea dx, wErrorMsg
    int 21h    
    popRegs
    ret
    
    endWrite:
    mov ah, 09h
    lea dx, wSuccessMsg
    int 21h    

    popRegs
    ret
wFile EndP


;Read File
;Abre un archivo en modo de lectura
;Asume el nombre del archivo en fileName
;Asume un puntero al nombre del archivo en dx y deja el handle del archivo en la variable fileHandle
;deja el tamaño del archivo en fileSize
rFile Proc
    pushRegs
    mov ah, 42h 
    mov al, 2 ; un 2 en al mueve el pointer al final del archivo
    mov bx, fileHandle
    xor dx, dx      
    xor cx, cx   ; se ponga al final del archivo
    int 21h 
    mov fileSize, ax

    lea dx, fileName
    call clFile
    lea dx, fileName
    call opFile

    mov ah, 3Fh
    xor al, al
    mov bx, fileHandle
    mov cx, fileSize
    lea dx, readBuffer
    int 21h
    jc readError

    mov ah, 09h
    lea dx, readBuffer
    int 21h    

    mov ah, 09h
    lea dx, rSuccessMsg
    int 21h    

    popRegs
    ret
    readError: 
    mov ah, 09h
    lea dx, rErrorMsg
    int 21h    
    
    popRegs
    ret
rFile EndP


;Create File
;Crea un archivo con el nombre especificado en
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


;Associate File
assFile Proc
    pushRegs
    
    popRegs
    ret
assFile EndP


main: mov ax, pila
    mov ss, ax

    mov ax, datos
    mov ds, ax

    lea dx, fileName
    call crFile
    call opFile
    call wFile
    call rFile
    call clFile

    mov ax, 4C00h
    int 21h 

codigo ends

end main