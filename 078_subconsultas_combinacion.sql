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





