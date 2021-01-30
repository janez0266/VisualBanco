*****************************************************************
* PROGRAMA:    alquila.prg                                      *
* DESCRIPCION: Verificacion para realizar alquiler              *
* AUTOR:       Automatizacion - Serbiluz - Ing. Julio Anez      *
* REALIZADO:   16-03-96                                         *
* MODIFICADO:  01-11-2000                                       * 
*****************************************************************
PUBLIC T,CED,FAC,FECHA,ultima,xnombre,coa,saldo,XX,XY,LIN,INF,ABOMIN,ABO,COL,I,FED,TANIA,OPFAC

DO ABRIRBASES

OPFACT=1
FECHAH=DATE()
define window ventana from 13,12 to 32,86 ;
   title ' Alquiler/Devolución de Libros ' SYSTEM COLOR W/B
   
activate window ventana
CLEAR
OPFAC=1
CANT=3
XX=1
DO WHILE .T.

	DO CHEQUEAUSUARIO
		IF OPFACT=0
			CLOSE DATABASES ALL
			EXIT
		ENDIF
		IF OPFACT=3
			LOOP
		ENDIF
	DO BUSCARMOVALQUILA
		IF OPFACT=0
			EXIT
		ENDIF
	DO MARCAREGISTROS
		IF OPFACT=3
			LOOP
		ENDIF
	DO CALCULAMONTO
 
    DO ALQUILAR
   		IF OPFACT=0
   			EXIT
		ENDIF
   *RETURN
   *EXIT
ENDDO

RELEASE WINDOWS VENTANA


************************ PROCEDIMIENTOS**********************




*************************************
*   PROCEDIMIENTO PASA ABRIR BASES
*************************************
PROCEDURE ABRIRBASES


SELECT 1
USE (DatabasesPath+"USUARIO.dbf") order cedula
SELECT 2
USE (DatabasesPath+"MOVIMIEN.dbf") order cedula
SELECT 3
USE (DatabasesPath+"LIBROS.dbf") order registro
SELECT 4
USE (DatabasesPath+"CONTA.dbf") order nrofact
SELECT 5
USE (DatabasesPath+"PARALIZA.dbf") order cedula
SELECT 6
USE (DatabasesPath+"NOHABIL.dbf") order fechano
SELECT 7
USE (DatabasesPath+"FACTU.dbf") order nrofact
SELECT 8
USE (DatabasesPath+"PROBLEMA.dbf") order cedula
select 9
  CREATE CURSOR tempmov ;
  (cedula N(10),fechreg D(8),fechent D(8),facultad C(2),escuela c(30), ;
   deuda N(10,2),Registro N(6),diario N(6,2),abomin N(7))
   index on registro tag xregis
*select 10
*use banco   
* store ultfact to ultima
select 11    && archivo temporal para alquileres
USE (TempPath+"tempo.dbf") exclusive
DELETE ALL
pack
  *CREATE CURSOR temp01 ;
  *(reg N(6), devol D(8), op C(1),titulo C(35),deuda N(10),abono N(10),diario N(6,2))
*****


RETURN

************************************************
* PROCEDIMIENTO PARA CHEQUEAR ESTADO DEL USUARIO
************************************************

PROCEDURE CHEQUEAUSUARIO
   OPFACT=1
   saldo=0
   x=0
   select 11    && archivo temporal para alquileres
   USE (TempPath+"tempo.dbf") exclusive
   DELETE ALL
   pack
*     CREATE CURSOR temp01 ;
 *    (reg N(6), devol D(8), op C(1),titulo C(35),deuda N(10),abono N(10),diario N(6,2))
   clear  
   STORE 0 TO CEDU
   @ 0,0 SAY "C‚dula:" GET CEDU PICTURE "9999999999"
   @ 17,1 say "Presione <ENTER> para regresar al menu anterior"
   READ
   @ 17,1 say space(60)
   IF CEDU=0
   	OPFACT=0
       *release window ventana 
       *close DATABASES ALL
       RETURN
       
   ENDIF
   STORE CEDU TO CED

   SELECT 1  && usuarios
   SEEK CED
   IF CEDULA # CED
      ??chr(7)
      wait window "Usuario no inscrito, presione <ENTER> para continuar"
      OPFACT=3
      RETURN
      *LOOP
   ENDIF
   @ 00,20 SAY "Nombre:"
   @ 00,28 GET APELLIDO
   @ 00,48 GET NOMBRE
   store trim(apellido)+', '+trim(nombre) to xnombre
   CLEAR GET
   STORE INFSOCIAL TO INF
   STORE FACULTAD  TO FAC
   
   *******************************************
   SELECT 5  && deudas paralizadas
   SEEK CED
   IF CED=CEDUL
      ??CHR(7)
      wait window "Este usuario tiene una deuda paralizada, Presione <ENTER>"
      @ 00,20 clear to 00,78
      RETURN
      *LOOP
   ENDIF
   
   
   *****procedimiento para ver si tiene factura anulada****** 
   
   SELECT 12
   USE ANULADA order cedula
   SEEK CED
   IF CED=CEDULA
      ??CHR(7)
      wait window "Este usuario tiene una FACTURA anulada no cancelada, Presione <ENTER>"
      @ 00,20 clear to 00,78
      RETURN
      *LOOP
   ENDIF
   
     
   
   *******************************************  
   
   SELECT 8                        && ARCHIVO DE PROBLEMAS
   set order to cedula
   SEEK ced
   IF ced=cedula
      ??CHR(7)
      STORE problem TO xproble
      STORE desde   TO xdesde
      STORE hasta   TO xhasta
      STORE SUBSTR(xproble,1,43) TO xproblem
      IF fechah < xhasta           && MUESTRA EL PROBLEMA
         define window problema from 20,20 to 24,76;
           title ' Suspendido temporalmente  ' SYSTEM COLOR N/BG
         activate window problema  
         @ 00,01 SAY "Problema:" GET xproblem
         @ 01,01 SAY "Desde:   " GET xdesde
         @ 01,24 SAY "Hasta:" GET xhasta
         @ 02,01 say "Presione <ENTER> para continuar"
         CLEAR GET
         READ
         release window problema
         @ 4,1 clear to 17,76
         @ 3,20 say space(60) 
*         LOOP
      ELSE                         && BORRA EL PROBLEMA
         DELETE
      ENDIF
   ENDIF
   *****  
   
   RETURN
   
   ************************************************
   * PROCEDIMIENTO PARA BUSCAR MOVIMIENTOS ACTUALES
   *    Y ALQUILAR NUEVOS LIBROS
   ************************************************
   
   PROCEDURE BUSCARMOVALQUILA
   
   OPFAC=1
   SELECT 2  &&movimientos
   set order to cedula
   SEEK CED
   if eof()
      @ 1,0 to 3,78
      @ 2,1  SAY "Registro"
      @ 2,11 SAY "Fec.Dev."
      @ 2,23 say "Dias "
      @ 2,29 say "Diario"
      @ 2,37 say "Alquiler"
      @ 2,47 say "Abo.Min."
      @ 2,58 SAY "Deuda"
      do alquilar                      && EJECUTA EL PROCEDIMIENTO ALQUILAR
      opfact=0
      *RELEASE WINDOWS VENTANA
      RETURN
      *EXIT
      *loop
   endif
   @ 1,0 to 3,78
   @ 2,1  SAY "Registro"
   @ 2,11 SAY "Fec.Dev."
   @ 2,23 say "Dias "
   @ 2,29 say "Diario"
   @ 2,37 say "Alquiler"
   @ 2,47 say "Abo.Min."
   @ 2,58 SAY "Deuda"
   coa=0                            && para contar la cantidad de libros
   DO WHILE CEDULA=CED
      coa=coa+1                     && incrementa coa
      DIASMORO=0                    && INICIALIZA LA VARIABLE DIASMORO
      DIASREAL=0                    && INICIALIZA LA VARIABLE DIASREAL
      STORE REGISTRO TO RR          && ALMACENA EL REGISTRO DEL LIBRO EN RR

      STORE FECHENT TO FEDD         && FECHA DE DEVOLUCION DEL LIBRO
      STORE FECHAH  TO FECHA        && FECHA DEL DIA
      STORE DEUDA   TO DEU          && ALMACENA LA DEUDA REAL DEL LIBRO
      STORE DIARIO  TO ALQDIARIO    && ALMACENA EL ALQUILER DIARIO
   
      DIASMORO=FECHA-FEDD           && DIAS DE MOROSIDAD
       
      SELECT 3   && libros
      seek rr
      store substr(titulo,1,35) to xtitu
      SELE 6                        && UTILIZA EL ARCHIVO DE DIAS NO HABILES
      GO TOP
      STORE 0 TO DIA
      DO WHILE .NOT. EOF()
         IF FECHANO > FEDD .AND. FECHANO <= FECHA
            DIA=DIA+1
         ENDIF
         SKIP
      ENDDO
      SELE 2                        && UTILIZA ARCHIVO DE ALQUILERES
      IF DIASMORO <= 0
         DEU1=ROUND(DEU,0)
         store deu1   to xdeu
      ELSE
         DIASREAL=DIASMORO-DIA
         DEUDA1=ROUND((ALQDIARIO*DIASREAL)+DEU,0)
         store deuda1 to xdeu
      ENDIF
      sele 11     && base de datos temporal
      append blank
      replace reg    with rr
      replace devol  with fedd
      replace titulo with xtitu
      replace deuda  with xdeu
      replace op     with "C"
      replace diario with alqdiario
      replace abono  with 0
      SELECT 2
      IF CANT >14
         ??chr(7)
         @ 17,1 say "Proxima p gina, Presione <ENTER> "
         read
         @ 4,1 clear to 16,71
         CANT=3
         
         XX=1
      ENDIF
      SKIP
   ENDDO   
   RETURN
   
 *****************************************************
 * PROCEDIMIENTO PARA MARCAR LOS REGISTROS C D R P A
 *****************************************************
 
 PROCEDURE MARCAREGISTROS
   OPFACT=1
   release all like vb
   dimension vb(coa)      && crea un arreglo de memoria
   select 11              && abre archivo temporal
   go top   
   cant=3
   xx=1
   xy=68
   ce=1
   do while ce<=coa
      cant=cant+1
      @ CANT,XX    SAY reg        && MUESTRA EL REGISTRO DEL LIBRO PRESTADO
      @ CANT,XX+10 SAY devol      && MUESTRA LA FECHA DE DEVOLUCION
      @ cant,23    say titulo
      @ CANT,XX+56 SAY deuda  PICTURE "99999999"
      store "C" to vb(ce) 
      @ cant,xy get vb(ce) PICTURE "!" 
      if cant >14
         ??CHR(7)
         @ 17,1 say "Proxima p gina, Presione <ENTER> "
         read
         @ 4,1 clear to 16,71
         CANT=3
         XX=1
         xy=68
      endif
      skip
      ce=ce+1   
   enddo
   @ 17,01 SAY "(C)ontinua, (D)evoluci¢n, (R)enovaci¢n, (P)araliza deuda, (A)bono"
   READ
   @ 17,01 say space(70)
   fff=1
   ban1="T"
   DO WHILE fff<ce
      IF vb(fff) <> "C" .AND. vb(fff) <> "D" .AND. vb(fff) <> "R" .AND. vb(fff) <> "A" .AND. vb(fff) <> "P"
         ??CHR(7)
         wait "Se ingreso un dato no valido, presione <ENTER> para continuar" window
         ban1="F"
         @ 4,1 CLEAR TO 17,76
         @ 3,20 SAY SPACE(60)
         EXIT
      ENDIF
      fff=fff+1
   ENDDO
   IF ban1="F"
      OPFACT=3
      RETURN
      
      *LOOP
   ENDIF
   go top
   ce=0
   do while .not. eof()
      ce=ce+1
      replace op with vb(ce)
      skip
   enddo   
   lin=1
   col=1
   saldo=0
   **** 
 
 RETURN  
 
 
 *****************************************************
 *  PROCEDIMIENTO PARA CALCULAR EL MONTO A PAGAR
 *****************************************************
 
 
 PROCEDURE CALCULAMONTO
 
   define window opera from 16,16 to 27,82 ;
     title ' Operaciones realizadas ' SYSTEM COLOR N/BG
   activate window opera
   ***
   @ 0,1  say "Reg."
   @ 0,9  say "op"
   @ 0,13 say "Devoluci¢n"
   @ 0,25 say "Deuda"
   @ 0,37 say "Abono"
   @ 0,49 say "Saldo"
   GO TOP
   vari="T"
   DO WHILE .NOT. EOF()
      DO CASE
         CASE op="R"               && para renovar un libro
              diasreno=30
              @ 0,31 say "Alq."
              @ 0,37 say "Debe  "
              @ 0,45 say "Abono         "
              @ 0,53 say "Deuda " 
              @ lin,col   get reg
              @ lin,col+8 get op
              clear get
              store fechah    to dev     &&fecha de devolucion
              store fechah+30 to dev1    &&fecha de devolucion + 30
              @ lin,col+12 get dev1      && permite modificar fecha
              read
              if devol > dev1
                 ??chr(7) 
                 wait window "Este libro no esta vencido, presione <ENTER>"
                 exit
              endif  
              if dow(dev1)=1    &&domingo
                 ??chr(7)
                 dev1=dev1+1
                 diasreno=diasreno+1
                 @ lin,col+12 get dev1
                 clear get                  
              endif    
              if dow(dev1)=7    &&sabado
                 ??chr(7)
                 dev1=dev1+2
                 diasreno=diasreno+2
                 @ lin,col+12 get dev1
                 clear get   
              endif    
              store dev1-dev to dias
              reno1=diario*dias   && total a pagar deuda anterior
              reno=round(reno1,0) && total redondeado deuda anterior
              mini=diario*diasreno     && abono minimo
              renova=round(reno,0)     && esta de mas
              deuda1=deuda+renova      && lo que se debe + renovacion
              abono12=deuda+mini       && deuda + abono minimo
              abono1=round(abono12,0)  && abono minimo
              @ lin,col+24 get deuda picture '99999' && la deuda anterior 
              @ lin,col+30 get reno  picture '99999' && el nuevo alquiler 
              clear get
              @ lin,col+36 get deuda1 picture '9999999' && la deuda completa
              clear get
              @ lin,col+44 get abono1 picture '9999999'
              read
              store deuda1-abono1 to deu      && aqui era la falla
              store abono1+saldo to saldo     && aqui almacena el saldo
              @ lin,col+52 get deu picture '9999999'
              clear get
              replace deuda  with deu
              replace devol  with dev1
              replace abono  with abono1
              lin=lin+1
         CASE op="D"               && para devolver un libro
              @ lin,col    get reg
              store reg to rrg
              @ lin,col+8  get op
              @ lin,col+12 get devol
              @ lin,col+24 get deuda
              store deuda+saldo to saldo
              @ lin,col+48 get saldo
              clear get
              read
              replace abono  with deuda
              lin=lin+1
              if deuda=0
                 select 2
                 set order to registro
                 seek rrg
                 dele
                 sele 11
                 replace op with '*' 
              endif   
         CASE op="A"               && para abonar a una deuda    
              @ lin,col    get reg
              @ lin,col+8 get op
              @ lin,col+12 get devol
              @ lin,col+24 get deuda
              clear get
              @ lin,col+36 get abono
              read
              deu=deuda-abono
              store abono+saldo to saldo
              @ lin,col+48 get saldo
              clear get
              read
              replace abono with abono
              replace deuda with deu 
              lin=lin+1
         CASE op="P"               && para paralizar una deuda
              @ lin,col    get reg
              @ lin,col+8 get op
              clear get
              store fechah to dev1
              @ lin,col+12 get dev1
              @ lin,col+24 get deuda
              clear get
              @ lin,col+36 get abono
              read
              deu=deuda-abono
              store abono+saldo to saldo
              @ lin,col+48 get saldo
              clear get
              read
              replace devol  with dev1
              replace abono with abono
              replace deuda with deu 
              lin=lin+1
      ENDCASE
      SKIP
      if lin>=10
         @ 1,1 clear to 16,70
         lin=1
      endif   
   ENDDO
  
   release window opera
   @ 17,57 SAY "Total:" GET saldo PICTURE "99999999"
   CLEAR GET 
 RETURN
 
 
 *******************************************************
 * PROCEDIMIENTO PARA ALQUILAR NUEVOS LIBROS
 *******************************************************
 
 PROCEDURE ALQUILAR

OPFACT=1 
STORE saldo TO ABO1
cant=cant+1
SET ESCAPE ON
ON ESCAPE RETURN
DO WHILE .T.
   SELECT 2
   set order to registro
   @ 17,1 say "< ENTER > elabora factura, < 0 > anula operaci¢n"
   STORE -1 TO XREG
   @ cant,xx GET XREG PICTURE "999999"
   READ
   @ 17,1 SAY SPACE(56)
   IF XREG=-1
      *if abo1=0     && cuando la factura es igual a cero
         *  ??chr(7)
          * wait window "No es posible elaborar factura cuando el monto es cero"
           *loop
      *endif
      **
      if abo1=0     && cuando la factura es CERO
         ??chr(7)   && no imprime y devuelve los libros
         wait window "No es posible imprimir recibo, se ejecutaran los procesos " 
         select 11
         go top
         do while .not. eof()
            if op='D'
               store reg to xreg
               select 2   && movimiento
               seek xreg
               delete
            endif   
            select 11
            skip
         enddo   
         CANT=3
         XX=1
         exit
         loop
      else
         store abo1 to x
         do factura                           && ejecuta procedimiento factura
         opfact=0
         EXIT
         *RETURN
      endif    
   ENDIF
   if xreg=0   && LIMPIA LAS BASES PARA ANULAR LA OPERACION
      select 9 
      CREATE CURSOR tempmov ;
       (cedula N(10),fechreg D(8),fechent D(8),facultad C(2),escuela c(30), ;
       deuda N(10,2),Registro N(6),diario N(6,2),abomin N(7))
       index on registro tag xregis
      select 11    && archivo temporal para alquileres
      USE (TempPath+"tempo.dbf") exclusive
      DELETE ALL
      pack
       *CREATE CURSOR temp01 ;
       *(reg N(6), devol D(8), op C(1),titulo C(35),deuda N(10),abono N(10),diario N(6,2))
      CANT=3
      XX=1
      exit
      *LOOP
      *DO ALQUILA 
      *RETURN TO ALQUILA
  endif   
  && PROCEDIMIENTO PARA ALQUILAR MAS LIBROS
  ***************************************
  
  
   STORE XREG TO REG

   SELECT 3
   SEEK REG
   IF REGISTRO # REG
      ??chr(7) 
      wait window "Este libro no se encuentra registrado, presione <ENTER>"
      LOOP
   ENDIF
   SELECT 2
   set order to registro
   SEEK REG
   IF REGISTRO = REG
      ??chr(7)
      wait window "Este libro se encuentra alquilado, presione <ENTER>"
      LOOP
   ENDIF
   ******
   * aqui validacion de operacion
   SELECT 9    && base de datos temporal
   SEEK REG
   IF REGISTRO = REG
      ??chr(7)
      wait window "Este libro se esta procesando, presione <ENTER>"
      LOOP
   ENDIF
   ******
   SELECT 3   && archivo de libros
   define window libro from 18,20 to 22,76;
      title ' Datos del libro ' SYSTEM 
   activate window libro
   store titulo               to xtitulo
   store autor                to xauto
   store substr(xtitulo,1,45) to xtitu
   store substr(xauto,1,45)   to xautor
   @ 00,1 SAY "T¡tulo:" get xtitu
   @ 01,1 SAY "Autor :" get xautor
   CLEAR GET
   STORE "S" TO W
   @ 02,1 SAY "Correcto S/N" GET W ;
      PICTURE "!" VALID W$('SN');
      error "Opci¢n invalida"
   READ
   IF W="N"
      release window libro
      LOOP
   ENDIF
   release window libro
   select 2
   *****
   DO PAGOALQ                                 &&rutina que elabora los calculos
   store abomin to abo
   @ cant,xx+46 GET ABO PICTURE "9999999"  &&abono
   READ
   do while abo<abomin
      ??chr(7)
      wait window "Abono no puede ser menor al abono minimo"
      store abomin to abo
      @ cant,xx+46 GET ABO PICTURE "9999999"  &&abono
      READ
   enddo   
   do while abo>I          
      ??chr(7)
      wait window "Abono no puede ser mayor que el alquiler"
      store abomin to abo
      @ cant,xx+46 GET ABO PICTURE "9999999"  &&abono
      READ
   enddo   
   STORE I-ABO TO T  && deuda pendiente total
   if t < 0
      store 0 to t
      @ cant,xx+56 GET t PICTURE "99999999"  && deuda pendiente total
      clear get
   else          
      @ cant,xx+56 GET t PICTURE "99999999"  && deuda pendiente total
      clear get
   endif   
   *****
   select 9    && base de datos temporal de movimientos
   APPEND BLANK      && agrega el alquiler en temporal de movimientos
   REPLACE FECHREG  WITH FECHAH
   REPLACE FECHENT  WITH FED
   REPLACE REGISTRO WITH REG
   REPLACE CEDULA   WITH CED
   REPLACE FACULTAD WITH FAC
   REPLACE DEUDA    WITH T
   REPLACE DIARIO   WITH TANIA
   REPLACE ABOMIN   WITH ABO
   x=abo1+abo
   abo1=x
   @ 17,57 SAY "Total:" GET X PICTURE "99999999"
   CLEAR GET
   if cant>14
      ??chr(7)
      @ 17,1 say "Proxima p gina, Presione <ENTER> "
      read
      @ 4,1 clear to 16,71
      CANT=4
      XX=1
     loop
   endif 
   cant=cant+1
ENDDO

RETURN


**************************************************
* PROCEDIMIENTO PARA CALCULAR EL MONTO DE ALQUILER
*      (FORMULA DE ALQUILER)
**************************************************

PROCEDURE PAGOALQ

cantdias=30
DO WHILE .T.
   store day(fechah)   to DD
   store month(fechah) to MM
   store year(fechah)  to AA
   STORE INT(30.57*MM) + INT(365.25*AA-395.25) + DD TO TTT
   ******
   SET CONFIRM ON
   * para evitar que el prestamo sea sabado o domingo
   store fechah+xdiasalq  to fed
   if dow(fed)=1    &&domingo
      fed=fed+1
      cantdias=cantdias+1
   endif    
   if dow(fed)=7    &&sabado
      fed=fed+2
      cantdias=cantdias+2
   endif    
   @ cant,xx+10 GET fed   && ingresa la fecha de devolucion
   READ
   SET CONFIRM OFF
   ******
   IF FED <= FECHAH
      wait window "La fecha de devolución en incorrecta, presione <ENTER>"
      LOOP
   ENDIF
   store day(fed)   to WW
   store month(fed) to ZZ
   store year(fed)  to YY
   STORE INT(30.57*ZZ) + INT(365.25*YY-395.25) + WW TO XXX
   STORE XXX-TTT TO DI
   @ cant,xx+22 GET DI PICTURE "9999"  && dias de alquiler
   SELECT 3     && archivo de libros
   SEEK REG
   STORE USO    TO XUSO
   STORE COSLBO TO C  &&costo del libro
   STORE ROUND ((12.67-(248-C)*0.03)/30,2) TO ALQDIA
   STORE (ALQDIA*0.35)+ALQDIA TO ALQDIA
   @ cant,xx+28 GET ALQDIA PICTURE "999.99"  &&muestra el alquiler diario
   STORE ALQDIA TO TANIA  && GUARDA EL ALQUILER DIARIO DEL LIBRO
   IF INF = "SI"
      STORE ROUND(ALQDIA*DI*.80,0) TO I
      @ cant,xx+36 GET I PICTURE "99999999"  &&alquiler informe SI
      * aqui
      STORE ALQDIA*.80*cantdias TO CALCU
      store round(calcu,0) to abomin  && abono minimo
   ELSE
      STORE ROUND (ALQDIA*DI,0) TO I
      @ cant,xx+36 GET I PICTURE "99999999"  &&alquiler libro informe NO
      * aqui 
      STORE ALQDIA*cantdias TO CAL
      store round(cal,0) to abomin   && abono minimo
   ENDIF
   STORE XUSO+1 TO XXUSO
   REPLACE USO WITH XXUSO  && REVISAR ESTA RUTINA
   CLEAR GET
   RETURN
ENDDO

RETURN
 
**********************************************************
* PROCEDIMIENTO PARA ELABORAR LA FACTURA
**********************************************************

PROCEDURE FACTURA

define window factura from 05,25 to 20,93 ;
   title ' Elaboración de Facturas ' SYSTEM COLOR W/B
activate window factura
*****
*sele 10   && banco

@ 00,12 say "Registro"
@ 00,24 say "Concepto"     
@ 00,48 say "Monto "

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

??chr(7)
if init_impre("Imprimiendo Factura...")=0
   return
endif 

select 10     && archivo de datos 
USE (DatabasesPath+"BANCO.dbf") exclusive
****   SE TOMA EL NUMERO DE LA FACTURA Y SE INCREMENTA EN LA BASE biblio.dbf
STORE ULTFACT TO ULTFAC
STORE ULTFAC TO FACTU
ULTFAC=ULTFAC+1
replace ultfact with ultfac
USE
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
           replace fecha    with  FECHAH
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
           replace fecha    with  FECHAH
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
           replace fecha    with  FECHAH
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
           replace fecha    with  FECHAH
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
   replace fecha    with  FECHAH
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
USE (TempPath+"tempo.dbf") exclusive
DELETE ALL
pack
  *CREATE CURSOR temp01 ;
  *(reg C(5), devol D(8), op C(1),titulo C(35),deuda N(10),abono N(10),diario N(6,2))
  ***** 

select 7    && archivo de facturas
append blank
replace nrofact   with factu
replace usuario   with xnombre
replace cedula    with ced 
replace fecha     with fechah
replace totalfact with x
*ultfac=ultfac+1   


*****
op='F'
CANT=3
XX=1


release window ventana1
release window factura


************proceso previo a la impresion de la factura*******

xano=year(date())
CLOSE DATABASES all
select 7 && 13
use '/visual banco/data/FACTU.dbf'
set order to nrofact
set filter to year(fecha)==xano
SEEK FACTU &&DATO DE LA FACTURA DEL PROC. ANT.
STORE FECHA TO FECHAH
store nrofact to nrofactura
	store cedula to xcedula
	store nbauche to xnbauche
	STORE USUARIO TO XNOMBRE
	store totalfact to xtotal
	
	select 15
	use (TempPath+'tempconta.dbf') exclusive
	delete all
	pack
	&&select 12
	SELECT 4
	use (DatabasesPath+"CONTA.dbf")
	set order to nrofact
	set filter to year(fecha)==xano
	seek nrofactura
	do while NROFACT == NROFACTURA &&.and. date()== fecha
		store concepto to xconcepto
		store registro to xregistro
		store fecha to xfecha
		store ingreso to xingreso
		select 15
		append blank
		replace concepto with xconcepto
		replace fecha with xfecha
		replace monto with xingreso
		replace registro with xregistro
		&&SELECT 12
		SELECT 4
		SKIP
	ENDDO
	CLOSE DATABASES ALL
	SELECT 13
	use (DatabasesPath+"FACTU.dbf")
	SELECT 15
	use (TempPath+'tempconta.dbf') exclusive
	do menú2.mpr
	
	DO FORM FACTURA

RETURN



********************************************
* procedimiento para comenzar la impresion *
********************************************

FUNCTION INIT_IMPRE

PARAMETER NOMBRE_REP
define window ventana1 from 20,20 to 25,78 ;
   title ' Impresión de Facturas ';
   SYSTEM
activate window ventana1
OP=0
DO WHILE  (OP <> 1) .AND. (OP <> 2)
   @ 00,2 SAY "CONFIRME SI ESTA SEGURO QUE DESEA IMPRIMIR"
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
           USE (TempPath+"tempo.dbf") exclusive
		   DELETE ALL
		   pack
           *CREATE CURSOR temp01 ;
           *(reg C(5), devol D(8), op C(1),titulo C(35),deuda N(10),abono N(10),diario N(6,2))
           release window factura
           release window ventana1
           CANT=3
           XX=1
           CLOSE DATABASES ALL
           *RELEASE WINDOWS VENTANA
           *DO ALQUILA
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

 
 
 