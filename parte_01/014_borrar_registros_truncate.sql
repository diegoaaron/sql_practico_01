-- podemos utilizar "truncate", la cual elimina todo los registro pero mantiene la estructura de la tabla. 

truncate table libros;

select * from libros;

commit;

-- comparando con:
-- drop table: elimina toda la tabla (registros + estructura)
--- delete tabla: elimina todo los registros pero no la estructura (permite definir eliminar solo algunos registros específicos). Otra
-- diferencia es que Oracle guarda  una copia de los registro borrados con "delete" los cuales se pueden recuperar pero no 
-- guarda nada al ejecutar "truncate" 



