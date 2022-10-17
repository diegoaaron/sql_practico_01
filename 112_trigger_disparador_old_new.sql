/*
Cuando trabajamos con trigger a nivel de fila, Oracle provee de dos tablas temporales a las cuales se puede acceder, que 
contienen los antiguos y nuevos valores de los campos del registro afectado por la sentencia que disparó el trigger. 
El nuevo valor es ":new" y el viejo valor es ":old". Para referirnos a ellos debemos especificar su campo separado 
por un punto ":new.CAMPO" y ":old.CAMPO".

El acceso a estos campos depende del evento del disparador.

En un trigger disparado por un "insert", se puede acceder al campo ":new" unicamente, el campo ":old" contiene "null".

En una inserción se puede emplear ":new" para escribir nuevos valores en las columnas de la tabla.

En un trigger que se dispara con "update", se puede acceder a ambos campos. En una actualizacion, se pueden comparar 
los valores de ":new" y ":old".

En un trigger de borrado, unicamente se puede acceder al campo "old", ya que el campo ":new" no existe luego que el 
registro es eliminado, el campo ":new" contiene "null" y no puede ser modificado.

Los valores de "old" y "new" están disponibles en triggers after y before.

El valor de ":new" puede modificarse en un trigger before, es decir, se puede acceder a los nuevos valores antes que se 
ingresen en la tabla y cambiar los valores asignando a ":new.CAMPO" otro valor.

El valor de ":new" NO puede modificarse en un trigger after, esto es porque el trigger se activa luego que los valores 
de "new" se almacenaron en la tabla.

El campo ":old" nunca se modifica, sólo puede leerse.

Pueden usarse en una clásula "when" (que veremos posteriormente).

En el cuerpo el trigger, los campos "old" y "new" deben estar precedidos por ":" (dos puntos), pero si está en "when" no.

Veamos un ejemplo.

Creamos un trigger a nivel de fila que se dispara "antes" que se ejecute un "update" sobre el campo "precio" de la 
tabla "libros". En el cuerpo del disparador se debe ingresar en la tabla "control", el nombre del usuario que realizó la 
actualización, la fecha, el código del libro que ha sido modificado, el precio anterior y el nuevo:

 create or replace trigger tr_actualizar_precio_libros
 before update of precio
 on libros
 for each row
 begin
  insert into control values(user,sysdate,:new.codigo,:old.precio,:new.precio);
 end tr_actualizar_precio_libros;
 /
 
Cuando el trigger se dispare, antes de ingresar los valores a la tabla, almacenará en "control", además del nombre del 
usuario y la fecha, el precio anterior del libro y el nuevo valor.

El siguiente trigger debe controlar el precio que se está actualizando, si supera los 50 pesos, se debe redondear tal
valor a entero, hacia abajo (empleando "floor"), es decir, se modifica el valor ingresado accediendo a ":new.precio" 
asignándole otro valor:

 create or replace trigger tr_actualizar_precio_libros
 before update of precio
 on libros
 for each row
 begin
  if (:new.precio>50) then
   :new.precio:=floor(:new.precio);
  end if;
  insert into control values(user,sysdate,:new.codigo,:old.precio,:new.precio);
 end tr_actualizar_precio_libros;
 /
 
Si al actualizar el precio de un libro colocamos un valor superior a 50, con decimales, tal valor se redondea al entero más
cercano hacia abajo. Por ejemplo, si el nuevo valor es "54.99", se almacenará "54".

Podemos crear un disparador para múltiples eventos, que se dispare al ejecutar "insert", "update" y "delete" sobre "libros".
En el cuerpo del trigger se realiza la siguiente acción: se almacena el nombre del usuario, la fecha y los antiguos y viejos 
valores del campo "precio":

create or replace trigger tr_libros
 before insert or update or delete
 on libros
 for each row
 begin
  insert into control values(user,sysdate,:old.codigo,:old.precio,:new.precio);
 end tr_libros;
 /
 
Si ingresamos un registro, el campo ":old.codigo" y el campo ":old.precio" contendrán "null". Si realizamos una actualización 
del campo de un campo que no sea "precio", los campos ":old.precio" y ":new.precio" guardarán el mismo valor.

Si eliminamos un registro, el campo ":new.precio" contendrá "null".

Entonces, se puede acceder a los valores de ":new" y ":old" en disparadores a nivel de fila (no en disparadores a nivel de 
sentencia). Están disponibles en triggers after y before. Los valores de ":old" solamente pueden leerse, 
nunca modificarse. Los valores de ":new" pueden modificarse únicamente en triggers before (nunca en triggers after).
*/

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
  codigo number(6),
  precioanterior number(6,2),
  precionuevo number(6,2)
 );

 insert into libros values(100,'Uno','Richard Bach','Planeta',25);
 insert into libros values(103,'El aleph','Borges','Emece',28);
 insert into libros values(105,'Matematica estas ahi','Paenza','Nuevo siglo',12);
 insert into libros values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55);
 insert into libros values(145,'Alicia en el pais de las maravillas','Carroll','Planeta',35);
 
-- Creamos un trigger a nivel de fila que se dispara "antes" que se ejecute un "update" sobre el campo "precio" de la tabla 
-- "libros". En el cuerpo del disparador se debe ingresar en la tabla "control", el nombre del usuario que realizó la actualización,
-- la fecha, el código del libro que ha sido modificado, el precio anterior y el nuevo:

create or replace trigger tr_actualizar_precio_libros
before update of precio on libros
for each row
begin
insert into control values(user, sysdate, :new.codigo, :old.precio, :new.precio);
end tr_actualizar_precio_libros;
/

-- Cuando el trigger se dispare, antes de ingresar los valores a la tabla, almacenará en "control", además del nombre del 
-- usuario y la fecha, el precio anterior del libro y el nuevo valor.

-- Actualizamos el precio del libro con código 100:

update libros set precio = 30 where codigo = 100;

-- Veamos lo que se almacenó en "control" al dispararse el trigger:

select * from control;

-- Los campos "precioanterior" y "precionuevo" de la tabla "control" almacenaron los valores de ":old.precio" y ":new.precio" 
-- respectivamente.

-- Actualizamos varios registros:

update libros set precio = precio * 1.1 where editorial = 'Planeta';

-- Veamos lo que se almacenó en "control" al dispararse el trigger:

select * from control;

-- Los campos "precioanterior" y "precionuevo" de la tabla "control" almacenaron los valores de ":old.precio" y ":new.precio" 
-- respectivamente de cada registro afectado por la actualización.

-- Modificamos la editorial de un libro:

update libros set editorial = 'Sudamericana' where editorial = 'Planeta';

-- El trigger no se disparó, pues fue definido para actualizaciones del campo "precio" unicamente.

-- Verifiquémoslo:

select * from control;

-- Vamos a reemplazar el trigger anteriormente creado. Ahora el disparador "tr_actualizar_precio_libros" debe controlar el 
-- precio que se está actualizando, si supera los 50 pesos, se debe redondear tal valor a entero hacia abajo (empleando 
--"floor"), es decir, se modifica el valor ingresado accediendo a ":new.precio" asignándole otro valor:

 create or replace trigger tr_actualizar_precio_libros
 before update of precio
 on libros
 for each row
 begin
  if (:new.precio>50) then
   :new.precio:=floor(:new.precio);
  end if;
  insert into control values(user,sysdate,:new.codigo,:old.precio,:new.precio);
 end tr_actualizar_precio_libros;
 /

--Vaciamos la tabla "control":

 truncate table control;

-- Actualizamos el precio del libro con código 100:

 update libros set precio=54.99 where codigo=100;

-- Veamos cómo se actualizó tal libro en "libros":

 select *from libros where codigo=100;

-- El nuevo precio actualizado se redondeó a 54.

-- Veamos lo que se almacenó en "control" al dispararse el trigger:

 select *from control;
 
-- Los campos "precioanterior" y "precionuevo" de la tabla "control" almacenaron los valores de ":old.precio" y ":new.precio" 
-- respectivamente.

-- Truncamos la tabla "control" nuevamente:

 truncate table control;
 
-- Creamos un disparador para múltiples eventos, que se dispare al ejecutar "insert", "update" y "delete" sobre "libros". 
-- En el cuerpo del trigger se realiza la siguiente acción: se almacena el nombre del usuario, la fecha y los antiguos y viejos 
-- valores de "precio":

create or replace trigger tr_libros
 before insert or update or delete
 on libros
 for each row
 begin
  insert into control values(user,sysdate,:old.codigo,:old.precio,:new.precio);
 end tr_libros;
 /

-- Ingresamos un registro:

 insert into libros values (150,'El gato con botas','Anonimo','Emece',21);

-- Veamos lo que se almacenó en "control":

 select *from control;

-- La sentencia disparadora fue una inserción, por lo tanto, los campos ":old.codigo" y ":old.precio" contienen "null", así que 
-- en "codigo" y en "precioanterior" se almacena "null"; el único campo con valor diferente de "null" es "precionuevo" 
-- correspondiente al valor de ":new.precio".

-- Actualizamos el campo "precio" de un libro:

 update libros set precio=12 where codigo=103;

-- Veamos lo que se almacenó en "control":

 select *from control;

-- Analicemos: actualizamos el precio, por lo tanto, ninguno de los campos consultados contiene "null".

-- Actualizamos un campo diferente de "precio" de un libro:

 update libros set autor='J.L.Borges' where autor='Borges';

-- Veamos lo que se almacenó en "control":

 select *from control;

-- Actualizamos el autor, por lo tanto, los campos ":old.precio" y ":new.precio" son iguales.

-- Eliminamos un registro de "libros":

 delete from libros where codigo=100;

-- Veamos lo que se almacenó en "control":

 select *from control;

-- Analicemos: la sentencia que disparó el trigger fue un "delete", por lo tanto, el campo ":new.precio" contiene "null".

-- Veamos qué informa el diccionario "user_triggers" respecto del trigger anteriormente creado:

 select *from user_triggers where trigger_name ='TR_LIBROS';
 