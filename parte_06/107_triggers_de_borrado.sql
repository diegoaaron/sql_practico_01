/*
Dijimos que un disparador está asociado a una tabla y a una operación específica (inserción, actualización o borrado).

A continuación veremos la creación de un disparador para el evento de borrado: "delete trigger".

La siguiente es la sintaxis para crear un trigger de eliminación que se dispare cada vez que se ejecute una sentencia "delete" 
sobre la tabla especificada, es decir, cada vez que se eliminen registros de la tabla:

 create or replace trigger NOMBREDISPARADOR
  MOMENTO delete
  on NOMBRETABLA
  NIVEL-- statement o for each row
  begin
   CUERPO DEL TRIGGER;
  end NOMBREDISPARADOR;
  /
  
Luego de la instrucción "create trigger" o "create or replace trigger" se coloca el nombre del disparador.

"MOMENTO" indica cuando se disparará el trigger en relación al evento, puede se BEFORE (antes) o AFTER (después). 
Se especifica el evento que causa que el trigger se dispare, en este caso "delete", ya que el trigger se activará cada vez 
que se ejecute la sentencia "delete" sobre la tabla especificada luego de "on".

En "NIVEL" se especifica si será un trigger a nivel de sentencia (se dispara una sola vez por cada sentencia "delete", aunque 
la sentencia elimine varios registros) o a nivel de fila (se dispara tantas veces como filas se eliminan en la sentencia "delete").

Finalmente se coloca el cuerpo del tigger dentro del bloque "begin.. end".

Creamos un desencadenador a nivel de fila que se dispara cada vez que se ejecuta un "delete" sobre la tabla "libros", en el 
cuerpo del trigger se especifican las acciones, en este caso, por cada fila eliminada de la tabla "libros", se ingresa un 
registro en "control" con el nombre del usuario que realizó la eliminación y la fecha:

 create or replace trigger tr_borrar_libros
  before delete
  on libros
  for each row
 begin
  insert into Control values(user,sysdate);
 end tr_borrar_libros;
 /
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

 insert into libros values(97,'Uno','Richard Bach','Planeta',25);
 insert into libros values(98,'El aleph','Borges','Emece',28);
 insert into libros values(99,'Matematica estas ahi','Paenza','Nuevo siglo',12);
 insert into libros values(100,'Aprenda PHP','Molina Mario','Nuevo siglo',55);
 insert into libros values(101,'Alicia en el pais de las maravillas','Carroll','Planeta',35);
 insert into libros values(102,'El experto en laberintos','Gaskin','Planeta',20);

-- Establecemos el formato de fecha para que muestre "DD/MM/YYYY HH24:MI":

alter session set NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI';

-- Creamos un disparador a nivel de fila, que se dispare cada vez que se borre un registro de "libros"; el trigger debe 
-- ingresar en la tabla "control", el nombre del usuario, la fecha y la hora en la cual se realizó un "delete" sobre "libros":

create or replace trigger tr_borrar_libros
before delete on libros
for each row
begin
insert into control values(user,sysdate);
end tr_borrar_libros;
/

-- Veamos qué nos informa el diccionario "user_triggers" respecto del trigger anteriormente creado:

select * from user_triggers where trigger_name = 'TR_BORRAR_LIBROS';

-- obtenemos la siguiente información:
-- trigger_name: nombre del disparador;
-- trigger_type: momento y nivel, en este caso es un desencadenador "before" y a nivel de fila (each row);
-- triggering_event: evento que lo dispara, en este caso, "delete";
-- base_object_type: a qué objeto está asociado, puede ser una tabla o una vista, en este caso, una tabla (table);
-- table_name: nombre de la tabla al que está asociado (libros);

-- Eliminamos todos los libros cuyo código sea inferior a 100:

delete from libros where codigo < 100;

-- Veamos si el trigger se disparó consultando la tabla "control":

select * from control;

-- Se eliminaron 3 registros, como el trigger fue definido a nivel de fila, se disparó 3 veces, una vez por cada registro 
-- eliminado. Si el trigger hubiese sido definido a nivel de sentencia, se hubiese disparado una sola vez.

-- Reemplazamos el disparador creado anteriormente por otro con igual código pero a nivel de sentencia:

create or replace trigger tr_borrar_libros 
before delete on libros
begin
insert into control values(user,sysdate);
end tr_borrar_libros;
/

-- Veamos qué nos informa el diccionario "user_triggers" respecto del trigger anteriormente creado:
-- en este caso es un desencadenador a nivel de sentencia.

select * from user_triggers where trigger_name = 'TR_BORRAR_LIBROS';

-- Eliminamos todos los libros cuya editorial sea "Planeta":

delete from libros where editorial = 'Planeta';

-- Se han eliminado 2 registros, pero el trigger se ha disparado una sola vez, consultamos la tabla "control":

select * from control;

-- Si el trigger hubiese sido definido a nivel de fila, se hubiese disparado dos veces.

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

-- Cree un disparador a nivel de fila, que se dispare cada vez que se borre un registro de "empleados"; el trigger debe 
-- ingresar en la tabla "control", el nombre del usuario y la fecha en la cual se realizó un "delete" sobre "empleados"

create or replace trigger tr_borrar_empleados
before delete on empleados
for each row
begin
insert into control values(user,sysdate);
end tr_borrar_empleados;
/

-- Vea qué informa el diccionario "user_triggers" respecto del trigger anteriormente creado

select * from user_triggers where trigger_name = 'TR_BORRAR_EMPLEADOS';

-- Elimine todos los empleados cuyo sueldo supera los $800

delete from empleados where sueldo > 800;

-- Vea si el trigger se disparó consultando la tabla "control"
-- Se eliminaron 3 registros, como el trigger fue definido a nivel de fila, se disparó 3 veces, una vez por cada registro 
-- eliminado. Si el trigger hubiese sido definido a nivel de sentencia, se hubiese disparado una sola vez.

select * from control;

-- Reemplace el disparador creado anteriormente por otro con igual código pero a nivel de sentencia

create or replace trigger tr_borrar_empleados
before delete on empleados
begin
insert into control values(user, sysdate);
end tr_borrar_empleados;
/

-- Vea qué nos informa el diccionario "user_triggers" respecto del trigger anteriormente creado
-- en este caso es un desencadenador a nivel de sentencia; en la columna "TRIGGER_TYPE" muestra "BEFORE STATEMENT".

select * from user_triggers where trigger_name  = 'TR_BORRAR_EMPLEADOS';

-- Elimine todos los empleados de la sección "Secretaria"
-- Se han eliminado 2 registros, pero el trigger se ha disparado una sola vez.

delete from empleados where seccion = 'Secretaria';

-- Consultamos la tabla "control"
-- Si el trigger hubiese sido definido a nivel de fila, se hubiese disparado dos veces.

select * from control;
