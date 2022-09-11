/*

Dijimos que el objetivo de un indice es acelerar la recuperaci�n de informaci�n y que es �til cuando la tabla contiene miles 
de registros, cuando se realizan operaciones de ordenamiento y agrupamiento, etc.

Es importante identificar el o los campos por los que ser�a �til crear un �ndice, aquellos campos por los cuales se 
realizan b�squedas con frecuencia: claves primarias, claves externas o campos que combinan tablas.

No se recomienda crear �ndices sobre campos que no se usan con frecuencia en consultas o en tablas muy peque�as.

Para crear �ndices empleamos la instrucci�n "create index".

La sintaxis b�sica es la siguiente:

 create TIPOdeINDICE index NOMBREINDICE
on NOMBRETABLA(CAMPOS);

Los �ndices pueden ser: no �nicos (los valores pueden estar repetidos) o �nicos (los valores no pueden duplicarse). 
De modo predeterminado, si no se especifica el tipo de �ndice, se crea un no �nico.

Si se intenta crear un �ndice �nico para un campo que tiene valores duplicados, Oracle no lo permite.

Los campos de tipo "long" y "long raw" no pueden indexarse.

*/

-- En el siguiente ejemplo creamos un �ndice �nico sobre el campo "documento" de la tabla "empleados":

create unique index I_EMPLEADOS_DOCUMENTO
on empleados (documento);

-- Una tabla puede indexarse por un campo (o varios). Podemos crear un indice compuesto para los campos "apellido" y "nombre"

create index I_EMPLEADOS_APELLIDONOMBRE
on empleados(apellido, nombre);

select * from empleados;

-- Cuando creamos una restricci�n "primary key" o "unique" sobre una tabla, Oracle autom�ticamente crea un �ndice 
-- sobre el campo (o los campos) de la restricci�n y le da el mismo nombre que la restricci�n. En caso que la tabla ya tenga 
-- un �ndice, Oracle lo usa, no crea otro.

/*
Para obtener informaci�n sobre los �ndices podemos consultar varios diccionarios.

1) "user_indexes": nos muestra las siguientes columnas (entre otras que no analizaremos):

 - INDEX_NAME (nombre del �ndice),
 - INDEX_TYPE (tipo de �ndice, nosotros crearemos el stardart normal),
 - TABLE_NAME (nombre de la tabla),
 - UNIQUENESS (si es �nico o no).

2) "user_ind_columns": nos muestra las siguientes columnas (entre otras que no analizaremos):

 - INDEX_NAME (nombre del �ndice),
 - TABLE_NAME (nombre de la tabla),
 - COLUMN_NAME (nombre del campo),
 - COLUMN_POSITION (posici�n del campo),

3) "user_objects": en la columna "OBJECT_TYPE" muestra "index" si es un �ndice.

4) "user_constraints": si la restricci�n tiene un �ndice asociado, aparece su nombre en la columna "INDEX_NAME".
*/

drop table empleados;

create table empleados(
  legajo number(5),
  documento char(8),
  apellido varchar2(25),
  nombre varchar2(25),
  domicilio varchar2(30)
);

-- Agregamos una restricci�n "primary key" sobre el campo "legajo":

alter table empleados
add constraint PK_EMPLEADOS_LEGAJO
primary key(legajo);

-- Consultamos "user_constraints":

select constraint_name, constraint_type, index_name from user_constraints
where table_name = 'EMPLEADOS';

-- Note que Oracle cre� un �ndice con el mismo nombre de la restricci�n.

-- Veamos los �ndices de "empleados":

select index_name, index_type, uniqueness from user_indexes
where table_name = 'EMPLEADOS';

--  Aparece 1 fila, mostrando el nombre del �ndice, indicando que es normal y �nico.

-- Creamos un �ndice �nico sobre el campo "documento":

create unique index I_EMPLEADOS_DOCUMENTO
on empleados(documento);

-- Verificamos que se cre� el �ndice

select index_name, index_type, uniqueness from user_indexes
where table_name = 'EMPLEADOS';

-- Aparecen 2 filas, una por cada �ndice.

-- Agregamos a la tabla una restricci�n �nica sobre el campo "documento":

alter table empleados
add constraint UQ_EMPLEADOS_DOCUMENTO
unique (documento);

-- Analicemos la informaci�n que nos muestra "user_constraints"

select constraint_name, constraint_type, index_name
from user_constraints
where table_name = 'EMPLEADOS';

-- En la columna "index_name" correspondiente a la restricci�n �nica, aparece "I_EMPLEADOS_DOCUMENTO", 
-- Oracle usa para esta restricci�n el �ndice existente, no crea otro nuevo.

-- Creamos un �ndice no �nico, compuesto (para los campos "apellido" y "nombre")

create index I_EMPLEADOS_APELLIDONOMBRE
on empleados (apellido, nombre);

-- Consultamos el diccionario "user_indexes". Nos muestra informaci�n sobre los 3 �ndices de la tabla.

select index_name, index_type, uniqueness from user_indexes
where table_name = 'EMPLEADOS';

-- Veamos todos los �ndices de la base de datos activa consultando "user_objects". Aparecen varios �ndices, entre ellos, 
-- los de nuestra tabla "empleados".

select * from user_objects where object_type = 'INDEX';

-- Obtenemos informaci�n de "user_ind_columns". La tabla tiene 3 �ndices, 2 filas corresponden al �ndice compuesto 
-- "I_empleados_apellidonombre"; la columna "position" indica el orden de los campos indexados.

select index_name, column_name, column_position from user_ind_columns
where table_name = 'EMPLEADOS';

-- Agregamos algunos registros

insert into empleados values(1,'22333444','Lopez','Juan','Colon 123');
insert into empleados values(2,'23444555','Lopez','Luis','Lugones 1234');
insert into empleados values(3,'24555666','Garcia','Pedro','Avellaneda 987');
insert into empleados values(4,'25666777','Garcia','Ana','Caseros 678');

-- Si intentamos crear un �ndice �nico para el campo "apellido" (que contiene valores duplicados") Oracle no lo permite:

create unique index I_EMPLEADOS_APELLIDO
on empleados(apellido);

-- Igualmente, si hay un �ndice �nico sobre un campo y luego intentamos ingresar un registro con un valor repetido para 
-- el campo indexado, Oracle no lo permite.

-- Creamos un �ndice �nico sobre el campo "nombre"

create unique index I_EMPLEADOS_NOMBRE
on empleados(nombre);

-- Oracle lo permite porque no hay valores duplicados.

-- Intentamos agregamos un registro que repita un nombre:

insert into empleados values(5,'30111222','Perez','Juan','Bulnes 233');

-- oracle no lo permite. 

-- Ejercicio 1

drop table alumnos;

create table alumnos(
  legajo char(5) not null,
  documento char(8) not null,
  nombre varchar2(30),
  curso char(1),
  materia varchar2(30),
  notafinal number(4,2)
);

insert into alumnos values ('A123','22222222','Perez Patricia','5','Matematica',9);
insert into alumnos values ('A234','23333333','Lopez Ana','5','Matematica',9);
insert into alumnos values ('A345','24444444','Garcia Carlos','6','Matematica',8.5);
insert into alumnos values ('A348','25555555','Perez Patricia','6','Lengua',7.85);
insert into alumnos values ('A457','26666666','Perez Fabian','6','Lengua',3.2);

-- Intente crear un �ndice �nico para el campo "nombre".
-- No lo permite porque hay valores duplicados.

create unique index I_ALUMNOS_NOMBRE
on alumnos(nombre);

-- Cree un �ndice no �nico, para el campo "nombre"

create index I_ALUMNOS_NOMBRE
on alumnos(nombre);

-- Cree un �ndice �nico, para el campo "legajo".

create unique index I_ALUMNOS_LEGAJO 
on alumnos(legajo);

-- Establezca una restricci�n "primary key" sobre el campo "legajo"

alter table alumnos
add constraint PK_ALUMNOS_LEGAJO
primary key(legajo);

-- Verifique que Oracle no cre� un �ndice al agregar la restricci�n, utiliz� el �ndice "I_alumnos_legajo" existente

select index_name, column_name, column_position from user_ind_columns 
where table_name='ALUMNOS';

-- Agregue una restricci�n �nica sobre el campo "documento"

alter table alumnos
add constraint UQ_ALUMNOS_DOCUMENTO
unique (documento);

-- Verifique que Oracle cre� un �ndice al agregar la restricci�n y le dio el nombre de la restricci�n.

select index_name, column_name, column_position from user_ind_columns
where table_name='ALUMNOS';

-- Intente crear un �ndice �nico para la tabla "alumnos" sobre el campo "notafinal"

create unique index I_ALUMNOS_NOTAFINAL
on alumnos(notafinal);

-- Indexe la tabla "alumnos" por el campo "notafinal" (�ndice no �nico)

create index I_ALUMNOS_NOTAFINAL
on alumnos(notafinal);

-- Indexe la tabla "alumnos" por los campos "curso" y "materia" (�ndice no �nico)

create index I_ALUMNOS_CURSOMATERIA
on alumnos(curso, materia);

-- Intente crear un �ndice �nico sobre "materia" (error pues hay datos duplicados)

create unique index I_ALUMNOS_MATERIA
on alumnos(materia);

-- Vea los indices de "alumnos"

select index_name, column_name, column_position from user_ind_columns 
where table_name='ALUMNOS';

-- Consulte el diccionario "user_ind_columns" y analice la informaci�n retornada.

select * from user_ind_columns;

-- Vea todos los �ndices de la base de datos activa que contengan en su nombre el patr�n "%EMPLEADOS%" (5 filas retornadas)

select * from user_ind_columns where table_name like '%EMPLEADOS%';
