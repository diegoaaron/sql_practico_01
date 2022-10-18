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
 
 -- Cree un trigger a nivel de fila que se dispare "antes" que se ejecute un "update" sobre la tabla "libros". En el cuerpo del 
 -- trigger se debe averiguar el campo que ha sido modificado. En caso de modificarse:
-- el código, debe rechazarse la modificación con un mensaje de error.
-- el "precio", se controla si es mayor o igual a cero, si lo es, debe dejarse el precio anterior y mostrar un mensaje de error.
-- el stock, debe controlarse que no se ingrese un número negativo ni superior a 1000, en tal caso, debe rechazarse con un 
-- mensaje de error.

create or replace trigger tr_actualizar_libros
before update on libros
for each row
begin
if updating ('codigo') then
raise_application_error(-20000,'No puede modificar el codigo');
end if;
if updating('precio') then
if (:new.precio < 0) then
raise_application_error(-20001,'No puede colocar precios negativos');
end if;
end if;
if updating('stock') then
if (:new.stock<0) or (:new.stock>1000) then
raise_application_error(-20002,'El valor de stock debe estar entre 0 y 10000');
end if;
end if;
end tr_actualizar_libros;
/

-- Intente modificar el precio de un libro con un valor negativo. Mensaje de error 20001;

 update libros set precio=-50 where codigo=100;

-- Verifique que el trigger se ha disparado consultando la tabla "libros"
-- El cambio de precio no se realizó.

select * from libros;

-- Actualice un precio a un valor aceptado

 update libros set precio=1 where codigo=100;

-- Verifique que el trigger se ha disparado consultando la tabla "libros"
-- El cambio de precio se realizó.

select * from libros;

-- Intente cambiar el código de un libro
-- Mensaje de error 20000.

 update libros set codigo=1 where codigo=100;

-- Verifique que el cambio no se ha realizado

select * from libros;

-- Intente cambiar el stock de un libro a un valor negativo
-- Mensaje de error 20002.

 update libros set stock=-1 where codigo=100;

-- Verifique que el cambio no se ha realizado

select * from libros;

-- Intente cambiar el stock de un libro a un valor que supere los 1000
-- Mensaje de error 20002.

 update libros set stock=2000 where codigo=100;

-- Cambie el stock de un libro a un valor permitido

 update libros set stock=200 where codigo=100;

-- Verifique que el cambio se ha realizado
 
 select * from libros;
 
 -- Ejercicio 2
 
 drop table articulos;
 drop table pedidos;
 drop table controlPrecios;

 create table articulos(
  codigo number(4),
  descripcion varchar2(40),
  precio number (6,2),
  stock number(4)
 );

 create table pedidos(
  codigo number(4),
  cantidad number(4)
 );

 create table controlPrecios(
  fecha date,
  codigo number(4),
  anterior number(6,2),
  nuevo number(6,2)
 );

 insert into articulos values(100,'cuaderno rayado 24h',4.5,100);
 insert into articulos values(102,'cuaderno liso 12h',3.5,150);
 insert into articulos values(104,'lapices color x6',8.4,60);
 insert into articulos values(160,'regla 20cm.',6.5,40);
 insert into articulos values(173,'compas xxx',14,35);
 insert into articulos values(234,'goma lapiz',0.95,200);
 
 -- Ingrese en "pedidos" todos los códigos de "articulos", con "cantidad" cero
 
insert into pedidos (codigo) select (codigo) from articulos;

update pedidos set cantidad = 0;

-- Active el paquete "dbms_output":

 set serveroutput on;
 execute dbms_output.enable(20000);

-- Cada vez que se disminuye el stock de un artículo de la tabla "articulos", se debe incrementar la misma cantidad de ese 
-- artículo en "pedidos" y cuando se incrementa en "articulos", se debe disminuir la misma cantidad en "pedidos". Si se 
-- ingresa un nuevo artículo en "articulos", debe agregarse un registro en "pedidos" con "cantidad" cero. Si se elimina un 
-- registro en "articulos", debe eliminarse tal artículo de "pedidos". Cree un trigger para los tres eventos (inserción, borrado y 
-- actualización), a nivel de fila, sobre "articulos", para los campos "stock" y "precio", que realice las tareas descriptas 
-- anteriormente, si el campo modificado es "stock". Si el campo modificado es "precio", almacene en la tabla "controlPrecios", 
-- la fecha, el código del artículo, el precio anterior y el nuevo.
-- El trigger muestra el mensaje "Trigger activado" cada vez que se dispara; en cada "if" muestra un segundo mensaje que 
-- indica cuál condición se ha cumplido.

create or replace trigger tr_articulos
 before insert or delete or update of stock, precio
 on articulos
 for each row
 begin
  dbms_output.put_line('Trigger disparado');
  if (inserting) then
    insert into pedidos values(:new.codigo,0);
    dbms_output.put_line(' insercion');
  end if; 
  if (deleting) then
    delete from pedidos where codigo = :old.codigo;    
    dbms_output.put_line(' borrado');
  end if; 
  if updating ('STOCK') then
    update pedidos set cantidad=cantidad+(:old.stock - :new.stock) where codigo = :old.codigo;
    dbms_output.put_line(' actualizacion de stock');
  end if;
  if updating('PRECIO') then
    insert into controlPrecios values(sysdate,:old.codigo,:old.precio,:new.precio);
    dbms_output.put_line(' actualizacion de precio');
  end if;
 end tr_articulos;
 /

-- Disminuya el stock del artículo "100" a 30
-- Un mensaje muestra que el trigger se ha disparado actualizando el "stock".

update articulos set stock = 30 where codigo = 100;

-- Verifique que el trigger se disparó consultando la tabla "pedidos" (debe aparecer "70" en "cantidad" en el registro 
-- correspondiente al artículo "100")

select * from pedidos;

-- Ingrese un nuevo artículo en "articulos"
-- Un mensaje muestra que el trigger se ha disparado por una inserción.

insert into articulos values(280, 'carpeta oficio', 15,50);

-- Verifique que se ha agregado un registro en "pedidos" con código "280" y cantidad igual a 0

select * from pedidos;

-- Elimine un artículo de "articulos"
-- Un mensaje muestra que el trigger se ha disparado por un borrado.

delete articulos where codigo = 234;

-- Verifique que se ha borrado el registro correspondiente al artículo con código "234" en "pedidos"

 select *from pedidos;

-- Modifique el precio de un artículo
-- Un mensaje muestra que el trigger se ha disparado por una actualización de precio.

update articulos set precio = 4.8 where codigo = 102;

-- Verifique que se ha agregado un registro en "controlPrecios"

select * from controlPrecios;

-- Modifique la descripción de un artículo
-- El trigger no se ha disparado, no aparece mensaje.

 update articulos set descripcion='compas metal xxx' where codigo=173;

-- Modifique el precio, stock y descripcion de un artículo
-- Un mensaje muestra que el trigger se ha disparado por una actualización de stock y otra de precio. La actualización 
-- de "descripcion" no disparó el trigger.

 update articulos set precio=10, stock=55, descripcion='lapices colorx6 Faber' where codigo=104;

-- Verifique que se ha agregado un registro en "controlPrecios" y se ha modificado el campo "cantidad" con el valor "5"

 select *from controlPrecios;
 select *from pedidos;

-- Modifique el stock de varios artículos en una sola sentencia
-- Cuatro mensajes muestran que el trigger se ha disparado 4 veces, por actualizaciones de stock.


-- Verifique que se han modificado 4 registros en "pedidos"

-- Modifique el precio de varios artículos en una sola sentencia
-- Cuatro mensajes muestran que el trigger se ha disparado 4 veces, por actualizaciones de precio.

-- Verifique que se han agregado 4 nuevos registros en "controlPrecios"

-- Elimine varios artículos en una sola sentencia
-- Cuatro mensajes muestran que el trigger se ha disparado 4 veces, por borrado de registros.

-- Verifique que se han eliminado 4 registros en "pedidos"
 
 