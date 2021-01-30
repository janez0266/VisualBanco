*************************************************************
* PROGRAMA:    factura.prg                                  *
* LLAMADO POR: alquilar.prg                                 *
* DESCRIPCION: para la elaboracion de las facturas en el    *
*              Sistema banco 3.0 (Alquileres)               *
* AUTOR:       Automatizacion - Serbiluz - Ing. Julio Anez      *
* REALIZADO:   16-03-96                                         *
* MODIFICADO:  01-11-2000                                       * 
*****************************************************************
public xusuario,cedula,total,xlin,xcol &&,XFECHA
define window factura from 05,5 to 20,73 ;
   title ' Elaboración de Facturas ' SYSTEM
activate window factura
*****
sele 10   && banco
store ultfact to ultfac
@ 00,01 say "Recibo"
@ 00,12 say "Registro"
@ 00,24 say "Concepto"     
@ 00,48 say "Monto "
&&fac=str(ultfac,8)
STORE ULTFAC TO FACTU
&&store ltrim(fac) to factu
&&DO WHILE LEN(FACTU)<8
&&   STORE "0"+FACTU TO FACTU
&&&ENDDO
@ 1,1  get factu    picture '99999999' && numero de la factura
clear get
select 11    && temp01 acumula temporal de devoluciones
GO TOP
lin1=1
col1=1
DO WHILE .NOT. EOF()
   DO CASE
      CASE op="R"               && para renovar un libro
           store "RENOVACION           " to xconcepto
           store abono                   to xabono
           store reg                     to xregistro
           @ lin1,col1+11 get xregistro
           @ lin1,col1+23 get xconcepto       && concepto de la operacion
           @ lin1,col1+47 get xabono  picture '99999999' && total de la factura 
           clear get
           lin1=lin1+1
      CASE op="D"               && para devolver un libro
           store "DEVOLUCION           " to xconcepto
           store abono                   to xabono
           store reg                     to xregistro
           @ lin1,col1+11 get xregistro
           @ lin1,col1+23 get xconcepto       && concepto de la operacion
           @ lin1,col1+47 get xabono  picture '99999999' && total de la factura 
           clear get
           lin1=lin1+1
      CASE op="A"               && para abonar a una deuda    
           store "ABONO                " to xconcepto
           store abono                   to xabono
           store reg                     to xregistro
           @ lin1,col1+11 get xregistro
           @ lin1,col1+23 get xconcepto       && concepto de la operacion
           @ lin1,col1+47 get xabono  picture '99999999' && total de la factura 
           clear get
           lin1=lin1+1
      CASE op="P"               && para paralizar una deuda
           store "ABONO                " to xconcepto
           store abono                   to xabono
           store reg                     to xregistro
           @ lin1,col1+11 get xregistro
           @ lin1,col1+23 get xconcepto       && concepto de la operacion
           @ lin1,col1+47 get xabono  picture '99999999' && total de la factura 
           clear get
           lin1=lin1+1
   ENDCASE
   SKIP
   if lin1>=10
      @ 1,1 clear to 16,70
      lin1=1
   endif   
ENDDO
*****
   select 09   && tempmov acumula temporal de devoluciones
   GO TOP
   DO WHILE .NOT. EOF()
      store "ALQUILER             " to xconcepto
      store abomin                  to xabono
      store registro                to xregistro
      @ lin1,col1+11 get xregistro
      @ lin1,col1+23 get xconcepto       && concepto de la operacion
      @ lin1,col1+47 get xabono  picture '99999999' && total de la factura 
      clear get
      lin1=lin1+1
      SKIP
      if lin1>=10
         @ 1,1 clear to 16,70
         lin1=1
      endif   
   ENDDO
*****
lin1=lin1+1
@ lin1,col1+40 say "Total:"
@ lin1,col1+47 get x picture "99999999"
clear get
&&do imprifact  && para imprimir factura
*****
&&procedure imprifact
***********************************************
* procedimiento para la impresion de facturas *
***********************************************
??chr(7)
if init_impre("Imprimiendo Factura...")=0
   return
endif 
** aqui comenzo el cambio
select 10     && archivo de datos
replace ultfact with ultfac

select 11    && temp01 acumula temporal de devoluciones
GO TOP
DO WHILE .NOT. EOF()
   DO CASE
      CASE op="R"               && para renovar un libro
           store "RENOVACION           " to xconcepto
           store abono                   to xabono
           store reg                     to xregistro
           store fecha                   to xfechreg
           store devol                   to xfechent     
           store fac                     to xfacultad
           store CED                     to xcedula
           store DEUDA                   to xdeuda
           store DIARIO                  to xdiario
           *****
           select 2   && movimientos
           seek xregistro
           replace FECHREG  WITH xfechreg
           replace FECHENT  WITH xfechent
           replace REGISTRO WITH xregistro
           replace CEDULA   WITH xcedula
           replace FACULTAD WITH xfacultad
           replace DEUDA    WITH xdeuda
           replace DIARIO   WITH xdiario
           select 4   && conta
           append blank
           replace nrofact  with  factu
           replace fecha    with  fechah
           replace mes      with  mesh
           replace registro with  xregistro
           replace ingreso  with  xabono
           replace concepto with  xconcepto
      CASE op="D"               && para devolver un libro
           store "DEVOLUCION           " to xconcepto
           store abono                   to xabono
           store reg                     to xregistro
           store fecha                   to xfechreg
           store devol                   to xfechent     
           store CED                     to xcedula
           store DEUDA                   to xdeuda
           store DIARIO                  to xdiario
           store fac                     to xfacultad
           *****
           select 2   && movimiento
           seek xregistro
           delete
           select 4   && conta
           append blank
           replace nrofact  with  factu
           replace fecha    with  fechah
           replace mes      with  mesh
           replace registro with  xregistro
           replace ingreso  with  xabono
           replace concepto with  xconcepto
      CASE op="A"               && para abonar a una deuda    
           store "ABONO                " to xconcepto
           store abono                   to xabono
           store reg                     to xregistro
           store fecha                   to xfechreg
           store devol                   to xfechent     
           store CED                     to xcedula
           store DEUDA                   to xdeuda
           store DIARIO                  to xdiario
           store fac                     to xfacultad
           *****
           select 2   && movimientos
           seek xregistro
           replace FECHREG  WITH xfechreg
           replace FECHENT  WITH xfechent
           replace REGISTRO WITH xregistro
           replace CEDULA   WITH xcedula
           replace FACULTAD WITH xfacultad
           replace DEUDA    WITH xdeuda
           replace DIARIO   WITH xdiario
           select 4   && conta
           append blank
           replace nrofact  with  factu
           replace fecha    with  fechah
           replace mes      with  mesh
           replace registro with  xregistro
           replace ingreso  with  xabono
           replace concepto with  xconcepto
      CASE op="P"               && para paralizar una deuda
           store "ABONO                " to xconcepto
           store abono                   to xabono
           store reg                     to xregistro
           store fecha                   to xfechreg
           store devol                   to xfechent     
           store CED                     to xcedula
           store DEUDA                   to xdeuda
           store DIARIO                  to xdiario
           store fac                     to xfacultad
           *****
           select 4   && conta
           append blank
           replace nrofact  with  factu
           replace fecha    with  fechah
           replace mes      with  mesh
           replace registro with  xregistro
           replace ingreso  with  xabono
           replace concepto with  xconcepto
           select 5  && paraliza
           append blank
           replace cedul    with  xcedula
           replace regg     with  xregistro
           replace deud     with  xdeuda
           replace fechpara with  fechah
           select 2   && movimientos
           seek xregistro
           delete
   ENDCASE
   select 11
   SKIP
ENDDO
*****
select 9     && temporal de movimientos
go top
do while .not. eof()
   store FECHREG  to xfechreg
   store FECHENT  to xfechent
   store REGISTRO to xregistro
   store CEDULA   to xcedula
   store FACULTAD to xfacultad
   store DEUDA    to xdeuda
   store DIARIO   to xdiario
   store ABOMIN   to xabomin
   *****
   select 2   && movimientos
   append blank
   replace FECHREG  WITH xfechreg
   replace FECHENT  WITH xfechent
   replace REGISTRO WITH xregistro
   replace CEDULA   WITH xcedula
   replace FACULTAD WITH xfacultad
   replace DEUDA    WITH xdeuda
   replace DIARIO   WITH xdiario

   select 4   && conta
   append blank
   replace nrofact  with  factu
   replace fecha    with  fechah
   replace mes      with  mesh
   replace registro with xregistro
   replace ingreso  with xabomin
   replace concepto with "ALQUILER"
   select 9   && regreso al temporal de movimientos
   skip
enddo
select 9   && borra el contenido del temporal de movimientos
  CREATE CURSOR tempmov ;
  (cedula C(10),fechreg D(8),fechent D(8),facultad C(2),escuela c(30), ;
  deuda N(10,2),Registro C(5),diario N(6,2),abomin N(7))
  index on registro tag xregis
select 11    && archivo temporal para alquileres
  CREATE CURSOR temp01 ;
  (reg C(5), devol D(8), op C(1),titulo C(35),deuda N(10),abono N(10),diario N(6,2))
  ***** 

select 7    && archivo de facturas
append blank
replace nrofact   with factu
replace usuario   with xnombre
replace cedula    with ced 
replace fecha     with fechah
replace totalfact with x
ultfac=ultfac+1   


*****
op='F'
CANT=3
XX=1
&&do imprime
&&do rest_impre

release window ventana1
release window factura
DO FACTURA2
RETURN
&& return to alquila

*****

*****
FUNCTION INIT_IMPRE
********************************************
* procedimiento para comenzar la impresion *
********************************************
PARAMETER NOMBRE_REP
define window ventana1 from 20,10 to 25,68 ;
   title ' Impresi¢n de Facturas ';
   SYSTEM
activate window ventana1
OP=0
DO WHILE  (OP <> 1) .AND. (OP <> 2)
   @ 00,18 SAY "Prepare la impresora"
   @ 02,17 PROMPT "C\<ontinuar"
   @ 02,32 PROMPT "\<Cancelar "
   MENU TO OP
   DO CASE
      &&CASE OP = 1
      &&     IF (NOT PRINTSTATUS()) THEN
      &&        OP = 3
       &&    ENDIF
      CASE OP = 2
           select 9  && borra el contenido del temporal
           CREATE CURSOR tempmov ;
             (cedula C(10),fechreg D(8),fechent D(8),facultad C(2),escuela c(30), ;
             deuda N(10,2),Registro C(5),diario N(6,2),abomin N(7))
             index on registro tag xregis
           select 11    && archivo temporal para alquileres
           CREATE CURSOR temp01 ;
           (reg C(5), devol D(8), op C(1),titulo C(35),deuda N(10),abono N(10),diario N(6,2))
           release window factura
           release window ventana1
           CANT=3
           XX=1
           CLOSE DATABASES ALL
           RELEASE WINDOWS VENTANA
           DO ALQUILA
           *return to alquila
   ENDCASE	
ENDDO
IF (OP = 1) THEN
	&&&&SET DEVI TO FILE salida.prn
	&&&&SET CONSOLE OFF
	*SET PRINT ON
	*ON ESCAPE DO CANCELPRIN
	*ON ERROR DO ERRORPRIN
	* ??CHR(15) para utilizar letra peque¤a
	RETURN (1)
ELSE
    release window ventana1
	RETURN (0)
ENDIF
RETURN
*****
