/*
Los �ndices se eliminan con "drop index"; la siguiente es la sintaxis b�sica:

drop index NOMBREINDICE;
 
Los �ndices usados por las restricciones "primary key" y "unique" no pueden eliminarse con "drop index", 
se eliminan autom�ticamente cuando quitamos la restricci�n.

Si eliminamos una tabla, todos los �ndices asociados a ella se eliminan.
*/
drop table empleados;

 create table empleados(
  legajo number (5),
  documento char(8),
  apellido varchar2(40),
  nombre varchar2(40)
 );
 
-- Creamos un �ndice �nico para el campo "legajo":
 
 create unique index I_EMPLEADOS_LEGAJO 
 on empleados(legajo);
 

 