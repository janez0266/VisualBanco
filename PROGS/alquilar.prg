*************************************************************
* PROGRAMA:    alquilar.prg                                     *
* DESCRIPCION: Registra el alquiler de los libros               *
* AUTOR:       Automatizacion - Serbiluz - Ing. Julio Anez      *
* REALIZADO:   16-03-96                                         *
* MODIFICADO:  01-11-2000                                       * 
*****************************************************************
PUBLIC Z,REG,CED,xy,abo1,xreg
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
      if abo1=0     && cuando la factura es igual a cero
           ??chr(7)
           wait window "No es posible elaborar factura "
           loop
      endif
      **
      if abo1<50     && cuando la factura es menor que CINCUENTA
         ??chr(7)   && no imprime y devuelve los liobros
         wait window "No es posible imprimir recibo " 
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
         do factura
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
       CREATE CURSOR temp01 ;
       (reg N(6), devol D(8), op C(1),titulo C(35),deuda N(10),abono N(10),diario N(6,2))
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
   define window libro from 11,30 to 15,86;
      title ' Datos del libro ' SYSTEM && color scheme 5
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
   DO PAGOALQ        &&rutina que elabora los calculos
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

RETURN TO ALQUILA

