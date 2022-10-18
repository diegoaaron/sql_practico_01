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

