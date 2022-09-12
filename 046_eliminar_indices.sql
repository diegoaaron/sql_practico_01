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

select index_name,uniqueness
from user_indexes
where table_name='EMPLEADOS';

-- Creamos un índice no único sobre "nombre"

create index I_EMPLEADOS_NOMBRE
on empleados(nombre);

-- Creamos un índice no único sobre "apellido"

create index I_EMPLEADOS_APELLIDO
on empleados(apellido);
 
 -- Si intentamos eliminar un índice que utiliza una restricción Oracle no lo permite:

drop index I_EMPLEADOS_LEGAJO;

-- Verificamos que tal índice es utilizado por una restricción

select constraint_name, constraint_type, index_name
from user_constraints
where index_name='I_EMPLEADOS_LEGAJO';

-- Eliminamos el índice "I_empleados_nombre"

drop index I_EMPLEADOS_NOMBRE;


 