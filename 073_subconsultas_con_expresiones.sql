/*
Una subconsulta puede reemplazar una expresi�n. Dicha subconsulta debe devolver un valor escalar (o una lista de valores 
de un campo).

Las subconsultas que retornan un solo valor escalar se utiliza con un operador de comparaci�n o en lugar de una expresi�n:

 select CAMPOS
  from TABLA
  where CAMPO OPERADOR (SUBCONSULTA);

 select CAMPO OPERADOR (SUBCONSULTA)
  from TABLA;

Si queremos saber el precio de un determinado libro y la diferencia con el precio del libro m�s costoso, anteriormente 
deb�amos averiguar en una consulta el precio del libro m�s costoso y luego, en otra consulta, calcular la diferencia con el 
valor del libro que solicitamos. Podemos conseguirlo en una sola sentencia combinando dos consultas:

 select titulo,precio,
  precio-(select max(precio) from libros) as diferencia
  from libros
  where titulo='Uno';

En el ejemplo anterior se muestra el t�tulo, el precio de un libro y la diferencia entre el precio del libro y el m�ximo valor de precio.

Queremos saber el t�tulo, autor y precio del libro m�s costoso:

 select titulo,autor, precio
  from libros
  where precio=
   (select max(precio) from libros);

Note que el campo del "where" de la consulta exterior es compatible con el valor retornado por la expresi�n de la subconsulta.

Se pueden emplear en "select", "insert", "update" y "delete".

Para actualizar un registro empleando subconsulta la sintaxis b�sica es la siguiente:

 update TABLA set CAMPO=NUEVOVALOR
  where CAMPO= (SUBCONSULTA);

Para eliminar registros empleando subconsulta empleamos la siguiente sintaxis b�sica:

 delete from TABLA
  where CAMPO=(SUBCONSULTA);
*/









