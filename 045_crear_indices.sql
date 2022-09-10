/*

Dijimos que el objetivo de un indice es acelerar la recuperaci�n de informaci�n y que es �til cuando la tabla contiene miles 
de registros, cuando se realizan operaciones de ordenamiento y agrupamiento, etc.

Es importante identificar el o los campos por los que ser�a �til crear un �ndice, aquellos campos por los cuales se 
realizan b�squedas con frecuencia: claves primarias, claves externas o campos que combinan tablas.

No se recomienda crear �ndices sobre campos que no se usan con frecuencia en consultas o en tablas muy peque�as.

Para crear �ndices empleamos la instrucci�n "create index".

La sintaxis b�sica es la siguiente:

 create TIPOdeINDICE index NOMBREINDICE
on NOMBRETABLA(CAMPOS);

Los �ndices pueden ser: no �nicos (los valores pueden estar repetidos) o �nicos (los valores no pueden duplicarse). 
De modo predeterminado, si no se especifica el tipo de �ndice, se crea un no �nico.

*/
