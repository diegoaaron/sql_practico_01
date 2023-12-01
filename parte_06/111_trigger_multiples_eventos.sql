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
  fecha date,
  operacion varchar2(20)
 );

 insert into libros values(100,'Uno','Richard Bach','Planeta',25);
 insert into libros values(103,'El aleph','Borges','Emece',28);
 insert into libros values(105,'Matematica estas ahi','Paenza','Nuevo siglo',12);
 insert into libros values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55);
 insert into libros values(145,'Alicia en el pais de las maravillas','Carroll','Planeta',35);
 
-- Establecemos el formato de fecha para que muestre "DD/MM/YYYY HH24:MI":

alter session set NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI';

-- Creamos un disparador a nivel de sentencia, que se dispare cada vez que se ingrese, actualice o elimine un registro de 
-- la tabla "libros". El trigger ingresa en la tabla "control", el nombre del usuario, la fecha y la hora en la cual se realiz� la 
-- modificaci�n y el tipo de operaci�n que se realiz�:
-- si se realiz� una inserci�n (insert), se almacena "inserci�n";
-- si se realiz� una actualizaci�n (update), se almacena "actualizaci�n" y
-- si se realiz� una eliminaci�n (delete) se almacena "borrado".

create or replace trigger tr_cambio_libros
before insert or update or delete on libros
for each row
begin
if inserting then
insert into control values (user, sysdate, 'insercion');
end if;
if updating then
insert into control values (user, sysdate, 'actualizacion');
end if;
if deleting then
insert into control values(user, sysdate, 'borrado');
end if;
end tr_cambio_libros;
/

-- Veamos qu� nos informa el diccionario "user_triggers" respecto del trigger anteriormente creado:

select * from user_triggers where trigger_name = 'TR_CAMBIO_LIBROS';

-- obtenemos la siguiente informaci�n:
-- trigger_name: nombre del disparador;
-- trigger_type: momento y nivel, en este caso es un desencadenador "before" y a nivel de fila (each row);
-- triggering_event: evento que lo dispara, en este caso, "insert or update or delete";
-- base_object_type: a qu� objeto est� asociado, puede ser una tabla o una vista, en este caso, una tabla (table);
-- table_name: nombre de la tabla al que est� asociado (libros);

-- Ingresamos un registro en "libros":

insert into libros values(150, 'El experto en laberintos', 'Gaskin', 'Planeta', 23);

-- Veamos si el trigger se dispar� consultando la tabla "control":

select * from control;

-- Vemos que se ingres� un registro que muestra que el usuario "system", el d�a y hora actual realiz� una inserci�n sobre "libros".

-- Actualizamos algunos registros de "libros":

update libros set precio = precio*1.1 where editorial = 'Planeta';

 -- Veamos si el trigger se dispar� consultando la tabla "control":

select * from control;

-- Vemos que se ingresaron 3 nuevos registros que muestran que el usuario "system", el d�a y hora actual actualiz� tres 
-- registros de "libros". Si el trigger se hubiese definido a nivel de sentencia, el "update" anterior se hubiese disparado 
-- una sola vez.

-- Eliminamos un registro de "libros":

delete from libros where codigo = 145;

-- Veamos si el trigger se dispar� consultando la tabla "control":
-- Vemos que se elimin� 1 registro.

select * from control;

-- Ejercicio 1

 drop table control;
 drop table libros;

 create table libros(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(6,2)
 );

 create table control(
  usuario varchar2(30),
  fecha date,
  operacion varchar2(20)
 );

 insert into libros values(100,'Uno','Richard Bach','Planeta',25);
 insert into libros values(103,'El aleph','Borges','Emece',28);
 insert into libros values(105,'Matematica estas ahi','Paenza','Nuevo siglo',12);
 insert into libros values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55);
 insert into libros values(145,'Alicia en el pais de las maravillas','Carroll','Planeta',35);

-- 4- El gerente permite:
-- ingresar o borrar libros de la tabla "libros" unicamente los s�bados de 8 a 12 hs.
-- actualizar los precios de los libros de lunes a viernes de 8 a 18 hs. y s�bados entre la 8 y 12 hs.
-- Cree un disparador para los tres eventos que controle la hora en que se realizan las operaciones sobre "libros". Si se 
-- intenta eliminar, ingresar o actualizar registros de "libros" fuera de los d�as y horarios permitidos, debe aparecer un 
-- mensaje de error. Si la operaci�n de ingreso, borrado o actualizaci�n de registros se realiza, se debe almacenar en 
-- "control", el nombre del usuario, la fecha y el tipo de operaci�n ejecutada

create or replace trigger tr_cambios_libro
before insert or update or delete on libros
for each row
begin
if inserting then
if ((to_char(sysdate,'dy','nls_date_language=SPANISH') in ('s�b')) and
(to_number(to_char(sysdate,'HH24')) between 8 and 11)) then
insert into control values(user, sysdate, 'ingreso');
else
raise_application_error(-20000,'Los ingresos s�lo los Sab. de 8 a 12 hs.');
end if;
end if;
 if deleting then
  if (to_char(sysdate,'dy','nls_date_language=SPANISH') in ('s�b')) and
     (to_number(to_char(sysdate,'HH24')) between 8 and 11) then
   insert into control values (user, sysdate,'borrado');
  else
    raise_application_error(-20001,'Las eliminaciones solo los Sab. de 8 a 12 hs.');
  end if;
 end if; 
 if updating then
  if ((to_char(sysdate,'dy','nls_date_language=SPANISH') in ('lun','mar','mi�','jue','vie')) and
     (to_number(to_char(sysdate,'HH24')) between 8 and 19)) or
     ((to_char(sysdate,'dy','nls_date_language=SPANISH') in('s�b')) and
     (to_number(to_char(sysdate,'HH24')) between 8 and 11))then
   insert into control values (user, sysdate,'actualizaci�n');
  else
    raise_application_error(-20002,'Las actualizaciones solo de L a V de 8 a 20 o S de 8 a 12 hs.');
  end if;
 end if;
end tr_cambios_libros;
/

-- Intente ingresar un libro. Mensaje de error.

 insert into libros values(150,'El experto en laberintos','Gaskin','Planeta',25);

-- Realice un "select" sobre "libros" y sobre "control" para verificar que se han cargado los datos correspondientes/
-- Aparece el nuevo libro en "libros" y una fila de "ingreso" en "control".

select * from libros;

select * from control;

-- Cambie la fecha y hora del sistema a "domingo 18 hs.". Intente modificar el precio de un libro. Mensaje de error.

create or replace trigger tr_cambios_libro
before insert or update or delete on libros
for each row
begin
if inserting then
if ((to_char(sysdate,'dy','nls_date_language=SPANISH') in ('lun')) and
(to_number(to_char(sysdate,'HH24')) between 1 and 11)) then
insert into control values(user, sysdate, 'ingreso');
else
raise_application_error(-20000,'Los ingresos s�lo los Sab. de 8 a 12 hs.');
end if;
end if;
 if deleting then
  if (to_char(sysdate,'dy','nls_date_language=SPANISH') in ('lun')) and
     (to_number(to_char(sysdate,'HH24')) between 1 and 11) then
   insert into control values (user, sysdate,'borrado');
  else
    raise_application_error(-20001,'Las eliminaciones solo los Sab. de 8 a 12 hs.');
  end if;
 end if; 
 if updating then
  if ((to_char(sysdate,'dy','nls_date_language=SPANISH') in ('lun','mar','mi�','jue','vie')) and
     (to_number(to_char(sysdate,'HH24')) between 1 and 11)) or
     ((to_char(sysdate,'dy','nls_date_language=SPANISH') in('s�b')) and
     (to_number(to_char(sysdate,'HH24')) between 8 and 11))then
   insert into control values (user, sysdate,'actualizaci�n');
  else
    raise_application_error(-20002,'Las actualizaciones solo de L a V de 8 a 20 o S de 8 a 12 hs.');
  end if;
 end if;
end tr_cambios_libros;
/

--  Intente ingresar, modificar y eliminar el precio de un libro. 

 insert into libros values(150,'El experto en laberintos','Gaskin','Planeta',25);

 update libros set precio=45 where codigo=150;

 delete from libros where codigo=150;

-- Realice un "select" sobre "libros" y sobre "control" para verificar que se han cargado los datos correspondientes.
-- Se ha eliminado el registro en "libros" y se ha cargado una nueva fila de "borrado" en "control".

select * from control;
