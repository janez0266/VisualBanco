DO MENÚ2.MPR
define window indice from 07,20 to 17,78 ;
   title ' Reconstrucción de índices ';
   color scheme 5;
   shadow
activate window indice
@ 00,01 say "El recontruir los ¡ndices, le tomara a          "
@ 01,01 say "BANCO 3.1 varios minutos...                     "            
@ 02,01 say "Recuerde solo utilizar esta función en horas de "
@ 03,01 say "poco movimiento y a fin de mes Cuando no esten  "  
@ 04,01 say "mas usuarios conectados al mismo                "
op="N"
@ 06,01 SAY "Desea continuar S/N" GET op;
   PICTURE "!" VALID op="S" .OR. op="N";
   error "Opción inválida. Presione S ó N. (Pulse una tecla)"
READ
if op="N"
   release window indice 
   do menú1.mpr
   return
endif   
clear
* dibuja la tazita
 text
           ú
             ú
            ú
           ú ú                 
          ÉÍÍÍË»              
          º   Ì¼              
          ÈÍÍÍ¼
endtext              
@ 02,22 say "Archivo: "
@ 04,22 say "Indice : " 
@ 08,01 say "Espere por favor, generando ¡ndices..."
**************
@ 02,32 say "Libros        "
use libros exclusive                        
pack
*****
@ 04,32 say "Registro      "
set safety off
index on registro tag registro
set safety on
*****
@ 04,32 say "uso del libro "
set safety off
index on uso tag uso descending   
set safety on
*****
@ 04,32 say "Autor        "
set safety off
index on substr(autor,1,60) tag autor   
set safety on
*****
@ 04,32 say "T¡tulo       "
set safety off
index on substr(titulo,1,60) tag titulo   
set safety on
*************
@ 04,32 say "Cod. de Mat. "
set safety off
index on codmat tag codmat
set safety on
*************
@ 02,32 say "Userban       "
use userban exclusive                        
pack
*****
@ 04,32 say "Password      "
*set safety off
*index on password  
*set safety on
*************
@ 02,32 say "Usuario      "
use usuario exclusive                       
pack
*****
@ 04,32 say "Cédula      "
set safety off
index on cedula tag cedula    
set safety on
*****
@ 04,32 say "Apellido    "
set safety off
index on trim(apellido)+trim(nombre) tag apellido
set safety on
*****
@ 04,32 say "Fecha       "
set safety off
index on fechain tag fechain    
set safety on
**************
@ 02,32 say "Movimient    "
use movimien exclusive                       
pack
*****
@ 04,32 say "Cédula       "
set safety off
index on cedula tag cedula    
set safety on
*****
@ 04,32 say "Registro     "
set safety off
index on registro tag registro    
set safety on
**************
@ 02,32 say "Problema     "
use problema exclusive                       
pack
*****
@ 04,32 say "Cédula       "
set safety off
index on cedula tag cedula    
set safety on
**************
@ 02,32 say "Hist. de usuarios"
use husua exclusive                       
pack
*****
@ 04,32 say "Cédula       "
set safety off
index on cedula tag cedula    
set safety on
***************
@ 02,32 say "Conta            "
use conta exclusive                       
pack
*****
@ 04,32 say "Nrofact     "
set safety off
index on nrofact tag nrofact    
set safety on
*****
@ 04,32 say "Mes         "
set safety off
index on month(fecha)+year(fecha) tag mes
set safety on
*****
@ 04,32 say "Fecha       "
set safety off
index on fecha tag fecha
set safety on
*****
@ 04,32 say "Ano         "
set safety off
index on year(fecha) tag ano
set safety on
***************
@ 02,32 say "Paraliza         "
use paraliza exclusive                       
pack
*****
@ 04,32 say "Cedula      "
set safety off
index on cedul tag cedula    
set safety on
*****
@ 04,32 say "Registro    "
set safety off
index on regg tag registro    
set safety on
*****
@ 02,32 say "Factu            "
use factu exclusive                       
pack
*****
@ 04,32 say "Nro. Fact  "
set safety off
index on nrofact tag nrofact    
set safety on
*****
@ 04,32 say "Fecha     "
set safety off
index on fecha tag fecha    
set safety on
**************


@ 02,32 say "Anuladas     "
use anulada exclusive                       
pack
*****
@ 04,32 say "Cédula       "
set safety off
index on cedula tag cedula    
set safety on
**********************
@ 02,32 say "No Habiles   "
use nohabil exclusive                       
pack
*****
@ 04,32 say "Fecha        "
set safety off
index on fechano tag fechano    
set safety on

close databases




@ 08,01 say space(40)
@ 02,22 say "Operaci¢n Concluida,            "
@ 04,22 say "Presione <ENTER> para continuar "
read
release window indice
DO MENÚ1.MPR
return
******