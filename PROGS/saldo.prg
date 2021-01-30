************************************************************
* PROGRAMA:    saldo.prg                                   *
* DESCRIPCION: para mostrar los saldos de cada usuario     *
* AUTOR:       Automatizacion - Serbiluz - Ing. Julio Anez      *
* REALIZADO:   16-03-96                                         *
* MODIFICADO:  01-11-2000                                       * 
*****************************************************************
PUBLIC T,CED,FAC,FECHA
CLOSE DATABASES ALL
DO MENÚ2.MPR

define window ventana from 13,12 to 32,86 ;
   title ' Consulta de saldos ' SYSTEM COLOR W/B &&COLOR N/B
activate window ventana
clear
CANT=3
XX=1
DO WHILE .T.
   total=0
   total1=0
   total2=0
   cant=3
   xx=1
   clear  
   *STORE SPACE(10) TO CEDU
   STORE 0 TO CEDU
   @ 0,0 SAY "Cedula:" GET CEDU PICTURE "99999999"
   @ 17,1 say "Presione <ENTER> para regresar al menu anterior"
   READ
   @ 17,1 say space(60)
   IF CEDU=0
       close data
       release window ventana 
       DO MENU.PRG
       CLOSE DATABASES ALL
       RETURN
   ENDIF
   *STORE RTRIM(CEDU) TO CED
   STORE CEDU TO CED
   *DO WHILE LEN(CED) < 10
   *   STORE "0" + CED TO CED
   *ENDDO
 
SELECT 1
USE USUARIO order cedula
SELECT 2
USE MOVIMIEN order cedula
SELECT 3
USE LIBROS order registro
SELECT 4
USE CONTA order nrofact
SELECT 5
USE PARALIZA order cedula
SELECT 6
USE NOHABIL order fechano   
   
   SELECT 1  && usuarios
   SEEK CED
   *IF CEDULA = CED
   IF EOF()
      ??chr(7)
      wait window "Usuario no inscrito, presione <ENTER> para continuar"
      loop
   ENDIF
   @ 00,20 SAY "Nombre:"
   @ 00,28 GET APELLIDO
   @ 00,48 GET NOMBRE
   CLEAR GET
   STORE INFSOCIAL TO INF
   STORE FACULTAD  TO FAC
   SELECT 5  && deudas paralizadas
   SEEK CED
   IF CED=CEDUL
      ??CHR(7)
      wait window "Este usuario tiene una deuda paralizada, Presione <ENTER>"
      @ 00,20 clear to 00,78
      LOOP
   ENDIF
   SELECT 2  && movimientos
   set order to cedula
   SEEK CED
   ** encabezado
   @ 1,0 to 3,78
   @ 2,1  SAY "Registro"
   @ 2,11 SAY "Fec.Dev."
   @ 2,23 say "Titulo  "
   @ 2,66 SAY "Deuda"
   **
   DO WHILE CEDULA=CED
      DIASMORO=0                    && INICIALIZA LA VARIABLE DIASMORO
      DIASREAL=0                    && INICIALIZA LA VARIABLE DIASREAL
      RR=REGISTRO                   && ALMACENA EL REGISTRO DEL LIBRO EN RR
      CANT=CANT+1                   && INCREMENTA CANT
      @ CANT,XX SAY REGISTRO        && MUESTRA EL REGISTRO DEL LIBRO PRESTADO
      @ CANT,XX+10 SAY FECHENT      && MUESTRA LA FECHA DE DEVOLUCION
      STORE FECHENT TO FEDD         && FECHA DE DEVOLUCION DEL LIBRO
      STORE FECHAH  TO FECHA        && FECHA DEL DIA
      STORE DEUDA   TO DEU          && ALMACENA LA DEUDA REAL DEL LIBRO
      STORE DIARIO  TO ALQDIARIO    && ALMACENA EL ALQUILER DIARIO
      DIASMORO=FECHA-FEDD           && DIAS DE MOROSIDAD
      SELECT 3  && libros
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
      @ cant,23 say xtitu
      SELE 2                        && UTILIZA ARCHIVO DE ALQUILERES
       IF DIASMORO <= 0
         DEU1=ROUND(DEU,0)
         @ CANT,XX+62 SAY DEU1 PICTURE "99999.99"
         total1=total1+deu1
      ELSE
         DIASREAL=DIASMORO-DIA
         DEUDA1=ROUND((ALQDIARIO*DIASREAL)+DEU,0)
         @ CANT,XX+62 SAY DEUDA1 PICTURE "99999.99"
         total2=total2+deuda1
      ENDIF
      SELECT 2
      IF CANT >13
         ??chr(7)
         @ 17,1 say "Proxima p gina, Presione <ENTER> "
         read
         @ 4,1 clear to 21,70
         CANT=3
         XX=1
      ENDIF
      SKIP
   ENDDO
   total=total1+total2
   @ 15,49 say "Deuda total:"
   @ 15,61 say total picture "9999999.99"   
   ??chr(7)
   CLOSE DATABASES ALL
   @ 17,1 say "Presione <ENTER> para consultar otro usuario "
   read
ENDDO