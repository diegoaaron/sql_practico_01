/*
Vimos la creación de un disparador para el evento de inserción a nivel de sentencia, es decir, se dispara una vez por cada 
sentencia "insert" sobre la tabla asociada.

En caso que una sola sentencia "insert" ingrese varios registros en la tabla asociada, el trigger se disparará una sola vez; si 
queremos que se active una vez por cada registro afectado, debemos indicarlo con "for each row".

La siguiente es la sintaxis para crear un trigger de inserción a nivel de fila, se dispare una vez por cada fila ingresada sobre 
la tabla especificada:

 create or replace trigger NOMBREDISPARADOR
  MOMENTO insert
  on NOMBRETABLA
  for each row
  begin
   CUERPO DEL TRIGGER;
  end NOMBREDISPARADOR;
  /
  
Creamos un desencadenador que se dispara una vez por cada registro ingresado en la tabla "ofertas":

 create or replace trigger tr_ingresar_ofertas
  before insert
  on ofertas
  for each row
 begin
  insert into Control values(user,sysdate);
 end tr_ingresar_ofertas;
 /
 
Si al ejecutar un "insert" sobre "ofertas" empleamos la siguiente sentencia:

 insert into ofertas select titulo,autor,precio from libros where precio<30;
y se ingresan 5 registros en "ofertas", en la tabla "control" se ingresarán 5 registros, uno por cada inserción en "ofertas". Si 
el trigger hubiese sido definido a nivel de sentencia (statement), se agregaría una sola fila en "control".
*/

 drop table libros;
 drop table ofertas;
 drop table control;

 create table libros(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(6,2)
 );

 create table ofertas(
  titulo varchar2(40),
  autor varchar2(30),
  precio number(6,2)
 );

 create table control(
  usuario varchar2(30),
  fecha date
 );

-- Establecemos el formato de fecha para que muestre "DD/MM/YYYY HH24:MI":


