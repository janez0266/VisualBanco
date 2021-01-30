*****************************************************************
* PROGRAMA:  grafico.prg                                        *
* DESCRIPCION: grafico anual de ingreso                         *
* AUTOR:       Automatizacion - Serbiluz - Ing. Julio Anez      *
* REALIZADO:   16-03-96                                         *
* MODIFICADO:  01-11-2000                                       * 
*****************************************************************
*public xfecha,xmes,xano,xano1,BARRA,CANTIDAD
DO MENÚ2.MPR
select 1
USE conta ORDER fecha
total=0
MAXIMO=0
CANTIDAD=0
BARRA=' '
*do ano
**********************************************
* para seleccionar el ano para reporte anual *
**********************************************
set escape off
define window fecha from 19,20 to 24,75 ;
   title ' Selección del Año para el reporte' SYSTEM
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
   IF xano<=0
      release window fecha
      return to estadist
   ENDIF
   *store val(xano) to xano1 
   STORE xano TO xano1
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
   title ' Progreso ' SYSTEM
   &&color scheme 5;
   
activate window fecha1
@ 01,2 say 'Realizando los c lculos'
set filter to year(fecha)=xano1
sum ingreso to total
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
*total=0

set filter to month(fecha)=1 .and. year(fecha)=xano1
sum ingreso  to enero
@ 01,2 say 'Realizando los calculos:  ²²' 
set filter to month(fecha)=2 .and. year(fecha)=xano1
sum ingreso  to febrero
@ 01,2 say 'Realizando los calculos:  ²²²²' 
set filter to month(fecha)=3 .and. year(fecha)=xano1
sum ingreso  to marzo
@ 01,2 say 'Realizando los calculos:  ²²²²²²' 
set filter to month(fecha)=4 .and. year(fecha)=xano1
sum ingreso  to abril
@ 01,2 say 'Realizando los calculos:  ²²²²²²²²' 
set filter to month(fecha)=5 .and. year(fecha)=xano1
sum ingreso  to mayo
@ 01,2 say 'Realizando los calculos:  ²²²²²²²²²²' 
set filter to month(fecha)=6 .and. year(fecha)=xano1
sum ingreso  to junio
@ 01,2 say 'Realizando los calculos:  ²²²²²²²²²²²²' 
set filter to month(fecha)=7 .and. year(fecha)=xano1
sum ingreso  to julio
@ 01,2 say 'Realizando los calculos:  ²²²²²²²²²²²²²²' 
set filter to month(fecha)=9 .and. year(fecha)=xano1
sum ingreso  to septiembre
@ 01,2 say 'Realizando los calculos:  ²²²²²²²²²²²²²²²²²' 
set filter to month(fecha)=10 .and. year(fecha)=xano1
sum ingreso  to octubre
@ 01,2 say 'Realizando los calculos:  ²²²²²²²²²²²²²²²²²²²²' 
set filter to month(fecha)=11 .and. year(fecha)=xano1
sum ingreso to noviembre
@ 01,2 say 'Realizando los calculos:  ²²²²²²²²²²²²²²²²²²²²²²²' 
set filter to month(fecha)=12 .and. year(fecha)=xano1
sum ingreso  to diciembre
@ 01,2 say 'Realizando los calculos:  ²²²²²²²²²²²²²²²²²²²²²²²²²²²' 


store max(enero, febrero, marzo, abril, mayo, junio, julio, septiembre, octubre, noviembre, diciembre) to maximo


*store enero+febrero+marzo+abril+mayo+julio+julio+septiembre+octubre+noviembre+diciembre to total
release window fecha1
define window inganual from 11,11 to 32,87 ;
   title ' Gráfico de Ingresos Anuales ' SYSTEM
activate window inganual
clear
? "         INGRESOS ANUALES A¤o:",xano1 picture "9999"
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
DO CALCULOS
? "ABRIL      ",ABRIL,BARRA
STORE MAYO TO CANTIDAD
DO CALCULOS
? "MAYO       ",MAYO,BARRA
STORE JUNIO TO CANTIDAD
DO CALCULOS
? "JUNIO      ",JUNIO,BARRA
STORE JULIO TO CANTIDAD
DO CALCULOS
? "JULIO      ",JULIO,BARRA
STORE SEPTIEMBRE TO CANTIDAD
DO CALCULOS
? "SEPTIEMBRE:",SEPTIEMBRE,BARRA
STORE OCTUBRE TO CANTIDAD
DO CALCULOS
? "OCTUBRE:   ",OCTUBRE,BARRA
STORE NOVIEMBRE TO CANTIDAD
DO CALCULOS
? "NOVIEMBRE: ",NOVIEMBRE,BARRA
STORE DICIEMBRE TO CANTIDAD
DO CALCULOS
? "DICIEMBRE: ",DICIEMBRE,BARRA
? 
? "    TOTAL:",TOTAL," Bol¡vares"
?
@ 18,1 say "Presione <ENTER> para continuar"
read
************
if init_impre("Imprimiendo Gráfico de ingresos anuales...")=0
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
?
? "                              Gr fico de Ingresos Anuales "
?
?
? "               INGRESOS ANUALES A¤o:",xano1 picture "9999"
?
?
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
DO CALCULOS
? "ABRIL      ",ABRIL,BARRA
STORE MAYO TO CANTIDAD
DO CALCULOS
? "MAYO       ",MAYO,BARRA
STORE JUNIO TO CANTIDAD
DO CALCULOS
? "JUNIO      ",JUNIO,BARRA
STORE JULIO TO CANTIDAD
DO CALCULOS
? "JULIO      ",JULIO,BARRA
STORE SEPTIEMBRE TO CANTIDAD
DO CALCULOS
? "SEPTIEMBRE:",SEPTIEMBRE,BARRA
STORE OCTUBRE TO CANTIDAD
DO CALCULOS
? "OCTUBRE:   ",OCTUBRE,BARRA
STORE NOVIEMBRE TO CANTIDAD
DO CALCULOS
? "NOVIEMBRE: ",NOVIEMBRE,BARRA
STORE DICIEMBRE TO CANTIDAD
DO CALCULOS
? "DICIEMBRE: ",DICIEMBRE,BARRA
? 
? "    TOTAL:",TOTAL," Bol¡vares"
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


************
release window inganual
return

*****


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



*****
PROCEDURE CANCELPRIN
******************************
* para cancelar la impresion *
******************************
SET DEVICE TO SCREEN
SET PRINT OFF
ON ERROR
ON ESCAPE
@ 00,00 SAY REPLICATE(CHR(32),56)
@ 00,19 SAY "Impresi¢n Cancelada"
READ
release window ventana1
release window INGANUAL
DO MENU.PRG
CLOSE DATABASES ALL
RETURN TO estadist    && regresa al programa
*****
PROCEDURE ERRORPRIN
******************************************
* indica si hay un error en la impresora *
******************************************
SET DEVICE TO SCREEN
SET PRINT OFF
??CHR(7)
@ 00,00 SAY REPLICATE(CHR(32),56)
@ 00,18 SAY "Error en la Impresora"
READ
ON ERROR
ON ESCAPE
release window ventana1
release window codigo
DO MENU.PRG
CLOSE DATABASES ALL
RETURN TO estadist
*****

FUNCTION INIT_IMPRE
********************************************
* procedimiento para comenzar la impresion *
********************************************
PARAMETER NOMBRE_REP
define window ventana1 from 21,20 to 28,78 ;
   title ' Grafico de ingreso anual' SYSTEM
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
    release window INGANUAL
    DO MENU.PRG
    CLOSE DATABASES ALL
	RETURN (0)
ENDIF
RETURN to estadist
*****


PROCEDURE REST_IMPRE
***********************************************
* procedimiento para regresar de impresion    *
***********************************************
EJECT PAGE
SET PRINT OFF
SET DEVI TO SCREEN
SET CONSOLE ON
ON ERROR
ON ESCAPE
release window ventana1
release window INGANUAL
DO MENU.PRG
CLOSE DATABASES ALL
RETURN to estadist
*****
