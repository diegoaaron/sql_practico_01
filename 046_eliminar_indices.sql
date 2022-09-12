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
 
-- Agregamos una restricción "unique" sobre "legajo":

alter table empleados
add constraint UQ_EMPLEADOS_LEGAJO
unique (legajo);

-- Verificamos que la restricción usa el índice creado anteriormente, no crea otro

select constraint_name, constraint_type, index_name
from user_constraints
where table_name='EMPLEADOS';

-- Agregamos una restricción "primary key" sobre "documento"

alter table empleados
add constraint PK_EMPLEADOS_DOCUMENTO
primary key(documento);
 
 -- Verificamos que Oracle creó un índice para el campo "documento"
 
select constraint_name, constraint_type, index_name
from user_constraints
where table_name='EMPLEADOS'; 
 
--  Consultamos todos los índices y sus tipos consultando "user_indexes"




 