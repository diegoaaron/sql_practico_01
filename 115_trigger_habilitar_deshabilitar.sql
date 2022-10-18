/*
Un disparador puede estar en dos estados: habilitado (enabled) o deshabilitado (disabled).

Cuando se crea un trigger, por defecto está habilitado.

Se puede deshabilitar un trigger para que no se ejecute. Un trigger deshabilitado sigue existiendo, pero al ejecutar una 
instrucción que lo dispara, no se activa.

Sintaxis para deshabilitar un trigger:

 alter trigger NOMBREDISPARADOR disable;
Ejemplo: Deshabilitamos el trigger "tr_ingresar_empleados":

 alter trigger tr_ingresar_empleados disable;
 
Sintaxis para habilitar un trigger que está deshabilitado:

 alter trigger NOMBREDISPARADOR enable;

Ejemplo: Habilitamos el trigger "tr_actualizar_empleados":

 alter trigger tr_actualizar_empleados enable;

Se pueden habilitar o deshabilitar todos los trigger establecidos sobre una tabla especifica, se emplea la siguiente sentencia;

 alter table TABLA disable all triggers;--deshabilita
 alter table TABLA enable all triggers;-- habilita

La siguiente sentencia deshabilita todos los triggers de la tabla "empleados":

 alter table empleados enable all triggers;

Podemos saber si un trigger está o no habilitado cosultando el diccionario "user_triggers", en la columna "status" aparece 
"enabled" si está habilitado y "disabled" si está deshabilitado.
*/

  drop table empleados;
  drop table controlCambios;

 create table empleados(
  documento char(8) not null,
  nombre varchar2(30) not null,
  domicilio varchar2(30),
  seccion varchar2(20)
 );

 create table controlCambios(
  usuario varchar2(30),
  fecha date,
  datoanterior varchar2(30),
  datonuevo varchar2(30)
 );

 insert into empleados values('22222222','Ana Acosta','Bulnes 56','Secretaria');
 insert into empleados values('23333333','Bernardo Bustos','Bulnes 188','Contaduria');
 insert into empleados values('24444444','Carlos Caseres','Caseros 364','Sistemas');
 insert into empleados values('25555555','Diana Duarte','Colon 1234','Sistemas');
 insert into empleados values('26666666','Diana Duarte','Colon 897','Sistemas');
 insert into empleados values('27777777','Matilda Morales','Colon 542','Gerencia');

-- Creamos un disparador que se active cuando modificamos algún campo de "empleados" y almacene en 
-- "controlCambios" el nombre del usuario que realiza la actualización, la fecha, el dato que se cambia y el nuevo valor:

create or replace trigger tr_actualizar_empleados
  before update
  on empleados
  for each row
 begin
  if updating('documento') then
   insert into controlCambios values(user,sysdate, :old.documento, :new.documento);
  end if;
  if updating('nombre') then
   insert into controlCambios values(user,sysdate, :old.nombre, :new.nombre);
  end if;
  if updating('domicilio') then
   insert into controlCambios values(user,sysdate, :old.domicilio, :new.domicilio);
  end if;
  if updating('seccion') then
   insert into controlCambios values(user,sysdate, :old.seccion, :new.seccion);
  end if;
 end tr_actualizar_empleados;
 /
 
 -- Creamos otro desencadenador que se active cuando ingresamos un nuevo registro en "empleados", debe almacenar 
 -- en "controlCambios" el nombre del usuario que realiza el ingreso, la fecha, "null" en "datoanterior" (porque se dispara 
 -- con una inserción) y en "datonuevo" el documento:
 
 create or replace trigger tr_ingresar_empleados
 before insert on empleados
 for each row
 begin
 insert into controlCambios values(user, sysdate, null, :new.documento);
 end tr_ingresar_empleados;
 /
 
 -- Creamos un tercer trigger sobre "empleados" que se active cuando eliminamos un registro en "empleados", debe 
 -- almacenar en "controlCambios" el nombre del usuario que realiza la eliminación, la fecha, el documento en "datoanterior" 
 -- y "null" en "datonuevo":

 create or replace trigger tr_eliminar_empleados
  before delete
  on empleados
  for each row
 begin
   insert into controlCambios values(user,sysdate, :old.documento, null);
 end tr_eliminar_empleados;
 /

-- Los tres triggers están habilitados. Consultamos el diccionario "user_triggers" para corroborarlo:

 select trigger_name, triggering_event, status
  from user_triggers
  where trigger_name like 'TR%EMPLEADOS';

-- Vamos a ingresar un empleado y comprobar que el trigger "tr_ingresar_empleados" se dispara recuperando los 
-- registros de "controlCambios":

 insert into empleados values('28888888','Pedro Perez','Peru 374','Secretaria');
 
 select * from controlCambios;

-- Deshabilitamos el trigger "tr_ingresar_empleados":

 alter  trigger tr_ingresar_empleados disable;

-- Consultamos el diccionario "user_triggers" para corroborarlo:

 select trigger_name, status
  from user_triggers
  where trigger_name like 'TR%EMPLEADOS';

-- El trigger "tr_ingresar_empleados" está deshabilitado, "tr_actualizar_empleados" y "tr_elimnar_empleados" están habilitados.

-- Vamos a ingresar un empleado y comprobar que el trigger de inserción no se dispara recuperando los registros de 
-- "controlCambios":

 insert into empleados values('29999999','Rosa Rodriguez','Rivadavia 627','Secretaria');
 select *from controlCambios;

-- Vamos a actualizar el domicilio de un empleado y comprobar que el trigger de actualización se dispara recuperando los' 
-- registros de "controlCambios":

 update empleados set domicilio='Bulnes 567' where documento='22222222';
 select *from controlCambios;

-- Deshabilitamos el trigger "tr_actualizar_empleados":

 alter  trigger tr_actualizar_empleados disable;

-- Consultamos el diccionario "user_triggers" para corroborarlo:

 select trigger_name, status
  from user_triggers
  where trigger_name like 'TR%EMPLEADOS';

-- Los triggers "tr_ingresar_empleados" y "tr_actualizar_empleados" están deshabilitados, "tr_eliminar_empleados" 
-- está habilitado.

-- Vamos a borrar un empleado de "empleados" y comprobar que el trigger de borrado se disparó recuperando los 
-- registros de "controlCambios":

 delete from empleados where documento= '29999999';
 
 select *from controlCambios;

-- Deshabilitamos el trigger "tr_eliminar_empleados":

 alter  trigger tr_eliminar_empleados disable;

-- Consultamos el diccionario "user_triggers" para comprobarlo:

 select trigger_name, status
  from user_triggers
  where table_name = 'EMPLEADOS';

-- Los tres trigger establecidos sobre "empleados" están deshabilitados.

-- Eliminamos un empleado de "empleados" y comprobamos que el trigger de borrado no se dispara recuperando los 
-- registros de "controlCambios":

 delete from empleados where documento= '28888888';
 select *from controlCambios;

-- Habilitamos el trigger "tr_actualizar_empleados":

 alter  trigger tr_actualizar_empleados enable;

-- Actualizamos la sección de un empleado y comprobamos que el trigger de actualización se dispara recuperando los 
-- registros de "controlCambios":

 update empleados set seccion='Sistemas' where documento='23333333';
 
 select *from controlCambios;

-- Habilitamos todos los triggers establecidos sobre "empleados":

 alter table empleados enable all triggers;

-- Consultamos el diccionario "user_triggers" para comprobar que el estado (status) de todos los triggers establecidos 
-- sobre "empleados" es habilitado:

 select trigger_name, triggering_event, status
  from user_triggers
  where table_name = 'EMPLEADOS';

-- Los tres trigger establecidos sobre "empleados" han sido habilitados. Se activarán ante cualquier sentencia "insert", 
-- "update" y "delete".
 
 -- Ejercicio 1
 
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
 
 -- Cree un disparador que se active cuando modificamos algún campo de "libros" y almacene en "control" el nombre 
 -- del usuario que realiza la actualización, la fecha y en "operacion" coloque el nombre del campo actualizado
 
 create or replace trigger tr_actualizar_libros
  before update
  on libros
  for each row
 begin
  if updating('codigo') then
   insert into control values(user,sysdate,'codigo');
  end if;
  if updating('titulo') then
   insert into control values(user,sysdate,'titulo');
  end if;
  if updating('autor') then
   insert into control values(user,sysdate,'autor');
  end if;
  if updating('editorial') then
   insert into control values(user,sysdate,'editorial');
  end if;
  if updating('precio') then
   insert into control values(user,sysdate,'precio');
  end if;
 end tr_actualizar_libros;
 /

-- Cree otro desencadenador que se active cuando ingresamos un nuevo registro en "libros", debe almacenar en "control" 
-- el nombre del usuario que realiza el ingreso, la fecha e "insercion" en "operacion"

 create or replace trigger tr_ingresar_libros
  before insert
  on libros
  for each row
 begin
   insert into control values(user,sysdate,'insercion');
 end tr_ingresar_libros;
 /

-- Cree un tercer trigger sobre "libros" que se active cuando eliminamos un registro de "libros", debe almacenar en "control" 
-- el nombre del usuario que realiza la eliminación, la fecha y "borrado" en "operacion"

create or replace trigger tr_eliminar_libros
  before delete
  on libros
  for each row
 begin
   insert into control values(user,sysdate,'borrado');
 end tr_eliminar_libros;
 /

-- Los tres triggers están habilitados. Consultamos el diccionario "user_triggers" para corroborarlo

select trigger_name, triggering_event, status from user_triggers
where table_name = 'LIBROS';

-- Ingrese un libro y compruebe que el trigger "tr_ingresar_libros" se dispara recuperando los registros de "control"

 insert into libros values(150,'El experto en laberintos','Gaskin','Planeta',38);
 select *from control;

-- Deshabilite el trigger "tr_ingresar_libros"

 alter trigger tr_ingresar_libros disable;

-- Consulte el diccionario "user_triggers" para corroborarlo
-- El trigger "tr_ingresar_libros" está deshabilitado, "tr_actualizar_libros" y "tr_eliminar_libros" están habilitados.

select trigger_name, status from user_triggers
where table_name = 'LIBROS';

-- Ingrese un libro y compruebe que el trigger de inserción no se dispara recuperando los registros de "control":

 insert into libros values(152,'El anillo del hechicero','Gaskin','Planeta',22);
 select *from control;

-- Actualice la editorial de varios libros y compruebe que el trigger de actualización se dispara recuperando los registros 
-- de "control"

 insert into libros values(152,'El anillo del hechicero','Gaskin','Planeta',22);
 select *from control;

-- Deshabilite el trigger "tr_actualizar_libros"

update libros set editorial='Sudamericana' where editorial='Planeta';
 select *from control;

-- Consulte el diccionario "user_triggers" para corroborarlo
-- Los triggers "tr_ingresar_libros" y "tr_actualizar_libros" están deshabilitados, "tr_eliminar_libros" está habilitado.

 alter trigger tr_actualizar_libros disable;
 
  select trigger_name, status  from user_triggers
  where table_name ='LIBROS';

-- Borre un libro de "libros" y compruebe que el trigger de borrado se disparó recuperando los registros de "control"

 delete from libros where codigo=152;
 select *from control;

-- Deshabilite el trigger "tr_eliminar_libros"

 alter  trigger tr_eliminar_libros disable;

-- Consulte el diccionario "user_triggers" para comprobarlo
-- Los tres trigger establecidos sobre "empleados" están deshabilitados.

 select trigger_name, status  from user_triggers
where table_name = 'EMPLEADOS';

-- Elimine un libro de "libros" y compruebe que tal registro se eliminó de "libros" pero que el trigger de borrado no se dispara 
-- recuperando los registros de "control"

delete from libros where codigo=150;
 select *from libros where codigo=150;
 select *from control;

-- Habilite el trigger "tr_actualizar_libros"

 alter trigger tr_actualizar_libros enable;

-- Actualice el autor de un libro y compruebe que el trigger de actualización se dispara recuperando los registros de "control"

 update libros set autor='Adrian Paenza' where autor='Paenza';
 select *from control;

-- Habilite todos los triggers establecidos sobre "libros"

 alter table libros enable all triggers;

-- Consulte el diccionario "user_triggers" para comprobar que el estado (status) de todos los triggers establecidos sobre 
-- "libros" es habilitado
-- Los tres trigger establecidos sobre "libros" han sido habilitados. Se activarán ante cualquier sentencia "insert", 
-- "update" y "delete".

select trigger_name, triggering_event, status from user_triggers
where table_name = 'LIBROS';
