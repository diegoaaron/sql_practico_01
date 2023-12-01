-- existen varias funciones para operar registros, el tipo de dato del campo determina las funciones que se pueden emplear con ellas

/*
Las relaciones entre las funciones de agrupamiento y los tipos de datos es la siguiente:

- count: se puede emplear con cualquier tipo de dato.
- min y max: con cualquier tipo de dato.
- sum y avg: sólo en campos de tipo numérico.

A estas funciones se les denomina "de grupo" porque operan sobre un conjunto de registros, no con datos individuales.

Todas las funciones de grupo, excepto "count(*)", excluye los valores nulos de los campos;
"count(*)" cuenta todos los registros, incluidos los que contienen "null".

*/

drop table libros;

create table libros(
  codigo number(4) not null,
  titulo varchar2(40) not null,
  autor varchar2(30) default 'Desconocido',
  editorial varchar2(15),
  edicion date,
  precio number(5,2),
  cantidad number(3),
  primary key(codigo)
);
 
insert into libros values(1562,'El aleph','Borges','Planeta','10/10/1980',15,null);
insert into libros values(1878,'Martin Fierro','Jose Hernandez','Emece',null,22.20,200);
insert into libros values(2587,'Antologia poetica','J.L. Borges','Planeta',null,null,150);
insert into libros values(3654,'Aprenda PHP','Mario Molina',null,'05/05/1999',18.20,null);
insert into libros values(3921,'Cervantes y el quijote',default,'Paidos','15/02/2000',null,null);
insert into libros values(4582,'Manual de PHP', 'J.C. Paez', 'Siglo XXI','21/04/2005',31.80,120);
insert into libros values(5963,'Harry Potter y la piedra filosofal','J.K. Rowling',default,null,45.00,90);
insert into libros values(6211,'Harry Potter y la camara secreta','J.K. Rowling','Emece',null,0,100);
insert into libros values(8851,'Alicia en el pais de las maravillas','Lewis Carroll',null,null,null,220);
insert into libros values(9920,'PHP de la A a la Z',default,default,default,null,0);

-- Para conocer la cantidad total de libros, sumamos las cantidades de cada uno

select sum(cantidad) from libros;

-- Queremos saber cuántos libros tenemos de la editorial "Emece":

select sum(cantidad) from libros where editorial = 'Emece';

-- Queremos saber el precio del libro más costoso; usamos la función "max()":

select min(precio) from libros where autor like '%Rowling%';

-- Queremos saber el promedio del precio de los libros referentes a "PHP"

select avg(precio) from libros where titulo like '%PHP%';

-- Mínimo valor del campo edición

select min(edicion) from libros;

-- Necesitamos conocer el mayor valor de "codigo"

select max(codigo) from libros;

-- Ejercicio 1

drop table empleados;

create table empleados(
  nombre varchar2(30),
  documento char(8),
  domicilio varchar2(30),
  seccion varchar2(20),
  sueldo number(6,2),
  cantidadhijos number(2),
  fechaingreso date,
  primary key(documento)
);

insert into empleados values('Juan Perez','22333444','Colon 123','Gerencia',5000,2,'10/10/1980');
insert into empleados values('Ana Acosta','23444555','Caseros 987','Secretaria',2000,0,'15/08/1998');
insert into empleados values('Lucas Duarte','25666777','Sucre 235','Sistemas',4000,1,null);
insert into empleados values('Pamela Gonzalez','26777888','Sarmiento 873','Secretaria',2200,3,null);
insert into empleados values('Marcos Juarez','30000111','Rivadavia 801','Contaduria',3000,0,'26/08/2000');
insert into empleados values('Yolanda Perez','35111222','Colon 180','Administracion',3200,1,'25/09/2001');
insert into empleados values('Rodolfo Perez','35555888','Coronel Olmedo 588','Sistemas',4000,3,null);
insert into empleados values('Martina Rodriguez','30141414','Sarmiento 1234','Administracion',3800,4,'14/12/2000');
insert into empleados values('Andres Costa','28444555',default,'Secretaria',null,null,'08/08/1990');

-- Muestre la cantidad de empleados usando "count"

select count(nombre) from empleados;

-- Muestre la cantidad de empleados con fecha de ingreso conocida

select count(fechaingreso) from empleados;

-- Muestre la cantidad de empleados con sueldo

select count(sueldo) from empleados;

-- Muestre la cantidad de empleados con sueldo de la sección "Secretaria"

select count(sueldo) from empleados where seccion = 'Secretaria';

-- Muestre el sueldo más alto y el más bajo colocando un alias 

select max(sueldo) as "maximo", min(sueldo) as "minimo" from empleados;

-- Muestre el valor mayor de "cantidadhijos" de los empleados "Perez"

select max(cantidadhijos) from empleados where nombre like '%Perez%';

-- Muestre la fecha de ingreso más reciente (max) y la más lejana (min)

select max(fechaingreso) as "mas reciente", min(fechaingreso) as "mas lejana" from empleados;

-- Muestre el documento menor

select min(documento) from empleados;

-- Muestre el promedio de sueldos de todo los empleados

select avg(sueldo) from empleados;

-- Muestre el promedio de sueldos de los empleados de la sección "Secretaría"

select avg(sueldo) from empleados where seccion = 'Secretaria';

-- Muestre el promedio de hijos de todos los empleados de "Sistemas"

select avg(cantidadhijos) from empleados where seccion = 'Sistemas';

-- Muestre la cantidad de empleados, la cantidad de empleados con domicilio conocido, la suma de los hijos, 
-- el promedio de los sueldos y los valores mínimo y máximo del campo "fechaingreso" de todos los empleados.

select count(nombre) as "cant. empleados", count(domicilio) as "emp. domic. conocido", sum(cantidadhijos), 
avg(sueldo), min(fechaingreso), max(fechaingreso) from empleados;

-- Realice la misma consulta anterior pero ahora de los empleados de la sección "Recursos".

select count(nombre) as "cant. empleados", count(domicilio) as "emp. domic. conocido", sum(cantidadhijos), 
avg(sueldo), min(fechaingreso), max(fechaingreso) from empleados where seccion = 'Recursos';

commit;
