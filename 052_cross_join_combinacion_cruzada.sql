/*
Vimos que hay tres tipos de combinaciones: 

1) combinaciones internas (join) 

2) combinaciones externas (left, outer y full join)

3) combinaciones cruzadas.

Las combinaciones cruzadas (cross join) muestran todas las combinaciones de todos los registros de las 
tablas combinadas. Para este tipo de join no se incluye una condici�n de enlace. Se genera el producto cartesiano 
en el que el n�mero de filas del resultado es igual al n�mero de registros de la primera tabla multiplicado por el n�mero 
de registros de la segunda tabla, es decir, si hay 3 registros en una tabla y 4 en la otra, retorna 12 filas.

La sintaxis b�sica es �sta:

select CAMPOS
from TABLA1
cross join TABLA2;

Veamos un ejemplo. Un peque�o restaurante almacena los nombres y precios de sus comidas en una tabla llamada 
"comidas" y en una tabla denominada "postres" los mismos datos de sus postres.
Si necesitamos conocer todas las combinaciones posibles para un men�, cada comida con cada postre, empleamos 
un "cross join":

select c.nombre as "plato principal", p.nombre as "postre"
from comidas c
cross join postres p;

La salida muestra cada plato combinado con cada uno de los postres.

Como cualquier tipo de "join", puede emplearse una cl�usula "where" que condicione la salida.

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
 
 -- El restaurante quiere combinar los registros de ambas tablas para mostrar los distintos men�es que ofrece. Lo hacemos 
 -- usando un "cross join"
 
 -- La salida muestra cada plato combinado con cada uno de los postres y el precio total de cada men�. Se obtienen 8 registros

select c.nombre as "plato principal",
p.nombre as "postre"
from comidas c
cross join postres p;
 
 