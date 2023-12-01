/*
Vimos que "alter table" permite modificar la estructura de una tabla, agregando, modificando y eliminando campos.

Para eliminar campos de una tabla la sintaxis básica es la siguiente:

 alter table NOMBRETABLA
  drop column NOMBRECAMPO;
  
En el siguiente ejemplo eliminamos el campo "precio" de la tabla "libros":

 alter table libros
  drop column precio;
  
No pueden eliminarse los campos a los cuales hace referencia una restricción "foreign key".

Si eliminamos un campo que tiene una restricción "primary key", "unique", "check" o "foreign key", la restricción también se elimina.

Si eliminamos un campo indexado, el índice también se elimina.

NO puede eliminarse un campo si es el único en la tabla.
*/
 drop table libros;
 drop table editoriales;

 create table editoriales(
  codigo number(3),
  nombre varchar2(30),
  primary key(codigo)
 );

 create table libros(
  titulo varchar2(30),
  editorial number(3),
  autor varchar2(30),
  precio number(6,2),
  constraint FK_libros_editorial
   foreign key(editorial)
   references editoriales(codigo)
 );

-- Eliminamos un campo de la tabla "libros":

alter table libros
drop column precio;

-- Vemos la estructura de la tabla "libros":

describe libros;

-- El campo "precio" ya no existe.

-- Recuerde que no pueden eliminarse los campos referenciados por una "foreign key". Intentamos eliminar el 
-- campo "codigo" de "editoriales":
-- Un mensaje indica que la sentencia no fue ejecutada.

alter table editoriales
drop column codigo;

-- Eliminamos el campo "editorial" de "libros":

alter table libros
drop column editorial;

describe libros;

-- El campo se ha eliminado y junto con él la restricción "foreign key":

select * from user_constraints
where table_name = 'LIBROS';

-- Ahora si podemos eliminar el campo "codigo" de "editoriales", pues la restricción "foreign key" que hacía referencia a ella 
-- ya no existe:

alter table editoriales
drop column codigo;

-- El campo "codigo" de "editoriales" se ha eliminado y junto con él la restricción "primary key":

select * from user_constraints
where table_name = 'EDITORIALES';

-- Agregamos un índice compuesto sobre "titulo" y "autor" de "libros":

create unique index I_LIBROS_TITULO
on libros(titulo, autor);

-- validemos la existencia del indice

select index_name, column_name, column_position
from user_ind_columns
where table_name = 'LIBROS';

-- Recuerde que si elimina un campo indizado, su índice también se elimina. Eliminamos el campo "autor" de "libros":

alter table libros
drop column autor;

-- veamos si aun existe el indice

select index_name, column_name, column_position
from user_ind_columns
where table_name = 'LIBROS';

-- La tabla ahora solamente consta de un campo, por lo tanto, no puede eliminarse, pues la tabla no puede quedar vacía de 
-- campos:

alter table libros
drop column titulo;

-- Ejercicio 1 

 drop table empleados;
 drop table secciones;

 create table secciones(
  codigo number(2),
  nombre varchar(20),
  primary key (codigo)
 );

 create table empleados(
  apellido varchar2(20),
  nombre varchar2(20) not null,
  domicilio varchar2(30),
  seccion number(2),
  sueldo number(8,2),
  constraint CK_empleados_sueldo
   check (sueldo>=0) disable,
  fechaingreso date,
  constraint FK_empleados_seccion
   foreign key (seccion)
   references secciones(codigo)
   on delete set null
 );

 insert into secciones values(8,'Secretaria');
 insert into secciones values(9,'Contaduria');
 insert into secciones values(10,'Sistemas');

 insert into empleados values('Lopez','Juan','Colon 123',8,505.50,'10/10/1980');
 insert into empleados values('Gonzalez','Juana','Avellaneda 222',9,600,'01/05/1990');
 insert into empleados values('Perez','Luis','Caseros 987',10,800,'12/09/2000');
 
-- Elimine el campo "domicilio" y luego verifique la eliminación

alter table empleados
drop column domicilio;

describe empleados;

-- Vea las restricciones de "empleados" (1 restricción "foreign key" y 2 "check")

select * from user_constraints
where table_name = 'EMPLEADOS';

-- Intente eliminar el campo "codigo" de "secciones"

alter table secciones
drop column codigo;

-- Elimine la restricción "foreign key" de "empleados", luego elimine el campo "codigo" de "secciones" y verifique la eliminación

alter table empleados
drop constraint FK_EMPLEADOS_SECCION;

alter table secciones
drop column codigo;

-- Verifique que al eliminar el campo "codigo" de "secciones" se ha eliminado la "primary key" de "secciones"

describe secciones;

-- Elimine el campo "sueldo" y verifique que la restricción sobre tal campo se ha eliminado

alter table empleados
drop column sueldo;

select * from user_constraints
where table_name = 'EMPLEADOS';

-- Cree un índice no único por el campo "apellido" y verifique su existencia consultando "user_indexes"

create index I_EMPLEADOS_APELLIDO
on empleados(apellido);


select * from user_indexes
where table_name = 'EMPLEADOS';

-- Elimine el campo "apellido" y verifique que el índice se ha eliminado

alter table empleados
drop column apellido;

-- Elimine 2 campos de "empleados" y vea la estructura de la tabla

alter table empleados
drop column seccion;

alter table empleados
drop column fechaingreso;

-- Intente eliminar el único campo de "empleados"
 
 describe empleados;
 
 alter table empleados
drop column nombre;
 