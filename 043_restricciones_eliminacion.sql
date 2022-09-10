/*

Para eliminar una restricci�n, la sintaxis b�sica es la siguiente:

 alter table NOMBRETABLA
  drop constraint NOMBRERESTRICCION;
  
Cuando eliminamos una tabla, todas las restricciones que fueron establecidas en ella, se eliminan tambi�n.

La condici�n de control que debe cumplir una restricci�n de control no puede modificarse, 
hay que eliminar la restricci�n y volver a crearla; igualmente con las restricciones "primary key" y "unique", 
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

-- Definimos una restricci�n "primary key" para nuestra tabla "libros" para asegurarnos que cada libro tendr� 
-- un c�digo diferente y �nico:

alter table libros
add constraint PK_LIBROS_CODIGO
primary key(codigo);

-- Definimos una restricci�n "check" para asegurarnos que el precio no ser� negativo:

alter table libros
add constraint CK_LIBROS_PRECIO
check (precio > 0);

-- Definimos una restricci�n "unique" para los campos "titulo", "autor" y "editorial":

alter table libros
add constraint UQ_LIBROS
unique (titulo, autor, editorial);

-- Vemos las restricciones:

select * from user_constraints where table_name = 'LIBROS';






