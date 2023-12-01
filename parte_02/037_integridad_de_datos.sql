/* 
Es importante, al diseñar una base de datos y las tablas que contiene, tener en cuenta la integridad de los datos, 
esto significa que la información almacenada en las tablas debe ser válida, coherente y exacta.

Hasta el momento, hemos controlado y restringido la entrada de valores a un campo mediante el tipo de dato que le 
definimos (cadena, numéricos, etc.), la aceptación o no de valores nulos, el valor por defecto. También hemos asegurado 
que cada registro de una tabla sea único definiendo una clave primaria y empleando secuencias.

Oracle ofrece más alternativas, además de las aprendidas, para restringir y validar los datos, las veremos ordenadamente
y al finalizar haremos un resumen de las mismas.

Comenzamos por las restricciones.

Las restricciones (constraints) son un método para mantener la integridad de los datos, asegurando que los valores 
ingresados sean válidos y que las relaciones entre las tablas se mantenga.

Las restricciones pueden establecerse a nivel de campo o de tabla.

Pueden definirse al crear la tabla ("create table") o agregarse a una tabla existente (empleando "alter table") y 
se pueden aplicar a un campo o a varios. También es posible habilitarlas y deshabilitarlas.

Oracle ofrece varios tipos de restricciones:

- not null: a nivel de campo.

- primary key: a nivel de tabla. Es un campo o varios que identifican cada registro de una tabla.

- foreign key: a nivel de tabla. Establece que un campo (o varios) relacione una clave primaria de una tabla con otra.

- check: a nivel de tabla. Restringe los valores que pueden ingresarse en un campo especifico.

- unique: a nivel de tabla.

Se pueden crear, modificar y eliminar las restricciones sin eliminar la tabla y volver a crearla.

Para obtener información de las restricciones podemos consultar los catálogos 
"all_objects", "all_constraints" y "all_cons_columns".

El catálogo "all_constraints" retorna varias columnas, entre ellas: OWNER (propietario), CONSTRAINT_NAME 
(nombre de la restricción), CONSTRAINT_TYPE (tipo de restricción, si es primary key (P), foreign key (), unique (U), etc.), 
TABLE_NAME (nombre de la tabla), SEARCH_CONDITION (en caso de ser Check u otra), DELETE_RULE (), 
STATUS (estado), DEFERRABLE (), DEFERRED (), VALIDATED (), GENERATED (), INDEX_OWNER (), INDEX_NAME ().

El catálogo "all_cons_columns" retorna las siguientes columnas: OWNER (propietario), CONSTRAINT_NAME (nombre), 
TABLE_NAME (nombre de la tabla), COLUMN_NAME (campo), POSITION (posición).

*/

select * from all_constraints;

select * from all_cons_columns;








