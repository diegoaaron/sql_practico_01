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
 
 -- Ejercicio 1
 
drop table empleados;
 drop table control;

 create table empleados(
  documento char(8),
  apellido varchar2(30),
  nombre varchar2(30),
  domicilio varchar2(30),
  seccion varchar2(20),
  sueldo number(8,2)
 );

 create table control(
  usuario varchar2(30),
  fecha date,
  operacion varchar2(30)
 );

 insert into empleados values('22222222','Acosta','Ana','Avellaneda 11','Secretaria',1800);
 insert into empleados values('23333333','Bustos','Betina','Bulnes 22','Gerencia',5000);
 insert into empleados values('24444444','Caseres','Carlos','Colon 333','Contaduria',3000);

-- Cree un trigger de inserci�n sobre "empleados" que guarde en "control" el nombre del usuario que ingresa datos, la 
-- fecha y "insercion", en el campo "operacion". Pero, si el sueldo que se intenta ingresar supera los $5000, debe 
-- mostrarse un mensaje de error y deshacer la transacci�n

 create or replace trigger tr_insertar_empleados
 before insert
 on empleados
 for each row
 begin
   if (:new.sueldo>5000)then
    raise_application_error(-20000,'El sueldo no puede superar los $5000');
   end if;
   insert into control values(user,sysdate,'insercion');
 end tr_insertar_empleados;
 /

-- Cree un trigger de borrado sobre "empleados" que guarde en "control" los datos requeridos (en "operacion" debe 
-- almacenar "borrado". Si se intenta eliminar un empleado de la secci�n "gerencia", debe aparecer un mensaje de error y
-- deshacer la operaci�n

 create or replace trigger tr_eliminar_empleados
 before delete
 on empleados
 for each row
 begin
   if (:old.seccion='Gerencia')then
    raise_application_error(-20001,'No puede eliminar empleados de gerencia');
   end if;
   insert into control values(user,sysdate,'borrado');
 end;
 /

-- Cree un trigger de actualizaci�n. Ante cualquier modificaci�n de los registros de "empleados", se debe ingresar en la 
-- tabla "control", el nombre del usuario que realiz� la actualizaci�n, la fecha y "actualizacion". Pero, controlamos que NO se 
-- permita modificar el campo "documento", en caso de suceder, la acci�n no debe realizarse y debe mostrarse un mensaje 
-- de error indic�ndolo

 create or replace trigger tr_actualizar_empleados
 before update
 on empleados
 for each row
 begin
   if updating('documento') then
    raise_application_error(-20002,'No se puede modificar el documento de los empleados');
   else
    insert into control values(user,sysdate,'actualizacion');
   end if;
 end;
 /

-- Intente ingresar un empleado con sueldo superior a $5000:

 insert into empleados values('25555555','Duarte','Dario','Dominicana 444','Secretaria',5800);

-- Note que muestra el mensaje de error definido por usted.

-- Ingrese un empleado con valores permitidos:

 insert into empleados values('25555555','Duarte','Dario','Dominicana 444','Secretaria',2800);

-- Intente borrar un empleado de "gerencia"
-- Aparece un mensaje de error.

 delete from empleados where documento='23333333';

-- Elimine un empleado que no sea de "Gerencia"

 delete from empleados where documento='25555555';

-- Intente modificar el documento de un empleado
-- Mensaje de error.

 update empleados set documento='28888888' where documento='22222222';

-- Modifique un campo diferente de "documento"

 update empleados set nombre='Ana Laura' where nombre='Ana';

-- Vea que se ha almacenado hasta el momento en "control"
-- Debe haber 3 registros, de inserci�n, de borrado y actualizaci�n.
 
  select *from control;
