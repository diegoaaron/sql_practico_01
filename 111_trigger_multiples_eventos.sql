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





