/*
En un trigger de actualización a nivel de fila, se puede especificar el nombre de un campo en la condición "updating" para 
determinar cuál campo ha sido actualizado.

Sintaxis básica:

 create or replace trigger NOMBRETRIGGER
 MOMENTO update...
 for each row
 begin
  if updating ('CAMPO') then
   ...
  end if;
 end NOMBREDISPARADOR;
 /

El siguiente trigger se dispara cuando se actualiza la tabla "libros". Dentro del cuerpo del trigger se averigua el campo 
que ha sido modificado; en caso de modificarse el "precio", se ingresa en la tabla "controlPrecios" la fecha, el código 
del libro y el antiguo y nuevo precio; en caso de actualizarse cualquier otro campo, se almacena en la tabla "control" el 
nombre del usuario que realizó la modificación, la fecha y el código del libro modificado.

 create or replace trigger tr_actualizar_libros
 before update
 on libros
 for each row
 begin
  if updating ('precio') then
   insert into controlprecios values(sysdate,:old.codigo,:old.precio,:new.precio);
  else
   insert into control values(user,sysdate,:old.codigo);
  end if;
 end tr_actualizar_libros;
 /
*/

 drop table controlprecios;
 drop table libros;
 drop table control;

 create table libros(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(6,2),
  stock number(4)
 );

 create table control(
  usuario varchar2(30),
  fecha date,
  codigo number(6)
 );

 create table controlprecios(
  fecha date,
  codigo number(6),
  precioanterior number(6,2),
  precionuevo number(6,2)
 );

 insert into libros values(100,'Uno','Richard Bach','Planeta',25,100);
 insert into libros values(103,'El aleph','Borges','Emece',28,0);
 insert into libros values(105,'Matematica estas ahi','Paenza','Nuevo siglo',12,50);
 insert into libros values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55,200);
 insert into libros values(145,'Alicia en el pais de las maravillas','Carroll','Planeta',35,10);

-- Cree un trigger a nivel de fila que se dispare "antes" que se ejecute un "update" sobre la tabla "libros".
-- En el cuerpo del trigger se debe averiguar el campo que ha sido modificado; en caso de modificarse el "precio", se 
-- ingresa en la tabla "controlPrecios" la fecha, el código del libro y el antiguo y nuevo precio; en caso de actualizarse 
-- cualquier otro campo, se almacena en la tabla "control" el nombre del usuario que realizó la modificación, la fecha y el 
-- código del libro modificado.

create or replace trigger tr_actualizar_libros
before update on libros
for each row
begin
if updating ('precio') then
insert into controlprecios values(sysdate,:old.codigo,:old.precio,:new.precio);
else
insert into control values(user, sysdate,:old.codigo);
end if;
end tr_actualizar_libros;
/

-- Actualice el precio de un libro:

update libros set precio = 35 where codigo = 100;

-- Verifique que el trigger se ha disparado consultando la tabla "controlprecios":
-- Se ha insertado una fila.

select * from controlprecios;

-- Actualice un campo diferente de precio:

update libros set stock = 0 where codigo = 145;

-- Verifique que el trigger se ha disparado consultando la tabla "control":
-- Se ha insertado una fila.

select * from control;

-- Verifique que la tabla "controlprecios" no tiene nuevos registros:

select * from controlprecios;

-- Ejercicio 1 

 drop table libros;

 create table libros(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(6,2),
  stock number(4)
 );

 insert into libros values(100,'Uno','Richard Bach','Planeta',25,100);
 insert into libros values(103,'El aleph','Borges','Emece',28,0);
 insert into libros values(105,'Matematica estas ahi','Paenza','Nuevo siglo',12,50);
 insert into libros values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55,200);
 insert into libros values(145,'Alicia en el pais de las maravillas','Carroll','Planeta',35,10);
 
 
 
 