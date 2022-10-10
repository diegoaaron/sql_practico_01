/*
Los procedimientos almacenados son objetos, así que para obtener información de ellos pueden consultarse los siguientes 
diccionarios:

- "user_objects": nos muestra todos los objetos de la base de datos seleccionada, incluidos los procedimientos. En la 
columna "object_type" aparece "procedure" si es un procedimiento almacenado.

En el siguiente ejemplo solicitamos todos los objetos que son procedimientos:

 select *from user_objects where object_type='PROCEDURE';
 
- "user_procedures": nos muestra todos los procedimientos almacenados de la base de datos actual. En el siguiente ejemplo 
solicitamos información de todos los procedimientos que comienzan con "PA":

 select *from user_procedures where object_name like 'PA_%';
*/
 drop table libros;

 create table libros(
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(5,2)
 );

 insert into libros values('Uno','Richard Bach','Planeta',15);
 insert into libros values('Ilusiones','Richard Bach','Planeta',18);
 insert into libros values('El aleph','Borges','Emece',25);
 insert into libros values('Aprenda PHP','Mario Molina','Nuevo siglo',45);
 insert into libros values('Matematica estas ahi','Paenza','Nuevo siglo',12);
 insert into libros values('Java en 10 minutos','Mario Molina','Paidos',35);
 
  -- La librería, frecuentemente, aumenta los precios de los libros en un 10%. Necesitamos un procedimiento almacenado 
  -- que actualice los precios de los libros aumentándolos en un 10%:
 
 create or replace procedure pa_libros_aumentar10 as 
 begin 
 update libros set precio = precio + (precio * 0.1);
 end;
 /
 
 -- Solicitamos todos los objetos que son procedimientos:
 
 select * from user_objects where object_type = 'PROCEDURE';
 
 -- Mostrar todos los procedimientos almacenados de la base de datos actual que comienzan con "PA":
 
 select * from user_procedures where object_name like 'PA_%';
 