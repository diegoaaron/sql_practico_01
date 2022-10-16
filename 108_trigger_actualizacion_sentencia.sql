/*
Dijimos que un disparador est� asociado a una tabla y a una operaci�n espec�fica (inserci�n, actualizaci�n o borrado).

A continuaci�n veremos la creaci�n de un disparador para el evento de actualizaci�n: "update trigger".

La siguiente es la sintaxis para crear un trigger de actualizaci�n a nivel de sentencia, que se dispare cada vez que se ejecute 
una sentencia "update" sobre la tabla especificada, es decir, cada vez que se intenten modificar datos en la tabla:

 create or replace trigger NOMBREDISPARADOR
  MOMENTO update
  on NOMBRETABLA
  statement
  begin
   CUERPO DEL TRIGGER;
  end NOMBREDISPARADOR;
  /
Luego de la instrucci�n "create trigger" se coloca el nombre del disparador. Si agregamos "or replace" al momento de 
crearlo y ya existe un trigger con el mismo nombre, tal disparador ser� borrado y vuelto a crear.

"MOMENTO" indica cuando se disparar� el trigger en relaci�n al evento, puede ser BEFORE (antes) o AFTER (despu�s). 
Se especifica el evento que causa que el trigger se dispare, en este caso "update", ya que el trigger se activar� cada vez 
que se ejecute la sentencia "update" sobre la tabla especificada luego de "on".

"statement" significa que es un trigger a nivel de sentencia, es decir, se dispara una sola vez por cada sentencia "update", 
aunque la sentencia modifique varios registros; como en cualquier trigger, es el valor por defecto si no se especifica.

Finalmente se coloca el cuerpo del tigger dentro del bloque "begin.. end".

Las siguientes sentencias disparan un trigger de inserci�n:

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
Al ocurrir el evento de actualizaci�n sobre "libros", se ingresa en la tabla "control" el nombre del usuario que alter� la 
tabla "libros" (obtenida mediante la funci�n "user") y la fecha en que lo hizo (mediante la funci�n "sysdate").

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
-- debe ingresar en la tabla "control", el nombre del usuario, la fecha y la hora en la cual se realiz� un "update" sobre "libros":

create or replace trigger tr_actualizar_libros
before update on libros
begin
insert into control values(user,sysdate);
end tr_actualizar_libros;
/

-- 