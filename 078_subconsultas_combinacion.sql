/*
Algunas sentencias en las cuales la consulta interna y la externa emplean la misma tabla pueden reemplazarse por una 
autocombinación.

Por ejemplo, queremos una lista de los libros que han sido publicados por distintas editoriales.

 select distinct l1.titulo
  from libros l1
  where l1.titulo in
  (select l2.titulo
    from libros l2 
    where l1.editorial <> l2.editorial);

En el ejemplo anterior empleamos una subconsulta correlacionada y las consultas interna y externa emplean la misma 
tabla. La subconsulta devuelve una lista de valores por ello se emplea "in" y sustituye una expresión en una cláusula "where".

Con el siguiente "join" se obtiene el mismo resultado:

 select distinct l1.titulo
  from libros l1
  join libros l2
  on l1.titulo=l1.titulo and
  l1.autor=l2.autor 
  where l1.editorial<>l2.editorial;

Otro ejemplo: Buscamos todos los libros que tienen el mismo precio que "El aleph" empleando subconsulta:

 select titulo
  from libros
  where titulo<>'El aleph' and
  precio =
   (select precio
     from libros
     where titulo='El aleph');

La subconsulta retorna un solo valor. Podemos obtener la misma salida empleando "join".

Buscamos los libros cuyo precio supere el precio promedio de los libros por editorial:

 select l1.titulo,l1.editorial,l1.precio
  from libros l1
  where l1.precio >
   (select avg(l2.precio) 
   from libros l2
    where l1.editorial= l2.editorial);

Por cada valor de l1, se evalúa la subconsulta, si el precio es mayor que el promedio.

Se puede conseguir el mismo resultado empleando un "join" con "having".
*/

 drop table libros;

 create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(5,2)
 );

 insert into libros values(1,'Alicia en el pais de las maravillas','Lewis Carroll','Emece',20.00);
 insert into libros values(2,'Alicia en el pais de las maravillas','Lewis Carroll','Plaza',35.00);
 insert into libros values(3,'Aprenda PHP','Mario Molina','Siglo XXI',40.00);
 insert into libros values(4,'El aleph','Borges','Emece',10.00);
 insert into libros values(5,'Ilusiones','Richard Bach','Planeta',15.00);
 insert into libros values(6,'Java en 10 minutos','Mario Molina','Siglo XXI',50.00);
 insert into libros values(7,'Martin Fierro','Jose Hernandez','Planeta',20.00);
 insert into libros values(8,'Martin Fierro','Jose Hernandez','Emece',30.00);
 insert into libros values(9,'Uno','Richard Bach','Planeta',10.00);

-- Obtenemos la lista de los libros que han sido publicados por distintas editoriales empleando una consulta correlacionada:

select distinct l1.titulo from libros l1
where l1.titulo in
(select l2.titulo from libros l2
where l1.editorial <> l2.editorial);

-- El siguiente "join" retorna el mismo resultado:

select distinct l1.titulo from libros l1
join libros l2
on l1.titulo = l2.titulo
where l1.editorial <> l2.editorial;

-- Buscamos todos los libros que tienen el mismo precio que "El aleph" empleando subconsulta:

select titulo from libros
where titulo <> 'El aleph' and 
precio = 
(select precio from libros
where titulo = 'El aleph');

-- Obtenemos la misma salida empleando "join":

select l1.titulo from libros l1
join libros l2
on l1.precio = l2.precio
where l2.titulo = 'El aleph' and l1.titulo <> l2.titulo;

-- Buscamos los libros cuyo precio supera el precio promedio de los libros por editorial:

select l1.titulo, l1.editorial, l1.precio from libros l1
where l1.precio > 
(select avg(l2.precio) from libros l2
where l1.editorial = l2.editorial);

-- Obtenemos la misma salida pero empleando un "join" con "having":

select l1.titulo, l1.editorial, l1.precio from libros l1
join libros l2
on l1.editorial = l2.editorial
group by l1.editorial, l1.titulo, l1.precio 
having l1.precio > avg(l2.precio);

-- Ejercicio 1

 drop table deportes;

 create table deportes(
  nombre varchar2(15),
  profesor varchar2(30),
  dia varchar2(10),
  cuota number(5,2)
 );
 
 insert into deportes values('tenis','Ana Lopez','lunes',20);
 insert into deportes values('natacion','Ana Lopez','martes',15);
 insert into deportes values('futbol','Carlos Fuentes','miercoles',10);
 insert into deportes values('basquet','Gaston Garcia','jueves',15);
 insert into deportes values('padle','Juan Huerta','lunes',15);
 insert into deportes values('handball','Juan Huerta','martes',10);

-- Muestre los nombres de los profesores que dictan más de un deporte empleando subconsulta (2 registros)

select distinct d1.profesor from deportes d1
where d1.profesor in
(select d2.profesor from deportes d2
where d1.nombre <> d2.nombre);

-- Obtenga el mismo resultado empleando join

select distinct d1.profesor from deportes d1
join deportes d2
on d1.profesor = d2.profesor
where d1.nombre <> d2.nombre;

-- Buscamos todos los deportes que se dictan el mismo día que un determinado deporte (natacion) empleando 
-- subconsulta (1 registro)

select nombre from deportes
where nombre <> 'natacion' and  dia = 
(select dia from deportes 
where nombre = 'natacion');

-- Obtenga la misma salida empleando "join"

select d1.nombre from deportes d1
join deportes d2
on 
