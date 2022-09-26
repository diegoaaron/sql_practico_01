/*
"alter table" permite modificar la estructura de una tabla. Podemos utilizarla para agregar, modificar y eliminar campos de una tabla.

Para agregar un nuevo campo a una tabla empleamos la siguiente sintaxis básica:

 alter table NOMBRETABLA
  add NOMBRENUEVOCAMPO DEFINICION;
  
En el siguiente ejemplo agregamos el campo "cantidad" a la tabla "libros", de tipo number(4), con el valor por defecto 
cero y que NO acepta valores nulos:

 alter table libros
  add cantidad number(4) default 0 not null;
Puede verificarse la alteración de la estructura de la tabla tipeando:

 describe libros;
 
Para agregar un campo "not null", la tabla debe estar vacía o debe especificarse un valor por defecto. Esto es sencillo de 
entender, ya que si la tabla tiene registros, el nuevo campo se llenaría con valores nulos; si no los admite, debe tener un valor 
por defecto para llenar tal campo en los registros existentes.
*/
