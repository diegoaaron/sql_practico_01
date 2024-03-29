/*
Vimos la creaci�n de un disparador para el evento de inserci�n a nivel de sentencia, es decir, se dispara una vez por cada 
sentencia "insert" sobre la tabla asociada.

En caso que una sola sentencia "insert" ingrese varios registros en la tabla asociada, el trigger se disparar� una sola vez; si 
queremos que se active una vez por cada registro afectado, debemos indicarlo con "for each row".

La siguiente es la sintaxis para crear un trigger de inserci�n a nivel de fila, se dispare una vez por cada fila ingresada sobre 
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
y se ingresan 5 registros en "ofertas", en la tabla "control" se ingresar�n 5 registros, uno por cada inserci�n en "ofertas". Si 
el trigger hubiese sido definido a nivel de sentencia (statement), se agregar�a una sola fila en "control".
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

 alter session set NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI';

-- Creamos un disparador que se dispare una vez por cada registro ingresado en "ofertas"; el trigger debe ingresar en la 
-- tabla "control", el nombre del usuario, la fecha y la hora en la cual se realiz� un "insert" sobre "ofertas":

create or replace trigger tr_ingresar_ofertas
before insert on ofertas
for each row
begin
insert into control values(user, sysdate);
end tr_ingresar_ofertas;
/

-- Veamos qu� nos informa el diccionario "user_triggers" respecto del trigger anteriormente creado:

select * from user_triggers where trigger_name = 'TR_INGRESAR_OFERTAS';

-- Ingresamos algunos registros 

 insert into libros values(100,'Uno','Richard Bach','Planeta',25);
 insert into libros values(102,'Matematica estas ahi','Paenza','Nuevo siglo',12);
 insert into libros values(105,'El aleph','Borges','Emece',32);
 insert into libros values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55);

-- Ingresamos en "ofertas" los libros de "libros" cuyo precio no superen los $30, utilizando la siguiente sentencia:

insert into ofertas select titulo, autor, precio from libros where precio < 30;

-- Verificamos que el trigger se dispar� 2 veces, una por cada fila afectada en la sentencia "insert" anteriormente ejecutada; 
-- consultamos la tabla "control":

select * from control;

--Si el trigger hubiese sido creado a nivel de sentencia, no de fila, el "insert" anterior se hubiese activado una sola vez aun 
-- cuando se ingresaron 2 registros.

-- Ejercicio 1 

 drop table empleados;
 drop table control;

 create table empleados(
  documento char(8),
  apellido varchar2(30),
  nombre varchar2(30),
  seccion varchar2(20)
 );

 create table control(
  usuario varchar2(30),
  fecha date
 );

-- Cree un disparador que se dispare una vez por cada registro ingresado en "empleados"; el trigger debe ingresar en la 
-- tabla "control", el nombre del usuario y la fecha en la cual se realiz� un "insert" sobre "empleados"

create or replace trigger tr_ingresar_empleados
before insert on empleados
for each row
begin 
insert into control values(user, sysdate);
end tr_ingresar_empleados;
/

-- Vea qu� nos informa el diccionario "user_triggers" respecto del trigger anteriormente creado

select * from user_triggers where trigger_name = 'TR_INGRESAR_EMPLEADOS';

-- Ingrese algunos registros en "empleados":

 insert into empleados values('22333444','ACOSTA','Ana','Secretaria');
 insert into empleados values('22777888','DOMINGUEZ','Daniel','Secretaria');
 insert into empleados values('22999000','FUENTES','Federico','Sistemas');
 insert into empleados values('22555666','CASEROS','Carlos','Contaduria');
 insert into empleados values('23444555','GOMEZ','Gabriela','Sistemas');
 insert into empleados values('23666777','JUAREZ','Juan','Contaduria');

-- Verifique que el trigger se dispar� 6 veces, una por cada fila afectada en la sentencia "insert" anteriormente ejecutada; 
-- consultamos la tabla "control":

select * from control;

-- Si el trigger hubiese sido creado a nivel de sentencia, no de fila, el "insert" anterior se hubiese activado una sola vez a�n 
-- cuando se ingresaron 6 registros.

