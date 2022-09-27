/*
Vimos que una subconsulta puede reemplazar una expresi�n. Dicha subconsulta debe devolver un valor escalar o una lista 
de valores de un campo; las subconsultas que retornan una lista de valores reemplazan a una expresi�n en una cl�usula 
"where" que contiene la palabra clave "in".

El resultado de una subconsulta con "in" (o "not in") es una lista. Luego que la subconsulta retorna resultados, la consulta 
exterior los usa.

Podemos averiguar si un valor de la consulta externa pertenece o no al conjunto devuelto por una subconsulta empleando 
"in" y "not in".

La sintaxis b�sica es la siguiente:

 ...where EXPRESION in (SUBCONSULTA);
 
Este ejemplo muestra los nombres de las editoriales que ha publicado libros de un determinado autor:

 select nombre
  from editoriales
  where codigo in
   (select codigoeditorial
     from libros
     where autor='Richard Bach');

La subconsulta (consulta interna) retorna una lista de valores de un solo campo (codigoeditorial) que la consulta exterior luego
emplea al recuperar los datos.

Se averigua si el c�digo devuelto por la consulta externa se encuentra dentro del conjunto de valores retornados por la consulta 
interna.

Podemos reemplazar por un "join" la consulta anterior:

 select distinct nombre
  from editoriales e
  join libros
  on codigoeditorial=e.codigo
  where autor='Richard Bach';
  
Una combinaci�n (join) siempre puede ser expresada como una subconsulta; pero una subconsulta no siempre puede 
reemplazarse por una combinaci�n que retorne el mismo resultado. Si es posible, es aconsejable emplear combinaciones 
en lugar de subconsultas, son m�s eficientes.

Se recomienda probar las subconsultas antes de incluirlas en una consulta exterior, as� puede verificar que retorna lo 
necesario, porque a veces resulta dif�cil verlo en consultas anidadas.

Tambi�n podemos buscar valores No coincidentes con una lista de valores que retorna una subconsulta; por ejemplo, las 
editoriales que no han publicado libros de un autor espec�fico:

 select nombre
  from editoriales
  where codigo not in
   (select codigoeditorial
     from libros
     where autor='Richard Bach');
*/









