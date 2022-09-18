/*
Podemos hacer un "join" con más de dos tablas.

La librería almacena los datos de sus libros en tres tablas: libros, editoriales y autores.

En la tabla "libros" un campo "codigoautor" hace referencia al autor y un campo "codigoeditorial" referencia la editorial.

Para recuperar todos los datos de los libros empleamos la siguiente consulta:

select titulo,a.nombre,e.nombre
from autores a
join libros l
on codigoautor=a.codigo
join editoriales e 
on codigoeditorial=e.codigo;
  
Analicemos la consulta anterior. Indicamos el nombre de la tabla luego del "from" ("autores"), combinamos esa tabla con la 
tabla "libros" especificando con "on" el campo por el cual se combinarán; luego debemos hacer coincidir los valores para el 
enlace con la tabla "editoriales" enlazándolas por los campos correspondientes. Utilizamos alias para una sentencia más 
sencilla y comprensible.

Note que especificamos a qué tabla pertenecen los campos cuyo nombre se repiten en las tablas, esto es necesario para 
evitar confusiones y ambiguedades al momento de referenciar un campo.
Los libros cuyo código de autor no se encuentra en "autores" y cuya editorial no existe en "editoriales", no aparecen porque 
realizamos una combinación interna.

Podemos combinar varios tipos de join en una misma sentencia:

select titulo,a.nombre,e.nombre
from autores a
right join libros l
on codigoautor=a.codigo
left join editoriales e
on codigoeditorial=e.codigo;

En la consulta anterior solicitamos el título, autor y editorial de todos los libros que encuentren o no coincidencia con 
"autores" ("right join") y a ese resultado lo combinamos con "editoriales", encuentren o no coincidencia.

Es posible realizar varias combinaciones para obtener información de varias tablas. Las tablas deben tener claves externas 
relacionadas con las tablas a combinar.

En consultas en las cuales empleamos varios "join" es importante tener en cuenta el orden de las tablas y los tipos de "join".
*/










