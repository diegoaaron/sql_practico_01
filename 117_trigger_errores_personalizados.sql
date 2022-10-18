/*
Oracle permite definir a los usuarios errores especificando un n�mero de error y un mensaje empleando el procedimiento 
-- "raise_application_error".

Sintaxis:

 raise_application_error (NUMERO,TEXTO);

El procedimiento "raise_application_error" permite emitir un mensaje de error. El NUMERO de mensaje debe ser un n�mero
negativo entre -20000 y -20999 y el mensaje de TEXTO una cadena de caracteres de hasta 2048 bytes.

Si durante la ejecuci�n de un trigger se produce un error definido por el usuario, se anulan todas las actualizaciones realizadas 
por la acci�n del trigger as� como el evento que la activ�, es decir, se reanuda cualquier efecto retornando un mensaje y se 
deshace la orden ejecutada.

En caso que se incluya en el cuerpo de un disparador "after" (que se ejecuta despu�s de la sentencia, es decir, cuando los 
datos ya han sido actualizados), la sentencia ser� deshecha (rollback). Si es un disparador "before" (que se ejecuta antes 
de la sentencia, o sea, cuando los datos a�n no han sido actualizados), la sentencia no se ejecuta.

Veamos un ejemplo: Creamos un trigger de actualizaci�n a nivel de fila sobre la tabla "libros". Ante cualquier modificaci�n de
los registros de "libros", se debe ingresar en la tabla "control", el nombre del usuario que realiz� la actualizaci�n y la fecha;
pero, controlamos que NO se permita modificar el campo "codigo", en caso de suceder, la acci�n no debe realizarse y debe 
mostrarse un mensaje de error indic�ndolo:

 create or replace trigger tr_actualizar_libros
 before update
 on libros
 for each row
 begin
   if updating('codigo') then
    raise_application_error(-20001,'No se puede modificar el c�digo de los libros');
   else
    insert into control values(user,sysdate);
   end if;
 end;
 /
 
Si se actualiza cualquier campo de "libros", se dispara el trigger; si se actualiza el campo "codigo", aparece un mensaje de 
error y la actualizaci�n no se realiza; en caso de actualizarse cualquier otro campo, se almacenar� en "control", el nombre 
del usuario y la fecha.
*/





