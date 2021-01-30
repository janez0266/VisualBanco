*****************************************************************
* PROGRAMA:    pagoalq.prg                                      *
* DESCRIPCION: indica el pago de alquiler por libro             *
* AUTOR:       Automatizacion - Serbiluz - Ing. Julio Anez      *
* REALIZADO:   16-03-96                                         *
* MODIFICADO:  01-11-2000                                       * 
*****************************************************************
PUBLIC ABO,I,DAT,FED,H,TANIA,abomin,cantdias
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
      wait window "La fecha de devoluci¢n en incorrecta, presione <ENTER>"
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