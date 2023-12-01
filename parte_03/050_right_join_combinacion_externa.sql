/*
Vimos que una combinación externa izquierda (left join) encuentra registros de la tabla izquierda que se correspondan 
con los registros de la tabla derecha y si un valor de la tabla izquierda no se encuentra en la tabla derecha, el registro 
muestra los campos correspondientes a la tabla de la derecha seteados a "null".

Una combinación externa derecha ("right outer join" o "right join") opera del mismo modo sólo que la tabla derecha es la 
que localiza los registros en la tabla izquierda.

En el siguiente ejemplo solicitamos el título y nombre de la editorial de los libros empleando un "right join":

select titulo,nombre as editorial
from libros l
right join editoriales e
on codigoeditorial = e.codigo;

El resultado mostrará el título y nombre de la editorial; las editoriales de las cuales no hay libros, es decir, cuyo código 
de editorial no está presente en "libros" aparece en el resultado, pero con el valor "null" en el campo "titulo".

Es FUNDAMENTAL tener en cuenta la posición en que se colocan las tablas en los "outer join". En un "left join" 
la primera tabla (izquierda) es la que busca coincidencias en la segunda tabla (derecha); en el "right join" la segunda 
tabla (derecha) es la que busca coincidencias en la primera tabla (izquierda).

En la siguiente consulta empleamos un "left join" para conseguir el mismo resultado que el "right join" anterior":

select titulo,nombre
from editoriales e
left join libros l
on codigoeditorial = e.codigo;

Note que la tabla que busca coincidencias ("editoriales") está en primer lugar porque es un "left join"; en el "right join" 
precedente, estaba en segundo lugar.

Un "right join" hace coincidir registros en una tabla (derecha) con otra tabla (izquierda); si un valor de la tabla de la derecha 
no encuentra coincidencia en la tabla izquierda, se genera una fila extra (una por cada valor no encontrado) con todos los 
campos correspondientes a la tabla izquierda seteados a "null". La sintaxis básica es la siguiente:

select CAMPOS
from TABLAIZQUIERDA
right join TABLADERECHA
on CONDICION;

Un "right join" también puede tener cláusula "where" que restringa el resultado de la consulta considerando solamente 
los registros que encuentran coincidencia en la tabla izquierda:

select titulo,nombre
from libros l
right join editoriales e
on e.codigo=codigoeditorial
where codigoeditorial is not null;

Mostramos las editoriales que NO están presentes en "libros", es decir, que NO encuentran coincidencia en la tabla de la 
derecha empleando un "right join":

select titulo,nombre
from libros l
right join editoriales e
on e.codigo=codigoeditorial
where codigoeditorial is null;

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
  codigo number(3),
  nombre varchar2(20)
);

alter table libros
add constraint PK_libros
primary key(codigo);

alter table editoriales
add constraint PK_editoriales
primary key(codigo);

insert into editoriales values(1,'Planeta');
insert into editoriales values(2,'Emece');
insert into editoriales values(3,'Siglo XXI');
insert into editoriales values(4,'Norma');

insert into libros values(100,'El aleph','Borges',1);
insert into libros values(101,'Martin Fierro','Jose Hernandez',1);
insert into libros values(102,'Aprenda PHP','Mario Molina',2);
insert into libros values(103,'Java en 10 minutos',null,4);
insert into libros values(104,'El anillo del hechicero','Carol Gaskin',4);

-- Solicitamos el título y nombre de la editorial de los libros empleando un "right join"
-- Las editoriales de las cuales no hay libros, es decir, cuyo código de editorial no está presente en "libros" aparece 
-- en el resultado, pero con el valor "null" en el campo "titulo"; caso de la editorial "Siglo XXI".

select titulo, nombre as editorial
from libros l
right join editoriales e
on l.codigoeditorial = e.codigo;

-- Realizamos la misma consulta anterior agregando un "where" que restringa el resultado considerando solamente los 
-- registros que encuentran coincidencia en la tabla izquierda:
-- Ya no aparece la editorial "Siglo XXI".

select titulo, nombre as editorial
from libros l
right join editoriales e
on l.codigoeditorial = e.codigo
where l.codigoeditorial is not null;

-- Mostramos las editoriales que NO están presentes en "libros" (que NO encuentran coincidencia en "editoriales"):
-- Solamente aparece la editorial "Siglo XXI".

select nombre
from libros l
right join editoriales e
on l.codigoeditorial = e.codigo
where l.codigoeditorial is null;

-- Ejercicio 1

 drop table clientes;
 drop table provincias;

 create table clientes (
  codigo number(5),
  nombre varchar2(30),
  domicilio varchar2(30),
  ciudad varchar2(20),
  codigoprovincia number(2),
  primary key(codigo)
 );

 create table provincias(
  codigo number(2),
  nombre varchar2(20),
  primary key (codigo)
 );

 insert into provincias values(1,'Cordoba');
 insert into provincias values(2,'Santa Fe');
 insert into provincias values(3,'Corrientes');

 insert into clientes values (101,'Lopez Marcos','Colon 111','Córdoba',1);
 insert into clientes values (102,'Perez Ana','San Martin 222','Cruz del Eje',1);
 insert into clientes values (103,'Garcia Juan','Rivadavia 333','Villa Maria',1);
 insert into clientes values (104,'Perez Luis','Sarmiento 444','Rosario',2);
 insert into clientes values (105,'Gomez Ines','San Martin 666','Santa Fe',2);
 insert into clientes values (106,'Torres Fabiola','Alem 777','La Plata',4);
 insert into clientes values (107,'Garcia Luis','Sucre 475','Santa Rosa',5);

-- Muestre todos los datos de los clientes, incluido el nombre de la provincia empleando un "right join".
-- la segunda tabla (clientes) busca coincidencias en la primera (provincias) 

select c.codigo, c.nombre, domicilio, ciudad, p.nombre as provincia
from provincias p 
right join clientes c
on p.codigo = c.codigoprovincia;

-- Obtenga la misma salida que la consulta anterior pero empleando un "left join".

select c.codigo, c.nombre, domicilio, ciudad, p.nombre as provincia
from clientes c 
left join provincias p 
on  c.codigoprovincia = p.codigo;

-- Empleando un "right join", muestre solamente los clientes de las provincias que existen en "provincias" (5 registros)

select c.codigo, c.nombre, domicilio, ciudad, p.nombre as provincia
from provincias p 
right join clientes c
on  p.codigo = c.codigoprovincia 
where p.codigo is not null;

-- Muestre todos los clientes cuyo código de provincia NO existe en "provincias" ordenados por ciudad (2 registros)

select c.codigo, c.nombre, domicilio, ciudad, p.nombre as provincia
from provincias p 
right join clientes c
on  p.codigo = c.codigoprovincia 
where p.codigo is null
order by ciudad;

