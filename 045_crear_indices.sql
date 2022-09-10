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

Si se intenta crear un índice único para un campo que tiene valores duplicados, Oracle no lo permite.

Los campos de tipo "long" y "long raw" no pueden indexarse.

*/

-- En el siguiente ejemplo creamos un índice único sobre el campo "documento" de la tabla "empleados":

create unique index I_EMPLEADOS_DOCUMENTO
on empleados (documento);

-- Una tabla puede indexarse por un campo (o varios). Podemos crear un indice compuesto para los campos "apellido" y "nombre"

create index I_EMPLEADOS_APELLIDONOMBRE
on empleados(apellido, nombre);

select * from empleados;

-- Cuando creamos una restricción "primary key" o "unique" sobre una tabla, Oracle automáticamente crea un índice 
-- sobre el campo (o los campos) de la restricción y le da el mismo nombre que la restricción. En caso que la tabla ya tenga 
-- un índice, Oracle lo usa, no crea otro.

/*
Para obtener información sobre los índices podemos consultar varios diccionarios.

1) "user_indexes": nos muestra las siguientes columnas (entre otras que no analizaremos):

 - INDEX_NAME (nombre del índice),
 - INDEX_TYPE (tipo de índice, nosotros crearemos el stardart normal),
 - TABLE_NAME (nombre de la tabla),
 - UNIQUENESS (si es único o no).

2) "user_ind_columns": nos muestra las siguientes columnas (entre otras que no analizaremos):

 - INDEX_NAME (nombre del índice),
 - TABLE_NAME (nombre de la tabla),
 - COLUMN_NAME (nombre del campo),
 - COLUMN_POSITION (posición del campo),

3) "user_objects": en la columna "OBJECT_TYPE" muestra "index" si es un índice.

4) "user_constraints": si la restricción tiene un índice asociado, aparece su nombre en la columna "INDEX_NAME".
*/


