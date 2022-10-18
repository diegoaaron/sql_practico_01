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
 drop table libros;
 drop table control;

 create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(6,2)
 );

 create table control(
  usuario varchar2(30),
  fecha date
 );

 insert into libros values (101,'Uno','Richard Bach','Planeta',25); 
 insert into libros values (102,'Matematica estas ahi','Paenza','Nuevo siglo',12); 
 insert into libros values (103,'El aleph','Borges','Emece',28);
 insert into libros values (104,'Aprenda PHP','Molina','Nuevo siglo',55); 
 insert into libros values (105,'El experto en laberintos','Gaskin','Planeta',23); 

-- Creamos un trigger de actualizaci�n a nivel de fila sobre la tabla "libros" que se dispare antes que se ejecute una 
-- actualizaci�n. Ante cualquier modificaci�n de los registros de "libros", se debe ingresar en la tabla "control", el nombre 
-- del usuario que realiz� la actualizaci�n y la fecha. Pero, controlamos que NO se permita modificar el campo "codigo", 
-- en caso de suceder, la acci�n no debe realizarse y debe mostrarse un mensaje de error indic�ndolo:

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
 
--  Aumentamos el precio de todos los libros de editorial "Planeta":

 update libros set precio=precio+precio*0.1  where editorial='Planeta';

-- Controlamos que los precios se han modificado y el trigger se ha disparado almacenando en "control" 2 registros:

 select *from libros;
 select *from control;

-- Intentamos modificar el c�digo de un libro:

 update libros set codigo=109 where codigo=101;
 
 -- Note que muestra el mensaje de error definido por nosotros. El trigger se dispar� y se ejecut� "raise_application_error", 
 -- por lo tanto, el c�digo no se modific�. Controlamos que el c�digo no se modific�:

 select *from libros;

 -- Reemplazamos el trigger creado anteriormente para que ahora se dispare DESPUES (after) de cualquier modificaci�n 
 -- de los registros de "libros"; debe realizar lo mismo que el anterior, ingresar en la tabla "control", el nombre del usuario que 
 -- realiz� la actualizaci�n y la fecha. Pero, controlando que NO se permita modificar el campo "codigo", en caso de suceder, 
 -- la acci�n no debe revertirse y debe mostrarse un mensaje de error indic�ndolo:

 create or replace trigger tr_actualizar_libros
 after update
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
 
 -- Intentamos modificar el c�digo de un libro:

 update libros set codigo=109 where codigo=101;

-- Note que muestra el mensaje de error definido por nosotros. El trigger fue definido "after", es decir, se dispar� luego de 
-- ejecutarse la actualizaci�n, pero tambi�n se ejecut� "raise_application_error", por lo tanto, la sentencia "update" se deshizo.

-- Controlamos que el c�digo no se modific�:

 select *from libros;
 
 