public xano,xcedula,xnombre,xtotal,xnbauche,nrofactura,NROFACT,FECHAH
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
	use '/visual banco/data/conta.dbf'
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
	use '/visual banco/data/FACTU.dbf'
	SELECT 15
	use (TempPath+'tempconta.dbf') exclusive
	do menú2.mpr
	
	DO FORM FACTURA
	*DO MENÚ1.MPR