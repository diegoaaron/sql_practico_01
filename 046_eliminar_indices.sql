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
 
-- Agregamos una restricci�n "unique" sobre "legajo":

alter table empleados
add constraint UQ_EMPLEADOS_LEGAJO
unique (legajo);

-- Verificamos que la restricci�n usa el �ndice creado anteriormente, no crea otro

select constraint_name, constraint_type, index_name
from user_constraints
where table_name='EMPLEADOS';

-- Agregamos una restricci�n "primary key" sobre "documento"

alter table empleados
add constraint PK_EMPLEADOS_DOCUMENTO
primary key(documento);
 
 -- Verificamos que Oracle cre� un �ndice para el campo "documento"
 
select constraint_name, constraint_type, index_name
from user_constraints
where table_name='EMPLEADOS'; 
 
--  Consultamos todos los �ndices y sus tipos consultando "user_indexes"

select index_name,uniqueness
from user_indexes
where table_name='EMPLEADOS';

-- Creamos un �ndice no �nico sobre "nombre"

create index I_EMPLEADOS_NOMBRE
on empleados(nombre);

-- Creamos un �ndice no �nico sobre "apellido"

create index I_EMPLEADOS_APELLIDO
on empleados(apellido);
 
 -- Si intentamos eliminar un �ndice que utiliza una restricci�n Oracle no lo permite:

drop index I_EMPLEADOS_LEGAJO;

-- Verificamos que tal �ndice es utilizado por una restricci�n

select constraint_name, constraint_type, index_name
from user_constraints
where index_name='I_EMPLEADOS_LEGAJO';

-- Eliminamos el �ndice "I_empleados_nombre"

drop index I_EMPLEADOS_NOMBRE;


 