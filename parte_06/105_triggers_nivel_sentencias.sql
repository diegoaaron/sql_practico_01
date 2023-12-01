/*
Dijimos que un disparador est� asociado a una tabla y a una operaci�n espec�fica (inserci�n, actualizaci�n o borrado).

A continuaci�n veremos la creaci�n de un disparador para el evento de inserci�n: "insert trigger".

La siguiente es la sintaxis para crear un trigger de inserci�n que se dispare cada vez que se ejecute una sentencia "insert" sobre la tabla especificada, es decir, cada vez que se intenten 
ingresar datos en la tabla:

 create or replace trigger NOMBREDISPARADOR
  MOMENTO insert
  on NOMBRETABLA
  begin
   CUERPO DEL TRIGGER;
  end NOMBREDISPARADOR;
  /

Analizamos la sintaxis:

Luego de la instrucci�n "create trigger" se coloca el nombre del disparador. Si se agrega "or replace" al momento de crearlo y ya existe un trigger con el mismo nombre, tal disparador 
ser� borrado y vuelto a crear.

"MOMENTO" indica cuando se disparar� el trigger en relaci�n al evento, puede se BEFORE (antes) o AFTER (despu�s). Se especifica el evento que causa que el trigger se dispare, 
en este caso "insert", ya que el trigger se activar� cada vez que se ejecute la sentencia "insert" sobre la tabla especificada luego de "on".

Es un trigger a nivel de sentencia, es decir, se dispara una sola vez por cada sentencia "insert", aunque la sentencia ingrese varios registros. Es el valor por defecto si no se especifica.

Finalmente se coloca el cuerpo del trigger dentro del bloque "begin.. end".

Las siguientes sentencias disparan un trigger de inserci�n:

 insert into TABLA values ...;
 insert into TABLA select ... from...;
 
Ejemplo: Creamos un desencadenador que se dispara cada vez que se ejecuta un "insert" sobre la tabla "libros":

 create or replace trigger tr_ingresar_libros
  before insert
  on libros
 begin
  insert into Control values(user,sysdate);
 end tr_ingresar_libros;
 /
Analizamos el trigger anterior:

"create or replace trigger" junto al nombre del disparador que tiene un prefijo "tr" para reconocer que es un trigger, referencia el evento que lo disparar� y la tabla asociada.

Para identificar f�cilmente los disparadores de otros objetos se recomienda usar un prefijo y darles el nombre de la tabla para la cual se crean junto al tipo de acci�n.

El disparador se activar� antes ("before") del evento "insert" sobre la tabla "libros", es decir, se disparar� ANTES que se realice una inserci�n en "libros". El trigger est� definido a nivel 
de sentencia, se activa una vez por cada instrucci�n "insert" sobre "libros". El cuerpo del disparador se delimita con "begin... end", all� se especifican las acciones que se realizar�n al 
ocurrir el evento de inserci�n, en este caso, ingresar en la tabla "control" el nombre del usuario que alter� la tabla "libros" (obtenida mediante la funci�n "user") y la fecha en que lo hizo 
(mediante la funci�n "sysdate").
*/

 drop table libros;
 
 create table libros(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  precio number(6,2)
 );

 drop table control;
 
 create table control(
  usuario varchar2(30),
  fecha date
 );

 create or replace trigger tr_ingresar_libros
  before insert
  on libros
 begin
  insert into Control values(user,sysdate);
 end tr_ingresar_libros;
 /

-- Establecemos el formato de fecha para que muestre "DD/MM/YYYY HH24:MI":

alter session set NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI';

-- Veamos qu� nos informa el diccionario "user_triggers" respecto del trigger anteriormente creado:

select * from user_triggers where trigger_name = 'TR_INGRESAR_LIBROS';

-- obtenemos la siguiente informaci�n:
-- trigger_name: nombre del disparador;
-- trigger_type: momento y nivel, en este caso es un desencadenador "before" y a nivel de sentencia (statement);
-- triggering_event: evento que lo dispara, en este caso, "insert";
-- base_object_type: a qu� objeto est� asociado, puede ser una tabla o una vista, en este caso, una tabla (table);
-- table_name: nombre de la tabla al que est� asociado (libros);
-- y otras columnas que no analizaremos por el momento.

-- Ingresamos un registro en "libros":

 insert into libros values(100,'Uno','Richard Bach',25);

-- Verificamos que el trigger se dispar� consultando la tabla "control" para ver si tiene un nuevo registro:

select * from control;

-- Ingresamos dos registros m�s en "libros":

insert into libros values(150,'Matematica estas ahi','Paenza',12);
insert into libros values(185,'El aleph','Borges',42);

-- Verificamos que el trigger se dispar� consultando la tabla "control" para ver si tiene dos nuevos registros:

select * from control;

-- Ejercicio 1

 drop table libros;
 drop table ofertas;
 drop table control;

 create table libros(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(6,2)
 );

 create table ofertas(
  titulo varchar2(40),
  autor varchar2(30),
  precio number(6,2)
 );

 create table control(
  usuario varchar2(30),
  fecha date
 );
 
 -- Establezca el formato de fecha para que muestre "DD/MM/YYYY HH24:MI":

 alter session set NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI';

-- Cree un disparador que se dispare cuando se ingrese un nuevo registro en "ofertas"; el trigger debe ingresar en la tabla "control", el nombre del usuario, la fecha y la hora en la cual 
-- se realiz� un "insert" sobre "ofertas"

create or replace trigger tr_ingresar_ofertas
before insert on ofertas
begin
insert into control values (user,sysdate);
end tr_ingresar_ofertas;
/

-- Vea qu� informa el diccionario "user_triggers" respecto del trigger anteriormente creado

select * from user_triggers where trigger_name = 'TR_INGRESAR_OFERTAS';

-- Ingrese algunos registros en "libros"

 insert into libros values(100,'Uno','Richard Bach','Planeta',25);
 insert into libros values(102,'Matematica estas ahi','Paenza','Nuevo siglo',12);
 insert into libros values(105,'El aleph','Borges','Emece',32);
 insert into libros values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55);



-- Ingrese en "ofertas" los libros de "libros" cuyo precio no superen los $30, utilizando la siguiente sentencia:

 insert into ofertas select titulo,autor,precio from libros where precio<30;

-- Verifique que el trigger se dispar� consultando la tabla "control"

 select *from control;


