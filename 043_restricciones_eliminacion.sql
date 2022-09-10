/*

Para eliminar una restricción, la sintaxis básica es la siguiente:

 alter table NOMBRETABLA
  drop constraint NOMBRERESTRICCION;
  
Cuando eliminamos una tabla, todas las restricciones que fueron establecidas en ella, se eliminan también.

La condición de control que debe cumplir una restricción de control no puede modificarse, 
hay que eliminar la restricción y volver a crearla; igualmente con las restricciones "primary key" y "unique", 
no pueden modificarse los campos.

*/

drop table libros;

create table libros(
  codigo number(5) not null,
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(15),
  precio number(6,2)
);

-- Definimos una restricción "primary key" para nuestra tabla "libros" para asegurarnos que cada libro tendrá 
-- un código diferente y único:

alter table libros
add constraint PK_LIBROS_CODIGO
primary key(codigo);

-- Definimos una restricción "check" para asegurarnos que el precio no será negativo:

alter table libros
add constraint CK_LIBROS_PRECIO
check (precio > 0);

-- Definimos una restricción "unique" para los campos "titulo", "autor" y "editorial":

alter table libros
add constraint UQ_LIBROS
unique (titulo, autor, editorial);

-- Vemos las restricciones:

select * from user_constraints where table_name = 'LIBROS';

/*
Aparecen 4 restricciones:

- 1 "check" que controla que el precio sea positivo

- 1 "check" , que se creó al definir "not null" el campo "codigo", el nombre le fue dado por Oracle

- 1 "primary key" 

- 1 "unique".

*/

-- Eliminamos la restricción "PK_libros_codigo"

alter table libros
drop constraint PK_LIBROS_CODIGO;

-- Eliminamos la restricción de control "CK_libros_precio"

alter table libros
drop constraint CK_LIBROS_PRECIO;

-- Vemos si se eliminaron:

select * from user_constraints where table_name = 'LIBROS';

-- solo aparecen 2 restricciones (1 de not null, creada al definir el PK y la restriccion UNIQUE




