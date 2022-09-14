/*
Vimos que una combinación interna (join) encuentra registros de la primera tabla que se correspondan con los registros de
la segunda, es decir, que cumplan la condición del "on" y si un valor de la primera tabla no se encuentra en la segunda tabla, 
el registro no aparece.

Si queremos saber qué registros de una tabla NO encuentran correspondencia en la otra, es decir, no existe valor coincidente
en la segunda, necesitamos otro tipo de combinación, "outer join" (combinación externa).

Las combinaciones externas combinan registros de dos tablas que cumplen la condición, más los registros de la segunda 
tabla que no la cumplen; es decir, muestran todos los registros de las tablas relacionadas, aún cuando no haya valores 
coincidentes entre ellas.

Este tipo de combinación se emplea cuando se necesita una lista completa de los datos de una de las tablas y la información 
que cumple con la condición. Las combinaciones externas se realizan solamente entre 2 tablas.

Hay tres tipos de combinaciones externas: "left outer join", "right outer join" y "full outer join"; se pueden abreviar con 
"left join", "right join" y "full join" respectivamente.

Vamos a estudiar las primeras.

Se emplea una combinación externa izquierda para mostrar todos los registros de la tabla de la izquierda. 
Si no encuentra coincidencia con la tabla de la derecha, el registro muestra los campos de la segunda tabla seteados a "null".

En el siguiente ejemplo solicitamos el título y nombre de la editorial de los libros:

select titulo,nombre
from editoriales e
left join libros l
on codigoeditorial = e.codigo;

El resultado mostrará el título y nombre de la editorial; las editoriales de las cuales no hay libros, es decir, cuyo código de
editorial no está presente en "libros" aparece en el resultado, pero con el valor "null" en el campo "titulo".

Es importante la posición en que se colocan las tablas en un "left join", la tabla de la izquierda es la que se usa para localizar
registros en la tabla de la derecha.

Entonces, un "left join" se usa para hacer coincidir registros en una tabla (izquierda) con otra tabla (derecha); si un valor de 
la tabla de la izquierda no encuentra coincidencia en la tabla de la derecha, se genera una fila extra (una por cada valor 
no encontrado) con todos los campos correspondientes a la tabla derecha seteados a "null". 

La sintaxis básica es la siguiente:

select CAMPOS
from TABLAIZQUIERDA
left join TABLADERECHA
on CONDICION;

En el siguiente ejemplo solicitamos el título y el nombre la editorial, la sentencia es similar a la anterior, la diferencia 
está en el orden de las tablas:

  select titulo,nombre
  from libros l
  left join editoriales e
  on codigoeditorial = e.codigo;

El resultado mostrará el título del libro y el nombre de la editorial; los títulos cuyo código de editorial no está presente en 
"editoriales" aparecen en el resultado, pero con el valor "null" en el campo "nombre".

Un "left join" puede tener clausula "where" que restringa el resultado de la consulta considerando solamente los registros 
que encuentran coincidencia en la tabla de la derecha, es decir, cuyo valor de código está presente en "libros":

 select titulo,nombre
  from editoriales e
  left join libros l
  on e.codigo=codigoeditorial
  where codigoeditorial is not null;
  
También podemos mostrar las editoriales que NO están presentes en "libros", es decir, que NO encuentran 
coincidencia en la tabla de la derecha:

 select titulo,nombre
  from editoriales e
  left join libros l
  on e.codigo=codigoeditorial
  where codigoeditorial is null;
*/

drop table libros;
drop table editoriales;

create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  codigoeditorial number(3)
);

create table editoriales(
  codigo number(3),
  nombre varchar2(20),
  direccion varchar2(40)
);
 
alter table editoriales
add constraints UQ_editoriales_codigo
unique (codigo);

alter table libros
add constraints UQ_libros_codigo
unique (codigo);

insert into editoriales values(1,'Planeta','Colon 120');
insert into editoriales values(2,'Emece','Estrada 356');
insert into editoriales values(3,'Siglo XXI','General Paz 700');
insert into editoriales values(null,'Sudamericana','Copiapo 343');
insert into editoriales values(null,'Norma','Bulnes 123');

insert into libros values(100,'El aleph','Borges',1);
insert into libros values(200,'Martin Fierro','Jose Hernandez',1);
insert into libros values(300,'Aprenda PHP','Mario Molina',2);
insert into libros values(400,'Java en 10 minutos',default,4);
insert into libros values(500,'El quijote de la mancha','Cervantes',null);

-- realizamos una combinación izquierda para obtener los títulos de los libros, incluyendo el nombre de la editorial:
-- Las editoriales de las cuales no hay libros, es decir, cuyo código de editorial no está presente en "libros" o tienen valor nulo, 
-- aparece en el resultado, pero con el valor "null" en el campo "titulo" (caso de "Siglo XXI", "Sudamericana" y "Norma").

select titulo, nombre
from editoriales e
left join libros l
on e.codigo = codigoeditorial;

-- Realizamos la misma consulta anterior pero cambiamos el orden de las tablas:
-- El resultado mostrará el título del libro y el nombre de la editorial; los títulos cuyo código de editorial no está presente en 
-- "editoriales" o tienen valor nulo, aparecen en el resultado, pero con el valor "null" en el campo "nombre" (caso de los libros 
-- "El quijote..." y "Java...").

select titulo, nombre
from libros l
left join editoriales e
on codigoeditorial = e.codigo;

-- Restringimos el resultado de una consulta considerando solamente los registros que encuentran coincidencia en la tabla 
-- de la derecha, es decir, cuyo valor de código está presente en "libros":

select titulo, nombre
from editoriales e
left join libros l
on e.codigo = codigoeditorial
where codigoeditorial is not null;

-- Mostramos las editoriales que NO están presentes en "libros", es decir, que NO encuentran coincidencia en la 
-- tabla de la derecha:

select nombre
from editoriales e
left join libros l
on e.codigo = codigoeditorial
where codigoeditorial is null;

-- Ejercicio 1 






