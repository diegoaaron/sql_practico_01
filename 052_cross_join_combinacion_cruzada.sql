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

