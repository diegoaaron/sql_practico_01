/*
Podemos usar "group by" y las funciones de agrupamiento con combinaciones de tablas.

Para ver la cantidad de libros de cada editorial consultando la tabla "libros" y "editoriales", tipeamos:

select nombre as editorial,
count(*) as cantidad
from editoriales e
join libros l
on codigoeditorial=e.codigo
group by e.nombre;

Las editoriales que no tienen libros no aparecen en la salida porque empleamos un "join".

Empleamos otra función de agrupamiento con "left join". Para conocer el mayor precio de los libros de cada editorial usamos la 
función "max()", hacemos un "left join" y agrupamos por nombre de la editorial:

select e.nombre as editorial,
max(precio) as "mayor precio"
from editoriales e
left join libros l
on codigoeditorial=e.codigo
group by nombre;

En la sentencia anterior, mostrará, para la editorial de la cual no haya libros, el valor "null", en la columna calculada.
*/

drop table libros;
drop table editoriales;

create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  codigoeditorial number(3),
  precio number(5,2),
  primary key(codigo)
);

create table editoriales(
  codigo number(3),
  nombre varchar2(20),
  primary key (codigo)
  );

insert into editoriales values(1,'Planeta');
insert into editoriales values(2,'Emece');
insert into editoriales values(3,'Siglo XXI');

insert into libros values(100,'El aleph','Borges',1,20);
insert into libros values(200,'Martin Fierro','Jose Hernandez',1,30);
insert into libros values(300,'Aprenda PHP','Mario Molina',3,50);
insert into libros values(400,'Uno','Richard Bach',3,15);
insert into libros values(500,'Java en 10 minutos',default,4,45);

-- Contamos la cantidad de libros de cada editorial consultando ambas tablas:
-- Note que las editoriales que no tienen libros no aparecen en la salida porque empleamos un "join".

select e.nombre as editorial,
count(*) as cantidad
from editoriales e
join libros l
on codigoeditorial = e.codigo
group by e.nombre;

-- Buscamos el libro más costoso de cada editorial con un "left join":
-- La sentencia muestra, para la editorial de la cual no haya libros, el valor "null" en la columna calculada.

select e.nombre as editorial,
max(precio) as "precio mayor"
from editoriales e
left join libros l
on codigoeditorial = e.codigo
group by e.nombre;





