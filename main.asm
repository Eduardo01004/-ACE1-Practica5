include Macros.asm
.model small

.486
.stack 
.data
include data.asm
.code
include proc.asm

main proc
    mov ax, @data
    mov ds,ax
MenuPrincipal:
    
    limpiarPantalla
    mov flag_derivada,0
    mov flag_normal,0
    imprimir enc1
    imprimir menu
    getTexto bufname
    cmp bufname[0],'1'
        je PedirFuncion
    cmp bufname[0],'2'
        je MostrarFuncion
    cmp bufname[0],'3'
        je MostrarDerivada
    cmp bufname[0],'4'
        je MostrarIntegral
    cmp bufname[0],'5'
        je MenuGraficas
    cmp bufname[0],'6'
        je Reportar
    cmp bufname[0],'7'
        je CargarArchivo
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

MostrarDerivada:
    cmp flagvacio,0
        je errorvacio
    imprimir salto
    imprimir fxderivada
    imprimir arrayderivada
    imprimir salto
    getChar
    jmp MenuPrincipal


PedirFuncion:
    xor di, di
    xor si, si

    mov flagvacio,0
    imprimir pedir4
    imprimir salto
    getChar

    cmp al, 45 ; si aqui pongo - es negativo  
        je Negativo4

    cmp al,48          ;0
        je PC1
    cmp al,49
        je PC1
    cmp al,50
        je PC1
    cmp al,51
        je PC1
    cmp al,52
        je PC1
    cmp al,53
        je PC1
    cmp al,54
        je PC1
    cmp al,55
        je PC1
    cmp al,56
        je PC1
    cmp al,57       ;9
        je PC1

    imprimir salto
    imprimir noes
    getChar
    jmp MenuPrincipal

    PC1:
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
        getChar
        cmp al,48          ;0
            je PCN1
        cmp al,49
            je PCN1
        cmp al,50
            je PCN1
        cmp al,51
            je PCN1
        cmp al,52
            je PCN1
        cmp al,53
            je PCN1
        cmp al,54
            je PCN1
        cmp al,55
            je PCN1
        cmp al,56
            je PCN1
        cmp al,57       ;9
            je PCN1

        imprimir salto
        imprimir noes
        getChar
        jmp MenuPrincipal
    
    PCN1:
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
        getChar

        cmp al, 45 ; si aqui pongo - es negativo  
        je Negativo3

        cmp al,48          ;0
            je PC2
        cmp al,49
            je PC2
        cmp al,50
            je PC2
        cmp al,51
            je PC2
        cmp al,52
            je PC2
        cmp al,53
            je PC2
        cmp al,54
            je PC2
        cmp al,55
            je PC2
        cmp al,56
            je PC2
        cmp al,57       ;9
            je PC2

        imprimir salto
        imprimir noes
        getChar
        jmp MenuPrincipal

    
    PC2:
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
        getChar
        cmp al,48          ;0
            je PCN2
        cmp al,49
            je PCN2
        cmp al,50
            je PCN2
        cmp al,51
            je PCN2
        cmp al,52
            je PCN2
        cmp al,53
            je PCN2
        cmp al,54
            je PCN2
        cmp al,55
            je PCN2
        cmp al,56
            je PCN2
        cmp al,57       ;9
            je PCN2

        imprimir salto
        imprimir noes
        getChar
        jmp MenuPrincipal

    PCN2:
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
        getChar

        cmp al, 45 ; si aqui pongo - es negativo  
            je Negativo2

        cmp al,48          ;0
            je PC3
        cmp al,49
            je PC3
        cmp al,50
            je PC3
        cmp al,51
            je PC3
        cmp al,52
            je PC3
        cmp al,53
            je PC3
        cmp al,54
            je PC3
        cmp al,55
            je PC3
        cmp al,56
            je PC3
        cmp al,57       ;9
            je PC3

        imprimir salto
        imprimir noes
        getChar
        jmp MenuPrincipal

    PC3:
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
        getChar
        cmp al,48          ;0
            je PCN3
        cmp al,49
            je PCN3
        cmp al,50
            je PCN3
        cmp al,51
            je PCN3
        cmp al,52
            je PCN3
        cmp al,53
            je PCN3
        cmp al,54
            je PCN3
        cmp al,55
            je PCN3
        cmp al,56
            je PCN3
        cmp al,57       ;9
            je PCN3

        imprimir salto
        imprimir noes
        getChar
        jmp MenuPrincipal


    PCN3:
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
        jmp LeerGrado1

    LeerGrado1:
        imprimir salto
        imprimir pedir1
        imprimir salto
        
        getChar

        cmp al, 45 ; si aqui pongo - es negativo  
        je Negativo1

        cmp al,48          ;0
            je PC4
        cmp al,49
            je PC4
        cmp al,50
            je PC4
        cmp al,51
            je PC4
        cmp al,52
            je PC4
        cmp al,53
            je PC4
        cmp al,54
            je PC4
        cmp al,55
            je PC4
        cmp al,56
            je PC4
        cmp al,57       ;9
            je PC4

        imprimir salto
        imprimir noes
        getChar
        jmp MenuPrincipal

    
    PC4:
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
        getChar
        cmp al,48          ;0
            je PCN4
        cmp al,49
            je PCN4
        cmp al,50
            je PCN4
        cmp al,51
            je PCN4
        cmp al,52
            je PCN4
        cmp al,53
            je PCN4
        cmp al,54
            je PCN4
        cmp al,55
            je PCN4
        cmp al,56
            je PCN4
        cmp al,57       ;9
            je PCN4

        imprimir salto
        imprimir noes
        getChar
        jmp MenuPrincipal


    PCN4:
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
        jmp LeerGrado0

    LeerGrado0:
        mov flagvacio,1
        imprimir salto
        imprimir pedir0
        imprimir salto
        getChar

        cmp al, 45 ; si aqui pongo - es negativo  
        je Negativo0

        cmp al,48          ;0
            je PC5
        cmp al,49
            je PC5
        cmp al,50
            je PC5
        cmp al,51
            je PC5
        cmp al,52
            je PC5
        cmp al,53
            je PC5
        cmp al,54
            je PC5
        cmp al,55
            je PC5
        cmp al,56
            je PC5
        cmp al,57       ;9
            je PC5

        imprimir salto
        imprimir noes
        getChar
        jmp MenuPrincipal
    
    PC5:
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
        mov arrayintegral[di],al ; numero del numerador
        inc di
        mov arrayintegral[di],88 ; numero del numerador
        inc di
        mov arrayintegral[di],32 ; numero del numerador
        inc di

        mov arrayintegral[di],43 ; positivo para el signo
        inc di  
        mov arrayintegral[di],32 ; espacio
        inc di
        mov arrayintegral[di],67 ; numero del numerador
        inc di
        jmp Exito

    Negativo0:
        mov sig0 ,0 ; si es negativo
        getChar
        cmp al,48          ;0
            je PCN5
        cmp al,49
            je PCN5
        cmp al,50
            je PCN5
        cmp al,51
            je PCN5
        cmp al,52
            je PCN5
        cmp al,53
            je PCN5
        cmp al,54
            je PCN5
        cmp al,55
            je PCN5
        cmp al,56
            je PCN5
        cmp al,57       ;9
            je PCN5

        imprimir salto
        imprimir noes
        getChar
        jmp MenuPrincipal


    PCN5:
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
        mov arrayintegral[di],al ; numero del numerador
        inc di
        mov arrayintegral[di],88 ; numero del numerador
        inc di
        mov arrayintegral[di],32 ; numero del numerador
        inc di


        mov arrayintegral[di],43 ; positivo para el signo
        inc di  
        mov arrayintegral[di],32 ; espacio
        inc di
        mov arrayintegral[di],67 ; numero del numerador
        inc di
        jmp Exito






Exito:
    imprimir salto
    imprimir msjexito
    OperarDerivada
    getChar 
    jmp MenuPrincipal


Reportar:
    crearF rutasave,handle3

    contarElementos enc1
    escribirF handle3,di,enc1

    obtenerFecha
    contarElementos fecha
    escribirF handle3,di,fecha

    obtenerHora
    contarElementos hora
    escribirF handle3,di,hora

    contarElementos msjfun1
    escribirF handle3,di,msjfun1
    contarElementos fx
    escribirF handle3,di,fx
    contarElementos arrayfuncion
    escribirF handle3,di,arrayfuncion

    contarElementos msjfun2
    escribirF handle3,di,msjfun2
    contarElementos fxderivada
    escribirF handle3,di,fxderivada
    contarElementos arrayderivada
    escribirF handle3,di,arrayderivada

    contarElementos msjfun3
    escribirF handle3,di,msjfun3
    contarElementos fxintegral
    escribirF handle3,di,fxintegral
    contarElementos arrayintegral
    escribirF handle3,di,arrayintegral

    cerrarF handle3

    imprimir msjexito1
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

ErrorCrear:
    imprimir errorfile
    imprimir salto
    escribir
    jmp MenuPrincipal
ErrorAbrir:
    imprimir erroropen
    getChar
    jmp MenuPrincipal
ErrorEscribir:
	    imprimir errorwrite
	    getChar
	    jmp MenuPrincipal
ErrorLeer:
    imprimir errorread 
    getChar
    jmp MenuPrincipal

GraphNormal:
    mov flag_normal,1
    PedirInicial
GraphDerivada:
    mov flag_derivada,1
    PedirInicial
GraphIntegral:
    mov flag_integral,1
    PedirConstante

Crear:
    PedirInicial

MenuGraficas:
    cmp flagvacio,0
        je errorvacio
    limpiarPantalla
    imprimir menu2
    getTexto bufname
    cmp bufname[0],'1'
        je GraphNormal
    cmp bufname[0],'2'
        je GraphDerivada
    cmp bufname[0],'3'
        je GraphIntegral
    cmp bufname[0],'4'
        je MenuPrincipal

    imprimir salto
    imprimir msjerror
    imprimir salto
    getChar
    jmp MenuGraficas
        

CargarArchivo:
    Limpiar
    imprimir salto
    imprimir msjpedir
    ObtenerDir path
val1:
    ValidarPath path


Salir:
    imprimir msjsalida
    mov ah, 4ch ;todos los procesos se cierran y libera la memoria 
    int 21h ;interrupcion del sistema con el valor 21 en hexadecimal

main endp

end main