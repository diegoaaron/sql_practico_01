/*
Al crear un procedimiento almacenado, las instrucciones que contiene se analizan para verificar si son correctas 
sintácticamente. Si se encuentra algún error, el procedimiento se compila, pero aparece un mensaje "con advertencias" 
que indica tal situación.

Un procedimiento almacenado se invoca llamándolo.

En primer lugar se deben tipear y probar las instrucciones que se incluyen en el procedimiento almacenado, luego, 
si se obtiene el resultado esperado, se crea el procedimiento.

Los procedimientos almacenados pueden hacer referencia a tablas, vistas, a funciones definidas por el usuario, a otros 
procedimientos almacenados.

Un procedimiento almacenado pueden incluir cualquier cantidad y tipo de instrucciones DML (de manipulación de datos, 
como insert, update, delete), no instrucciones DDL (de definición de datos, como create..., drop... alter...).

Para crear un procedimiento almacenado empleamos la instrucción "create procedure". La sintaxis básica parcial es:

 create or replace procedure NOMBREPROCEDIMIENTO
 as 
 begin
   INSTRUCCIONES
 end;
 /
El bloque de instrucciones comienza luego de "begin" y acaba con "end".

Otra cosa importante es la barra diagonal '/' luego del end, sin esto se genera un error.

Si empleamos "or replace", se sobreescribe (se reemplaza) un procedimiento existente; si se omite y existe un 
procedimiento con el nombre que le asignamos, Oracle mostrará un mensaje de error indicando tal situación.

Para diferenciar los procedimientos almacenados del sistema de los procedimientos almacenados creados por el usuario 
use un prefijo, por ejemplo "pa_" cuando les de el nombre.

Con las siguientes instrucciones creamos un procedimiento almacenado llamado "pa_libros_aumentar10" que incrementa 
en un 10% el precio de todos los libros:

 create procedure pa_libros_aumentar10
  as
  begin
   update libros set precio=precio+precio*0.1;
  end;
 /
 
Entonces, creamos un procedimiento almacenado colocando "create procedure" (o "create or replace", si es que desea 
reemplazar el existente), luego el nombre del procedimiento y seguido de "as" las sentencias que definen el procedimiento.

Para ejecutar el procedimiento almacenado creado anteriormente tipeamos:

 execute pa_libros_aumentar10;
Entonces, para ejecutar un procedimiento almacenado colocamos "execute" seguido del nombre del procedimiento.
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

-- Ejecutamos

execute pa_libros_aumentar10;

-- verificamos precio

select * from libros;

-- Volvemos a ejecutar el procedimiento

execute pa_libros_aumentar10;

-- Verificamos el aumento del precio

select * from libros;

-- Ejercicio 1 





