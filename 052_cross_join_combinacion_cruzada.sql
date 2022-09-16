/*
Vimos que hay tres tipos de combinaciones: 

1) combinaciones internas (join) 

2) combinaciones externas (left, outer y full join)

3) combinaciones cruzadas.

Las combinaciones cruzadas (cross join) muestran todas las combinaciones de todos los registros de las 
tablas combinadas. Para este tipo de join no se incluye una condición de enlace. Se genera el producto cartesiano 
en el que el número de filas del resultado es igual al número de registros de la primera tabla multiplicado por el número 
de registros de la segunda tabla, es decir, si hay 3 registros en una tabla y 4 en la otra, retorna 12 filas.

La sintaxis básica es ésta:

select CAMPOS
from TABLA1
cross join TABLA2;

Veamos un ejemplo. Un pequeño restaurante almacena los nombres y precios de sus comidas en una tabla llamada 
"comidas" y en una tabla denominada "postres" los mismos datos de sus postres.
Si necesitamos conocer todas las combinaciones posibles para un menú, cada comida con cada postre, empleamos 
un "cross join":

select c.nombre as "plato principal", p.nombre as "postre"
from comidas c
cross join postres p;

La salida muestra cada plato combinado con cada uno de los postres.

Como cualquier tipo de "join", puede emplearse una cláusula "where" que condicione la salida.

Este tipo de join no es muy utilizado.
*/

drop table comidas;
drop table postres;
 
create table comidas(
  codigo number(2),
  nombre varchar2(30),
  precio number(4,2)
);

create table postres(
  codigo number(2),
  nombre varchar2(30),
  precio number(4,2)
);
 
  insert into comidas values(1,'ravioles',5);
 insert into comidas values(2,'tallarines',4);
 insert into comidas values(3,'milanesa',7);
 insert into comidas values(4,'cuarto de pollo',6);

 insert into postres values(1,'flan',2.5);
 insert into postres values(2,'porcion torta',3.5);
 
 -- El restaurante quiere combinar los registros de ambas tablas para mostrar los distintos menúes que ofrece. Lo hacemos 
 -- usando un "cross join"
 
 -- La salida muestra cada plato combinado con cada uno de los postres y el precio total de cada menú. Se obtienen 8 registros

select c.nombre as "plato principal",
p.nombre as "postre"
from comidas c
cross join postres p;

-- Ejercicio 1

drop table mujeres;
drop table varones;

create table mujeres(
  nombre varchar2(30),
  domicilio varchar2(30),
  edad number(2)
);

create table varones(
  nombre varchar2(30),
  domicilio varchar2(30),
  edad number(2)
);
 
insert into mujeres values('Maria Lopez','Colon 123',45);
insert into mujeres values('Liliana Garcia','Sucre 456',35);
insert into mujeres values('Susana Lopez','Avellaneda 98',41);

insert into varones values('Juan Torres','Sarmiento 755',44);
insert into varones values('Marcelo Oliva','San Martin 874',56);
insert into varones values('Federico Pereyra','Colon 234',38);
insert into varones values('Juan Garcia','Peru 333',50);
 
 -- La agencia necesita la combinación de todas las personas de sexo femenino con las de sexo masculino. 
 -- Use un "cross join" (12 filas)
 
 select m.nombre, v.nombre 
 from mujeres m
 cross join varones v;
 
 -- Realice la misma combinación pero considerando solamente las personas mayores de 40 años (6 filas)
 
select m.nombre, v.nombre 
 from mujeres m
 cross join varones v
 where m.edad > 40 and v.edad > 40;
 
 -- Forme las parejas pero teniendo en cuenta que no tengan una diferencia superior a 10 años (8 filas)
 
select m.nombre, v.nombre 
 from mujeres m
 cross join varones v
 where m.edad -  v.edad  between -10 and 10;
 
-- Ejercicio 2 

drop table guardias;
drop table tareas;

create table guardias(
  documento char(8),
  nombre varchar2(30),
  sexo char(1), /* 'f' o 'm' */
  domicilio varchar2(30),
  primary key (documento)
);

create table tareas(
  codigo number(2),
  domicilio varchar2(30),
  descripcion varchar2(30),
  horario char(2), /* 'AM' o 'PM'*/
  primary key (codigo)
);

insert into guardias values('22333444','Juan Perez','m','Colon 123');
insert into guardias values('24333444','Alberto Torres','m','San Martin 567');
insert into guardias values('25333444','Luis Ferreyra','m','Chacabuco 235');
insert into guardias values('23333444','Lorena Viale','f','Sarmiento 988');
insert into guardias values('26333444','Irma Gonzalez','f','Mariano Moreno 111');

insert into tareas values(1,'Colon 1111','vigilancia exterior','AM');
insert into tareas values(2,'Urquiza 234','vigilancia exterior','PM');
insert into tareas values(3,'Peru 345','vigilancia interior','AM');
insert into tareas values(4,'Avellaneda 890','vigilancia interior','PM');
 
-- La empresa quiere que todos sus empleados realicen todas las tareas. Realice un "cross join" (20 filas)

select g.nombre, t.descripcion
from guardias g
cross join tareas t;


-- En este caso, la empresa quiere que todos los guardias de sexo femenino realicen las tareas de "vigilancia interior" 
-- y los de sexo masculino de "vigilancia exterior". Realice una "cross join" con un "where" que controle tal requisito (10 filas)

select g.nombre, t.descripcion
from guardias g
cross join tareas t
where (g.sexo = 'f' and t.descripcion = 'vigilancia interior') or (g.sexo='m' and t.descripcion='vigilancia exterior');

