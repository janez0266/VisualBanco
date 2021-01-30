if 6 = MESSAGEBOX('Desea salir del Sistema', 4+32+256 , 'Mensaje')
	close database
	*DELETE FILE (TEMPCONTADB)
	*DELETE FILE (TEMPODB)
	*DELETE FILE (TEMPORALDB)
	on shutdown
	CLEAR EVENTS
	quit
endif