/*
"any" y "some" son sinónimos. Chequean si alguna fila de la lista resultado de una subconsulta se encuentra el valor 
especificado en la condición.

Compara un valor escalar con los valores de un campo y devuelven "true" si la comparación con cada valor de la lista de 
la subconsulta es verdadera, sino "false".

El tipo de datos que se comparan deben ser compatibles.

La sintaxis básica es:

 ...VALORESCALAR OPERADORDECOMPARACION
  any (SUBCONSULTA);

Queremos saber los títulos de los libros de "Borges" que pertenecen a editoriales que han publicado también libros de 
"Richard Bach", es decir, si los libros de "Borges" coinciden con ALGUNA de las editoriales que publicó libros de 
"Richard Bach":

 select titulo
  from libros
  where autor='Borges' and
  codigoeditorial = any
   (select e.codigo
    from editoriales e
    join libros l
    on codigoeditorial=e.codigo
    where l.autor='Richard Bach');

La consulta interna (subconsulta) retorna una lista de valores de un solo campo (puede ejecutar la subconsulta como una 
consulta para probarla), luego, la consulta externa compara cada valor de "codigoeditorial" con cada valor de la lista 
devolviendo los títulos de "Borges" que coinciden.

"all" también compara un valor escalar con una serie de valores. Chequea si TODOS los valores de la lista de la consulta 
externa se encuentran en la lista de valores devuelta por la consulta interna.

Sintaxis:

  VALORESCALAR OPERADORDECOMPARACION all (SUBCONSULTA);

Queremos saber si TODAS las editoriales que publicaron libros de "Borges" coinciden con TODAS las editoriales que 
publicaron libros de "Richard Bach":

 select titulo
  from libros
  where autor='Borges' and
  codigoeditorial = all
   (select e.codigo
    from editoriales e
    join libros l
    on codigoeditorial=e.codigo
    where l.autor='Richard Bach');

La consulta interna (subconsulta) retorna una lista de valores de un solo campo (puede ejecutar la subconsulta como una 
consulta para probarla), luego, la consulta externa compara cada valor de "codigoeditorial" con cada valor de la lista, si 
TODOS coinciden, devuelve los títulos.

Veamos otro ejemplo con un operador de comparación diferente:

Queremos saber si ALGUN precio de los libros de "Borges" es mayor a ALGUN precio de los libros de "Richard Bach":

 select titulo,precio
  from libros
  where autor='Borges' and
  precio > any
   (select precio
    from libros
    where autor='Bach');

El precio de cada libro de "Borges" es comparado con cada valor de la lista de valores retornada por la subconsulta; 
si ALGUNO cumple la condición, es decir, es mayor a ALGUN precio de "Richard Bach", se lista.

Veamos la diferencia si empleamos "all" en lugar de "any":

 select titulo,precio
  from libros
  where autor='borges' and
  precio > all
   (select precio
    from libros
    where autor='bach');

El precio de cada libro de "Borges" es comparado con cada valor de la lista de valores retornada por la subconsulta; si 
cumple la condición, es decir, si es mayor a TODOS los precios de "Richard Bach" (o al mayor), se lista.

Emplear "= any" es lo mismo que emplear "in".

Emplear "<> all" es lo mismo que emplear "not in".
*/

 drop table libros;
 drop table editoriales;

 create table editoriales(
  codigo number(3),
  nombre varchar2(30),
  primary key (codigo)
 );
 
 create table libros (
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  codigoeditorial number(3),
  precio number(5,2),
  primary key(codigo),
 constraint FK_libros_editorial
   foreign key (codigoeditorial)
   references editoriales(codigo)
   on delete cascade
 );

 insert into editoriales values(1,'Planeta');
 insert into editoriales values(2,'Emece');
 insert into editoriales values(3,'Paidos');
 insert into editoriales values(4,'Siglo XXI');

 insert into libros values(100,'Uno','Richard Bach',1,15);
 insert into libros values(101,'Ilusiones','Richard Bach',4,18);
 insert into libros values(102,'Puente al infinito','Richard Bach',2,20);
 insert into libros values(103,'Aprenda PHP','Mario Molina',4,40);
 insert into libros values(104,'El aleph','Borges',2,10);
 insert into libros values(105,'Antología','Borges',1,20);
 insert into libros values(106,'Cervantes y el quijote','Borges',3,25);

-- Mostramos los títulos de los libros de "Borges" de editoriales que han publicado también libros de "Richard Bach":

select titulo from libros
where autor like '%Borges%' and
codigoeditorial = any 
(select e.codigo from editoriales e
join libros l
on e.codigo = codigoeditorial
where l.autor like '%Bach%');

-- Realizamos la misma consulta pero empleando "all" en lugar de "any":

 select titulo from libros
where autor like '%Borges%' and
codigoeditorial = all
(select e.codigo
from editoriales e
join libros l
on codigoeditorial=e.codigo
where l.autor like '%Bach%');

-- Mostramos los títulos y precios de los libros "Borges" cuyo precio supera a ALGUN precio de los libros de "Richard Bach":

select titulo, precio from libros
where autor like '%Borges%' and
precio > any
(select precio from libros
where autor like '%Bach%');

-- Veamos la diferencia si empleamos "all" en lugar de "any":

select titulo, precio from libros
where autor like '%Borges%' and
precio > all 
(select precio from libros
where autor like '%Bach%');

-- Empleamos la misma subconsulta para eliminación:

delete from libros
where autor like '%Borges%' and
precio > all 
(select precio from libros 
where autor like '%Bach%');

