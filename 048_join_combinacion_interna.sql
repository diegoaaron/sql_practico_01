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
combinar y c�mo

- cuando se combina informaci�n de varias tablas, es necesario especificar qu� registro de una tabla se combinar� con qu� registro de la otra tabla, con "on". Se debe especificar la condici�n para enlazarlas, es decir, el campo por el cual se combinar�n, que tienen en com�n. "on" hace coincidir registros de ambas tablas bas�ndose en el valor de tal campo, en el ejemplo, el campo "codigoeditorial" de "libros" y el campo "codigo" de "editoriales" son los que enlazar�n ambas tablas. Se emplean campos comunes, que deben tener tipos de datos iguales o similares.

La condicion de combinaci�n, es decir, el o los campos por los que se van a combinar (parte "on"), 
se especifica seg�n las claves primarias y externas.

Note que en la consulta, al nombrar el campo usamos el nombre de la tabla tambi�n. Cuando las tablas referenciadas 
tienen campos con igual nombre, esto es necesario para evitar confusiones y ambiguedades al momento de referenciar
un campo. En el ejemplo, si no especificamos "editoriales.codigo" y solamente tipeamos "codigo", Oracle no sabr� si 
nos referimos al campo "codigo" de "libros" o de "editoriales" y mostrar� un mensaje de error indicando que "codigo" 
es ambiguo.

Entonces, si las tablas que combinamos tienen nombres de campos iguales, DEBE especificarse a qu� tabla pertenece 
anteponiendo el nombre de la tabla al nombre del campo, separado por un punto (.).

Si una de las tablas tiene clave primaria compuesta, al combinarla con la otra, en la cl�usula "on" se debe
hacer referencia a la clave completa, es decir, la condici�n referenciar� a todos los campos clave que identifican al registro.

Se puede incluir en la consulta join la cl�usula "where" para restringir los registros que retorna el resultado; 
tambi�n "order by", "distinct", etc..

Se emplea este tipo de combinaci�n para encontrar registros de la primera tabla que se correspondan con 
los registros de la otra, es decir, que cumplan la condici�n del "on". Si un valor de la primera tabla no se encuentra
en la segunda tabla, el registro no aparece; si en la primera tabla el valor es nulo, tampoco aparece.

Para simplificar la sentencia podemos usar un alias para cada tabla:

select l.codigo,titulo,autor,nombre
from libros l
join editoriales e
on l.codigoeditorial=e.codigo;
  
En algunos casos (como en este ejemplo) el uso de alias es para fines de simplificaci�n y hace m�s legible la consulta 
si es larga y compleja, pero en algunas consultas es absolutamente necesario.
*/



