/*
Hasta el momento hemos aprendido a crear un disparador (trigger) asociado a una �nica operaci�n (inserci�n, 
actualizaci�n o borrado).

Un trigger puede definirse sobre m�s de un evento; en tal caso se separan con "or".

Sintaxis para crear un disparador para m�ltiples eventos:

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

Si el trigger se define para m�s de un evento desencadenante, en el cuerpo del mismo se puede emplear un condicional 
para controlar cu�l operaci�n dispar� el trigger. Esto permite ejecutar bloques de c�digo seg�n la clase de acci�n que 
dispar� el desencadenador.

Para identificar el tipo de operaci�n que dispar� el trigger empleamos "inserting", "updating" y "deleting".

Veamos un ejemplo. El siguiente trigger est� definido a nivel de sentencia, para los eventos "insert", "update" y "delete"; 
cuando se modifican los datos de "libros", se almacena en la tabla "control" el nombre del usuario, la fecha y el tipo de 
modificaci�n que alter� la tabla:

- si se realiz� una inserci�n, se almacena "inserci�n";

- si se realiz� una actualizaci�n (update), se almacena "actualizaci�n" y

- si se realiz� una eliminaci�n (delete) se almacena "borrado".

create or replace trigger tr_cambios_libros
 before insert or update or delete
 on libros
 for each row
begin
 if inserting then
   insert into control values (user, sysdate,'inserci�n');
 end if;
 if updating then
  insert into control values (user, sysdate,'actualizaci�n');
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





