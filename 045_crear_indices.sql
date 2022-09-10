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

Si se intenta crear un �ndice �nico para un campo que tiene valores duplicados, Oracle no lo permite.

Los campos de tipo "long" y "long raw" no pueden indexarse.

*/

-- En el siguiente ejemplo creamos un �ndice �nico sobre el campo "documento" de la tabla "empleados":

create unique index I_EMPLEADOS_DOCUMENTO
on empleados (documento);

-- Una tabla puede indexarse por un campo (o varios). Podemos crear un indice compuesto para los campos "apellido" y "nombre"

create index I_EMPLEADOS_APELLIDONOMBRE
on empleados(apellido, nombre);

select * from empleados;

-- Cuando creamos una restricci�n "primary key" o "unique" sobre una tabla, Oracle autom�ticamente crea un �ndice 
-- sobre el campo (o los campos) de la restricci�n y le da el mismo nombre que la restricci�n. En caso que la tabla ya tenga 
-- un �ndice, Oracle lo usa, no crea otro.

/*
Para obtener informaci�n sobre los �ndices podemos consultar varios diccionarios.

1) "user_indexes": nos muestra las siguientes columnas (entre otras que no analizaremos):

 - INDEX_NAME (nombre del �ndice),
 - INDEX_TYPE (tipo de �ndice, nosotros crearemos el stardart normal),
 - TABLE_NAME (nombre de la tabla),
 - UNIQUENESS (si es �nico o no).

2) "user_ind_columns": nos muestra las siguientes columnas (entre otras que no analizaremos):

 - INDEX_NAME (nombre del �ndice),
 - TABLE_NAME (nombre de la tabla),
 - COLUMN_NAME (nombre del campo),
 - COLUMN_POSITION (posici�n del campo),

3) "user_objects": en la columna "OBJECT_TYPE" muestra "index" si es un �ndice.

4) "user_constraints": si la restricci�n tiene un �ndice asociado, aparece su nombre en la columna "INDEX_NAME".
*/


