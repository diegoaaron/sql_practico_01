/*
Los índices se eliminan con "drop index"; la siguiente es la sintaxis básica:

drop index NOMBREINDICE;
 
Los índices usados por las restricciones "primary key" y "unique" no pueden eliminarse con "drop index", 
se eliminan automáticamente cuando quitamos la restricción.

Si eliminamos una tabla, todos los índices asociados a ella se eliminan.
*/
drop table empleados;

 create table empleados(
  legajo number (5),
  documento char(8),
  apellido varchar2(40),
  nombre varchar2(40)
 );
 
-- Creamos un índice único para el campo "legajo":
 
 create unique index I_EMPLEADOS_LEGAJO 
 on empleados(legajo);
 

 