/*
Un join es una operación que relaciona dos o más tablas para obtener un resultado que incluya datos 
(campos y registros) de ambas; las tablas participantes se combinan según los campos comunes a ambas tablas.

Hay tres tipos de combinaciones:

1) combinaciones internas (inner join o join),
2) combinaciones externas y
3) combinaciones cruzadas.
También es posible emplear varias combinaciones en una consulta "select", incluso puede combinarse una
tabla consigo misma.

La combinación interna emplea "join", que es la forma abreviada de "inner join". Se emplea para obtener 
información de dos tablas y combinar dicha información en una salida.

La sintaxis básica es la siguiente:

select CAMPOS
  from TABLA1
  join TABLA2
  on CONDICIONdeCOMBINACION;

Ejemplo:

select *from libros
join editoriales
on codigoeditorial=editoriales.codigo;

Analicemos la consulta anterior.

- especificamos los campos que aparecerán en el resultado en la lista de selección;

- indicamos el nombre de la tabla luego del "from" ("libros");

- combinamos esa tabla con "join" y el nombre de la otra tabla ("editoriales"); se especifica qué tablas se van a 
combinar y cómo;

*/



