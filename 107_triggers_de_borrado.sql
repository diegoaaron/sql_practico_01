/*
Dijimos que un disparador est� asociado a una tabla y a una operaci�n espec�fica (inserci�n, actualizaci�n o borrado).

A continuaci�n veremos la creaci�n de un disparador para el evento de borrado: "delete trigger".

La siguiente es la sintaxis para crear un trigger de eliminaci�n que se dispare cada vez que se ejecute una sentencia "delete" 
sobre la tabla especificada, es decir, cada vez que se eliminen registros de la tabla:

 create or replace trigger NOMBREDISPARADOR
  MOMENTO delete
  on NOMBRETABLA
  NIVEL-- statement o for each row
  begin
   CUERPO DEL TRIGGER;
  end NOMBREDISPARADOR;
  /
  
Luego de la instrucci�n "create trigger" o "create or replace trigger" se coloca el nombre del disparador.

"MOMENTO" indica cuando se disparar� el trigger en relaci�n al evento, puede se BEFORE (antes) o AFTER (despu�s). 
Se especifica el evento que causa que el trigger se dispare, en este caso "delete", ya que el trigger se activar� cada vez 
que se ejecute la sentencia "delete" sobre la tabla especificada luego de "on".

En "NIVEL" se especifica si ser� un trigger a nivel de sentencia (se dispara una sola vez por cada sentencia "delete", aunque 
la sentencia elimine varios registros) o a nivel de fila (se dispara tantas veces como filas se eliminan en la sentencia "delete").

Finalmente se coloca el cuerpo del tigger dentro del bloque "begin.. end".

Creamos un desencadenador a nivel de fila que se dispara cada vez que se ejecuta un "delete" sobre la tabla "libros", en el 
cuerpo del trigger se especifican las acciones, en este caso, por cada fila eliminada de la tabla "libros", se ingresa un 
registro en "control" con el nombre del usuario que realiz� la eliminaci�n y la fecha:

 create or replace trigger tr_borrar_libros
  before delete
  on libros
  for each row
 begin
  insert into Control values(user,sysdate);
 end tr_borrar_libros;
 /
*/







