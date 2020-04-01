;----Encabezado para lo menus ----------------------
enc1 db 13,10,'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA',13,10
     db 'FACULTAD DE INGENIERIA',13,10
     db 'CIENCIAS Y SISTEMAS',13,10
     db 'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1',13,10
     db 'NOMBRE: EDUARDO SAUL TUN AGUILAR',13,10
     db 'CARNET: 201612124',13,10,'SECCION : A ',13,10
     db 'QUINTA PRACTICA ',13,13,10,0,'$'

menu db '-------MENU PRINCIPAL----------',13,10
     db '1. Ingresar Funcion f(x) ' ,13,10
     db '2. Funcion en Memoria ',13,10
     db "3. Derivada f'(x) ",13,10
     db '4. Integral F(X) ' ,13,10
     db '5. Graficar Funcion: ' ,13,10
     db '6. Reporte' ,13,10
     db '7. Modo Calculadora ',13,10
     db '8. Salir ',13,10
     db 'Ingrese una opcion: $',13,10

menu2 db '1. Graficar Original f(x) ',13,10
      db "2. Graficar Derivada f'(x) ",13,10
      db '3. Graficar Integral F(x) ',13,10
      db '4. Regresar. ',13,10
      db 'Ingrese una opcion: $',13,10

intervaloini db 'Ingrese el valor inicial del intervalo: $',10
intervalofin db 'Ingrese el valor final del intervalo: $',13,10
msjcon db 'Ingrese el valor de la constante: $',13,10

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
msjerror2 db '<< Error el intervalo inicial es mayor al final ',13,10,"$"
msjerror3 db '<< Error la ruta ingresada falta ## ',13,10,"$"
msjlexico db ' << Error Caracter invalido: $ '
msjlexico1 db ' << Error del fin del archivo: $ '
msjexito3 db ' Archivo leido con exito ',13,10,0,'$'
;--------------pedir datos en consola ------------
pedir0 db 'Coeficiente de x0: $',13,10
pedir1 db 'Coeficiente de x1: $',13,10
pedir2 db 'Coeficiente de x2: $',13,10
pedir3 db 'Coeficiente de x3: $',13,10
pedir4 db 'Coeficiente de x4: $',13,10
fx db "   f(X) = ",0,"$"
fxderivada db "   f'(x)= ",0,"$"
fxintegral db "   F(x)= ",0,"$"


;-----------------VARIABLES PARA OPERACIONES --------------
unidad db ?
decena db ?
numero db ?
diez   dword 10
uno    db '1'
flagvacio db 0 ; bandera para mostrar si hay una funcion en memoria
;---------------------Coeficientes de la funcion normal----
grado0 dw 0 
grado1 dw 0
grado2 dw 0
grado3 dw 0
grado4 dw 0

;----------------------------ARRAYS PARA INTEGRAR DERIVAR NORMAL
arrayfuncion db 30 dup(0),0,"$" ; esto es para ir formando de una la funcion
arrayintegral db 50 dup(0),0,"$"
arrayderivada db 50 dup(0),0,"$"
tamderivada dw 0
tamintegral dw 0
constante dw 0
;--------------------signos de los coeficientes
sig0 db 0
sig1 db 0
sig2 db 0
sig3 db 0
sig4 db 0
; signos de los coeficienes de la derivada-----
sigd3 db 0
sigd2 db 0
sigd1 db 0
sigd0 db 0
;-------------- Coeficientes de la derivada
dgrado3 dw 0
dgrado2 dw 0
dgrado1 dw 0
dgrado0 dw 0

;----------------para intervalos----------------
iniX dw 0
finX dw 0

;----------------para graficar normal-----------
posx dw 0
posy dw 0
result dw 0
arrayplot db 50 dup("$")
flag_normal dw 0
flag_derivada dw 0
flag_integral dw 0

;------------VARIABLES PARA FICHEROS--------------
rutasave db 'reporte.arq',0
handle3  dw ?
handle4  dw ?
msjexito1 db '<< Reporte creado con Exito ',13,10,10,'$'
msjexito2 db '<< Ruta ingresada con Exito ',13,10,10,'$'
errorfile db '<< No se pudo crear el archivo ' ,13,10,'$'
errorwrite db '<< No se pudo Escribir el fichero ' ,13,10,'$'
errorread db ' << No se pudo leer el archivo ' , 13,10,'$'
erroropen db ' << No se pudo abrir el archivo ',13,10,'$'
msjreporte db ' Reporte Practica NO.5 ',13,10,0,"$"
msjpedir db 'Ingrese la ruta del Archivo : $ ',13,10,0
fecha db 'Fecha : 00/00/2020',13,10,0
hora db 'Hora: 00:00:00',13,13,10,0
msjfun1 db 13,'Funcion Original',13,10,0,"$"
msjfun2 db 13,'Funcion Derivada',13,13,10,0,"$"
msjfun3 db 13,'Funcion Integral',13,13,10,0,"$"
path db 50 dup(0),0,"$"
path2 db 50 dup(0),0,"$"
datos db 500 dup(0)
contador dw 0
flag_fin db 0
flag_error db 0