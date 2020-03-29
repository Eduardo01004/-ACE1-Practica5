;-----------------MACROS COMUNES------------------
imprimir macro string
    mov ah,09
    mov dx,offset string
    int 21h
endm

getTexto macro buffer
	LOCAL INICIO,FIN
    push si
	xor si,si
	INICIO:
		getChar	
		cmp al,0dh
		je FIN
		mov buffer[si],al
		inc si
		jmp INICIO
	FIN:
		mov buffer[si],'$'
        pop si
endm


getChar macro
    mov ah,0dh
    int 21h
    mov ah,01h
    int 21h
endm

escribir macro
    mov ah,09h
    int 21h
    mov ah,01h ; lee el caracter
    int 21h; interrupcion
endm

limpiarPantalla MACRO
	mov ah,00h
	mov al,03h
	int 10h
endm

pintar macro x,y ,color
	mov ah, 0ch
	mov cx, x ; columna
	mov dx, y ; fila
	mov al, color ;en al almacena el color
	mov bh, 0
	int 10h
endm

PintarPlano macro 
    LOCAL pintarx,parar,pintaryll,salir
	mov ax, 0013h ;este es para 40x25 46 colores 320x200
	int 10h
    xor si,si
    pintarx:
        cmp si,320 ;maximo de la pantalla en x
            je parar
        pintar si,99,10
        inc si
        jmp pintarx
    parar:
        xor si,si
        jmp pintaryll
    pintaryll:
        cmp si,200 ; en y
		je salir
        pintar 150, si, 10
        inc si
        jmp pintaryll
    salir:
        getChar
        jmp MenuPrincipal

endm