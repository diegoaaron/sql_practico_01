/*
Dijimos que un disparador está asociado a una tabla y a una operación específica (inserción, actualización o borrado).

A continuación veremos la creación de un disparador para el evento de actualización: "update trigger".

La siguiente es la sintaxis para crear un trigger de actualización a nivel de sentencia, que se dispare cada vez que se ejecute 
una sentencia "update" sobre la tabla especificada, es decir, cada vez que se intenten modificar datos en la tabla:

 create or replace trigger NOMBREDISPARADOR
  MOMENTO update
  on NOMBRETABLA
  statement
  begin
   CUERPO DEL TRIGGER;
  end NOMBREDISPARADOR;
  /
Luego de la instrucción "create trigger" se coloca el nombre del disparador. Si agregamos "or replace" al momento de 
crearlo y ya existe un trigger con el mismo nombre, tal disparador será borrado y vuelto a crear.

"MOMENTO" indica cuando se disparará el trigger en relación al evento, puede ser BEFORE (antes) o AFTER (después). 
Se especifica el evento que causa que el trigger se dispare, en este caso "update", ya que el trigger se activará cada vez 
que se ejecute la sentencia "update" sobre la tabla especificada luego de "on".

"statement" significa que es un trigger a nivel de sentencia, es decir, se dispara una sola vez por cada sentencia "update", 
aunque la sentencia modifique varios registros; como en cualquier trigger, es el valor por defecto si no se especifica.

Finalmente se coloca el cuerpo del tigger dentro del bloque "begin.. end".

Las siguientes sentencias disparan un trigger de inserción:

 update TABLA set CAMPO=NUEVOVALOR;
 update TABLA set CAMPO=NUEVOVALOR where CONDICION;
 
Ejemplo: Creamos un desencadenador que se dispara cada vez que se ejecuta un "update" sobre la tabla "libros":

 create or replace trigger tr_actualizar_libros
  before update
  on libros
 begin
  insert into control values(user,sysdate);
 end tr_actualizar_libros;
 /
Al ocurrir el evento de actualización sobre "libros", se ingresa en la tabla "control" el nombre del usuario que alteró la 
tabla "libros" (obtenida mediante la función "user") y la fecha en que lo hizo (mediante la función "sysdate").

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
  fecha date
 );

 insert into libros values(100,'Uno','Richard Bach','Planeta',25);
 insert into libros values(103,'El aleph','Borges','Emece',28);
 insert into libros values(105,'Matematica estas ahi','Paenza','Nuevo siglo',12);
 insert into libros values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55);
 insert into libros values(145,'Alicia en el pais de las maravillas','Carroll','Planeta',35);

-- Establecemos el formato de fecha para que muestre "DD/MM/YYYY HH24:MI":

alter session set NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI';

-- Creamos un disparador a nivel de sentencia, que se dispare cada vez que se actualice un registro en "libros"; el trigger 
-- debe ingresar en la tabla "control", el nombre del usuario, la fecha y la hora en la cual se realizó un "update" sobre "libros":

create or replace trigger tr_actualizar_libros
before update on libros
begin
insert into control values(user,sysdate);
end tr_actualizar_libros;
/

-- Veamos qué nos informa el diccionario "user_triggers" respecto del trigger anteriormente creado:

select * from user_triggers where trigger_name = 'TR_ACTUALIZAR_LIBROS';

-- obtenemos la siguiente información:

-- trigger_name: nombre del disparador;

-- trigger_type: momento y nivel, en este caso es un desencadenador "before" y a nivel de sentencia (statement);

-- triggering_event: evento que lo dispara, en este caso, "update";

-- base_object_type: a qué objeto está asociado, puede ser una tabla o una vista, en este caso, una tabla (table);

-- table_name: nombre de la tabla al que está asociado (libros);

-- .Actualizamos un registro en "libros":

update libros set codigo = 99 where codigo = 100;

-- Veamos si el trigger se disparó consultando la tabla "control":

select * from control;

-- Actualizamos varios registros de "libros":

update libros set precio = precio + precio * 0.1 where editorial = 'Nuevo siglo';

-- Veamos si el trigger se disparó consultando la tabla "control":

select * from control;

-- Note que se modificaron 2 registros de "libros", pero como la modificación se realizó con una sola sentencia "update" 
-- y el trigger es a nivel de sentencia, se agregó solamente una fila a la tabla "control"; si el trigger hubiese sido creado a 
-- nivel de fila, la sentencia anterior, hubiese disparado el trigger 2 veces y habría ingresado en "control" 2 filas.

-- Ejercicio 1 

 drop table empleados;
 drop table control;

 create table empleados(
  documento char(8),
  apellido varchar2(20),
  nombre varchar2(20),
  seccion varchar2(30),
  sueldo number(8,2)
 );

 create table control(
  usuario varchar2(30),
  fecha date
 );

 insert into empleados values('22333444','ACOSTA','Ana','Secretaria',500);
 insert into empleados values('22777888','DOMINGUEZ','Daniel','Secretaria',560);
 insert into empleados values('22999000','FUENTES','Federico','Sistemas',680);
 insert into empleados values('22555666','CASEROS','Carlos','Contaduria',900);
 insert into empleados values('23444555','GOMEZ','Gabriela','Sistemas',1200);
 insert into empleados values('23666777','JUAREZ','Juan','Contaduria',1000);

-- Cree un disparador a nivel de sentencia, que se dispare cada vez que se actualicen registros en "empleados"; el 
-- trigger debe ingresar en la tabla "control", el nombre del usuario y la fecha en la cual se realizó un "update" sobre 
-- "empleados"

create or replace trigger tr_actualizar_empleados
before update on empleados
begin
insert into control values(user,sysdate);
end tr_actualizar_empleados;
/

-- Vea qué informa el diccionario "user_triggers" respecto del trigger anteriormente creado

select * from user_triggers where trigger_name = 'TR_ACTUALIZAR_EMPLEADOS';

-- Actualice un registro en "empleados":

 update empleados set nombre='Graciela' where documento='23444555';

-- Vea si el trigger se disparó consultando la tabla "control"

-- Actualice varios registros de "empleados" en una sola sentencia

-- Vea si el trigger se disparó consultando la tabla "control"
-- Note que se modificaron 2 registros de "empleados", pero como la modificación se realizó con una sola sentencia 
-- "update" y el trigger es a nivel de sentencia, se agregó solamente una fila a la tabla "control"; si el trigger hubiese sido 
-- creado a nivel de fila, la sentencia anterior, hubiese disparado el trigger 2 veces y habría ingresado en "control" 2 filas.
