/*
Podemos crear una tabla e insertar datos en ella en una sola sentencia consultando otra tabla (o varias) con esta sintaxis:

 create table NOMBRENUEVATABLA
  as SUBCONSULTA;
Es decir, se crea una nueva tabla y se inserta en ella el resultado de una consulta a otra tabla.

Tenemos la tabla "libros" de una librería y queremos crear una tabla llamada "editoriales" que contenga los nombres de 
las editoriales.

La tabla "editoriales", que no existe, contendrá solamente un campo llamado "nombre". La tabla libros contiene varios registros.

Podemos crear la tabla "editoriales" con el campo "nombre" consultando la tabla "libros" y en el mismo momento 
insertar la información:

 create table editoriales
  as (select distinct editorial as nombre from libros);

La tabla "editoriales" se ha creado con el campo "nombre" seleccionado del campo "editorial" de "libros".

Los campos de la nueva tabla tienen el mismo nombre, tipo de dato y valores almacenados que los campos listados de 
la tabla consultada; si se quiere dar otro nombre a los campos de la nueva tabla se deben especificar alias.

Podemos emplear "group by", funciones de agrupamiento y "order by" en las consultas. También podemos crear 
una tabla que contenga datos de 2 o más tablas empleando combinaciones.
*/

 drop table libros;
 drop table editoriales;

 create table libros( 
  codigo number(5),
  titulo varchar2(40) not null,
  autor varchar2(30),
  editorial varchar2(20),
  precio number(5,2),
  primary key(codigo)
 ); 

 insert into libros values(1,'Uno','Richard Bach','Planeta',15);
 insert into libros values(2,'El aleph','Borges','Emece',25);
 insert into libros values(3,'Matematica estas ahi','Paenza','Nuevo siglo',18);
 insert into libros values(4,'Aprenda PHP','Mario Molina','Nuevo siglo',45);
 insert into libros values(5,'Ilusiones','Richard Bach','Planeta',14);
 insert into libros values(6,'Java en 10 minutos','Mario Molina','Nuevo siglo',50);
 
 -- Creamos una tabla llamada "editoriales" que contenga los nombres de las editoriales obteniendo tales nombres de la 
 -- tabla "libros":

create table editoriales as 
(select distinct editorial as nombre
from libros);

 -- Veamos la nueva tabla:

select * from editoriales;
 
 -- Necesitamos una nueva tabla llamada "librosporeditorial" que contenga la cantidad de libros de cada editorial. Primero 
 -- eliminamos la tabla:

drop table cantidadporeditorial;
 
 -- Creamos la nueva tabla empleando una subconsulta:

create table cantidadporeditorial as
(select editorial as nombre, count(*) as cantidad
from libros
group by editorial);
 
 -- Veamos los registros de la nueva tabla:

