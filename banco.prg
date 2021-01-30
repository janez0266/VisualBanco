set default to 'E:\visual banco\data'
set path to '\VISUAL BANCO;\VISUAL BANCO\GRAPHICS;\visual banco\forms;\visual banco\reports;\visual banco\progs'
modify window screen title "Sistema Automatizado de Alquiler de Libros"

SET EXCLUSIVE  OFF
SET SYSMENU    OFF
SET STATUS     OFF
set safety off
SET TALK       OFF
SET ESCAPE     OFF
SET DELETE     ON
SET CENTURY    ON
SET DATE       BRIT
set status bar off
set sysmenu off
CLOSE DATABASES
_PLENGTH=60    && Numero maximo de lineas en cada reporte
PUBLIC TempPath,FECHAH,R,xinstitucio,xunidad,xpresupuest,xejecutado,xnom1,xnom2,xve,xvp,xva,xvo,xmensaje1,xmensaje2,xtotest,xtotpre,xfecinv,val,xtiemprob,xdiasalq,letra,codi,acceso,xmodulo, XSalida,modo,encabezado,cantidad,solmensaje,ULTIMA,XBANCO,saldo,cant,NROFACTURA,OPFAC
letra="ABCDEFGHIJKLMNÑOPQRSTUVWXYZ1234567890"
close databases all
public suich,mesh,xregistro, xcedula, xnombre,xnbauche,xconcepto, xconcepto1,xconcepto2,xconcepto3,xconcepto4, xconcepto5,xconcepto6,xmonto1,xmonto2,xmonto3,xmonto4,xmonto5,xmonto6,xtotal,xmonto,minimo,XMES

@ 0,0 SAY '\visual banco\graphics\fondo.bmp' BITMAP 
use '\visual banco\data\banco.dbf'
store institucio  to xinstitucio
store unidad      to xunidad
store presupuest  to xpresupuest
store ejecutado   to xejecutado
store inscripcio  to xinscripcio
store solvencia   to xsolvencia
store venta       to xventa
store plastifica  to xplastifica
store otro        to xotro
store nom1        to xnom1
store nom2        to xnom2
store ve          to xve
store vp          to xvp
store va          to xva
store vo          to xvo
store mensaje1    to xmensaje1
store mensaje2    to xmensaje2
store totest      to xtotest
store totpre      to xtotpre
store fecinv      to xfecinv
store tiemprob    to xtiemprob
store diasalq     to xdiasalq
store .F.         to XSalida
STORE BANCO       TO XBANCO
store direccion   to xdireccion
store ultfact     to xultfact
@ 9.246,5.800 SAY xinstitucio ;
	SIZE 2.000,45.200 ;
	FONT "Arial Black", 10 ;
	STYLE "T" ;
	PICTURE "@!"
@ 9.406,5.600 SAY xinstitucio ;
	SIZE 2.000,45.200 ;
	FONT "Arial Black", 10 ;
	STYLE "T" ;
	PICTURE "@!" ;	
	COLOR RGB(0,0,255,192,192,192)
@ 11.300,5.800 SAY xmensaje1 ;
	SIZE 2.000,45.200 ;
	FONT "Arial Black", 10 ;
	STYLE "T" ;
	PICTURE "@!"
@ 11.460,5.600 SAY xmensaje1 ;
	SIZE 2.000,45.200 ;
	FONT "Arial Black", 10 ;
	STYLE "T" ;
	PICTURE "@!" ;
	COLOR RGB(0,0,255,192,192,192)
@ 13.470,5.800 SAY xmensaje2 ;
	SIZE 2.000,45.200 ;
	FONT "Arial Black", 10 ;
	STYLE "T" ;
	PICTURE "@!"
@ 13.622,5.600 SAY xmensaje2 ;
	SIZE 2.000,45.200 ;
	FONT "Arial Black", 10 ;
	STYLE "T" ;
	PICTURE "@!" ;
	COLOR RGB(255,0,0,,,,)
	
@ 1,1 say date() ;
	SIZE 2.000,45.200 ;
	FONT "Arial Black", 10 ;
	STYLE "T" ;
	PICTURE "@!" 
	
	
@ 40.462,25.800 SAY xunidad ;
	SIZE 2.000,45.200 ;
	FONT "Arial Black", 14 ;
	STYLE "T" ;
	PICTURE "@!"
@ 40.615,25.600 SAY xunidad ;
	SIZE 2.000,45.200 ;
	FONT "Arial Black", 14 ;
	STYLE "T" ;
	PICTURE "@!" ;
	COLOR RGB(255,255,0,,,,)	
ON SHUTDOWN DO SALIR
DO FORM LOGIN.SCX
DO CLAVE.PRG

&&STORE DATE() TO FECHAH         && para la fecha del dia
TempPath="c:\windows\temp\"
DatabasesPath="e:\visual banco\data\"
*tempcontadb=TempPath+sys(3)+"A.dbf"
*tempodb=    TempPath+sys(3)+"B.dbf"
*temporaldb= TempPath+sys(3)+"C.dbf"
copy file 'E:\visual banco\data\tempconta.dbf' to (TempPath+"tempconta.dbf")
copy file 'E:\visual banco\data\tempo.dbf' to (TempPath+"tempo.dbf")
copy file 'E:\visual banco\data\temporal.dbf' to (TempPath+"temporal.dbf")
copy file 'E:\visual banco\data\TEMPCARNET.dbf' to (TempPath+"TEMPCARNET.dbf")
use 'E:\visual banco\data\FACULTAD.dbf'
DIMENSION FACUL(20,2)
FOR X = 1 TO 2
	FOR Y = 1 TO 20
	FACUL(Y,X)=' '
	ENDFOR
ENDFOR	
COPY NEXT 20 TO ARRAY FACUL
close databases
cant=0
SUICH=0
xfecha=date()
xcedula=0
xnbauche=0
xnombre=" "
xconcepto="Solo para OTROS INGRESOS"
xconcepto1=" "
xconcepto2=" "
xconcepto3=" "
xconcepto4=" "
xconcepto5=" "
xconcepto6=" "
xmonto=0
xmonto1=0
xmonto2=0
xmonto3=0
xmonto4=0
xmonto5=0
xmonto6=0
xtotal=0
mensaje=' '
OPFAC=0



STORE MONTH(date()) TO A
DO CASE
   CASE A=1
        STORE "ENE" TO MESH
   CASE A=2
        STORE "FEB" TO MESH
   CASE A=3
        STORE "MAR" TO MESH
   CASE A=4
        STORE "ABR" TO MESH
   CASE A=5
        STORE "MAY" TO MESH
   CASE A=6
        STORE "JUN" TO MESH
   CASE A=7
        STORE "JUL" TO MESH
   CASE A=8
        STORE "AGO" TO MESH
   CASE A=9
        STORE "SEP" TO MESH
   CASE A=10
        STORE "OCT" TO MESH
   CASE A=11
        STORE "NOV" TO MESH
   CASE A=12
        STORE "DIC" TO MESH
   ENDcase
   


@ 42.462,25.800 SAY "Usuario: " ;
	SIZE 2.000,45.200 ;
	FONT "Arial Black", 10 ;
	STYLE "T" ;
	PICTURE "@!"
	@ 42.462,36.800 SAY LOGINNAME ;
	SIZE 2.000,45.200 ;
	FONT "Arial Black", 10 ;
	STYLE "T" ;
	PICTURE "@!"
DO MENU.PRG


READ EVENTS
CLOSE DATABASES ALL
*DELETE FILE (TEMPCONTADB)
*DELETE FILE (TEMPODB)
*DELETE FILE (TEMPORALDB)
SET SYSMENU TO DEFAULT


