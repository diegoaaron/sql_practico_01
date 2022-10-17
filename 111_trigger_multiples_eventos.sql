/*
Hasta el momento hemos aprendido a crear un disparador (trigger) asociado a una única operación (inserción, 
actualización o borrado).

Un trigger puede definirse sobre más de un evento; en tal caso se separan con "or".

Sintaxis para crear un disparador para múltiples eventos:

 create or replace trigger NOMBREDISPARADOR
 MOMENTO-- before, after o instead of
 of CAMPO--si alguno de los eventos es update
 EVENTOS-- insert, update y/o delete
 on NOMBRETABLA
 NIVEL--puede ser a nivel de sentencia (statement) o de fila (for each row)
 begin
  CUERPO DEL DISPARADOR--sentencias
 end NOMBREDISPARADOR;
 /

Si el trigger se define para más de un evento desencadenante, en el cuerpo del mismo se puede emplear un condicional 
para controlar cuál operación disparó el trigger. Esto permite ejecutar bloques de código según la clase de acción que 
disparó el desencadenador.

Para identificar el tipo de operación que disparó el trigger empleamos "inserting", "updating" y "deleting".

Veamos un ejemplo. El siguiente trigger está definido a nivel de sentencia, para los eventos "insert", "update" y "delete"; 
cuando se modifican los datos de "libros", se almacena en la tabla "control" el nombre del usuario, la fecha y el tipo de 
modificación que alteró la tabla:

- si se realizó una inserción, se almacena "inserción";

- si se realizó una actualización (update), se almacena "actualización" y

- si se realizó una eliminación (delete) se almacena "borrado".

create or replace trigger tr_cambios_libros
 before insert or update or delete
 on libros
 for each row
begin
 if inserting then
   insert into control values (user, sysdate,'inserción');
 end if;
 if updating then
  insert into control values (user, sysdate,'actualización');
 end if;
 if deleting then
   insert into control values (user, sysdate,'borrado');
 end if;
end tr_cambios_libros;
/

Si ejecutamos un "insert" sobre "libros", el disparador se activa entrando por el primer "if"; si ejecutamos un "update" el 
trigger se dispara entrando por el segundo "if"; si ejecutamos un "delete" el desencadenador se dispara entrando por el
tercer "if".

Las siguientes sentencias disparan el trigger creado anteriormente:

 insert into TABLA values ...;
 insert into TABLA select ... from...;
 update TABLA set...;
 delete from TABLA...;
*/

 drop table libros;
 drop table control;

 create table libros(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(6,2)
 );

 create table control(
  usuario varchar2(30),
  fecha date,
  operacion varchar2(20)
 );

 insert into libros values(100,'Uno','Richard Bach','Planeta',25);
 insert into libros values(103,'El aleph','Borges','Emece',28);
 insert into libros values(105,'Matematica estas ahi','Paenza','Nuevo siglo',12);
 insert into libros values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55);
 insert into libros values(145,'Alicia en el pais de las maravillas','Carroll','Planeta',35);
 
-- Establecemos el formato de fecha para que muestre "DD/MM/YYYY HH24:MI":

alter session set NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI';

-- Creamos un disparador a nivel de sentencia, que se dispare cada vez que se ingrese, actualice o elimine un registro de 
-- la tabla "libros". El trigger ingresa en la tabla "control", el nombre del usuario, la fecha y la hora en la cual se realizó la 
-- modificación y el tipo de operación que se realizó:
-- si se realizó una inserción (insert), se almacena "inserción";
-- si se realizó una actualización (update), se almacena "actualización" y
-- si se realizó una eliminación (delete) se almacena "borrado".

create or replace trigger tr_cambio_libros
before insert or update or delete on libros
for each row
begin
if inserting then
insert into control values (user, sysdate, 'insercion');
end if;
if updating then
insert into control values (user, sysdate, 'actualizacion');
end if;
if deleting then
insert into control values(user, sysdate, 'borrado');
end if;
end tr_cambio_libros;
/

-- Veamos qué nos informa el diccionario "user_triggers" respecto del trigger anteriormente creado:

select * from user_triggers where trigger_name = 'TR_CAMBIO_LIBROS';

-- obtenemos la siguiente información:
-- trigger_name: nombre del disparador;
-- trigger_type: momento y nivel, en este caso es un desencadenador "before" y a nivel de fila (each row);
-- triggering_event: evento que lo dispara, en este caso, "insert or update or delete";
-- base_object_type: a qué objeto está asociado, puede ser una tabla o una vista, en este caso, una tabla (table);
-- table_name: nombre de la tabla al que está asociado (libros);

-- Ingresamos un registro en "libros":

insert into libros values(150, 'El experto en laberintos', 'Gaskin', 'Planeta', 23);

-- Veamos si el trigger se disparó consultando la tabla "control":

select * from control;

-- Vemos que se ingresó un registro que muestra que el usuario "system", el día y hora actual realizó una inserción sobre "libros".

-- Actualizamos algunos registros de "libros":

update libros set precio = precio*1.1 where editorial = 'Planeta';

 -- Veamos si el trigger se disparó consultando la tabla "control":

select * from control;

-- Vemos que se ingresaron 3 nuevos registros que muestran que el usuario "system", el día y hora actual actualizó tres 
-- registros de "libros". Si el trigger se hubiese definido a nivel de sentencia, el "update" anterior se hubiese disparado 
-- una sola vez.

-- Eliminamos un registro de "libros":

delete from libros where codigo = 145;

-- Veamos si el trigger se disparó consultando la tabla "control":
-- Vemos que se eliminó 1 registro.

select * from control;

