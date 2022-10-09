/*
Los procedimientos almacenados se eliminan con "drop procedure". Sintaxis:

 drop procedure NOMBREPROCEDIMIENTO;
 
Eliminamos el procedimiento almacenado llamado "pa_libros_aumentar10":

 drop procedure pa_libros_aumentar10;
 
Si el procedimiento que queremos eliminar no existe, aparece un mensaje de error indicando tal situación.

Podemos eliminar una tabla referenciada en un procedimiento almacenado, Oracle lo permite, pero luego, al ejecutar el 
procedimiento, aparecerá un mensaje de error porque la tabla referenciada no existe.

Si al crear un procedimiento almacenado colocamos "create or replace procedure...", el nuevo procedimiento reemplaza 
al anterior.
*/

drop procedure pa_libros_aumentar10;