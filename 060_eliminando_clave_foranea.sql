/*
Podemos eliminar una restricción "foreign key" con "alter table". La sintaxis básica es la misma que para cualquier 
otra restricción:

 alter table TABLA
  drop constraint NOMBRERESTRICCION;

Eliminamos la restricción "foreign key" de "libros":

 alter table libros
  drop constraint FK_libros_codigoeditorial;

No se puede eliminar una tabla si una restricción "foreign key" hace referencia a ella.

Cuando eliminamos una tabla que tiene una restricción "foreign key", la restricción también se elimina.
*/

 drop table libros;
 drop table editoriales;

 create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  codigoeditorial number(3)
 );
 create table editoriales(
  codigo number(3),
  nombre varchar2(20)
);

 insert into editoriales values(1,'Emece');
 insert into editoriales values(2,'Planeta');
 insert into editoriales values(3,'Siglo XXI');

 insert into libros values(100,'El aleph','Borges',1);
 insert into libros values(101,'Martin Fierro','Jose Hernandez',2);

 alter table editoriales
 add constraint PK_editoriales
  primary key (codigo);

 alter table libros
 add constraint FK_libros_codigoeditorial
  foreign key (codigoeditorial)
  references editoriales(codigo);

 select constraint_name, constraint_type
  from user_constraints
  where table_name='LIBROS';
 
 -- Eliminamos la restricción "foreign key" de "libros": 
 alter table libros
  drop constraint FK_libros_codigoeditorial;

 -- No existe ahora la restricción FK_libros_codigoeditorial
 select constraint_name, constraint_type
  from user_constraints
  where table_name='LIBROS';
