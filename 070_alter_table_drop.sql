/*
Vimos que "alter table" permite modificar la estructura de una tabla, agregando, modificando y eliminando campos.

Para eliminar campos de una tabla la sintaxis básica es la siguiente:

 alter table NOMBRETABLA
  drop column NOMBRECAMPO;
  
En el siguiente ejemplo eliminamos el campo "precio" de la tabla "libros":

 alter table libros
  drop column precio;
  
No pueden eliminarse los campos a los cuales hace referencia una restricción "foreign key".

Si eliminamos un campo que tiene una restricción "primary key", "unique", "check" o "foreign key", la restricción también se elimina.

Si eliminamos un campo indexado, el índice también se elimina.

NO puede eliminarse un campo si es el único en la tabla.
*/

