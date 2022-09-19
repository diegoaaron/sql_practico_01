/*
Hemos aprendido que existen varios tipos de combinaciones en Oracle:

1) combinaciones internas (inner join o simplemente join),
2) combinaciones externas (left join, right join y full join)
3) combinaciones cruzadas (cross join).

También vimos que es posible emplear varios tipos de combinaciones en una consulta, incluso puede combinarse una tabla 
consigo misma.

Existen otros tipos de "join" en Oracle, que veremos rápidamente, ya que se resuelven con los que vimos anteriormente, 
básicamente lo que cambia es la sintaxis.

1) combinación natural: realiza un join entre dos tablas cuando los campos por los cuales se enlazan tienen el mismo nombre. 
Involucra claves primarias y foráneas.

Sintaxis:

select CAMPOS 
from TABLA1
natural join TABLA2; 

Ejemplo:

select titulo,nombre as editorial
from libros
natural join
editoriales;

En el ejemplo anterior la tabla "libros" combina su campo "codigoeditorial" con el campo "codigoeditorial" de "editoriales". 
La cláusula "on" no aparece, este "join" no necesita condición de enlace porque Oracle busca los campos con nombres 
iguales de ambas tablas (ambas tablas deben tener un único campo con idéntico nombre, si tiene más de un campo con igual 
nombre, Oracle no podrá realizar el enlace y mostrará un mensaje de error).

2) combinación empleando la cláusula "using": permite especificar el campo (o los campos) por el cual se enlazarán las 
tablas; los campos de ambas tablas DEBEN tener el mismo nombre y ser de tipos compatibles.

Sintaxis:

select CAMPOS
from TABLA1
join TABLA2
using (CAMPOenCOMUN);

Ejemplo:

 select titulo,nombre as editorial
  from libros
  join editoriales
  using (codigoeditorial);

En el ejemplo anterior la tabla "libros" combina su campo "codigoeditorial" con el campo "codigoeditorial" de "editoriales". 
La cláusula "on" no aparece, es reemplazada por "using" seguido del nombre del campo en común por el cual se enlazan.

3) combinación izquierda empleando "join" y el operador o modificador "(+)": Podemos obtener el mismo resultado que 
un "left join" empleando "join" y el modificador "(+)", con lo cual se indica que se consideran los registros con valor nulo. 
La sintaxis es la siguiente:

select CAMPOS
from TABLA1
join TABLA2
on CAMPOTABLA1=CAMPOTABLA2(+);

Es decir, se coloca el modificador "(+)" luego del campo de la tabla de la derecha para indicar que se incluyan los que tienen
valor nulo.

Las siguientes consultas retornan el mismo resultado. Una de ellas emplea "left join" y la otra un "join" con el modificador "(+)":

select titulo,nombre as editorial
from libros l
left join editoriales l
on l.codigoeditorial = e.codigoeditorial;

select titulo,nombre as editorial
from libros l
join editoriales e
on l.codigoeditorial = e.codigoeditorial(+);

Ambas mostrarán el título y nombre de la editorial; los libros cuyo código de editorial no esté presente en "editoriales" 
aparecerán con el valor "null" en la columna "editorial".

4) combinación derecha empleando "join" y el modificador "(+)": de modo similar al anterior, podemos obtener el mismo 
resultado que un "right join" empleando "join" y el modificador "(+)", con lo cual se indica que se consideren los registros 
con valor nulo. La sintaxis es la siguiente:

select CAMPOS
from TABLA1
join TABLA2
on CAMPOTABLA1(+)=CAMPOTABLA2;

Entonces, se coloca el modificador "(+)" luego del campo de la tabla de la izquierda para indicar que se incluyan los que 
tienen valor nulo.

Las siguientes consultas retornan el mismo resultado. Una de ellas emplea "right join"· y la otra un "join" con el modificador "(+)":

select titulo,nombre as editorial
from editoriales e
right join libros l
on e.codigoeditorial = l.codigoeditorial;

select titulo,nombre as editorial
from editoriales e
join libros l
on e.codigoeditorial(+) = l.codigoeditorial;

Ambas mostrarán el título y nombre de la editorial; las editoriales que no encuentran coincidencia en "libros", aparecen 
con el valor "null" en la columna "titulo".

Si la condición de combinación es compuesta (más de un campo), DEBE colocarse el modificador "(+)" en todos los campos 
que forman parte del enlace.

No se puede colocar el modificador en campos de distintas tablas. La siguiente combinación producirá un mensaje de error:

select titulo,nombre as editorial
from libros l
join editoriales e
on l.codigoeditorial(+)= e.codigoeditorial(+);
*/

 drop table libros;
 drop table editoriales;

 create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  codigoeditorial number(3)
 );
 create table editoriales(
  codigoeditorial number(3),
  nombre varchar2(20)
);

 insert into editoriales values(1,'Planeta');
 insert into editoriales values(2,'Emece');
 insert into editoriales values(3,'Siglo XXI');
 insert into editoriales values(null,'Norma');

 insert into libros values(100,'El aleph','Borges',1);
 insert into libros values(101,'Martin Fierro','Jose Hernandez',1);
 insert into libros values(102,'Aprenda PHP','Mario Molina',2);
 insert into libros values(103,'Java en 10 minutos',null,4);
 insert into libros values(104,'El anillo del hechicero','Carol Gaskin',null);

-- Realizamos un natural join entre las dos tablas
-- En el ejemplo anterior la tabla "libros" combina su campo "codigoeditorial" con el campo "codigoeditorial" de "editoriales".

select titulo, nombre as editorial
from libros
natural join editoriales;

-- Realizamos una combinación empleando la cláusula "using"
-- En el ejemplo anterior la tabla "libros" combina su campo "codigoeditorial" con el campo "codigoeditorial" de "editoriales".

select titulo, nombre as editorial
from libros
join editoriales 
using (codigoeditorial);

-- Realizamos una combinación izquierda y luego un "join" con el modificador "(+)"; ambas consultas retornan el mismo resultado
-- Ambas mostrarán el título y nombre de la editorial; los libros cuyo código de editorial no esté presente en "editoriales" 
-- aparecerán con el valor "null" en la columna "editorial".

select titulo, nombre as editorial
from libros l
left join editoriales e
on l.codigoeditorial = e.codigoeditorial;

select titulo, nombre as editorial
from libros l
join editoriales e
on l.codigoeditorial = e.codigoeditorial(+);

-- Realizamos una combinación derecha y luego obtenemos el mismo resultado empleando "join" y el modificador "(+)"
-- Ambas mostrarán el título y nombre de la editorial; las editoriales que no encuentran coincidencia en "libros", 
-- aparecen con el valor "null" en la columna "titulo".

select titulo, nombre as editorial
from editoriales e
right join libros l
on e.codigoeditorial = l.codigoeditorial;

select titulo, nombre as editorial
from editoriales e
join libros l
on e.codigoeditorial(+) = l.codigoeditorial;

-- Si intentamos emplear el modificador en campos de distintas tablas Oracle mostrará un mensaje de error:

select titulo, nombre as editorial
from libros l
join editoriales e
on l.codigoeditorial(+) = e.codigoeditorial(+);

-- Ejercicio 1

 drop table clientes;
 drop table provincias;

 create table clientes (
  codigo number(5),
  nombre varchar2(30),
  domicilio varchar2(30),
  ciudad varchar2(20),
  codigoprovincia number(2)
 );

create table provincias(
  codigoprovincia number(2),
  nombre varchar2(20)
);
 
  insert into provincias values(1,'Cordoba');
 insert into provincias values(2,'Santa Fe');
 insert into provincias values(3,'Corrientes');
 insert into provincias values(null,'Salta');

 insert into clientes values (100,'Lopez Marcos','Colon 111','Córdoba',1);
 insert into clientes values (101,'Perez Ana','San Martin 222','Cruz del Eje',1);
 insert into clientes values (102,'Garcia Juan','Rivadavia 333','Villa Maria',1);
 insert into clientes values (103,'Perez Luis','Sarmiento 444','Rosario',2);
 insert into clientes values (104,'Gomez Ines','San Martin 666','Santa Fe',2);
 insert into clientes values (105,'Torres Fabiola','Alem 777','La Plata',4);
 insert into clientes values (106,'Garcia Luis','Sucre 475','Santa Rosa',null);
 
 -- Muestre todos los datos de los clientes, incluido el nombre de la provincia empleando un "left join" (7 filas)
 
  select c.nombre,domicilio,ciudad, p.nombre as provincia
  from clientes c
  left join provincias p
  on c.codigoprovincia = p.codigoprovincia;
 
-- Obtenga la misma salida que la consulta anterior pero empleando un "join" con el modificador (+)
-- Note que en los puntos 3 y 4, los registros "Garcia Luis" y "Torres Fabiola" aparecen aunque no encuentran 
-- coincidencia en "provincias", mostrando "null" en la columna "provincia".

 select c.nombre,domicilio,ciudad, p.nombre as provincia
  from clientes c
  join provincias p
  on c.codigoprovincia = p.codigoprovincia(+);

-- Muestre todos los datos de los clientes, incluido el nombre de la provincia empleando un "right join" para que 
-- las provincias de las cuales no hay clientes también aparezcan en la consulta (7 filas)

  select c.nombre,domicilio,ciudad, p.nombre as provincia
  from provincias p
  right join clientes c
  on c.codigoprovincia = p.codigoprovincia;

-- Obtenga la misma salida que la consulta anterior pero empleando un "join" con el modificador (+)
-- Note que en los puntos 5 y 6, las provincias "Salta" y "Corrientes" aparecen aunque no encuentran coincidencia en 
-- "clientes", mostrando "null" en todos los campos de tal tabla.

  select c.nombre,domicilio,ciudad, p.nombre as provincia
  from provincias p
  join clientes c
  on c.codigoprovincia(+) = p.codigoprovincia;

-- Intente realizar un natural join entre ambas tablas mostrando el nombre del cliente, la ciudad y nombre de la provincia 
-- (las tablas tienen 2 campos con igual nombre "codigoprovincia" y "nombre"; mensaje de error)

 select c.nombre,ciudad,p.nombre as provincia
  from clientes c
  natural join
  provincias p;

-- Realice una combinación entre ambas tablas empleando la cláusula "using" (5 filas)
 
 select c.nombre,ciudad,p.nombre as provincia
  from clientes c
join provincias p
using(codigoprovincia);

 -- Ejercicio 2
 
 
 
 
 