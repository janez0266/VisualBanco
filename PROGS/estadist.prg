************************************************************
* PROGRAMA:    estadist.prg                                *
* LLAMADO POR: banco30.prg                                 *
* DESCRIPCION: Estadisticas del sistema                    *      
* AUTOR:       Automatizacion - Serbiluz - Ing. Julio Anez      *
* REALIZADO:   16-03-96                                         *
* MODIFICADO:  01-11-2000                                       * 
*****************************************************************
*public xfecha,xmes,xano,xano1,BARRA,CANTIDAD
DO MENÚ2.MPR
fechah=date()
do case
case menusele="libros"

******************************************************
* muestra estadisticas de libros                     *
******************************************************
select 1 
use libros       && base de datos de libros cant. de ejemplares
select 2
use movimien    && base de datos de alquileres
select 3
use volumen      && base de datos con la cantidad de titulos 
*
define window estadist from 18,20 to 28,78 ;
   title ' Estadísticas de libros ' SYSTEM COLOR W/B
activate window estadist
do caltitu
@ 04,01 say "Espere un momento, actualizando informaci¢n ..."
librpre=0
cantejem=0
select 3
store volumen to cantlibr
select 2
*count for registro <> " " to librpre
count to librpre
select 1
count to cantejem
*count for registro <> " " to cantejem

close data
clear
@ 00,01 SAY "Cantidad de t¡tulos     =" GET cantlibr PICTURE '99999999'
@ 02,01 SAY "Cantidad de Ejemplares  =" GET cantejem PICTURE '99999999'
@ 04,01 SAY "Libros alquilados       =" GET librpre  PICTURE '99999999'
@ 06,01 SAY "Fecha de actualizaci¢n: "  GET fechah
@ 08,01 say "Presione <ENTER> para continuar"
clear get
read
close data
release window estadist

if init_impre("Imprimiendo Reporte de Usuarios....")=0
   return
endif   
?
? " ", xinstitucio
? " ", xmensaje1
? " ", xmensaje2
? " ", xunidad
? " ", date()
?
?
? 
?
? "         ESTADISTICAS GENERALES DE LIBROS REGISTRADOS"
?
?
?
? "Cantidad de t¡tulos     =", cantlibr  picture '999999'
?
?
? "Cantidad de Ejemplares  =", cantejem  picture '999999'
?
?
? "Libros alquilados       =", librpre  picture '999999'
?
?
? "Fecha de actualizaci¢n: =", fechah picture '999999'
?
?
?
?
?
?
?
?
?
?
?
?
?
?
?
?
?
?
? "                               ___________________________"
? "                                  COORDINADOR DEL BANCO   "
? "                                        DE LIBROS         "

do rest_impre




*
case menusele="usuarios"
******************************************************
* muestra estadisticas de usuarios                   *
******************************************************
select 1 
use usuario

define window estadist from 5,13 to 40,70 ;
   title ' Estadísticas de usuarios ' SYSTEM COLOR W/B
   &&color scheme 5;
   
activate window estadist
@ 04,01 say "Espere un momento, actualizando informaci¢n ..."
select 1
cantusua=0
COUNT TO CANTUSUA
*count for cedula <> ""     to cantusua 
count for condicion = "EST" to estud
count for condicion = "PRO" to profe
count for condicion = "EMP" to admin
count for condicion = "OTR" to otro
count for condicion = "pos" to postgrado
COUNT FOR INFSOCIAL = "SI"  TO INFORME
COUNT FOR MORO = "*" TO MOROSOS  
COUNT FOR FACULTAD = "IN" TO INGE
COUNT FOR FACULTAD = "DE" TO DERE
COUNT FOR FACULTAD = "AR" TO ARQU
COUNT FOR FACULTAD = "ME" TO MEDI
COUNT FOR FACULTAD = "HU" TO HUMA
COUNT FOR FACULTAD = "AG" TO AGRO
COUNT FOR FACULTAD = "VE" TO VETE
COUNT FOR FACULTAD = "CE" TO ECON
COUNT FOR FACULTAD = "EG" TO EGEN
COUNT FOR FACULTAD = "CI" TO CIEN
COUNT FOR FACULTAD = "OD" TO ODON
COUNT FOR FACULTAD = "XX" TO GENE
COUNT FOR FACULTAD = "AT" TO ARTE


close data
clear
@ 01,01 SAY "Ingenier¡a         =" GET inge     PICTURE '99999999'
@ 02,01 SAY "Derecho            =" GET dere     PICTURE '99999999'
@ 03,01 SAY "Arquitectura       =" GET arqu     PICTURE '99999999'
@ 04,01 SAY "Medicina           =" GET medi     PICTURE '99999999'
@ 05,01 SAY "Humanidades        =" GET huma     PICTURE '99999999'
@ 06,01 SAY "Agronom¡a          =" GET agro     PICTURE '99999999'
@ 07,01 SAY "Veterinaria        =" GET vete     PICTURE '99999999'
@ 08,01 SAY "Econom¡a           =" GET econ     PICTURE '99999999'
@ 09,01 SAY "Estudios Generales =" GET egen     PICTURE '99999999'
@ 10,01 SAY "Ciencias           =" GET cien     PICTURE '99999999'
@ 11,01 SAY "Odontolog¡a        =" GET odon     PICTURE '99999999'
@ 12,01 SAY "Generales          =" GET gene     PICTURE '99999999'
@ 13,01 SAY "Artes              =" GET arte     PICTURE '99999999'
@ 14,01 say "                 _______________"
@ 15,01 say "Total de usuarios  =" GET cantusua PICTURE '99999999'

@ 18,01 SAY "Cantidad de estudiantes       =" GET estud    PICTURE '99999999'
@ 19,01 SAY "Cantidad de profesores        =" GET profe    PICTURE '99999999'
@ 20,01 SAY "Cantidad de empleados         =" GET admin    PICTURE '99999999'
@ 21,01 say "Cantidad de Postgrado         =" get postgrado picture '99999999'
@ 22,01 SAY "Cant. Otros usuarios          =" GET otro     PICTURE '99999999'
@ 23,32 say "_______________"
@ 24,01 say "Cant. total de usuarios       =" GET cantusua PICTURE '99999999'
@ 26,01 say "_____________________________________________"
@ 27,01 SAY "Total Informe Social Positivo =" get informe picture '99999999'
@ 28,01 say "Total Morosos del Sistema     =" get morosos picture '99999999'
@ 31,01 say "Presione <ENTER> para continuar"
clear get
read

release window estadist


if init_impre("Imprimiendo Reporte de Usuarios....")=0
   return
endif   

?
? " ", xinstitucio
? " ", xmensaje1
? " ", xmensaje2
? " ", xunidad
? " ", date()
?
? 
?
? "         ESTADISTICAS GENERALES DE USUARIOS DEL SISTEMA"
?
?
? "     Ingenier¡a         =", inge picture '999999'   
? "     Derecho            =", dere picture '999999'  
? "     Arquitectura       =", arqu    picture '999999'
? "     Medicina           =", medi  picture '999999'
? "     Humanidades        =", huma    picture '999999'
? "     Agronom¡a          =", agro  picture '999999'
? "     Veterinaria        =", vete    picture '999999'
? "     Econom¡a           =", econ    picture '999999'
? "     Estudios Generales =", egen   picture '999999'
? "     Ciencias           =", cien  picture '999999' 
? "     Odontolog¡a        =", odon   picture '999999' 
? "     Generales          =", gene   picture '999999'
? "     Artes              =", arte picture '999999' 
?
?
? "     Cantidad de Estudiantes       =", estud   picture '999999' 
? "     Cantidad de Profesores        =", profe   picture '999999' 
? "     Cantidad de Empleados         =", admin   picture '999999'
? "     Cantidad de Postgrado         =", postgrado picture '999999'   
? "     Cant. Otros Usuarios          =", otro  picture '999999'
?
? "                               __________________"
? "     Cant. total de usuarios       =", cantusua picture '999999'
?
? "     Total Informe Social Positivo =", informe  picture '999999'
? "     Total Morosos del Sistema     =", morosos picture '999999'
?
?
?
?
?
?
?
?
?
?
?
?
? "                               ___________________________"
? "                                  COORDINADOR DEL BANCO   "
? "                                        DE LIBROS         "


do rest_impre

case menusele="consultas"
******************************************************
* muestra libros mas consultados                     *
******************************************************
select 1 
use libros order uso
define window estadist from 16,11 to 29,88;
   title ' Libros mas consultados (Tecla "escape" para salir)' SYSTEM COLOR W/B
   &&color scheme 10 ;
   
activate window estadist
CLEAR
? "Libros mas consultados ordenados por cantidad de consultas realizadas"
select 1
brow fields uso:W=.f.,titulo:40,autor:25,editorial:40,coslbo,fechadq NOEDIT COLOR SCHEME 10 window estadist
release window estadist
DO MENU.PRG



*
case menusele="movimientos"
*******ESTADISTICAS SOBRE MOVIMIENTOS ANUALES POR MES
select 1
USE conta ORDER fecha
total=0
MAXIMO=0
CANTIDAD=0
BARRA=' '

***********************************************
* para seleccionar el ano para reporte anual *
***********************************************
set escape off
define window fecha from 19,20 to 24,75 ;
   title ' Selección del Año ' SYSTEM COLOR W/B
   &&color scheme 5;
   
activate window fecha
sele 1
set order to ano
vali='T'
do while vali='T'
   *store space(4) to xano
   STORE 0 TO xano
   @ 01,20 say 'A¤o:' get xano picture '9999'
   @ 02,5 say 'Debe esperar que se realicen los c lculos'
   READ
   *IF xano="  "
   IF xano <=0
      release window fecha
      return to estadist
   ENDIF
   *store val(xano) to xano1 
   store xano to xano1 
   store xano1 to busca
   seek busca 
   if eof()
      ??chr(7)
      @ 3,1 say "A¤o no registrado" 
      read
      @ 3,1 say space(30)
      loop
   else 
      vali='F'      
   endif   
enddo   
release window fecha
sele 1
set order to fecha
define window fecha1 from 29,20 to 32,80 ;
   title ' Progreso ' SYSTEM COLOR W/B
   &&color scheme 5;
  
activate window fecha1
@ 01,2 say 'Realizando los c lculos' 
set filter to year(fecha)=xano1
COUNT TO TOTAL
*****
enero=0
febrero=0
marzo=0
abril=0
mayo=0
junio=0
julio=0
septiembre=0
octubre=0
noviembre=0
diciembre=0
total=0

set filter to month(fecha)=1 .and. year(fecha)=xano1
COUNT  to enero
@ 01,2 say 'Realizando los calculos:  ²²' 
set filter to month(fecha)=2 .and. year(fecha)=xano1
COUNT  to febrero
@ 01,2 say 'Realizando los calculos:  ²²²²' 
set filter to month(fecha)=3 .and. year(fecha)=xano1
COUNT  to marzo
@ 01,2 say 'Realizando los calculos:  ²²²²²²' 
set filter to month(fecha)=4 .and. year(fecha)=xano1
COUNT  to abril
@ 01,2 say 'Realizando los calculos:  ²²²²²²²²' 
set filter to month(fecha)=5 .and. year(fecha)=xano1
COUNT  to mayo
@ 01,2 say 'Realizando los calculos:  ²²²²²²²²²²' 
set filter to month(fecha)=6 .and. year(fecha)=xano1
COUNT  to junio
@ 01,2 say 'Realizando los calculos:  ²²²²²²²²²²²²' 
set filter to month(fecha)=7 .and. year(fecha)=xano1
COUNT  to julio
@ 01,2 say 'Realizando los calculos:  ²²²²²²²²²²²²²²' 
set filter to month(fecha)=9 .and. year(fecha)=xano1
COUNT  to septiembre
@ 01,2 say 'Realizando los calculos:  ²²²²²²²²²²²²²²²²²' 
set filter to month(fecha)=10 .and. year(fecha)=xano1
COUNT  to octubre
@ 01,2 say 'Realizando los calculos:  ²²²²²²²²²²²²²²²²²²²²' 
set filter to month(fecha)=11 .and. year(fecha)=xano1
COUNT to noviembre
@ 01,2 say 'Realizando los calculos:  ²²²²²²²²²²²²²²²²²²²²²²²' 
set filter to month(fecha)=12 .and. year(fecha)=xano1
COUNT  to diciembre
@ 01,2 say 'Realizando los calculos:  ²²²²²²²²²²²²²²²²²²²²²²²²²²²' 

store max(enero, febrero, marzo, abril, mayo, junio, julio, septiembre, octubre, noviembre, diciembre) to maximo


store enero+febrero+marzo+abril+mayo+julio+julio+septiembre+octubre+noviembre+diciembre to total
release window fecha1
define window inganual from 11,11 to 32,87 ;
   title ' Cantidad de Operaciones realizados ' SYSTEM COLOR W/B
activate window inganual
clear
? "                     OPERACIONES ANUALES A¥O:",xano1 picture "9999"
?
STORE ENERO TO CANTIDAD
DO CALCULOS
? "ENERO      ",ENERO,BARRA
STORE FEBRERO TO CANTIDAD
DO CALCULOS
? "FEBRERO    ",FEBRERO,BARRA
STORE MARZO TO CANTIDAD
DO CALCULOS
? "MARZO      ",MARZO,BARRA
STORE ABRIL TO CANTIDAD
DO calculos
? "ABRIL      ",ABRIL,BARRA
STORE MAYO TO CANTIDAD
DO calculos
? "MAYO       ",MAYO,BARRA
STORE JUNIO TO CANTIDAD
DO calculos
? "JUNIO      ",JUNIO,BARRA
STORE JULIO TO CANTIDAD
DO calculos
? "JULIO      ",JULIO,BARRA
STORE SEPTIEMBRE TO CANTIDAD
DO calculos
? "SEPTIEMBRE:",SEPTIEMBRE,BARRA
STORE OCTUBRE TO CANTIDAD
DO calculos
? "OCTUBRE:   ",OCTUBRE,BARRA
STORE NOVIEMBRE TO CANTIDAD
DO calculos
? "NOVIEMBRE: ",NOVIEMBRE,BARRA
STORE DICIEMBRE TO CANTIDAD
DO calculos
? "DICIEMBRE: ",DICIEMBRE,BARRA
? 
? "    TOTAL:",TOTAL," Operaciones"
?
@ 18,1 say "Presione <ENTER> para continuar"
read
release window inganual
***********************************************
if init_impre("Imprimiendo Gráfico de Operaciones anuales...")=0
   return
endif   
?
? " ", xinstitucio
? " ", xmensaje1
? " ", xmensaje2
? " ", xunidad
? " ", date()
?
?
?
? "                              Grafico de Operaciones Anuales "
?
?
? "                   OPERACIONES ANUALES A¤o:",xano1 picture "9999"
?
STORE ENERO TO CANTIDAD
DO calculos
? "ENERO      ",ENERO,BARRA
STORE FEBRERO TO CANTIDAD
DO calculos
? "FEBRERO    ",FEBRERO,BARRA
STORE MARZO TO CANTIDAD
DO calculos
? "MARZO      ",MARZO,BARRA
STORE ABRIL TO CANTIDAD
DO calculos
? "ABRIL      ",ABRIL,BARRA
STORE MAYO TO CANTIDAD
DO calculos
? "MAYO       ",MAYO,BARRA
STORE JUNIO TO CANTIDAD
DO calculos
? "JUNIO      ",JUNIO,BARRA
STORE JULIO TO CANTIDAD
DO calculos
? "JULIO      ",JULIO,BARRA
STORE SEPTIEMBRE TO CANTIDAD
DO calculos
? "SEPTIEMBRE:",SEPTIEMBRE,BARRA
STORE OCTUBRE TO CANTIDAD
DO calculos
? "OCTUBRE:   ",OCTUBRE,BARRA
STORE NOVIEMBRE TO CANTIDAD
DO calculos
? "NOVIEMBRE: ",NOVIEMBRE,BARRA
STORE DICIEMBRE TO CANTIDAD
DO calculos
? "DICIEMBRE: ",DICIEMBRE,BARRA
? 
? "    TOTAL:",TOTAL," Operaciones"
?
?
?
?
?
?
?
?
? "                               ___________________________"
? "                                  COORDINADOR DEL BANCO   "
? "                                        DE LIBROS         "



do rest_impre


close data


***********************************************
case menusele="morosos"
***********************************************
*     Morosos por Facultad
***********************************************
select 1
USE usuario ORDER cedula
set filter to moro='*'  

define window estadist from 5,13 to 40,70 ;
   title ' Estadísticas de Morosos por Facultad ' SYSTEM COLOR W/B
   &&color scheme 5;
  
activate window estadist
@ 04,01 say "Espere un momento, actualizando informaci¢n ..."
COUNT TO CANTUSUA
*count for cedula <> " "     to cantusua 
count for condicion = "EST" to estud
count for condicion = "PRO" to profe
count for condicion = "EMP" to admin
count for condicion = "pos" to postgrado
count for condicion = "OTR" to otro
* COUNT FOR INFSOCIAL = "SI"  TO INFORME
* COUNT FOR MORO = "*" TO MOROSOS  
COUNT FOR FACULTAD = "IN" TO INGE
COUNT FOR FACULTAD = "DE" TO DERE
COUNT FOR FACULTAD = "AR" TO ARQU
COUNT FOR FACULTAD = "ME" TO MEDI
COUNT FOR FACULTAD = "HU" TO HUMA
COUNT FOR FACULTAD = "AG" TO AGRO
COUNT FOR FACULTAD = "VE" TO VETE
COUNT FOR FACULTAD = "CE" TO ECON
COUNT FOR FACULTAD = "EG" TO EGEN
COUNT FOR FACULTAD = "CI" TO CIEN
COUNT FOR FACULTAD = "OD" TO ODON
COUNT FOR FACULTAD = "XX" TO GENE
COUNT FOR FACULTAD = "AT" TO ARTE


close data
clear
@ 01,01 SAY "Ingenier¡a         =" GET inge     PICTURE '99999999'
@ 02,01 SAY "Derecho            =" GET dere     PICTURE '99999999'
@ 03,01 SAY "Arquitectura       =" GET arqu     PICTURE '99999999'
@ 04,01 SAY "Medicina           =" GET medi     PICTURE '99999999'
@ 05,01 SAY "Humanidades        =" GET huma     PICTURE '99999999'
@ 06,01 SAY "Agronom¡a          =" GET agro     PICTURE '99999999'
@ 07,01 SAY "Veterinaria        =" GET vete     PICTURE '99999999'
@ 08,01 SAY "Econom¡a           =" GET econ     PICTURE '99999999'
@ 09,01 SAY "Estudios Generales =" GET egen     PICTURE '99999999'
@ 10,01 SAY "Ciencias           =" GET cien     PICTURE '99999999'
@ 11,01 SAY "Odontolog¡a        =" GET odon     PICTURE '99999999'
@ 12,01 SAY "Generales          =" GET gene     PICTURE '99999999'
@ 13,01 SAY "Artes              =" GET arte     PICTURE '99999999'
@ 14,01 say "                 _______________"
@ 15,01 say "  Total de Morosos =" GET cantusua PICTURE '99999999'

@ 18,01 SAY "Cantidad de Estudiantes       =" GET estud    PICTURE '99999999'
@ 19,01 SAY "Cantidad de Profesores        =" GET profe    PICTURE '99999999'
@ 20,01 SAY "Cantidad de Empleados         =" GET admin    PICTURE '99999999'
@ 21,01 SAY "Cantidad de Postgrado         =" GET postgrado PICTURE '99999999'
@ 22,01 SAY "Cant. Otros Usuarios          =" GET otro     PICTURE '99999999'
@ 23,32 say "___________"
@ 24,01 say "       Cant. total de Morosos =" GET cantusua PICTURE '99999999'
@ 25,01 say "_____________________________________________"

@ 28,01 say "Presione <ENTER> para continuar"
clear get
read

release window estadist


if init_impre("Imprimiendo Reporte de Morosos....")=0
   return
endif   

?
? " ", xinstitucio
? " ", xmensaje1
? " ", xmensaje2
? " ", xunidad
? " ", date()
?
?
?
?
? "         ESTADISTICAS GENERALES DE MOROSOS DEL SISTEMA"
?
?
? "     Ingenier¡a         =", inge  picture '999999'  
? "     Derecho            =", dere  picture '999999'   
? "     Arquitectura       =", arqu  picture '999999'    
? "     Medicina           =", medi  picture '999999'  
? "     Humanidades        =", huma  picture '999999'    
? "     Agronom¡a          =", agro  picture '999999'  
? "     Veterinaria        =", vete  picture '999999'    
? "     Econom¡a           =", econ  picture '999999'    
? "     Estudios Generales =", egen  picture '999999'   
? "     Ciencias           =", cien  picture '999999'   
? "     Odontolog¡a        =", odon  picture '999999'    
? "     Generales          =", gene  picture '999999'   
? "     Artes              =", arte  picture '999999'  
?
?
? "     Cantidad de Estudiantes       =", estud  picture '999999'    
? "     Cantidad de Profesores        =", profe  picture '999999'    
? "     Cantidad de Empleados         =", admin picture '999999'  
? "     Cantidad de Postgrado         =", postgrado picture '999999'      
? "     Cant. Otros Usuarios          =", otro  picture '999999'  
?
? "                            __________________"
? "     Cant. total de Morosos        =", cantusua picture '999999'  
?
?
?
?
?
?
?
?
?
?
?
?
?
? "                               ___________________________"
? "                                  COORDINADOR DEL BANCO   "
? "                                        DE LIBROS         "

do rest_impre



***********************************************
case menusele="retirados"
***********************************************
* muestra estadisticas de usuarios                   *
***********************************************
select 1 
use husua

define window estadist from 5,13 to 40,70;
   title ' Estadísticas de Usuarios Retirados ' SYSTEM COLOR W/B
   &&color scheme 5;
  
activate window estadist
@ 04,01 say "Espere un momento, actualizando informaci¢n ..."
select 1
count for cedula <> 0     to cantusua 
count for condicion = "EST" to estud
count for condicion = "PRO" to profe
count for condicion = "EMP" to admin
count for condicion = "POS" to postgrado
count for condicion = "OTR" to otro
COUNT FOR INFSOCIAL = "SI"  TO INFORME

COUNT FOR FACULTAD = "IN" TO INGE
COUNT FOR FACULTAD = "DE" TO DERE
COUNT FOR FACULTAD = "AR" TO ARQU
COUNT FOR FACULTAD = "ME" TO MEDI
COUNT FOR FACULTAD = "HU" TO HUMA
COUNT FOR FACULTAD = "AG" TO AGRO
COUNT FOR FACULTAD = "VE" TO VETE
COUNT FOR FACULTAD = "CE" TO ECON
COUNT FOR FACULTAD = "EG" TO EGEN
COUNT FOR FACULTAD = "CI" TO CIEN
COUNT FOR FACULTAD = "OD" TO ODON
COUNT FOR FACULTAD = "XX" TO GENE
COUNT FOR FACULTAD = "AT" TO ARTE


close data
clear
@ 01,01 SAY "Ingenier¡a         =" GET inge     PICTURE '99999999'
@ 02,01 SAY "Derecho            =" GET dere     PICTURE '99999999'
@ 03,01 SAY "Arquitectura       =" GET arqu     PICTURE '99999999'
@ 04,01 SAY "Medicina           =" GET medi     PICTURE '99999999'
@ 05,01 SAY "Humanidades        =" GET huma     PICTURE '99999999'
@ 06,01 SAY "Agronom¡a          =" GET agro     PICTURE '99999999'
@ 07,01 SAY "Veterinaria        =" GET vete     PICTURE '99999999'
@ 08,01 SAY "Econom¡a           =" GET econ     PICTURE '99999999'
@ 09,01 SAY "Estudios Generales =" GET egen     PICTURE '99999999'
@ 10,01 SAY "Ciencias           =" GET cien     PICTURE '99999999'
@ 11,01 SAY "Odontolog¡a        =" GET odon     PICTURE '99999999'
@ 12,01 SAY "Generales          =" GET gene     PICTURE '99999999'
@ 13,01 SAY "Artes              =" GET arte     PICTURE '99999999'
@ 14,01 say "                 _______________"
@ 15,01 say "Total de usuarios  =" GET cantusua PICTURE '99999999'


@ 18,01 SAY "Cantidad de Estudiantes       =" GET estud    PICTURE '99999999'
@ 19,01 SAY "Cantidad de Profesores        =" GET profe    PICTURE '99999999'
@ 20,01 SAY "Cantidad de Empleados         =" GET admin    PICTURE '99999999'
@ 21,01 SAY "Cantidad de Postgrado         =" GET postgrado PICTURE '99999999'
@ 22,01 SAY "Cant. Otros Usuarios          =" GET otro     PICTURE '99999999'
@ 23,32 say "___________"
@ 24,01 say "     Cant. total de Retirados =" GET cantusua PICTURE '99999999'
@ 25,01 say "_____________________________________________"
@ 26,01 SAY "Total Informe Social Positivo =" get informe picture '99999999'

@ 29,01 say "Presione <ENTER> para continuar"
clear get
read

release window estadist


if init_impre("Imprimiendo Reporte de Usuarios Retirados....")=0
   return
endif   

?
? " ", xinstitucio
? " ", xmensaje1
? " ", xmensaje2
? " ", xunidad
? " ", date()
?
?
?
?
? "        ESTADISTICAS GENERALES DE USUARIOS RETIRADOS DEL SISTEMA"
?
?
? "     Ingenier¡a         =", inge    picture '999999'  
? "     Derecho            =", dere   picture '999999'  
? "     Arquitectura       =", arqu   picture '999999'   
? "     Medicina           =", medi  picture '999999'  
? "     Humanidades        =", huma   picture '999999'   
? "     Agronom¡a          =", agro  picture '999999'  
? "     Veterinaria        =", vete  picture '999999'    
? "     Econom¡a           =", econ  picture '999999'    
? "     Estudios Generales =", egen  picture '999999'   
? "     Ciencias           =", cien  picture '999999'   
? "     Odontolog¡a        =", odon picture '999999'     
? "     Generales          =", gene picture '999999'    
? "     Artes              =", arte picture '999999'   
?
?
? "     Cantidad de Estudiantes       =", estud  picture '999999'    
? "     Cantidad de Profesores        =", profe  picture '999999'    
? "     Cantidad de Empleados         =", admin picture '999999'  
? "     Cantidad de Postgrado         =", postgrado   picture '999999'   
? "     Cant. Otros Usuarios          =", otro  picture '999999'  
?
? "                            __________________"
? "     Cant. total de Retirados       =", cantusua picture '999999'  
?
? "     Total Informe Social Positivo =", informe  picture '999999'  
? 
?
?
?
?
?
?
?
?
?
?
?
? "                               ___________________________"
? "                                  COORDINADOR DEL BANCO   "
? "                                        DE LIBROS         "

do rest_impre


endcase



***********************************************
procedure calculos
if CANTIDAD < maximo/45
 	store '  ß                                            ' to barra
ELSE
if CANTIDAD < maximo*2/45
	STORE '  ßß                                           ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*3/45
	STORE '  ßßß                                          ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*4/45
	STORE '  ßßßß                                         ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*5/45
	STORE '  ßßßßß                                        ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*6/45
	STORE '  ßßßßßß                                       ' TO BARRA
ELSE 
IF CANTIDAD < MAXIMO*7/45
	STORE '  ßßßßßßß                                      ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*8/45
	STORE '  ßßßßßßßß                                     ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*9/45
	STORE '  ßßßßßßßßß                                    ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*10/45
	STORE '  ßßßßßßßßßß                                   ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*11/45
	STORE '  ßßßßßßßßßßß                                  ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*12/45
	STORE '  ßßßßßßßßßßßß                                 ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*13/45
	STORE '  ßßßßßßßßßßßßß                                ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*14/45
	STORE '  ßßßßßßßßßßßßßß                               ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*15/45
	STORE '  ßßßßßßßßßßßßßßß                              ' TO BARRA	
else
if CANTIDAD < maximo*16/45
 	store '  ßßßßßßßßßßßßßßßß                             ' to barra
ELSE
if cantIDAD < maximo*17/45
	STORE '  ßßßßßßßßßßßßßßßßß                            ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*18/45
	STORE '  ßßßßßßßßßßßßßßßßßß                           ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*19/45
	STORE '  ßßßßßßßßßßßßßßßßßßß                          ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*20/45
	STORE '  ßßßßßßßßßßßßßßßßßßßß                         ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*21/45
	STORE '  ßßßßßßßßßßßßßßßßßßßßß                        ' TO BARRA
ELSE 
IF CANTIDAD < MAXIMO*22/45
	STORE '  ßßßßßßßßßßßßßßßßßßßßßß                       ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*23/45
	STORE '  ßßßßßßßßßßßßßßßßßßßßßßß                      ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*24/45
	STORE '  ßßßßßßßßßßßßßßßßßßßßßßßß                     ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*25/45
	STORE '  ßßßßßßßßßßßßßßßßßßßßßßßßß                    ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*26/45
	STORE '  ßßßßßßßßßßßßßßßßßßßßßßßßßß                   ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*27/45
	STORE '  ßßßßßßßßßßßßßßßßßßßßßßßßßßß                  ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*28/45
	STORE '  ßßßßßßßßßßßßßßßßßßßßßßßßßßßß                 ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*29/45
	STORE '  ßßßßßßßßßßßßßßßßßßßßßßßßßßßßß                ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*30/45
	STORE '  ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß               ' TO BARRA	
else
if cantIDAD < maximo*31/45
 	store '  ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß              ' to barra
ELSE
if cantIDAD < maximo*32/45
	STORE '  ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß             ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*33/45
	STORE '  ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß            ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*34/45
	STORE '  ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß           ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*35/45
	STORE '  ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß          ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*36/45
	STORE '  ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß         ' TO BARRA
ELSE 
IF cANTIDAD < MAXIMO*37/45
	STORE '  ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß        ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*38/45
	STORE '  ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß       ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*39/45
	STORE '  ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß      ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*40/45
	STORE '  ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß     ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*41/45
	STORE '  ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß    ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*42/45
	STORE '  ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß   ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*43/45
	STORE '  ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß  ' TO BARRA
ELSE
IF CANTIDAD < MAXIMO*44/45
	STORE '  ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß ' TO BARRA
ELSE
IF CANTIDAD = MAXIMO
	STORE '  ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß' TO BARRA								 
ENDIF
ENDIF
ENDIF
ENDIF
								 
ENDIF
ENDIF
ENDIF
ENDIF
							 
ENDIF
ENDIF
ENDIF
ENDIF
ENDIF
ENDIF
ENDIF
ENDIF
ENDIF
ENDIF
ENDIF
								 
ENDIF
ENDIF
ENDIF
ENDIF
							 
ENDIF
ENDIF
ENDIF
ENDIF
ENDIF
ENDIF
ENDIF
ENDIF
ENDIF
ENDIF
ENDIF
								 
ENDIF
ENDIF
ENDIF
ENDIF
							 
ENDIF
ENDIF
ENDIF
ENDIF
ENDIF
ENDIF
ENDIF
return













***********************************************
PROCEDURE CANCELPRIN
***********************************************
* para cancelar la impresion *
***********************************************
SET DEVICE TO SCREEN
SET PRINT OFF
ON ERROR
ON ESCAPE
@ 00,00 SAY REPLICATE(CHR(32),56)
@ 00,19 SAY "Impresión Cancelada"
READ
release window ventana1
DO MENU.PRG
CLOSE DATABASES ALL
RETURN TO ESTADIST   && regresa al programa
***********************************************
PROCEDURE ERRORPRIN
***********************************************
* indica si hay un error en la impresora *
***********************************************
SET DEVICE TO SCREEN
SET PRINT OFF
??CHR(7)
@ 00,00 SAY REPLICATE(CHR(32),56)
@ 00,18 SAY "Error en la Impresora"
READ
ON ERROR
ON ESCAPE
release window ventana1
DO MENU.PRG
CLOSE DATABASES ALL
RETURN TO estadist


***********************************************
FUNCTION INIT_IMPRE
***********************************************
* procedimiento para comenzar la impresion *
***********************************************
PARAMETER NOMBRE_REP
define window ventana1 from 21,20 to 27,78 ;
   title ' Impresión de Estadísticas ' SYSTEM COLOR W/B
   &&color scheme 5;
   
activate window ventana1
OP=0
DO WHILE  (OP <> 1) .AND. (OP <> 2)
   @ 00,18 SAY "Prepare la impresora"
   @ 02,17 PROMPT "C\<ontinuar"
   @ 02,32 PROMPT "\<Cancelar "
   MENU TO OP
   DO CASE
      CASE OP = 1
           IF (NOT PRINTSTATUS()) THEN
              OP = 3
           ENDIF
   ENDCASE	
ENDDO
IF (OP = 1) THEN
	SET DEVI TO PRINT
	SET CONSOLE OFF
	SET PRINT ON
	ON ESCAPE DO CANCELPRIN
 	ON ERROR DO ERRORPRIN
	* ??CHR(15) para utilizar letra peque¤a
	RETURN (1)
ELSE
    release window ventana1
    DO MENU.PRG
    CLOSE DATABASES ALL
	RETURN (0)
ENDIF

RETURN
*
PROCEDURE REST_IMPRE
***********************************************
* procedimiento para regresar de impresion    *
***********************************************
EJECT 
SET PRINT OFF
SET DEVI TO SCREEN
SET CONSOLE ON
ON ERROR
ON ESCAPE
release window ventana1
CLOSE DATABASES ALL
DO MENU.PRG
RETURN
***********************************************
