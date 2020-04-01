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


printCarac macro char
    mov ah,2
    mov dl, char
    int 21h
endm
;----------------------PARA DERIVAR----------------

OperarDerivada macro 
    LOCAL Contar,fin
    Contar:
        sub grado0,48
        sub grado1,48
        sub grado2,48
        sub grado3,48
        sub grado4,48
        xor di,di
        jmp DerivarX4
    DerivarX4:
        mov sigd3,1
        cmp sig4,1
            je D4
        mov sigd3,0
        mov arrayderivada[di],45
        inc di
        jmp D4
    D4:
        xor ax,ax
        xor bx,bx
        xor dx,dx

        mov al,4
        mov bx,grado4
        mul bx
        mov dgrado3 , ax
        cmp ax,9
            ja Dosdigitos
        add al,48

        mov arrayderivada[di],al
        inc di
        mov arrayderivada[di],88
        inc di
        mov arrayderivada[di],51
        inc di
        mov arrayderivada[di],32
        inc di
        jmp DerivadaX3
    Dosdigitos:
        mov dx,0
        mov bx,10
        div bx
        add al,48
        add dl,48

        mov arrayderivada[di],al
        inc di
        mov arrayderivada[di],dl
        inc di
        mov arrayderivada[di],88
        inc di
        mov arrayderivada[di],51
        inc di
        mov arrayderivada[di],32
        inc di
        jmp DerivadaX3
    DerivadaX3:
        mov sigd2,1
        mov arrayderivada[di],43

        cmp sigd3,1
            je D3
        mov sigd2,0
        mov arrayderivada[di],45
        jmp D3
        D3:
            inc di
            xor ax,ax
            xor bx,bx
            xor dx,dx

            mov al,3
            mov bx,grado3
            mul bx
            mov dgrado2 , ax
            cmp ax,9
                ja Dosdigitos2
            add al,48

            mov arrayderivada[di],32
            inc di
            mov arrayderivada[di],al
            inc di
            mov arrayderivada[di],88
            inc di
            mov arrayderivada[di],50
            inc di
            mov arrayderivada[di],32
            inc di
            jmp DerivadaX2

    Dosdigitos2:
        mov dx,0
        mov bx,10
        div bx
        add al,48
        add dl,48

        mov arrayderivada[di],32
        inc di
        mov arrayderivada[di],al
        inc di
        mov arrayderivada[di],dl
        inc di
        mov arrayderivada[di],88
        inc di
        mov arrayderivada[di],50
        inc di
        mov arrayderivada[di],32
        inc di
        jmp DerivadaX2


    DerivadaX2:
        mov sigd1,1
        mov arrayderivada[di],43

        cmp sigd2,1
            je D2
        mov sigd1,0
        mov arrayderivada[di],45
        
        jmp D2
    
    D2:
        inc di
        xor ax,ax
        xor bx,bx
        xor dx,dx

        mov al,2
        mov bx,grado2
        mul bx
        mov dgrado1 , ax
        cmp ax,9
            ja Dosdigitos3
        add al,48

        mov arrayderivada[di],32
        inc di
        mov arrayderivada[di],al
        inc di
        mov arrayderivada[di],88
        inc di
        mov arrayderivada[di],49
        inc di
        mov arrayderivada[di],32
        inc di
        jmp DerivadaX1

        Dosdigitos3:
            mov dx,0
            mov bx,10
            div bx
            add al,48
            add dl,48

            mov arrayderivada[di],32
            inc di
            mov arrayderivada[di],al
            inc di
            mov arrayderivada[di],dl
            inc di
            mov arrayderivada[di],88
            inc di
            mov arrayderivada[di],50
            inc di
            mov arrayderivada[di],32
            inc di
            jmp DerivadaX1

        DerivadaX1:
            mov sigd0,1
            mov arrayderivada[di],43

            cmp sigd1,1
                je D1
            mov sig0,0
            mov arrayderivada[di],45
            
            jmp D1
        D1:
            inc di
            xor ax,ax
            xor bx,bx
            xor dx,dx

            mov al,1
            mov bx,grado1
            mul bx
            mov dgrado0,ax
            add al,48
            mov arrayderivada[di],32
            inc di
            mov arrayderivada[di],al
            inc di      

        
    fin:


endm 


;----------------------PARA GRAFICAR ----------------
pintar macro x,y ,color
	mov ah, 0ch
	mov cx, x ; columna
	mov dx, y ; fila
	mov al, color ;en al almacena el color
	mov bh, 0
	int 10h
endm

PintarPlano macro 
    LOCAL pintarx,parar,pintaryll,salir,G1,G2,G3
	mov ax, 0013h ;este es para 40x25 46 colores 320x200
	int 10h
    xor si,si
    pintarx:
        cmp si,320 ;maximo de la pantalla en x
            je parar
        pintar si,99,2
        inc si
        jmp pintarx
    parar:
        xor si,si
        jmp pintaryll
    pintaryll:
        cmp si,200 ; en y
		je salir
        pintar 150, si, 2
        inc si
        jmp pintaryll
    salir:
        cmp flag_normal,1
            je G1
        cmp flag_derivada,1
            je G2
        cmp flag_integral,1
            je G3
    G1:
        GraficarNormal
    G2:
        GraficarDerivada
    G3:
        GraficarIntegral

endm


pedirInicial macro
    LOCAL Pedir,Pedir2,pedirneg,pedirneg2,conv2,converitr,PedirFin
    Pedir:
        imprimir intervaloini
        imprimir salto
        getChar
        cmp al,45       ;si primero viene un negativo
            je pedirneg
        cmp al,48          ;0
            je Pedir2
        cmp al,49
            je Pedir2
        cmp al,50
            je Pedir2
        cmp al,51
            je Pedir2
        cmp al,52
            je Pedir2
        cmp al,53
            je Pedir2
        cmp al,54
            je Pedir2
        cmp al,55
            je Pedir2
        cmp al,56
            je Pedir2
        cmp al,57       ;9
            je Pedir2

        imprimir salto
        imprimir noes
        getChar
        jmp MenuPrincipal

        Pedir2:
            sub al,48   ;quitar para obtener el valor real
            mov ah,0
            mov iniX,ax

            getChar
            cmp al,13
                je PedirFin

            cmp al,48          ;0
                je converitr
            cmp al,49
                je converitr
            cmp al,50
                je converitr
            cmp al,51
                je converitr
            cmp al,52
                je converitr
            cmp al,53
                je converitr
            cmp al,54
                je converitr
            cmp al,55
                je converitr
            cmp al,56
                je converitr
            cmp al,57       ;9
                je converitr

            imprimir salto
            imprimir noes
            getChar
            jmp MenuPrincipal

        converitr:
            sub al,48 ; se que quita el ascci
            xor cx,cx
            mov cl,al
            xor ax,ax
            mov ax,iniX
            mov bx,10
            mul bx
            add ax,cx
            mov iniX,ax
            jmp PedirFin

        pedirneg:
            getChar

            cmp al,48          ;0
                je pedirneg2
            cmp al,49
                je pedirneg2
            cmp al,50
                je pedirneg2
            cmp al,51
                je pedirneg2
            cmp al,52
                je pedirneg2
            cmp al,53
                je pedirneg2
            cmp al,54
                je pedirneg2
            cmp al,55
                je pedirneg2
            cmp al,56
                je pedirneg2
            cmp al,57       ;9
                je pedirneg2

            imprimir salto
            imprimir noes
            getChar
            jmp MenuPrincipal

        pedirneg2:  
            mov ah,0
            sub al,48   ; se le quita el ascii
            neg ax      ;se niega el numero convierte negativo
            mov iniX,ax ; se guarda en la varible

            getChar

            cmp al,13
            je PedirFin

            cmp al,48          ;0
                je conv2
            cmp al,49
                je conv2
            cmp al,50
                je conv2
            cmp al,51
                je conv2
            cmp al,52
                je conv2
            cmp al,53
                je conv2
            cmp al,54
                je conv2
            cmp al,55
                je conv2
            cmp al,56
                je conv2
            cmp al,57       ;9
                je conv2

            imprimir salto
            imprimir noes
            getChar
            jmp MenuPrincipal
        conv2:
            sub al,48
            xor cx,cx
            mov cl,al
            xor ax,ax
            mov ax,iniX
            neg ax
            mov bx,10
            mul bx
            add ax,cx
            neg ax
            mov iniX,ax
            jmp PedirFin

        PedirFin:
            PedirFinal
            
            ;PintarPlano
    
endm

PedirFinal macro
    LOCAL PedirFin,FinNeg,Pedir2,converitr,pedirneg2,conv2,Evaluar
    PedirFin:
        imprimir salto
        imprimir intervalofin
        imprimir salto
        getChar
        cmp al, 45
            je FinNeg
            
        cmp al,48          ;0
            je Pedir2
        cmp al,49
            je Pedir2
        cmp al,50
            je Pedir2
        cmp al,51
            je Pedir2
        cmp al,52
            je Pedir2
        cmp al,53
            je Pedir2
        cmp al,54
            je Pedir2
        cmp al,55
            je Pedir2
        cmp al,56
            je Pedir2
        cmp al,57       ;9
            je Pedir2

        imprimir salto
        imprimir noes
        getChar
        jmp MenuPrincipal
        
    Pedir2:
        sub al,48   ;quitar para obtener el valor real
        mov ah,0
        mov finX,ax

        getChar
        cmp al,13
            je Evaluar

        cmp al,48          ;0
            je converitr
        cmp al,49
            je converitr
        cmp al,50
            je converitr
        cmp al,51
            je converitr
        cmp al,52
            je converitr
        cmp al,53
            je converitr
        cmp al,54
            je converitr
        cmp al,55
            je converitr
        cmp al,56
            je converitr
        cmp al,57       ;9
            je converitr

        imprimir salto
        imprimir noes
        getChar
        jmp MenuPrincipal
    converitr:
        sub al,48
        xor cx,cx
        mov cl,al
        xor ax,ax
        mov ax,finX
        mov bx,10
        mul bx
        add ax,cx
        mov finX,ax
        jmp Evaluar
    FinNeg:
        getChar

        cmp al,48          ;0
            je pedirneg2
        cmp al,49
            je pedirneg2
        cmp al,50
            je pedirneg2
        cmp al,51
            je pedirneg2
        cmp al,52
            je pedirneg2
        cmp al,53
            je pedirneg2
        cmp al,54
            je pedirneg2
        cmp al,55
            je pedirneg2
        cmp al,56
            je pedirneg2
        cmp al,57       ;9
            je pedirneg2

        imprimir salto
        imprimir noes
        getChar
        jmp MenuPrincipal

    pedirneg2:  
            mov ah,0
            sub al,48   ; se le quita el ascii
            neg ax      ;se niega el numero convierte negativo
            mov finX,ax ; se guarda en la varible

            getChar

            cmp al,13
            je Evaluar

            cmp al,48          ;0
                je conv2
            cmp al,49
                je conv2
            cmp al,50
                je conv2
            cmp al,51
                je conv2
            cmp al,52
                je conv2
            cmp al,53
                je conv2
            cmp al,54
                je conv2
            cmp al,55
                je conv2
            cmp al,56
                je conv2
            cmp al,57       ;9
                je conv2

            imprimir salto
            imprimir noes
            getChar
            jmp MenuPrincipal

        conv2:
            sub al,48
            xor cx,cx
            mov cl,al
            xor ax,ax
            mov ax,finX
            neg ax
            mov bx,10
            mul bx
            add ax,cx
            neg ax
            mov finX,ax
            jmp Evaluar

        Evaluar:
            EvaluarIntervalo
endm

PedirConstante macro 
    LOCAL PedirDato,Negativo,Pedir2,pedir3,pedirneg,pedirneg2,pedirneg3,Rango,Rango2,end
    PedirDato:
        imprimir msjcon
        imprimir salto
        getChar
        cmp al, 45
            je Negativo
        cmp al,48          ;0
            je Pedir2
        cmp al,49
            je Pedir2
        cmp al,50
            je Pedir2
        cmp al,51
            je Pedir2
        cmp al,52
            je Pedir2
        cmp al,53
            je Pedir2
        cmp al,54
            je Pedir2
        cmp al,55
            je Pedir2
        cmp al,56
            je Pedir2
        cmp al,57       ;9
            je Pedir2

        imprimir salto
        imprimir noes
        getChar
        jmp MenuPrincipal
    Pedir2:
        mov ah,0
        sub al,48
        mov constante,ax
        getChar

        cmp al,13
            je Rango

        cmp al,48          ;0
            je Pedir3
        cmp al,49
            je Pedir3
        cmp al,50
            je Pedir3
        cmp al,51
            je Pedir3
        cmp al,52
            je Pedir3
        cmp al,53
            je Pedir3
        cmp al,54
            je Pedir3
        cmp al,55
            je Pedir3
        cmp al,56
            je Pedir3
        cmp al,57       ;9
            je Pedir3

        imprimir salto
        imprimir noes
        getChar
        jmp MenuPrincipal
    Pedir3:
        mov ah,0
        sub al,48
        xor bx,bx
        mov bx,ax
        mov ax,10
        xor cx,cx
        mov cx,constante
        mul cx
        add ax,cx
        mov constante,ax
        jmp Rango
    Negativo:
        getChar

        cmp al,48          ;0
            je pedirneg2
        cmp al,49
            je pedirneg2
        cmp al,50
            je pedirneg2
        cmp al,51
            je pedirneg2
        cmp al,52
            je pedirneg2
        cmp al,53
            je pedirneg2
        cmp al,54
            je pedirneg2
        cmp al,55
            je pedirneg2
        cmp al,56
            je pedirneg2
        cmp al,57       ;9
            je pedirneg2

        imprimir salto
        imprimir noes
        getChar
        jmp MenuPrincipal
    pedirneg2:
        mov ah,0
        sub al,48
        neg ax
        mov constante,ax
        getChar

        cmp al,48          ;0
            je pedirneg3
        cmp al,49
            je pedirneg3
        cmp al,50
            je pedirneg3
        cmp al,51
            je pedirneg3
        cmp al,52
            je pedirneg3
        cmp al,53
            je pedirneg3
        cmp al,54
            je pedirneg3
        cmp al,55
            je pedirneg3
        cmp al,56
            je pedirneg3
        cmp al,57       ;9
            je pedirneg3

        imprimir salto
        imprimir noes
        getChar
        jmp MenuPrincipal
    pedirneg3:
        mov ah,0
        sub al,48
        xor bx,bx
        mov bx,ax
        mov ax,10
        xor cx,cx
        mov cx,constante
        neg cx
        mul cx
        add ax,cx
        neg ax
        mov constante,ax
        jmp Rango
    Rango:
        mov ah,0
        mov al,57
        sub al,48
        neg ax
        mov iniX,ax
        mov ah,0
        mov al,57
        sub al,48
        xor cx,cx
        mov cl,al

        xor ax,ax
        mov ax,iniX
        neg ax
        mov bx,10
        mul bx
        add ax,cx
        neg ax
        mov iniX,ax
    Rango2:
        mov ah,0
        mov al,57
        sub al,48
        mov finX,ax

        mov ah,0
        mov al,57
        sub al,48

        xor cx,cx
        mov cl,al

        xor ax,ax
        mov ax,finX
        mov bx,10
        mul bx
        add ax,cx
        mov iniX,ax
    end:
        getChar
        call Crear

endm

EvaluarIntervalo macro
    LOCAL Evaluar1,Evaluar2,Evaluar3,error,plano,Ev1
    Evaluar1:
        xor ax,ax
        mov ax,iniX
        add ax,0
        js Evaluar2
        xor ax,ax
        mov ax,iniX
        cmp ax,finX
            ja error
        jmp plano


    Evaluar2:
        xor ax,ax
        mov ax,finX
        add ax,0
        js Evaluar3
        jmp plano

    Evaluar3:
        xor ax,ax
        xor bx,bx
        mov ax, iniX
        mov bx,finX
        neg ax
        neg bx
        cmp ax,bx
        jb error
        jmp plano
    error:
        imprimir salto
        imprimir msjerror2
        jmp Crear
    plano:
        PintarPlano
        jmp MenuPrincipal
        
        
endm

GraficarNormal macro
    LOCAL Grafica,PosXX,PosX2,PosX3,PosX4,PosX5,PosX6,Positivo,negativo,Fin
    Grafica:
        mov result, 0
        xor ax,ax
        
        mov ax,iniX ;paso el intervalo inicial
        mov posx,ax ; a posicion x
        xor ax,ax   ;se limpia ax
        xor si,si
        mov ax,finX ;paso intervalo final 
        mov si,ax   ;a si
        inc si      ;y se incrementa
        xor di,di
    PosXX:
        cmp posx,si
            je Fin
        jmp PosX2
    PosX2:  ;para x4
        xor ax,ax
        xor bx,bx

        mov ax,posx
        mov bx,posx

        mul bx   ; x *x
        mul bx   ; x*x*x
        mul bx   ; x*x*x*x
        xor bx,bx
        mov bx,grado4
        mul bx       ; coeficiente * x4
        mov result,ax
    PosX3: ;x3
        xor ax,ax
        xor bx,bx
        mov ax,posx
        mov bx,posx
        mul bx
        mul bx
        xor bx,bx
        mov bx,grado3
        mul bx
        add ax,result
        mov result,ax
    PosX4:   ;x2
        xor ax,ax
        xor bx,bx
        mov ax,posx
        mov bx,posx
        mul bx
        xor bx,bx
        mov bx,grado2
        mul bx
        add ax,result
        mov result,ax
    PosX5: ;x1
        xor ax,ax
        xor bx,bx
        mov ax,posx
        xor bx,bx
        mov bx,grado1
        mul bx
        add ax,result
        mov result,ax
    
    PosX6:   ; coeficiente 0 solo se suma 
        xor ax,ax
        mov ax,grado0
        add ax,result
        mov result,ax
        add ax,0
        js negativo
        jmp Positivo
    Positivo:
        inc posx
        mov bx,result
        cmp bx,99
            ja PosXX
        xor ax,ax
        mov ax,99
        sub ax,bx

        mov posy,ax
        mov cx,posx
        dec cx
        add cx,150
        pintar cx,posy,15
        inc cx
        xor ax,ax
        xor bx,bx
        mov ax,result

        jmp PosXX
    
    negativo:
        inc posx
        mov bx,result
        neg bx
        cmp bx,99
            ja PosXX

        xor ax,ax
        mov ax,99
        add ax,bx
        inc ax
        mov posy,ax
        
        mov cx,posx
        dec cx
        add cx,150
        
        pintar cx,posy,15

        xor ax,ax
        xor bx,bx
        jmp PosXX
    Fin:
        mov ah,00h
        mov al,30h
        int 10h
        getChar
        jmp MenuPrincipal

endm


GraficarDerivada macro
    LOCAL Grafica,PosXX,PosX2,PosX3,PosX4,PosX5,PosX6,Positivo,negativo,Fin
    Grafica:
        mov result, 0
        xor ax,ax
        
        mov ax,iniX ;paso el intervalo inicial
        mov posx,ax ; a posicion x

        xor ax,ax   ;se limpia ax
        xor si,si
        mov ax,finX ;paso intervalo final 
        mov si,ax   ;a si
        inc si      ;y se incrementa
        xor di,di
    PosXX:
        cmp posx,si
            je Fin
        jmp PosX2
    PosX2:  ;para x4
        xor ax,ax
        xor bx,bx

        mov ax,posx
        mov bx,posx

        mul bx   ; x *x
        mul bx   ; x*x*x
        xor bx,bx
        mov bx,dgrado3
        mul bx       ; coeficiente * x4
        mov result,ax
    PosX3: ;x3
        xor ax,ax
        xor bx,bx
        mov ax,posx
        mov bx,posx

        mul bx
        xor bx,bx
        mov bx,dgrado2
        mul bx

        add ax,result
        mov result,ax
    PosX5: ;x1
        xor ax,ax
        xor bx,bx

        mov ax,posx
        xor bx,bx
        mov bx,dgrado1
        mul bx
        add ax,result
        mov result,ax
    
    PosX6:   ; coeficiente 0 solo se suma 
        xor ax,ax
        xor bx,bx

        mov ax,dgrado0
        add ax,result
        mov result,ax

        js negativo
        jmp Positivo
    Positivo:
        inc posx
        mov bx,result
        cmp bx,99
            ja PosXX
        xor ax,ax
        mov ax,99
        sub ax,bx

        mov posy,ax
        mov cx,posx
        dec cx
        add cx,150
        pintar cx,posy,15
        inc cx
        xor ax,ax
        xor bx,bx
        mov ax,result

        jmp PosXX
    
    negativo:
        inc posx
        mov bx,result
        neg bx
        cmp bx,99
            ja PosXX

        xor ax,ax
        mov ax,99
        add ax,bx
        inc ax
        mov posy,ax
        
        mov cx,posx
        dec cx
        add cx,150
        pintar cx,posy,15

        jmp PosXX
    Fin:
        mov ah,00h
        mov al,30h
        int 10h
        getChar
        jmp MenuPrincipal

endm


GraficarIntegral macro
    LOCAL Grafica,PosXX,PosX2,PosX3,PosX4,PosX5,PosX6,PosX7,PosX8,Positivo,negativo,Fin
    Grafica:
        mov result, 0
        xor ax,ax
        
        mov ax,iniX ;paso el intervalo inicial
        mov posx,ax ; a posicion x

        xor ax,ax   ;se limpia ax
        xor si,si
        mov ax,finX ;paso intervalo final 
        mov si,ax   ;a si
        inc si      ;y se incrementa
        xor di,di
    PosXX:
        cmp posx,si
            je Fin
        jmp PosX2
    PosX2:  ;para x4
        xor ax,ax
        xor bx,bx

        mov ax,posx
        mov bx,posx

        mul bx   ; x *x
        mul bx   ; x*x*x
        mul bx
        mul bx
        
        xor bx,bx
        mov bx,grado4
        imul bx       ; coeficiente * x4
        mov bx,5
        idiv bx
        mov result,ax
    PosX3: ;x3
        xor ax,ax
        xor bx,bx

        mov ax,posx
        mov bx,posx

        mul bx
        mul bx
        mul bx

        xor bx,bx
        mov bx,grado3
        imul bx
        mov bx,4
        idiv bx

        add ax,result
        mov result,ax
    PosX5: ;x1
        xor ax,ax
        xor bx,bx
        
        mov ax,posx
        mov bx,posx

        mul bx
        mul bx
        xor bx,bx
        mov bx,grado2
        imul bx

        mov bx,3
        idiv bx
        add ax,result
        mov result,ax
    PosX6: ;x1
        xor ax,ax
        xor bx,bx
        mov ax,posx
        mov bx,posx

        mul bx

        xor bx,bx
        mov ax,posx
        
        mov bx,grado1
        imul bx
        mov bx,2
        idiv bx
        add ax,result
        mov result,ax

    PosX7: ;x1
        xor ax,ax
        xor bx,bx
        mov ax,posx

        xor bx,bx        
        mov bx,grado0
        imul bx

        add ax,result
        mov result,ax
    
    
    PosX8:   ; coeficiente 0 solo se suma 
        xor ax,ax

        mov ax,constante
        add ax,result
        mov result,ax
        add ax,0

        js negativo
        jmp Positivo
    Positivo:
        inc posx
        mov bx,result
        cmp bx,99
            ja PosXX
        xor ax,ax
        mov ax,99
        sub ax,bx

        mov posy,ax
        mov cx,posx
        dec cx
        add cx,150
        pintar cx,posy,15
        inc cx
        xor ax,ax
        xor bx,bx
        mov ax,result

        jmp PosXX
    
    negativo:
        inc posx
        mov bx,result
        neg bx
        cmp bx,99
            ja PosXX

        xor ax,ax
        mov ax,99
        add ax,bx
        inc ax
        mov posy,ax
        
        mov cx,posx
        dec cx
        add cx,150
        pintar cx,posy,15

        jmp PosXX
    Fin:
        mov ah,00h
        mov al,30h
        int 10h
        getChar
        jmp MenuPrincipal

endm
;-------------------PARA FICHEROS---------------------
contarElementos macro arreglo
    LOCAL continuar, finalizar
    xor di,di
    continuar:
        cmp arreglo[di],0
        je finalizar
        inc di
        jmp continuar
    finalizar: 
endm

abrirF macro ruta, handle
    mov al,00h
    lea dx,[ruta + 2]
    mov ah,3dh
    int 21h
    jc ErrorAbrir
    mov handle,ax
endm

crearF macro ruta, handle
	mov ah,3ch
	mov cx,00h
	lea dx, ruta
	int 21h
	jc ErrorCrear
	mov handle,ax
endm

escribirF macro handle, numBytes, buffer
	mov ah,40h
	mov bx,handle
	mov cx,numBytes
	lea dx,buffer
	int 21h
	jc ErrorEscribir
endm

leerF macro handle, numBytes, buffer
    mov ah,3fh
    mov bx,handle
    mov cx,numBytes
    lea dx, buffer
    int 21h
    jc ErrorLeer
endm

cerrarF macro handle
	mov ah,3eh
	mov bx,handle
	int 21h
endm

;--------------------PARA HORA Y FECHA ------------
obtenerHora macro
	call GetTime
endm

obtenerFecha macro
    call GetData
endm

;-------------------para Modo calculadora-----------
Limpiar macro
    mov cx,500
    xor si,si
    loopG:
        cmp si,06h
            ja cinc
        cinc:
            mov path[si],00h
        inc si
    loop loopG
endm


ObtenerDir macro buffer
    LOCAL leer,salir
    xor si,si
    leer:
        getChar
        mov buffer[si],al
        inc si
        cmp al,13
        je salir
    jmp leer
        salir:
            dec si
            mov buffer[si],0
endm

ValidarPath macro buffer
    LOCAL Validar,error,salir
    cmp buffer [0],35 ;primer dato con ## en el buffer
        jne error
    cmp buffer [1],35  ;segundo dato en buffer
        jne error
    cmp buffer[si-1],35 ; ultimo dato menos 1 en el buffer
        jne error
    cmp buffer[si-2],35 ; ultimo menos 2 ##
        jne error
    jmp Cargar
    
    error:
        imprimir salto
        imprimir msjerror3
        getChar
        jmp MenuPrincipal
    Cargar:
        Analisis buffer
    
endm



Analisis macro buffer
    abrirF buffer,handle4
    leerF handle4,SIZEOF datos,datos
    cerrarF handle4
    mov flag_fin ,0  ; pone en 0 el final del archivo
    analizarArchivo datos
    cmp flag_error,0 ; si no hay errores salta al ca
    ja MenuPrincipal
    jmp ca
    ca:
        imprimir sies
        imprimir salto
        getChar
        
endm

analizarArchivo macro carac
    LOCAL validacion,seguir,salir,finArchivo,errorLexico,error,errorFin,L0,caca
    xor si, si
    ;mov si , offset carac
    mov contador,0
    validacion:
        mov al,carac[si]
        cmp carac[si],32 ; espacio
            je seguir
        cmp carac[si],13  ; retorno de carro
            je seguir
        cmp carac[si],10  ; salto de linea
            je seguir

        inc contador

        cmp carac[si],43 ;+
            je seguir
        cmp carac[si],45 ;-
            je seguir
        cmp carac[si],42 ;*
            je seguir
        cmp carac[si],47 ;/
            je seguir

        cmp carac[si],00h
        je salir

        cmp carac[si],59 ; punto coma
            je finArchivo
        

        cmp flag_fin,00h
            ja error

        cmp carac[si],48
            jb errorLexico
        cmp carac[si],57
            ja errorLexico
        
        seguir:
            inc si
        jmp validacion
    salir:
        dec contador
        FinalArchivo
        getChar
    finArchivo: ;cuando encuentre ; que es el fin
        inc flag_fin
        jmp seguir
    errorLexico: ; cuando encuentre un caracter no valido
        imprimir msjlexico
        printCarac carac[si]
        imprimir salto
        inc flag_error
        jmp seguir
    error: ;cuando despues del ; sigue habiendo datos
        imprimir msjlexico1
        printCarac carac[si]
        imprimir salto
        inc flag_error
        jmp seguir
    
endm

FinalArchivo macro
    LOCAL errorFin,L0,caca
    errorFin:
        cmp flag_fin,0
            jne L0
        imprimir msjlexico1
        imprimir salto
        inc flag_error
        L0:
            imprimir msjexito3
            imprimir salto
            getChar
            imprimir datos
            jmp MenuPrincipal
endm