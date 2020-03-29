include Macros.asm
.model small

.486
.stack 64
.data
include data.asm
.code
include proc.asm

main proc
    mov ax, @data
    mov ds,ax
MenuPrincipal:
    
    limpiarPantalla
    imprimir enc1
    imprimir menu
    getTexto bufname
    cmp bufname[0],'1'
        je PedirFuncion
    cmp bufname[0],'2'
        je MostrarFuncion
    cmp bufname[0],'3'
        je Derivar
    cmp bufname[0],'4'
        je MostrarIntegral
    cmp bufname[0],'5'
        je MenuGraficas
    cmp bufname[0],'8'
        je Salir  
    imprimir salto
    imprimir msjerror
    imprimir salto
    getChar  
    jmp MenuPrincipal



MostrarFuncion:
    cmp flagvacio,0
        je errorvacio
    imprimir salto
    imprimir fx
    imprimir arrayfuncion
    imprimir salto
    getChar
    jmp MenuPrincipal

MostrarIntegral:
    cmp flagvacio,0
        je errorvacio
    imprimir salto
    imprimir fxintegral
    imprimir arrayintegral
    imprimir salto
    getChar
    jmp MenuPrincipal

PedirFuncion:
    xor di, di
    xor si, si

    mov flagvacio,0
    imprimir pedir4
    imprimir salto
    escribir

    cmp al, 45 ; si aqui pongo - es negativo  
    je Negativo4

    cmp al, 48
            jb Error  ; miestras no sea menor a 0 y mayor a 9
    cmp al, 57
        ja Error

    mov sig4,1 ; delo contrario es + 
    mov bh,0
    mov bl,al
    mov grado4,bx

    mov bx,ax

    cmp bl,48
        je LeerGrado3
    
    mov ax,bx
    mov arrayfuncion[si],al
    inc si
    mov arrayfuncion[si],88 ; agrego de una la x
    inc si
    mov arrayfuncion[si],52 ;exponente cuatro
    inc si 
    mov arrayfuncion[si],32 ; un espacio
    inc si

    mov arrayintegral[di],al
    inc di
    mov arrayintegral[di],47
    inc di
    mov arrayintegral[di],53 ; exponente = 5
    inc di
    mov arrayintegral[di],88
    inc di
    mov arrayintegral[di],53 ; denominador 
    inc di
    mov arrayintegral[di],32
    inc di

    jmp LeerGrado3


    Negativo4:
        mov sig4 ,0 ; si es negativo
        escribir
        cmp al, 48
            jb Error  ; miestras no sea menor a 0 y mayor a 9
        cmp al, 57
            ja Error

        mov bh,0
        mov bl,al
        mov grado4,bx

        mov bx,ax

        cmp bl,48
            je LeerGrado3 

        mov ax,bx
        mov arrayfuncion[si],45 ; se agrega el menos
        inc si
        mov arrayfuncion[si],al ; se agrega el numero ingresado
        inc si
        mov arrayfuncion[si],88 ; agrego de una la x
        inc si
        mov arrayfuncion[si],52 ;exponente cuatro
        inc si 
        mov arrayfuncion[si],32 ; un espacio
        inc si

        mov arrayintegral[di],45
        inc di
        mov arrayintegral[di],al
        inc di
        mov arrayintegral[di],47
        inc di
        mov arrayintegral[di],53
        inc di
        mov arrayintegral[di],88
        inc di
        mov arrayintegral[di],53
        inc di
        mov arrayintegral[di],32
        inc di

    LeerGrado3:
        imprimir salto
        imprimir pedir3
        imprimir salto
        escribir

        cmp al, 45 ; si aqui pongo - es negativo  
        je Negativo3

        cmp al, 48
                jb Error  ; miestras no sea menor a 0 y mayor a 9
            cmp al, 57
                ja Error

        mov sig3,1 ; delo contrario es + 
        mov bh,0
        mov bl,al
        mov grado3,bx

        mov bx,ax
        cmp bl,48
            je LeerGrado2
        
        mov ax,bx
        mov arrayfuncion[si],43 ; si no es negativo se le pone +
        inc si
        mov arrayfuncion[si],32 ; espacio
        inc si
        mov arrayfuncion[si],al ; numero
        inc si
        mov arrayfuncion[si],88 ; agrego de una la x
        inc si
        mov arrayfuncion[si],51 ;exponente cuatro
        inc si 
        mov arrayfuncion[si],32 ; un espacio
        inc si

        mov arrayintegral[di],43 ; positivo para el signo
        inc di  
        mov arrayintegral[di],32 ; espacio
        inc di
        mov arrayintegral[di],al ; numero del numerador
        inc di
        mov arrayintegral[di],47 ; signo del /
        inc di
        mov arrayintegral[di],52 ; denominador = 4
        inc di
        mov arrayintegral[di],88 ; variable x
        inc di
        mov arrayintegral[di],52 ; exponente = 4
        inc di
        mov arrayintegral[di],32 ; espacio
        inc di



        jmp LeerGrado2


    Negativo3:
        mov sig3 ,0 ; si es negativo
        escribir
        cmp al, 48
            jb Error  ; miestras no sea menor a 0 y mayor a 9
        cmp al, 57
            ja Error

        mov bh,0
        mov bl,al
        mov grado3,bx

        mov bx,ax

        cmp bl,48
            je LeerGrado2

        mov ax,bx
        mov arrayfuncion[si],45 ; se agrega el menos
        inc si
        mov arrayfuncion[si],32 ; un espacio
        inc si
        mov arrayfuncion[si],al ; se agrega el numero ingresado
        inc si
        mov arrayfuncion[si],88 ; agrego de una la x
        inc si
        mov arrayfuncion[si],51 ;exponente tres
        inc si 
        mov arrayfuncion[si],32 ; un espacio
        inc si

        mov arrayintegral[di],45 ; negativo para el signo
        inc di  
        mov arrayintegral[di],32 ; espacio
        inc di
        mov arrayintegral[di],al ; numero del numerador
        inc di
        mov arrayintegral[di],47 ; signo del /
        inc di
        mov arrayintegral[di],52 ; denominador = 4
        inc di
        mov arrayintegral[di],88 ; variable x
        inc di
        mov arrayintegral[di],52 ; exponente = 4
        inc di
        mov arrayintegral[di],32 ; espacio
        inc di

    LeerGrado2:
        imprimir salto
        imprimir pedir2
        imprimir salto
        escribir

        cmp al, 45 ; si aqui pongo - es negativo  
        je Negativo2

        cmp al, 48
            jb Error  ; miestras no sea menor a 0 y mayor a 9
        cmp al, 57
            ja Error

        mov sig2,1 ; delo contrario es + 
        mov bh,0
        mov bl,al
        mov grado2,bx

        mov bx,ax
        cmp bl,48
            je LeerGrado1
        
        mov ax,bx
        mov arrayfuncion[si],43 ; si no es negativo se le pone +
        inc si
        mov arrayfuncion[si],32 ; espacio
        inc si
        mov arrayfuncion[si],al ; numero
        inc si
        mov arrayfuncion[si],88 ; agrego de una la x
        inc si
        mov arrayfuncion[si],50 ;exponente cuatro
        inc si 
        mov arrayfuncion[si],32 ; un espacio
        inc si

        mov arrayintegral[di],43 ; positivo para el signo
        inc di  
        mov arrayintegral[di],32 ; espacio
        inc di
        mov arrayintegral[di],al ; numero del numerador
        inc di
        mov arrayintegral[di],47 ; signo del /
        inc di
        mov arrayintegral[di],51 ; denominador = 3
        inc di
        mov arrayintegral[di],88 ; variable x
        inc di
        mov arrayintegral[di],51 ; exponente = 4
        inc di
        mov arrayintegral[di],32 ; espacio
        inc di

        jmp LeerGrado1

    Negativo2:
        mov sig2 ,0 ; si es negativo
        escribir
        cmp al, 48
            jb Error  ; miestras no sea menor a 0 y mayor a 9
        cmp al, 57
            ja Error

        mov bh,0
        mov bl,al
        mov grado2,bx

        mov bx,ax

        cmp bl,48
            je LeerGrado1

        mov ax,bx
        mov arrayfuncion[si],45 ; se agrega el menos
        inc si
        mov arrayfuncion[si],32 ; un espacio
        inc si
        mov arrayfuncion[si],al ; se agrega el numero ingresado
        inc si
        mov arrayfuncion[si],88 ; agrego de una la x
        inc si
        mov arrayfuncion[si],50 ;exponente tres
        inc si 
        mov arrayfuncion[si],32 ; un espacio
        inc si

        mov arrayintegral[di],45 ; positivo para el signo
        inc di  
        mov arrayintegral[di],32 ; espacio
        inc di
        mov arrayintegral[di],al ; numero del numerador
        inc di
        mov arrayintegral[di],47 ; signo del /
        inc di
        mov arrayintegral[di],51 ; denominador = 4
        inc di
        mov arrayintegral[di],88 ; variable x
        inc di
        mov arrayintegral[di],51 ; exponente = 4
        inc di
        mov arrayintegral[di],32 ; espacio
        inc di

    LeerGrado1:
        imprimir salto
        imprimir pedir1
        imprimir salto
        
        escribir

        cmp al, 45 ; si aqui pongo - es negativo  
        je Negativo1

        cmp al, 48
            jb Error  ; miestras no sea menor a 0 y mayor a 9
        cmp al, 57
            ja Error

        mov sig1,1 ; delo contrario es + 
        mov bh,0
        mov bl,al
        mov grado1,bx

        mov bx,ax
        cmp bl,48
            je LeerGrado0
        
        mov ax,bx
        mov arrayfuncion[si],43 ; si no es negativo se le pone +
        inc si
        mov arrayfuncion[si],32 ; espacio
        inc si
        mov arrayfuncion[si],al ; numero
        inc si
        mov arrayfuncion[si],88 ; agrego de una la x
        inc si
        mov arrayfuncion[si],49 ;exponente cuatro
        inc si 
        mov arrayfuncion[si],32 ; un espacio
        inc si

        mov arrayintegral[di],43 ; positivo para el signo
        inc di  
        mov arrayintegral[di],32 ; espacio
        inc di
        mov arrayintegral[di],al ; numero del numerador
        inc di
        mov arrayintegral[di],47 ; signo del /
        inc di
        mov arrayintegral[di],50 ; denominador = 5
        inc di
        mov arrayintegral[di],88 ; variable x
        inc di
        mov arrayintegral[di],50 ; exponente = 4
        inc di
        mov arrayintegral[di],32 ; espacio
        inc di

        jmp LeerGrado0
    
    Negativo1:
        mov sig1 ,0 ; si es negativo
        escribir
        cmp al, 48
            jb Error  ; miestras no sea menor a 0 y mayor a 9
        cmp al, 57
            ja Error

        mov bh,0
        mov bl,al
        mov grado1,bx

        mov bx,ax

        cmp bl,48
            je LeerGrado0

        mov ax,bx
        mov arrayfuncion[si],45 ; se agrega el menos
        inc si
        mov arrayfuncion[si],32 ; un espacio
        inc si
        mov arrayfuncion[si],al ; se agrega el numero ingresado
        inc si
        mov arrayfuncion[si],88 ; agrego de una la x
        inc si
        mov arrayfuncion[si],49 ;exponente tres
        inc si 
        mov arrayfuncion[si],32 ; un espacio
        inc si

        mov arrayintegral[di],45 ; positivo para el signo
        inc di  
        mov arrayintegral[di],32 ; espacio
        inc di
        mov arrayintegral[di],al ; numero del numerador
        inc di
        mov arrayintegral[di],47 ; signo del /
        inc di
        mov arrayintegral[di],50 ; denominador = 5
        inc di
        mov arrayintegral[di],88 ; variable x
        inc di
        mov arrayintegral[di],50 ; exponente = 4
        inc di
        mov arrayintegral[di],32 ; espacio
        inc di

    LeerGrado0:
        mov flagvacio,1
        imprimir salto
        imprimir pedir0
        imprimir salto
        escribir

        cmp al, 45 ; si aqui pongo - es negativo  
        je Negativo0

        cmp al, 48
            jb Error  ; miestras no sea menor a 0 y mayor a 9
        cmp al, 57
            ja Error

        mov sig0,1 ; delo contrario es + 
        mov bh,0
        mov bl,al
        mov grado0,bx

        mov bx,ax
        cmp bl,48
            je MenuPrincipal ; esto despues
        
        mov ax,bx
        mov arrayfuncion[si],43 ; si no es negativo se le pone +
        inc si
        mov arrayfuncion[si],32 ; espacio
        inc si
        mov arrayfuncion[si],al ; numero
        inc si
        

        mov arrayintegral[di],43 ; positivo para el signo
        inc di  
        mov arrayintegral[di],32 ; espacio
        inc di
        mov arrayintegral[di],67 ; numero del numerador
        inc di
        jmp Exito

    Negativo0:
        mov sig0 ,0 ; si es negativo
        escribir
        cmp al, '0'
            jb Error  ; miestras no sea menor a 0 y mayor a 9
        cmp al,'9'
            ja Error

        mov sig0,1 ; delo contrario es + 
        mov bh,0
        mov bl,al
        mov grado0,bx

        mov bx,ax

        cmp bl,48
            je LeerGrado0

        mov ax,bx
        mov arrayfuncion[si],45 ; se agrega el menos
        inc si
        mov arrayfuncion[si],32 ; un espacio
        inc si
        mov arrayfuncion[si],al ; se agrega el numero ingresado
        inc si

        mov arrayintegral[di],45 ; positivo para el signo
        inc di  
        mov arrayintegral[di],32 ; espacio
        inc di
        mov arrayintegral[di],67 ; numero del numerador
        inc di
    jmp Exito


Derivar:
    jmp MenuPrincipal


Exito:
    imprimir salto
    imprimir msjexito
    getChar 
    jmp MenuPrincipal

Error:
    imprimir noes
    getChar
    jmp MenuPrincipal
errorvacio:
    imprimir msjvacio
    imprimir salto
    getChar
    jmp MenuPrincipal

Crear:
    PintarPlano

MenuGraficas:
    limpiarPantalla
    imprimir menu2
    getTexto bufname
    cmp bufname[0],'1'
        je Crear
    cmp bufname[0],'2'
        je Crear
    cmp bufname[0],'3'
        je Crear
    cmp bufname[0],'4'
        je MenuPrincipal

    imprimir salto
    imprimir msjerror
    imprimir salto
    getChar
    jmp MenuGraficas
        



Salir:
    imprimir msjsalida
    mov ah, 4ch ;todos los procesos se cierran y libera la memoria 
    int 21h ;interrupcion del sistema con el valor 21 en hexadecimal

main endp

end main