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