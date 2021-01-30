* -- Se ha generado un archivo de secuencia de comandos de Asistente para Web -- 
*
* Se ha creado un registro único en GENHTML.DBF con su configuración.
* Se puede hacer referencia a este archivo con el Id. especificado en el 
* comando DO (GENHTML) siguiente.

LOCAL lnSaveArea
lnSaveArea=SELECT()
SELECT 0

SELECT Registro,Titulo,Autor,Codmat,editorial,uso FROM "C:\VISUAL BANCO\DATA\LIBROS.DBF" ;
  ORDER BY Registro INTO CURSOR webwizard_query

IF EMPTY(_GENHTML)
  _GENHTML='GenHTML.PRG'
ENDIF
DO (_GENHTML) WITH "C:\VISUAL BANCO\LIBROS.HTM",ALIAS(),2,,"_0KV189BU7"

IF USED("webwizard_query")
  USE IN webwizard_query
ENDIF
SELECT (lnSaveArea)
