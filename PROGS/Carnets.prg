****************************************************************
* PROGRAMA:    carnets.prg                                     *
* LLAMADO POR: banco30.prg                                     *
* DESCRIPCION: elaboracion de carnets                          * 
* AUTOR:       Automatizacion - Serbiluz - Ing. Julio Anez      *
* REALIZADO:   16-03-96                                         *
* MODIFICADO:  01-11-2000                                       * 
*****************************************************************
public xfecha, ced
set bell off
define window sele from 10,40 to 16,70 ;
   color scheme 1;
   shadow
activate window sele
CLEAR
set color to n/w
CLEAR
set color to n/w
DEFINE MENU MENUSELE 
DEFINE PAD CA OF MENUSELE PROMPT 'Carnets por \<Fecha  '  at 00,00;
  key alt+F, '' 
DEFINE PAD PR OF MENUSELE PROMPT 'Carnets por \<C‚dula '  at 01,00; 
  key alt+C, '' 
ON SELECTION PAD CA OF MENUSELE DO carnet01
ON SELECTION PAD PR OF MENUSELE DO carnet02
*****
activate menu MENUSELE
release WINDOW sele
close data
set color to n/w
return
*****
procedure carnet01
**********************************
* Para imprimir carnet por fecha *
**********************************
select 1
USE (DatabasesPath+"USUARIO.dbf") ORDER fechain
** seleccionar la fecha
do fecha
if init_impre("Imprimiendo Carnets por Fecha...")=0
   return
endif   
set filter to fechain=xfecha 
do carnetiza 
*do rest_impre
return
*****
procedure carnet02
***********************************
* Para imprimir carnet por cedula *
***********************************
select 1
USE (DatabasesPath+"USUARIO.dbf") ORDER cedula
** seleccionar la cedula
do cedula
if init_impre("Imprimiendo Carnets por Fecha...")=0
   return
endif   
set filter to cedula=ced 
do carnetiza    
*do rest_impre
release window ventana1
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
RETURN TO CARNETS    && regresa al programa
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
RETURN TO CARNETS
*****
FUNCTION INIT_IMPRE
********************************************
* procedimiento para comenzar la impresion *
********************************************
PARAMETER NOMBRE_REP
define window ventana1 from 11,10 to 15,68 ;
   title ' Impresi¢n de Carnets ';
   color scheme 5;
   shadow
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
	*SET DEVI TO FILE SALIDA.PRN
	*SET CONSOLE OFF
	* SET PRINT ON
	* ON ESCAPE DO CANCELPRIN
	* ON ERROR DO ERRORPRIN
	* ??CHR(15) para utilizar letra peque¤a
	RETURN (1)
ELSE
    release window ventana1
	RETURN (0)
ENDIF
RETURN
*****
PROCEDURE REST_IMPRE
***********************************************
* procedimiento para regresar de impresion    *
***********************************************
* EJECT PAGE
*SET PRINT OFF
SET DEVI TO SCREEN
SET SAFETY OFF
COPY FILE SALIDA.PRN TO LPT1.DOS
SET SAFETY ON
SET CONSOLE ON
ON ERROR
ON ESCAPE
release window ventana1
RETURN
******
procedure fecha
***************************************************
* para seleccionar la fecha para imprimir carnets *
***************************************************
define window fecha from 09,10 to 14,65 ;
   title ' Selecci¢n de Fecha ';
   color scheme 5;
   shadow
activate window fecha
sele 1
set order to fechain
vali='T'
do while vali='T'
   STORE CTOD ('00/00/0000') TO xfecha
   @ 01,15 say 'Fecha:' GET xfecha
   READ
   STORE DTOC(xfecha) TO xfech
   IF xfech="  /  /    "
      release window fecha
      return to carnets
   ENDIF
   seek xfecha
   if eof()
      ??chr(7)
      @ 3,1 say "Fecha no registrada" 
      read
      @ 3,1 say space(30)
      loop
   else 
      vali='F'      
   endif   
enddo   
release window fecha
sele 1
set order to fechain
return
*****
procedure cedula
************************************************
* para seleccionar la fecha del reporte diario *
************************************************
define window fecha from 09,10 to 14,65 ;
   title ' Selecci¢n de C‚dula ';
   color scheme 5;
   shadow
activate window fecha
sele 1
set order to cedula
vali='T'
do while vali='T'
   store 0 to xcedula
   @ 01,15 say 'C‚dula:' GET xcedula
   READ
   IF xcedula=0
      release window fecha
      return to carnets
   ENDIF
   STORE xcedula TO ced
   *DO WHILE LEN(ced) < 10
   *   STORE "0"+ced TO ced
   *ENDDO
   SEEK ced
   if eof()
      ??chr(7)
      @ 3,1 say "Usuario no registrado" 
      read
      @ 3,1 say space(30)
      loop
   else 
      vali='F'      
   endif   
enddo   
release window fecha
sele 1
set order to cedula
return
*****

procedure carnetiza
***********************************
* cuerpo del programa 
SELE 1
  

      STORE FECHAH    TO XFEC      && MODIFICADO
      STORE CEDULA    TO XCED
      STORE NOMBRE    TO XNOM
      STORE APELLIDO  TO XAPE
      STORE CONDICION TO XCON 
      STORE FACULTAD  TO XFAC
      STORE BANCOLIB  TO XBAN
      ** PARA LOS NOMBRES Y APELLIDOS
      STORE XCED TO CEDU
      STORE XNOM TO NOMB
      STORE XAPE TO APEL
      *** HAY QUE ADAPTAR LAS CONDICIONES SEGUN BANCO DE LIBROS


     DO CASE
         CASE xcon="EST"
              STORE "ESTUDIANTE       " TO COND
              FECH=XFEC+XVE
         CASE xcon="PRO"
              STORE "PROFESOR         " TO COND
              FECH=XFEC+XVP
         CASE xcon="EMP"
              STORE "EMPLEADO         " TO COND
              FECH=XFEC+XVA
         CASE xcon="POS"
              STORE "POSTGRADO        " TO COND
              FECH=XFEC+XVA     
         CASE xcon="OTR"
              STORE "OTRO             " TO COND
              FECH=XFEC+XVO
      ENDCASE
      *** AQUI VA LA CONDICION PARA LA FACULTAD
      DO CASE
         CASE XFAC="IN"
              STORE "INGENIERIA                " TO FACU
         CASE XFAC="DE"
              STORE "CIENCIAS JURIDICAS Y P.   " TO FACU
         CASE XFAC="AR"
              STORE "ARQUITECTURA              " TO FACU
         CASE XFAC="ME"
              STORE "MEDICINA                  " TO FACU
         CASE XFAC="HU"
              STORE "HUMANIDADES Y EDUCACION   " TO FACU
         CASE XFAC="AG"
              STORE "AGRONOMIA                 " TO FACU
         CASE XFAC="VE"
              STORE "CIENCIAS VETERINARIAS     " TO FACU
         CASE XFAC="CE"
              STORE "CIENCIAS ECON. Y SOCIALES " TO FACU
         CASE XFAC="EG"
              STORE "ESTUDIOS GENERALES        " TO FACU
         CASE XFAC="CI"
              STORE "CIENCIAS                  " TO FACU
         CASE XFAC="OD"
              STORE "ODONTOLOGIA               " TO FACU
         CASE XFAC="AT"
              STORE "ARTES                     " TO FACU
         ENDCASE
         ** AQUI VA LA CONDICION PARA EL BANCO DE LIBROS

WAIT WINDOWS
report form CARNET noeject to printer

       
       REPLACE CARNET WITH "SI"    
  
   
   return