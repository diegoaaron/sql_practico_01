/*
Vimos que "alter table" permite modificar la estructura de una tabla, agregando, modificando y eliminando campos.

Para eliminar campos de una tabla la sintaxis b�sica es la siguiente:

 alter table NOMBRETABLA
  drop column NOMBRECAMPO;
  
En el siguiente ejemplo eliminamos el campo "precio" de la tabla "libros":

 alter table libros
  drop column precio;
  
No pueden eliminarse los campos a los cuales hace referencia una restricci�n "foreign key".

Si eliminamos un campo que tiene una restricci�n "primary key", "unique", "check" o "foreign key", la restricci�n tambi�n se elimina.

Si eliminamos un campo indexado, el �ndice tambi�n se elimina.

NO puede eliminarse un campo si es el �nico en la tabla.
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

-- El campo se ha eliminado y junto con �l la restricci�n "foreign key":

select * from user_constraints
where table_name = 'LIBROS';

-- Ahora si podemos eliminar el campo "codigo" de "editoriales", pues la restricci�n "foreign key" que hac�a referencia a ella 
-- ya no existe:

alter table editoriales
drop column codigo;

-- El campo "codigo" de "editoriales" se ha eliminado y junto con �l la restricci�n "primary key":

select * from user_constraints
where table_name = 'EDITORIALES';

-- Agregamos un �ndice compuesto sobre "titulo" y "autor" de "libros":

create unique index I_LIBROS_TITULO
on libros(titulo, autor);

-- validemos la existencia del indice

select index_name, column_name, column_position
from user_ind_columns
where table_name = 'LIBROS';

-- Recuerde que si elimina un campo indizado, su �ndice tambi�n se elimina. Eliminamos el campo "autor" de "libros":

alter table libros
drop column autor;

-- veamos si aun existe el indice

select index_name, column_name, column_position
from user_ind_columns
where table_name = 'LIBROS';

-- La tabla ahora solamente consta de un campo, por lo tanto, no puede eliminarse, pues la tabla no puede quedar vac�a de 
-- campos:

alter table libros
drop column titulo;

-- Ejercicio 1 

