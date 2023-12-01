/* 
Es importante, al dise�ar una base de datos y las tablas que contiene, tener en cuenta la integridad de los datos, 
esto significa que la informaci�n almacenada en las tablas debe ser v�lida, coherente y exacta.

Hasta el momento, hemos controlado y restringido la entrada de valores a un campo mediante el tipo de dato que le 
definimos (cadena, num�ricos, etc.), la aceptaci�n o no de valores nulos, el valor por defecto. Tambi�n hemos asegurado 
que cada registro de una tabla sea �nico definiendo una clave primaria y empleando secuencias.

Oracle ofrece m�s alternativas, adem�s de las aprendidas, para restringir y validar los datos, las veremos ordenadamente
y al finalizar haremos un resumen de las mismas.

Comenzamos por las restricciones.

Las restricciones (constraints) son un m�todo para mantener la integridad de los datos, asegurando que los valores 
ingresados sean v�lidos y que las relaciones entre las tablas se mantenga.

Las restricciones pueden establecerse a nivel de campo o de tabla.

Pueden definirse al crear la tabla ("create table") o agregarse a una tabla existente (empleando "alter table") y 
se pueden aplicar a un campo o a varios. Tambi�n es posible habilitarlas y deshabilitarlas.

Oracle ofrece varios tipos de restricciones:

- not null: a nivel de campo.

- primary key: a nivel de tabla. Es un campo o varios que identifican cada registro de una tabla.

- foreign key: a nivel de tabla. Establece que un campo (o varios) relacione una clave primaria de una tabla con otra.

- check: a nivel de tabla. Restringe los valores que pueden ingresarse en un campo especifico.

- unique: a nivel de tabla.

Se pueden crear, modificar y eliminar las restricciones sin eliminar la tabla y volver a crearla.

Para obtener informaci�n de las restricciones podemos consultar los cat�logos 
"all_objects", "all_constraints" y "all_cons_columns".

El cat�logo "all_constraints" retorna varias columnas, entre ellas: OWNER (propietario), CONSTRAINT_NAME 
(nombre de la restricci�n), CONSTRAINT_TYPE (tipo de restricci�n, si es primary key (P), foreign key (), unique (U), etc.), 
TABLE_NAME (nombre de la tabla), SEARCH_CONDITION (en caso de ser Check u otra), DELETE_RULE (), 
STATUS (estado), DEFERRABLE (), DEFERRED (), VALIDATED (), GENERATED (), INDEX_OWNER (), INDEX_NAME ().

El cat�logo "all_cons_columns" retorna las siguientes columnas: OWNER (propietario), CONSTRAINT_NAME (nombre), 
TABLE_NAME (nombre de la tabla), COLUMN_NAME (campo), POSITION (posici�n).

*/

select * from all_constraints;

select * from all_cons_columns;








