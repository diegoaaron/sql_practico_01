/*
El trigger de actualización (a nivel de sentencia o de fila) permite incluir una lista de campos. Si se incluye el nombre de 
un campo (o varios) luego de "update", el trigger se disparará únicamente cuando alguno de esos campos (incluidos en 
la lista) es actualizado. Si se omite la lista de campos, el trigger se dispara cuando cualquier campo de la tabla asociada 
es modificado, es decir, por defecto toma todos los campos de la tabla.

La lista de campos solamente puede especificarse en disparadores de actualización, nunca en disparadores de inserción 
o borrado.

Sintaxis general:

 create or replace trigger NOMBREDISPARADOR
  MOMENTO update of CAMPOS
  on TABLA
  NIVEL--statement o for each row
 begin
  CUERPODEL DISPARADOR;
 end NOMBREDISPARADOR;
 /
 
"CAMPOS" son los campos de la tabla asociada que activarán el trigger si son modificados. Pueden incluirse más de uno, 
en tal caso, se separan con comas.

Creamos un desencadenador a nivel de fila que se dispara cada vez que se actualiza el campo "precio" de la tabla "libros":

 create or replace trigger tr_actualizar_precio_libros
  before update of precio
  on libros
  for each row
 begin
  insert into control values(user,sysdate);
 end tr_actualizar_precio_libros;
 /
 
Si realizamos un "update" sobre el campo "precio" de "libros", el trigger se dispara. Pero si realizamos un "update" 
sobre cualquier otro campo, el trigger no se dispara, ya que está definido solamente para el campo "precio".
*/

 drop table control;
 drop table libros;

 create table libros(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(6,2)
 );

 create table control(
  usuario varchar2(30),
  fecha date
 );

 insert into libros values(100,'Uno','Richard Bach','Planeta',25);
 insert into libros values(103,'El aleph','Borges','Emece',28);
 insert into libros values(105,'Matematica estas ahi','Paenza','Nuevo siglo',12);
 insert into libros values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55);
 insert into libros values(145,'Alicia en el pais de las maravillas','Carroll','Planeta',35);
 
-- Establecemos el formato de fecha para que muestre "DD/MM/YYYY HH24:MI":

alter session set NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI';

-- Creamos un desencadenador a nivel de fila que se dispare cada vez que se actualiza el campo "precio"; el trigger debe 
-- ingresar en la tabla "control", el nombre del usuario, la fecha y la hora en la cual se realizó un "update" sobre "precio" de "libros":

create or replace trigger tr_actualizar_precio_libros
before update of precio on libros
for each row 
begin
insert into control values(user,sysdate);
end tr_actualizar_precio_libros;
/

-- Veamos qué nos informa el diccionario "user_triggers" respecto del trigger anteriormente creado:

select * from user_triggers where trigger_name = 'TR_ACTUALIZAR_PRECIO_LIBROS';

-- Aumentamos en un 10% el precio de todos los libros de editorial "Nuevo siglo':
-- El trigger se disparó 2 veces, una vez por cada registro modificado en "libros". Si el trigger hubiese sido creado a 
-- nivel de sentencia, el "update" anterior hubiese disparado el trigger 1 sola vez aún cuando se modifican 2 filas.

update libros set precio = precio*1.1 where editorial = 'Nuevo siglo';

-- Veamos cuántas veces se disparó el trigger consultando la tabla "control":

select * from control;

-- Modificamos otro campo, diferente de "precio":

update libros set autor = 'Lewis Carroll' where autor = 'Carroll';

-- Veamos si el trigger se disparó consultando la tabla "control":
-- El trigger no se disparó (no hay nuevas filas en "control"), pues está definido solamente sobre el campo "precio".

select * from control;

-- Ejercicio 1 

