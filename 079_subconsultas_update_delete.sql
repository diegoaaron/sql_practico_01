/*
Dijimos que podemos emplear subconsultas en sentencias "insert", "update", "delete", adem�s de "select".

La sintaxis b�sica para realizar actualizaciones con subconsulta es la siguiente:

 update TABLA set CAMPO=NUEVOVALOR
  where CAMPO= (SUBCONSULTA);
  
Actualizamos el precio de todos los libros de editorial "Emece":

 update libros set precio=precio+(precio*0.1)
  where codigoeditorial=
   (select codigo
     from editoriales
     where nombre='Emece');

La subconsulta retorna un �nico valor. Tambi�n podemos hacerlo con un join.

La sintaxis b�sica para realizar eliminaciones con subconsulta es la siguiente:

 delete from TABLA
  where CAMPO OPERADOR (SUBCONSULTA);
  
Eliminamos todos los libros de las editoriales que tiene publicados libros de "Juan Perez":

 delete from libros
  where codigoeditorial in
   (select e.codigo
    from editoriales e
    join libros
    on codigoeditorial=e.codigo
    where autor='Juan Perez');
    
La subconsulta es una combinaci�n que retorna una lista de valores que la consulta externa emplea al seleccionar los 
registros para la eliminaci�n.
*/