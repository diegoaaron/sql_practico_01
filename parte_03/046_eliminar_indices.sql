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

-- Corroboremos que se eliminó

select *from user_objects
where object_type='INDEX' and object_name like '%EMPLEADOS%';

-- Eliminamos la tabla

drop table empleados;
 
 -- Verificamos que se eliminaron todos los índices establecidos sobre la tabla

select * from user_indexes where table_name = 'EMPLEADOS';
 
 -- Lo verificamos nuevamente consultando el diccionario de todos los objetos

select *from user_objects
where object_type='INDEX' and object_name like '%EMPLEADOS%';

-- Ejercicio 1 

drop table alumnos;
 
create table alumnos(
  legajo char(5) not null,
  documento char(8) not null,
  nombre varchar2(30),
  curso char(1) not null,
  materia varchar2(20) not null,
  notafinal number(4,2)
);

-- Cree un índice no único para el campo "nombre"

create index I_ALUMNOS_NOMBRE
on alumnos(nombre); 

-- Establezca una restricción "primary key" para el campo "legajo"

alter table alumnos
add constraint PK_ALUMNOS_LEGAJO
primary key(legajo);

-- Verifique que se creó un índice con el nombre de la restricción

select * from user_indexes where table_name = 'ALUMNOS';

-- Verifique que se creó un índice único con el nombre de la restricción consultando el diccionario de índices.

select * from user_ind_columns  where table_name = 'ALUMNOS';

-- Intente eliminar el índice "PK_alumnos_legajo" con "drop index"

drop index PK_ALUMNOS_LEGAJO;

-- Cree un índice único para el campo "documento"

create index I_ALUMNOS_DOCUMENTO
on alumnos(documento); 

-- Agregue a la tabla una restricción única sobre el campo "documento" y verifique que no se creó un índice,
-- Oracle emplea el índice creado en el punto anterior.

alter table alumnos
add constraint UQ_ALUMNOS_DOCUMENTO
unique (documento);

-- Intente eliminar el índice "I_alumnos_documento" (no se puede porque una restricción lo está utilizando)

drop index I_ALUMNOS_DOCUMENTO;

-- Elimine la restricción única establecida sobre "documento"

alter table alumnos
drop constraint UQ_ALUMNOS_DOCUMENTO;

-- Verifique que el índice "I_alumnos_documento" aún existe.

select * from user_ind_columns  where table_name = 'ALUMNOS';

-- Elimine el índice "I_alumnos_documento", ahora puede hacerlo porque no hay restricción que lo utilice.

drop index I_ALUMNOS_DOCUMENTO;

--Elimine el índice "I_alumnos_nombre".

drop index I_ALUMNOS_NOMBRE;

-- Elimine la restricción "primary key"/

alter table alumnos
drop constraint PK_ALUMNOS_LEGAJO;

-- Verifique que el índice "PK_alumnos_legajo" fue eliminado (porque fue creado por Oracle al establecerse la restricción)

select * from user_ind_columns  where table_name = 'ALUMNOS';

-- Cree un índice compuesto por los campos "curso" y "materia", no único.

create index I_ALUMNOS_CURSOMATERIA
on alumnos(curso, materia);

-- Verifique su existencia.

select * from user_ind_columns  where table_name = 'ALUMNOS';

-- Elimine la tabla "alumnos" y verifique que todos los índices han sido eliminados junto con ella.

drop table alumnos;

select * from user_ind_columns  where table_name = 'ALUMNOS';