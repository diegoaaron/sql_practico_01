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

-- Ejercicio 1

 drop table visitantes;
 drop table ciudades;

 create table visitantes(
  nombre varchar2(30),
  edad number(2),
  sexo char(1) default 'f',
  domicilio varchar2(30),
  codigociudad number(2),
  mail varchar(30),
  montocompra decimal (6,2)
 );

 create table ciudades(
  codigo number(2),
  nombre varchar(20)
 );
 

 insert into ciudades values(1,'Cordoba');
 insert into ciudades values(2,'Carlos Paz');
 insert into ciudades values(3,'La Falda');
 insert into ciudades values(4,'Cruz del Eje');

 insert into visitantes values ('Susana Molina', 35,'f','Colon 123', 1, null,59.80);
 insert into visitantes values ('Marcos Torres', 29,'m','Sucre 56', 1, 'marcostorres@hotmail.com',150.50);
 insert into visitantes values ('Mariana Juarez', 45,'f','San Martin 111',2,null,23.90);
 insert into visitantes values ('Fabian Perez',36,'m','Avellaneda 213',3,'fabianperez@xaxamail.com',0);
 insert into visitantes values ('Alejandra Garcia',28,'f',null,2,null,280.50);
 insert into visitantes values ('Gaston Perez',29,'m',null,5,'gastonperez1@gmail.com',95.40);
 insert into visitantes values ('Mariana Juarez',33,'f',null,2,null,90);


-- Cuente la cantidad de visitas por ciudad mostrando el nombre de la ciudad (3 filas)

select c.nombre,
count(*) as "cantidad"
from ciudades c
inner join visitantes v
on c. codigo = v.codigociudad
group by c.nombre;

-- Muestre el promedio de gastos de las visitas agrupados por ciudad y sexo (4 filas)

select c.nombre as "ciudad",
v.sexo,
avg(v.montocompra) as "promedio de compra"
from ciudades c
inner join visitantes v
on c. codigo = v.codigociudad
group by c.nombre,v.sexo;

-- Muestre la cantidad de visitantes con mail, agrupados por ciudad (3 filas)

select c.nombre as "ciudad",
count(v.mail) as "correos"
from ciudades c
inner join visitantes v
on c. codigo = v.codigociudad
group by c.nombre;

-- Obtenga el monto de compra más alto de cada ciudad (3 filas)

select c.nombre as "ciudad",
max(v.montocompra) as "max monto compra"
from ciudades c
inner join visitantes v
on c. codigo = v.codigociudad
group by c.nombre;

-- Realice la misma consulta anterior pero con "left join" (4 filas)
-- Note que aparece el monto "95,4" con valor nulo en el campo correspondiente a la ciudad, ya que ese registro tiene un valor 
-- inexistente en "ciudades".

select c.nombre as "ciudad",
max(v.montocompra) as "max monto compra"
from ciudades c
inner join visitantes v
on c. codigo = v.codigociudad
group by c.nombre;



