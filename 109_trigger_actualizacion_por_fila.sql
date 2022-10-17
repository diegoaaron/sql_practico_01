/*
Vimos la creación de un disparador para el evento de actualización a nivel de sentencia, es decir, se dispara una vez por 
cada sentencia "update" sobre la tabla asociada.

En caso que una sola sentencia "update" modifique varios registros en la tabla asociada, el trigger se disparará una sola 
vez; si queremos que se active una vez por cada registro afectado, debemos indicarlo con "for each row".

La siguiente es la sintaxis para crear un trigger de actualización a nivel de fila, se dispare una vez por cada fila modificada 
sobre la tabla especificada:

 create or replace trigger NOMBREDISPARADOR
  MOMENTO update
  on NOMBRETABLA
  for each row
  begin
   CUERPO DEL TRIGGER;
  end NOMBREDISPARADOR;
  /
  
Creamos un desencadenador a nivel de fila, que se dispara una vez por cada fila afectada por un "update" sobre la tabla 
"libros". Se ingresa en la tabla "control" el nombre del usuario que altera la tabla "libros" (obtenida mediante la función 
"user") y la fecha en que lo hizo (mediante la función "sysdate"):

 create or replace trigger tr_actualizar_libros
  before update
  on libros
  for each row
 begin
  insert into control values(user,sysdate);
 end tr_actualizar_libros;
 /
 
Si al ejecutar un "update" sobre "libros" se actualizan 5 registros, en la tabla "control" se ingresarán 5 registros, uno por cada 
modificación. Si el trigger hubiese sido definido a nivel de sentencia (statement), se agregaría una sola fila en "control".
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

-- Creamos un disparador que se dispare cada vez que se actualice un registro en "libros"; el trigger debe ingresar en la 
-- tabla "control", el nombre del usuario, la fecha y la hora en la cual se realizó un "update" sobre "libros":

create or replace trigger tr_actualizar_libros
before update on libros
for each row
begin
insert into control values(user,sysdate);
end tr_actualizar_libros;
/

-- Actualizamos varios registros de "libros". Aumentamos en un 10% el precio de todos los libros de editorial "Nuevo siglo':

update libros set precio  = precio + precio*0.1 where editorial = 'Nuevo siglo';

-- Veamos cuántas veces se disparó el trigger consultando la tabla "control":

select * from control;

-- El trigger se disparó 2 veces, una vez por cada registro modificado en "libros". Si el trigger hubiese sido creado a nivel 
-- de sentencia, el "update" anterior hubiese disparado el trigger 1 sola vez aún cuando se modifican 2 filas.

-- Veamos qué nos informa el diccionario "user_triggers" respecto del trigger anteriormente creado:

select * from user_triggers where trigger_name = 'TR_ACTUALIZAR_LIBROS';

-- obtenemos el nombre del disparador, el momento y nivel (before each row), evento que lo dispara (update), a qué objeto 
-- está asociado (table), nombre de la tabla al que está asociado (libros).

-- Ejercicio 1 



