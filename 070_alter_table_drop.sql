/*
Vimos que "alter table" permite modificar la estructura de una tabla, agregando, modificando y eliminando campos.

Para eliminar campos de una tabla la sintaxis b�sica es la siguiente:

 alter table NOMBRETABLA
  drop column NOMBRECAMPO;
  
En el siguiente ejemplo eliminamos el campo "precio" de la tabla "libros":

 alter table libros
  drop column precio;
  
No pueden eliminarse los campos a los cuales hace referencia una restricci�n "foreign key".

Si eliminamos un campo que tiene una restricci�n "primary key", "unique", "check" o "foreign key", la restricci�n tambi�n se elimina.

Si eliminamos un campo indexado, el �ndice tambi�n se elimina.

NO puede eliminarse un campo si es el �nico en la tabla.
*/

