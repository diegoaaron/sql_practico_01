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

-- Corroboremos que se elimin�

select *from user_objects
where object_type='INDEX' and object_name like '%EMPLEADOS%';

-- Eliminamos la tabla

drop table empleados;
 
 -- Verificamos que se eliminaron todos los �ndices establecidos sobre la tabla

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

-- Cree un �ndice no �nico para el campo "nombre"

create index I_ALUMNOS_NOMBRE
on alumnos(nombre); 

-- Establezca una restricci�n "primary key" para el campo "legajo"

alter table alumnos
add constraint PK_ALUMNOS_LEGAJO
primary key(legajo);

-- Verifique que se cre� un �ndice con el nombre de la restricci�n

select * from user_indexes where table_name = 'ALUMNOS';

-- Verifique que se cre� un �ndice �nico con el nombre de la restricci�n consultando el diccionario de �ndices.

select * from user_ind_columns  where table_name = 'ALUMNOS';

-- Intente eliminar el �ndice "PK_alumnos_legajo" con "drop index"

drop index PK_ALUMNOS_LEGAJO;

-- Cree un �ndice �nico para el campo "documento"

create index I_ALUMNOS_DOCUMENTO
on alumnos(documento); 

-- Agregue a la tabla una restricci�n �nica sobre el campo "documento" y verifique que no se cre� un �ndice,
-- Oracle emplea el �ndice creado en el punto anterior.

alter table alumnos
add constraint UQ_ALUMNOS_DOCUMENTO
unique (documento);

-- Intente eliminar el �ndice "I_alumnos_documento" (no se puede porque una restricci�n lo est� utilizando)

drop index I_ALUMNOS_DOCUMENTO;

-- Elimine la restricci�n �nica establecida sobre "documento"

alter table alumnos
drop constraint UQ_ALUMNOS_DOCUMENTO;

-- Verifique que el �ndice "I_alumnos_documento" a�n existe.

select * from user_ind_columns  where table_name = 'ALUMNOS';

-- Elimine el �ndice "I_alumnos_documento", ahora puede hacerlo porque no hay restricci�n que lo utilice.

drop index I_ALUMNOS_DOCUMENTO;

--Elimine el �ndice "I_alumnos_nombre".

drop index I_ALUMNOS_NOMBRE;

-- Elimine la restricci�n "primary key"/

alter table alumnos
drop constraint PK_ALUMNOS_LEGAJO;

-- Verifique que el �ndice "PK_alumnos_legajo" fue eliminado (porque fue creado por Oracle al establecerse la restricci�n)

select * from user_ind_columns  where table_name = 'ALUMNOS';

-- Cree un �ndice compuesto por los campos "curso" y "materia", no �nico.

create index I_ALUMNOS_CURSOMATERIA
on alumnos(curso, materia);

-- Verifique su existencia.

select * from user_ind_columns  where table_name = 'ALUMNOS';

-- Elimine la tabla "alumnos" y verifique que todos los �ndices han sido eliminados junto con ella.

drop table alumnos;

select * from user_ind_columns  where table_name = 'ALUMNOS';