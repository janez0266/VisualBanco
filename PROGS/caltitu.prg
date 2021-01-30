******************************************************************
* *CALTITU.PRG                                                    *
* REPORTE GENERAL DE TITULOS Y TOTAL DE LIBROS EN EXISTENCIA     *
* AUTOR:       Automatizacion - Serbiluz - Ing. Julio Anez      *
* REALIZADO:   16-03-96                                         *
* MODIFICADO:  01-11-2000                                       * 
*****************************************************************
******************************************************************
SELE 3
USE VOLUMEN
SELE 1
USE LIBROS order titulo
LIBRO=0
KCONT=1


   @ 02,1 SAY "CALCULANDO EL NUMERO DE TITULOS... <<<<Espere>>>>"
GO TOP


DO WHILE .NOT. EOF()
store titulo to var1
store autor to var2
store registro to var3
   SKIP
   DO CASE
      CASE TITULO = VAR1 .AND. AUTOR = VAR2
           KCONT = KCONT+1
           @ 4,20 say kcont
           @ 5,20 say libro
           LOOP
      CASE (TITULO = VAR1 .AND. AUTOR <> VAR2) .OR. TITULO <> VAR1
           LIBRO = LIBRO+1
           KCONT = 1
           @ 4,20 say kcont
           @ 5,20 say libro
           LOOP
   ENDCASE
   
ENDDO
*wait window
SELE 3
REPLACE VOLUMEN WITH LIBRO

RETURN