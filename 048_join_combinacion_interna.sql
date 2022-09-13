/*
Un join es una operaci�n que relaciona dos o m�s tablas para obtener un resultado que incluya datos 
(campos y registros) de ambas; las tablas participantes se combinan seg�n los campos comunes a ambas tablas.

Hay tres tipos de combinaciones:

1) combinaciones internas (inner join o join),
2) combinaciones externas y
3) combinaciones cruzadas.
Tambi�n es posible emplear varias combinaciones en una consulta "select", incluso puede combinarse una
tabla consigo misma.

La combinaci�n interna emplea "join", que es la forma abreviada de "inner join". Se emplea para obtener 
informaci�n de dos tablas y combinar dicha informaci�n en una salida.

La sintaxis b�sica es la siguiente:

select CAMPOS
  from TABLA1
  join TABLA2
  on CONDICIONdeCOMBINACION;

Ejemplo:

select *from libros
join editoriales
on codigoeditorial=editoriales.codigo;

Analicemos la consulta anterior.

- especificamos los campos que aparecer�n en el resultado en la lista de selecci�n;

- indicamos el nombre de la tabla luego del "from" ("libros");

- combinamos esa tabla con "join" y el nombre de la otra tabla ("editoriales"); se especifica qu� tablas se van a 
combinar y c�mo;

*/



