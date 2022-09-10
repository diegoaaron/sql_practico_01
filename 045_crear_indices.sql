/*

Dijimos que el objetivo de un indice es acelerar la recuperación de información y que es útil cuando la tabla contiene miles 
de registros, cuando se realizan operaciones de ordenamiento y agrupamiento, etc.

Es importante identificar el o los campos por los que sería útil crear un índice, aquellos campos por los cuales se 
realizan búsquedas con frecuencia: claves primarias, claves externas o campos que combinan tablas.

No se recomienda crear índices sobre campos que no se usan con frecuencia en consultas o en tablas muy pequeñas.

Para crear índices empleamos la instrucción "create index".

La sintaxis básica es la siguiente:

 create TIPOdeINDICE index NOMBREINDICE
on NOMBRETABLA(CAMPOS);

Los índices pueden ser: no únicos (los valores pueden estar repetidos) o únicos (los valores no pueden duplicarse). 
De modo predeterminado, si no se especifica el tipo de índice, se crea un no único.

*/
