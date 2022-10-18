/*
Para eliminar un trigger se emplea la siguiente sentencia:

 drop trigger NOMBRETRIGGER;
Ejemplo:

 drop trigger tr_insertar_libros;
Si eliminamos una tabla, se eliminan todos los triggers establecidos sobre ella.
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
 
 -- Creamos un desencadenador que se active cuando ingresamos un nuevo registro en "libros", debe almacenar en 
 -- "control" el nombre del usuario que realiza el ingreso, la fecha e "insercion" en "operacion":

create or replace trigger tr_ingresar_libros
before insert on libros
for each row 
begin
insert into control values(user, sysdate, 'insercion');
end tr_ingresar_libros;
/

-- Creamos un segundo disparador que se active cuando modificamos algún campo de "libros" y almacene en "control" el 
-- nombre del usuario que realiza la actualización, la fecha y en "operacion" coloque el nombre del campo actualizado:

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
 
 -- Creamos un tercer trigger sobre "libros" que se active cuando eliminamos un registro de "libros", debe almacenar en 
 -- "control" el nombre del usuario que realiza la eliminación, la fecha y "borrado" en "operacion":
 
 create or replace trigger tr_eliminar_libros
  before delete
  on libros
  for each row
 begin
   insert into control values(user,sysdate,'borrado');
 end tr_eliminar_libros;
 /
 
 -- Vemos cuántos triggers están asociados a "libros"; consultamos el diccionario "user_triggers":

 select trigger_name, triggering_event, status from user_triggers
  where table_name = 'LIBROS';

--  Ingresamos algunos registros

 insert into libros values(100,'Uno','Richard Bach','Planeta',25);
 insert into libros values(101,'El aleph','Borges','Emece',28);
 insert into libros values(102,'Matematica estas ahi','Paenza','Nuevo siglo',12);
 insert into libros values(103,'Aprenda PHP','Molina Mario','Nuevo siglo',55);
 insert into libros values(144,'Alicia en el pais de las maravillas','Carroll','Planeta',35);
 
 -- Comprobamos que el trigge "tr_ingresar_libros" se disparó recuperando los registros de "control":

select * from control;

-- Actualizamos la editorial de varios libros y comprobamos que el trigger de actualización se disparó recuperando los 
-- registros de "control":

 update libros set editorial='Sudamericana' where editorial='Planeta';
 select *from control;
 
 -- Borramos un libro de "libros" y comprobamos que el trigger de borrado se disparó recuperando los registros de "control":

 delete from libros where codigo=101;
 select *from control;
 
 -- Actualizamos el autor de un libro y comprobamos que el trigger de actualización se dispara recuperando los registros 
 -- de "control":

 update libros set autor='Adrian Paenza' where autor='Paenza';
 select *from control;
 
 -- Eliminamos la tabla "libros":

 drop table libros;

-- Consultamos el diccionario "user_triggers" para comprobar que al eliminar "libros" se eliminaron también los triggers 
-- asociados a ella:

 select trigger_name, triggering_event, status from user_triggers
  where table_name = 'LIBROS';

-- Los tres trigger asociados a "libros" han sido eliminados.

-- Ejercicio 1

 drop table ventas;
 drop table articulos;

 create table articulos(
  codigo number(4) not null,
  descripcion varchar2(40),
  precio number (6,2),
  stock number(4),
  constraint PK_articulos_codigo
   primary key (codigo)
 );

 create table ventas(
  codigo number(4),
  cantidad number(4),
  fecha date,
  constraint FK_ventas_articulos
   foreign key (codigo)
   references articulos(codigo)
);

-- Cree una secuencia llamada "sec_codigoart", estableciendo que comience en 1, sus valores estén entre 1 y 9999 y 
-- se incrementen en 1. Antes elimínela por si existe

 drop sequence sec_codigoart;
 create sequence sec_codigoart
  start with 1
  increment by 1;

-- Active el paquete para permitir mostrar salida en pantalla

 set serveroutput on;
 execute dbms_output.enable (20000);

-- Cree un trigger que coloque el siguiente valor de una secuencia para el código de "articulos" cada vez que se ingrese un 
-- nuevo artículo
-- Podemos ingresar un nuevo registro en "articulos" sin incluir el código porque lo ingresará el disparador luego de calcularlo. 
-- Si al ingresar un registro en "articulos" incluimos un valor para código, será ignorado y reemplazado por el valor calculado 
-- por el disparador.

 create or replace trigger tr_insertar_codigo_articulos
  before insert
  on articulos
  for each row
 begin
  select sec_codigoart.nextval into :new.codigo from dual;
  dbms_output.put_line('"tr_insertar_codigo_articulos" activado');
 end tr_insertar_codigo_articulos;
 /

-- Ingrese algunos registros en "articulos" sin incluir el código:

 insert into articulos (descripcion, precio, stock) values ('cuaderno rayado 24h',4.5,100);
 insert into articulos (descripcion, precio, stock) values ('cuaderno liso 12h',3.5,150);
 insert into articulos (descripcion, precio, stock) values ('lapices color x6',8.4,60);

-- Recupere todos los artículos para ver cómo se almacenó el código

select *from articulos;

-- Ingrese algunos registros en "articulos" incluyendo el código:

 insert into articulos values(160,'regla 20cm.',6.5,40);
 insert into articulos values(173,'compas metal',14,35);
 insert into articulos values(234,'goma lapiz',0.95,200);

-- Recupere todos los artículos para ver cómo se almacenó los códigos
-- Ignora los códigos especificados ingresando el siguiente de la secuencia.

 select *from articulos;

-- Cuando se ingresa un registro en "ventas", se debe:
-- controlar que el código del artículo exista en "articulos" (lo hacemos con la restricción "foreign key" establecida en "ventas");
-- controlar que exista stock, lo cual no puede controlarse con una restricción "foreign key" porque el campo "stock" no es 
-- clave primaria en la tabla "articulos"; cree un trigger. Si existe stock, debe disminuirse en "articulos".
-- Cree un trigger a nivel de fila sobre la tabla "ventas" para el evento se inserción. Cada vez que se realiza un "insert" sobre 
-- "ventas", el disparador se ejecuta. El disparador controla que la cantidad que se intenta vender sea menor o igual al stock 
-- del articulo y actualiza el campo "stock" de "articulos", restando al valor anterior la cantidad vendida. Si la cantidad supera 
-- el stock, debe producirse un error, revertirse la acción y mostrar un mensaje

 create or replace trigger tr_insertar_ventas
  before insert
  on ventas
  for each row
 declare
   canti number:=null;
 begin
  dbms_output.put_line('"tr_insertar_ventas" activado');
  select stock into canti from articulos where codigo=:new.codigo;
   if :new.cantidad>canti then
    raise_application_error(-20001,'Sólo hay '|| to_char(canti)||' en stock');
   else
     update articulos set stock=stock-:new.cantidad where codigo=:new.codigo; 
   end if; 
 end tr_insertar_ventas;
 /

-- Ingrese un registro en "ventas" cuyo código no exista en "articulos"
-- Aparece un mensaje de error, porque el código no existe. El trigger se ejecutó.

  insert into ventas values(200,10,sysdate);

-- Verifique que no se ha agregado ningún registro en "ventas"

 select *from ventas;

-- Ingrese un registro en "ventas" cuyo código exista en "articulos" y del cual haya suficiente stock
-- Note que el trigger se disparó, aparece el texto "tr_insertar_ventas activado".

  insert into ventas values(2,10,sysdate);

-- Verifique que el trigger se disparó consultando la tabla "articulos" (debe haberse disminuido el stock) y se agregó un 
-- registro en "ventas"

 select *from articulos;
 select *from ventas;

-- Ingrese un registro en "ventas" cuyo código exista en "articulos" y del cual NO haya suficiente stock
-- Aparece el mensaje mensaje de error 20001 y el texto que muestra que se disparó el trigger.

 insert into ventas values(2,300,sysdate);

-- Verifique que NO se ha disminuido el stock en "articulos" ni se ha agregado un registro en "ventas"

 select *from articulos;
 select *from ventas;

-- El comercio quiere que se realicen las ventas de lunes a viernes de 8 a 18 hs. Reemplace el trigger creado anteriormente 
-- "tr_insertar_ventas" para que No permita que se realicen ventas fuera de los días y horarios especificados y muestre un 
-- mensaje de error

 create or replace trigger tr_insertar_ventas
  before insert
  on ventas
  for each row
 declare
   canti number:=null;
 begin
  dbms_output.put_line('"tr_insertar_ventas" activado');
  if (to_char(sysdate, 'DY','nls_date_language=SPANISH') in ('LUN','MAR','MIE','JUE','VIE')) then 
    if(to_number(to_char(sysdate, 'HH24')) between 8 and 17) then
      select stock into canti from articulos where codigo=:new.codigo;
      if :new.cantidad>canti then
        raise_application_error(-20001,'Sólo hay '|| to_char(canti)||' en stock');
      else
        update articulos set stock=stock-:new.cantidad where codigo=:new.codigo; 
      end if;
    else--hora
      raise_application_error(-20002,'Solo se pueden realizar ventas entre las 8 y 18 hs.');
    end if;--hora
  else
    raise_application_error(-20003,'Solo se pueden realizar ventas de lunes a viernes.');
  end if; --dia
 end tr_insertar_ventas;
 /

-- Ingrese un registro en "ventas", un día y horario permitido, si es necesario, modifique la fecha y la hora del sistema

 insert into ventas values(3,20,sysdate);

-- Verifique que se ha agregado un registro en "ventas" y se ha disminuido el stock en "articulos"

 select *from articulos;
 select *from ventas;

-- Ingrese un registro en "ventas", un día permitido fuera del horario permitido (si es necesario, modifique la fecha y hora del 
-- sistema). Se muestra un mensaje de error.

 insert into ventas values(3,20,sysdate);

-- Ingrese un registro en "ventas", un día sábado a las 15 hs.

insert into ventas values(3,20,sysdate);

-- El comercio quiere que los registros de la tabla "articulos" puedan ser ingresados, modificados y/o eliminados únicamente 
-- los sábados de 8 a 12 hs. Cree un trigger "tr_articulos" que No permita que se realicen inserciones, actualizaciones ni 
-- eliminaciones en "articulos" fuera del horario especificado los días sábados, mostrando un mensaje de error. Recuerde 
-- que al ingresar un registro en "ventas", se actualiza el "stock" en "articulos"; el trigger debe permitir las actualizaciones del 
-- campo "stock" en "articulos" de lunes a viernes de 8 a 18 hs. (horario de ventas)

 create or replace trigger tr_articulos
  before insert or update or delete
  on articulos
  for each row
 begin
  dbms_output.put_line('"tr_update_articulos" activado');
  if (to_char(sysdate, 'DY','nls_date_language=SPANISH')='SÁB')then
     if(to_number(to_char(sysdate, 'HH24')) not between 8 and 11) then
       raise_application_error(-20004,'Esta tarea en sábado sólo de 8 a 12 hs.');
     end if;
  else
    if(to_char(sysdate, 'DY','nls_date_language=SPANISH')='DOM')then
      raise_application_error(-20005,'Esta tarea no en domingo.');
    else 
      if updating ('stock') then
        if  (to_number(to_char(sysdate, 'HH24')) not between 8 and 17) then
           raise_application_error(-20006,'Esta tarea de LUN a VIE de 8 a 18 hs. o SAB de 8 a 12 hs.');
        end if;
      else
         raise_application_error(-20007,'Esta tarea solo SAB de 8 a 12 hs.');
      end if;--stock
    end if;--domingo
  end if;--sab
 end tr_articulos;
 /

-- Ingrese un nuevo artículo un sábado a las 9 AM. Note que se activan 2 triggers.

insert into articulos values(234,'cartulina',0.95,100);

-- Elimine un artículo, un sábado a las 16 hs. Mensaje de error.

 delete from articulos where codigo=1;

-- Actualice el precio de un artículo, un domingo

 update articulos set precio=precio+precio*0.1 where codigo=5;

-- Actualice el precio de un artículo, un lunes en horario de ventas. Mensaje de error.

update articulos set precio=precio+precio*0.1 where codigo=5;

-- Ingrese un registro en "ventas" que modifique el "stock" en "articulos", un martes entre las 8 y 18 hs.
-- Note que se activan 2 triggers.

 insert into ventas values(3,5,sysdate);

-- Consulte el diccionario "user_triggers" para ver cuántos trigger están asociados a "articulos" y a "ventas" (3 triggers)

select table_name, trigger_name, triggering_event from user_triggers
  where table_name ='ARTICULOS' or table_name='VENTAS';

-- Elimine el trigger asociado a "ventas"

 drop trigger tr_insertar_ventas;

-- Elimine las tablas "ventas" y "articulos"

 drop table articulos;
 
-- Consulte el diccionario "user_triggers" para verificar que al eliminar la tabla "articulos" se han eliminado todos los 
-- triggers asociados a ella

select * from user_triggers where trigger_name='TR_ARTICULOS' or trigger_name='TR_INSERTAR_CODIGO_ARTICULOS'; 

-- Ejercicio 2

 drop table empleados;
 drop table secciones;

 create table secciones(
  codigo number(2),
  nombre varchar2(30),
  sueldomaximo number(8,2),
  constraint PK_secciones primary key(codigo)
 );

 create table empleados(
  documento char(8) not null,
  nombre varchar2(30) not null,
  domicilio varchar2(30),
  codigoseccion number(2) not null,
  sueldo number(8,2),
  constraint PK_empleados primary key(documento),
  constraint FK_empleados_seccion
   foreign key (codigoseccion)
   references secciones(codigo)
 );

 insert into secciones values(1,'Administracion',1500);
 insert into secciones values(2,'Sistemas',2000);
 insert into secciones values(3,'Secretaria',1000);

 insert into empleados values('22222222','Ana Acosta','Avellaneda 88',1,1100);
 insert into empleados values('23333333','Bernardo Bustos','Bulnes 345',1,1200);
 insert into empleados values('24444444','Carlos Caseres','Colon 674',2,1800);
 insert into empleados values('25555555','Diana Duarte','Colon 873',3,1000);

-- Active el paquete necesario para mostrar mensaje por pantalla:

 set serveroutput on;
 execute dbms_output.enable (20000);
 
-- En cada disparador que cree próximamente muestre un mensaje por pantalla que indique su nombre.

-- Cree un disparador para que se ejecute cada vez que una instrucción "insert" ingrese datos en "empleados"; el mismo 
-- debe verificar que el sueldo del empleado no sea mayor al sueldo máximo establecido para la sección, si lo es, debe 
-- mostrar un mensaje indicando tal situación y deshacer la transacción

-- Ingrese un nuevo registro en "empleados" cuyo sueldo sea menor o igual al establecido para la sección:

 insert into empleados values('26666666','Federico Fuentes','Francia 938',2,1000);

-- El disparador se ejecutó, un texto en pantalla muestra su nombre.

-- Verifique que el disparador se ejecutó consultando la tabla "empleados"

-- Intente ingresar un nuevo registro en "empleados" cuyo sueldo sea mayor al establecido para la sección
-- El disparador se ejecutó mostrando un mensaje de error y la transacción se deshizo.

-- Verifique que el registro no se agregó en "empleados"

-- Intente ingresar un empleado con código de sección inexistente
-- Aparece un mensaje de error porque se viola la restricción "foreign key"; el trigger se ejecutó, aparece el mensaje 
-- de texto que lo indica.

-- Cree un disparador para que se ejecute cada vez que una instrucción "update" aumente el sueldo de "empleados"; el 
-- mismo debe verificar que el sueldo del empleado no supere al sueldo máximo establecido para la sección, si lo es, debe 
-- mostrar un mensaje indicando tal situación y deshacer la transacción

-- Modifique el sueldo de un empleado, debe ser menor o igual al establecido para la sección. El trigger se disparó.

-- Verifique que el disparador se ejecutó consultando la tabla "empleados"

-- Intente actualizar el sueldo de un empleado a un valor mayor al establecido para la sección
-- El disparador se ejecutó mostrando un mensaje de error y la transacción se deshizo.

-- Verifique que el registro no se modificó en "empleados"

-- Disminuya el sueldo de un empleado
-- El trigger no se disparo (no se mostró el texto con su nombre) porque se estableció en la condición "when" que el 
-- sueldo nuevo fuera mayor al anterior.

-- Verifique que el registro se modificó en "empleados"

-- Modifique el código de sección del empleado cuyo documento es "22222222" a "3"
-- Note que el cambio se realizó, y ahora existe un empleado de la sección "Secretaria" con sueldo "1350" cuando el 
-- máximo para esa sección es de "1000". Debe crear el trigger "tr_empleados_update_seccion", que se dispare cada 
-- vez que se modifique la seccion de un empleado y verifique que el sueldo no supere el máximo de la nueva sección, si lo 
-- supera, la transacción debe deshacerse

-- Modifique el código de sección del empleado cuyo documento es "22222222" a "1"
-- El trigger se disparó, como el sueldo no supera el máximo permitido para la nueva sección, el cambio se realizó.

-- Verifique que el cambio se realizó

-- Modifique el código de sección del empleado cuyo documento es "23333333" a "3"
-- El trigger se disparó y mostró el mensaje de error, la transacción se deshizo.

-- Verifique que el cambio no se realizó

-- Modifique el sueldo del empleado cuyo documento es "23333333" a "1000" y el código de sección a "3"
-- El trigger se disparó.

-- Verifique que el cambio se realizó

-- Si modificamos el sueldo máximo de una sección de "secciones", disminuyéndolo, pueden quedar en "empleados" 
-- valores de sueldos superiores al permitido para la sección. Para evitar esto debe crear un disparador sobre "secciones" 
-- que se active cuando se disminuya el campo "sueldomaximo" y modifique el sueldo (al máximo permitido para la sección) 
-- de todos los empleados de esa sección cuyos sueldos superen el nuevo máximo establecido

-- Modifique el sueldo máximo para la sección "Administracion" a 2000, es decir, auméntelo
-- Note que el trigger No se disparó, porque el trigger tiene una condición "when" que especifica que se active unicamente 
-- cuando el nuevo sueldo maximo sea menor al anterior.

-- Verifique que el sueldo máximo de "Administracion" se ha modificado

-- Modifique el sueldo máximo para la sección "Administracion" a 1800, es decir, disminúyalo
-- Note que el trigger se disparó, cumple con la condición "when". Pero, como no hay en "empleados", sueldos de tal 
-- sección que superen tal valor, no se han modificado registros en "empleados".

-- Verifique que se modificó el sueldo máximo en "secciones" pero ningún registro en "empleados"

-- Modifique el sueldo máximo para la sección "Administracion" a 1200, es decir, disminúyalo
-- Note que el trigger se disparó, cumple con la condición "when". Como hay en "empleados" un sueldo de 1350, de 
-- "Administracion", es decir supera el nuevo "sueldomaximo" que se intenta establecer, se modifica tal registro en "empleados".

-- Verifique que se modificó el sueldo máximo en "secciones" y un registro en "empleados"

-- Cree un trigger que no permita que se modifique el código de "secciones"

-- Intente modificar el código de una sección de "secciones"
-- Note que el trigger se disparó y muestra el mensaje de error. El código no se modificó. Verifíquelo

-- Actualice en una misma sentencia "update", el sueldo a "1800" y el codigo de sección a "2" del empleado cuyo documento 
-- es "22222222"
-- Note que se activan 2 triggers.

-- Cree un trigger a nivel de sentencia sobre "empleados", que muestre un mensaje de error para evitar que se actualice el 
-- campo "documento"

-- Consulte el diccionario "user_triggers" para ver cuántos trigger están asociados a "empleados" y a "secciones"

-- Elimine los 2 triggers asociados a la tabla "secciones"

-- Consulte el diccionario "user_triggers" para verificar que "secciones" ya no tiene disparadores asociados a ella

-- Cree un trigger sobre "secciones", para el evento de actualización que realice todas las acciones que ejecutaban los 
-- 2 triggers que "secciones" tenía asociados anteriormente; es decir:
-- si se actualiza un sueldo máximo, modificar el sueldo, al máximo permitido, a todos los empleados (de la sección 
-- modificada) cuyos sueldos superen el nuevo sueldo máximo;

-- definir un mensaje de error si se intenta actualizar un código se sección.

-- Probarlo. Disminuir el sueldo máximo de una sección que no supere el sueldo de ningun empleado:
-- Se activó el trigger de actualizacion de secciones pero ningún registro de "empleados" fue modificado.

-- Disminuir el sueldo máximo de una sección de modo que supere el sueldo de algún empleado
-- Se activó el trigger de actualizacion de secciones y 2 registros de "empleados" fueron modificados.

-- Intente modificar un código de sección. Mensaje de error.

-- Consulte el diccionario "user_triggers" para ver cuántos triggers están asociados a las tablas "secciones" y "empleados"

-- Elimine la tabla "empleados"

-- Consulte el diccionario "user_triggers" para verificar que al borrar la tabla "empleados" se eliminaron todos los 
-- disparadores asociados a ella

-- Elimine la tabla "secciones" y consulte "user_triggers" para verificar que al borrar la tabla "secciones" se eliminaron todos 
-- los desencadenadores asociados a ella