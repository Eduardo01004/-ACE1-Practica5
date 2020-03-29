;----Encabezado para el menu principal----------------------
enc1 db 13,10,'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA',13,10
     db 'FACULTAD DE INGENIERIA',13,10
     db 'CIENCIAS Y SISTEMAS',13,10
     db 'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1',13,10
     db 'NOMBRE: EDUARDO SAUL TUN AGUILAR',13,10
     db 'CARNET: 201612124',13,10,'SECCION : A ',13,10
     db 'QUINTA PRACTICA ',13,10,'$'

menu db '-------MENU PRINCIPAL----------',13,10
     db '1. Ingresar Funcion f(x) ' ,13,10
     db '2. Funcion en Memoria ',13,10
     db "3. Derivada f'(x) ",13,10
     db '4. Integral F(X) ' ,13,10
     db '5. Graficar Funcione ' ,13,10
     db '6. Reporte' ,13,10
     db '7. Modo Calculadora ',13,10
     db '8. Salir ',13,10
     db 'Ingrese una opcion: $',13,10

menu2 db '1. Graficar Original f(x) ',13,10
      db "2. Graficar Derivada f'(x) ",13,10
      db '3. Graficar Integral F(x) ',13,10
      db '4. Regresar. ',13,10
      db 'Ingrese una opcion: $',13,10

; ---------------------variables de rapido acceso *-----------
bufname db 10 dup('$')
salto db 13,10,'$'

;-----------------------MENSAJES PARA MOSTRAR-----------------
noes db' << ERROR SOLO SE ACEPTAN NUMEROS (0-9)',13,10,'$'
sies db' << Dato Ingresado con exito',13,10,'$'
msjsalida db '<< Saliendo del sistema.......... ',13,10,10,'$'
msjexito db ' << Funcion ingresada con exito ',13,10,'$'
msjvacio db ' << Error NO hay una funcion guardada',13,10,'$'
msjerror db ' << Error elija una opcion correcta ',13,10,"$"
;--------------pedir datos en consola ------------
pedir0 db 'Coeficiente de x0: $',13,10
pedir1 db 'Coeficiente de x1: $',13,10
pedir2 db 'Coeficiente de x2: $',13,10
pedir3 db 'Coeficiente de x3: $',13,10
pedir4 db 'Coeficiente de x4: $',13,10
fx db "   f(X) = ","$"
fxprima db "   f'(x)= ","$"
fxintegral db "   F(x)= ","$"


;-----------------VARIABLES PARA OPERACIONES --------------
signo  db ? ; este es 0 cuando es positivo y 1 cuando es negativo
unidad db ?
decena db ?
numero db ?
diez   dword 10
uno    db '1'
flagvacio db 0
grado0 dw 0
grado1 dw 0
grado2 dw 0
grado3 dw 0
grado4 dw 0

;----------------------------ARRAYS PARA INTEGRAR DERIVAR NORMAL
arrayfuncion db 30 dup("$") ; esto es para ir formando de una la funcion
arrayintegral db 50 dup("$")
;--------------------signos de los coeficientes
sig0 db 0
sig1 db 0
sig2 db 0
sig3 db 0
sig4 db 0

