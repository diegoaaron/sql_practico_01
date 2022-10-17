/*
En los triggers a nivel de fila, se puede incluir una restricción adicional, agregando la clausula "when" con una condición 
que se evalúa para cada fila que afecte el disparador; si resulta cierta, se ejecutan las sentencias del trigger para ese 
registro; si resulta falsa, el trigger no se dispara para ese registro.

Limitaciones de "when":

- no puede contener subconsultas, funciones agregadas ni funciones definidas por el usuario;

- sólo se puede hacer referencia a los parámetros del evento;

- no se puede especificar en los trigers "instead of" ni en trigger a nivel de sentencia.

Creamos el siguiente disparador:

create or replace trigger tr_precio_libros
 before insert or update of precio
 on libros
 for each row when(new.precio>50)
 begin
  :new.precio := round(:new.precio);
 end tr_precio_libros;
 /
 
El disparador anterior se dispara ANTES (before) que se ejecute un "insert" sobre "libros" o un "update" sobre "precio" de 
"libros". Se ejecuta una vez por cada fila afectada (for each row) y solamente si cumple con la condición del "when", 
es decir, si el nuevo precio que se ingresa o modifica es superior a 50. Si el precio es menor o igual a 50, el trigger no 
se dispara. Si el precio es mayor a 50, se modifica el valor ingresado redondeándolo a entero.

Note que cuando hacemos referencia a "new" (igualmente con "old") en la condición "when", no se colocan los dos puntos
precediéndolo; pero en el cuerpo del trigger si.

Si ingresamos un registro con el valor 30.80 para "precio", el trigger no se dispara.

Si ingresamos un registro con el valor "55.6" para "precio", el trigger se dispara modificando tal valor a "56".

Si actualizamos el precio de un libro a "40.30", el trigger no se activa.

Si actualizamos el precio de un libro a "50.30", el trigger se activa y modifica el valor a "50".

Si actualizamos el precio de 2 registros a valores que superen los "50", el trigger se activa 2 veces redondeando los valores 
a entero.

Si actualizamos en una sola sentencia el precio de 2 registros y solamente uno de ellos supera los "50", el trigger se activa 
1 sola vez.

El trigger anterior podría haberse creado de la siguiente manera:

create or replace trigger tr_precio_libros
 before insert or update of precio
 on libros
 for each row
 begin
  if :new.precio>50 then
   :new.precio := round(:new.precio);
  end if;
 end tr_precio_libros;
 /
 
En este caso, la condición se chequea en un "if" dentro del cuerpo del trigger. La diferencia con el primer trigger que
contiene "when" es que la condición establecida en el "when" se testea antes que el trigger se dispare y si resulta 
verdadera, se dispara el trigger, sino no. En cambio, si la condición está dentro del cuerpo del disparador, el trigger se 
dispara y luego se controla el precio, si cumple la condición, se modifica el precio, sino no.

Por ejemplo, la siguiente sentencia:

 update libros set precio=40 where...;
no dispara el primer trigger, ya que no cumple con la condición del "when"; pero si dispara el segundo trigger, que no realiza
ninguna acción ya que al evaluarse la condición del "if", resulta falsa.
*/

 drop table libros;

 create table libros(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(6,2)
 );

 insert into libros values(100,'Uno','Richard Bach','Planeta',25);
 insert into libros values(103,'El aleph','Borges','Planeta',40);
 insert into libros values(105,'Matematica estas ahi','Paenza','Nuevo siglo',12);
 insert into libros values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55);

-- Creamos un trigger a nivel de fila que se dispara "antes" que se ejecute un "insert" o un "update" sobre el campo "precio" 
-- de la tabla "libros". Se activa solamente si el nuevo precio que se ingresa o se modifica es superior a 50, en caso de 
-- serlo, se modifica el valor ingresado redondeándolo a entero:

create or replace trigger tr_precio_libros
before insert or update of precio
on libros
for each row when (new.precio > 50)
begin
:new.precio := round(:new.precio);
end tr_precio_libros;
/

-- Ingresamos un registro con el valor 30.80 para "precio":

 insert into libros values(250,'El experto en laberintos','Gaskin','Emece',30.80);

-- El trigger no se dispara.
-- Veamos si el precio ingresado se redondeó:

 select * from libros where titulo like '%experto%';

-- El precio no se redondeó porque no es superior a 50, el trigger no se disparó.
-- Ingresamos un registro con el valor "55.6" para "precio":

 insert into libros values(300,'Alicia en el pais de las maravillas','Carroll','Emece',55.6);

-- Consultamos "libros":
-- El trigger se disparó y se redondeó el nuevo precio a 56.

 select *from libros where titulo like '%maravillas%';
 
-- Actualizamos el precio de un libro a "40.30":

 update libros set precio=40.30 where codigo=105;

-- Consultamos "libros":

 select *from libros where codigo =105;

-- Se almacenó el valor tal como se solicitó, el trigger no se disparó ya que ":new.precio" no cumplió con la condición 
-- del "when".

-- Actualizamos el precio de un libro a "50.30":

 update libros set precio=50.30 where codigo=105;

-- Consultamos la tabla:

 select *from libros where codigo=105;
 
-- El trigger se activa porque ":new.precio" cumple con la condición "when" y modifica el valor a "50".
-- Actualizamos el precio de 2 registros a "50.30":

 update libros set precio=50.30 where editorial='Nuevo siglo';

-- Consultamos:

 select * from libros where editorial='Nuevo siglo';

-- El trigger se activa 2 veces redondeado el valor a 50.

-- Ejecutamos el siguiente "update":

 update libros set precio=precio+15.8 where editorial='Planeta';

-- Consultamos:

 select * from libros where editorial='Planeta';

-- De los dos libros de editorial "Planeta" solamente uno supera el valor 50, por lo tanto, el trigger se dispara una sola vez.

-- Activamos el paquete "dbms_output":

 set serveroutput on;
 execute dbms_output.enable(20000);

-- Reemplazamos el trigger anterior por uno sin condición "when". La condición se controla en un "if" en el interior del trigger. 
-- En este caso, el trigger se dispara SIEMPRE que se actualice un precio en "libros", dentro del trigger se controla el 
-- precio, si cumple la condición, se modifica, sino no:

create or replace trigger tr_precio_libros
before insert or update of precio
on libros
for each row
begin 
dbms_output.put_line('Trigger disparado');
if :new.precio > 50 then
dbms_output.put_line('Precio redondeado');
:new.precio := round(:new.precio);
end if;
end tr_precio_libros;
/

-- Note que agregamos una salida de texto para controlar si el trigger se ha disparado y otra, para controlar si entra por la 
-- condición "if".
-- Ingresamos un registro con un valor inferior a 50 para "precio":

 insert into libros values(350,'Ilusiones','Bach','Planeta',20.35);

-- El trigger se dispara (aparece el primer mensaje), pero no realiza ninguna acción ya que al evaluarse la condición del "if",
-- resulta falsa.

-- Ingresamos un registro con un valor superior a 50 para "precio":

 insert into libros values(380,'El anillo del hechicero','Gaskin','Planeta',60.35);

-- El trigger se dispara (aparece el primer mensaje) y al evaluarse como cierta la condición, realiza la acción (aparece el 
-- segundo mensaje).

-- Consultamos el diccionario para ver qué nos informa sobre el disparador recientemente creado:

select * from user_triggers where trigger_name = 'TR_PRECIO_LIBROS';

-- Ejercicio 1

drop table libros;
 drop table ofertas;

 create table libros(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar(20),
  precio number(6,2)
 );

 create table ofertas(
  codigo number(6),
  titulo varchar2(40)
 );

 insert into libros values(100,'Uno','Richard Bach','Planeta',25);
 insert into libros values(103,'El aleph','Borges','Emece',28);
 insert into libros values(105,'Matematica estas ahi','Paenza','Nuevo siglo',12);
 insert into libros values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55);
 insert into libros values(145,'Alicia en el pais de las maravillas','Carroll','Planeta',35);
 
 -- Cree un trigger a nivel de fila que se dispara "antes" que se ejecute un "insert" sobre "libros". Se activa solamente si el 
 -- precio que se ingresa es inferior a $30, en caso de serlo, se ingresa en "ofertas" el código y precio del libro

create or replace trigger tr_ingresar_libros_ofertas
before insert on libros
for each row when (new.precio < 30)
begin
insert into ofertas values(:new.codigo, :new.titulo);
end tr_ingresar_libros_ofertas;
/

-- Ingrese un libro en "libros" cuyo precio sea inferior a $30

 insert into libros values(150,'El experto en laberintos','Gaskin','Planeta',28);

-- Verifique que el trigger se disparó consultando "ofertas"

select * from ofertas;

-- Ingrese un libro en "libros" cuyo precio supere los $30

 insert into libros values(155,'El gato con botas',null,'Planeta',38);

-- Verifique que el trigger no se disparó consultando "ofertas"

  select * from ofertas;

-- Cree un trigger a nivel de fila que se dispare al borrar un libro de "libros", únicamente si el precio del libro que se 
-- elimina es inferior a $30, es decir, si existe en "ofertas"

create or replace trigger tr_borrar_libros_ofertas
before delete on libros
for each row when(old.precio < 30)
begin
delete from ofertas where codigo = :old.codigo;
end tr_borrar_libros_ofertas;
/

-- Elimine un registro de "libros" cuyo precio sea inferior a $30

 delete from libros where codigo=150;

-- Verifique que el trigger se disparó consultando "ofertas" y "libros"

 select *from ofertas;
 select *from libros;

-- Elimine un registro de "libros" cuyo precio supere los $30

 delete from libros where codigo=155;

-- Verifique que el trigger no se disparó consultando "ofertas" y que si se ha eliminado el registro en "libros"
 
 select *from ofertas;
 select *from libros;
 
 -- Ejercicio 2
 
  drop table empleados;

 create table empleados(
  documento char(8),
  apellido varchar2(20),
  nombre varchar2(20),
  seccion varchar2(30),
  sueldo number(8,2)
 );

 insert into empleados values('22333444','ACOSTA','Ana','Secretaria',500);
 insert into empleados values('22555666','CASEROS','Carlos','Contaduria',900);
 insert into empleados values('22777888','DOMINGUEZ','Daniel','Secretaria',560);
 insert into empleados values('22999000','FUENTES','Federico','Sistemas',680);
 insert into empleados values('23444555','GOMEZ','Gabriela','Sistemas',1200);
 insert into empleados values('23666777','JUAREZ','Juan','Contaduria',1000);

 drop table control;

 create table control(
  usuario varchar2(30),
  fecha date,
  documento char(8),
  antiguosueldo number(8,2),
  nuevosueldo number(8,2)
 ); 
 
 -- Cree un disparador que almacene el nombre del usuario, la fecha, documento, el antiguo y el nuevo sueldo en "control" 
 -- cada vez que se actualice un sueldo de la tabla "empleados" a un valor mayor. Si el sueldo se disminuye, el trigger no 
 -- debe activarse. Si se modifica otro campo diferente de "sueldo", no debe activarse.
 
 create or replace trigger tr_aumentar_sueldo_empleados
 before update of sueldo on empleados
 for each row when(new.sueldo > old.sueldo)
 begin
 insert into control values(user,sysdate,:old.documento,:old.sueldo,:new.sueldo);
 end;
 /

-- Actualice el sueldo de todos los empleados de la sección "Sistemas" a "1000"

update empleados set sueldo = 1000 where seccion = 'Sistemas';

-- Consulte la tabla "control" para ver cuántas veces se ha disparado el trigger
-- Se ha disparado una sola vez; se actualizaron 2 registros, pero en solo uno de ellos se aumentó el sueldo.

select * from control;

-- Al empleado con documento "22333444" se lo ha cambiado a la sección "contaduria". Realice el cambio en la tabla 
-- "empleados"

update empleados set seccion = 'Contaduria' where documento = '22333444';

-- Verifique que el trigger no se ha activado porque no se ha modificado el campo "sueldo". Consulte "control"

 select *from control;

-- Cree un disparador a nivel de fila que se dispare cada vez que se ingrese un nuevo empleado y coloque en mayúsculas 
-- el apellido ingresado. Además, si no se ingresa sueldo, debe ingresar '0'

create or replace trigger tr_ingresar_empleados
before insert on empleados
for each row
begin
:new.apellido := upper(:new.apellido);
if (:new.sueldo is null) then
:new.sueldo := 0;
end if;
end;
/

-- Ingrese un nuevo empleado empleando minúsculas en el apellido

 insert into empleados values('25666777','Lopez','Luisa','Secretaria',650);

-- Verifique que el trigger "tr_ingresar_empleados" se disparó

select * from empleados where documento = '25666777';

-- Ingrese dos nuevos empleados, uno sin sueldo y otro con sueldo "null"

insert into empleados (documento,apellido,nombre, seccion) values('26777888','Morales','Marta','Secretaria');
 insert into empleados values('26999000','Perez','Patricia','Contaduria',null);

-- Verifique que el trigger "tr_ingresar_empleados" se ha disparado
-- Los dos registros deben tener el apellido en mayúsculas y deben tener el valor '0' en sueldo.

select * from empleados;

-- Cree un disparador a nivel de fila que se dispare cada vez que se ingresa un nuevo empleado y coloque "null" en 
-- "sueldo" si el sueldo ingresado supera los $1000 o es inferior a $500

create or replace trigger tr_ingresar_empleados
before insert on empleados
for each row when(new.sueldo > 1000 or new.sueldo < 500)
begin
:new.sueldo := null;
end tr_ingresar_empleados;
/

-- Ingrese un nuevo empleado con un sueldo que dispare el trigger creado anteriormente

 insert into empleados values('25666777','Lopez','Luisa','Secretaria',1650);

-- Verifique que el trigger "tr_ingresar_empleados" se disparó

select * from empleados;

 