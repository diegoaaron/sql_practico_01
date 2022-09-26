/*
Continuamos aprendiendo las operaciones de conjuntos. Aprendimos "union", "union all", "intersect", nos resta ver "minus" 
(resta, diferencia).

Como cualquier otra operación de conjuntos, "minus" se emplea cuando los datos que se quieren obtener pertenecen a 
distintas tablas y no se puede acceder a ellos con una sola consulta. Del mismo modo, las tablas referenciadas DEBEN 
tener tipos de datos similares, la misma cantidad de campos y el mismo orden de campos en la lista de selección de cada 
consulta que intervenga en la operación de resta.

"minus" (diferencia) devuelve los registros de la primera consulta que no se encuentran en segunda consulta, es decir, 
aquellos registros que no coinciden. Es el equivalente a "except" en SQL.

Sintaxis:

 SENTENCIASELECT1
  minus
  SENTENCIASELECT2;
  
No olvide que las consultas DEBEN tener el mismo numero de valores retornados y los valores deben ser del mismo tipo.

Una academia de enseñanza de idiomas da clases de inglés y frances; almacena los datos de los alumnos que estudian 
inglés en una tabla llamada "ingles" y los que están inscriptos en "francés" en una tabla denominada "frances".

La academia necesita el nombre y domicilio de todos los alumnos que cursan solamente inglés (no presentes en la 
tabla "frances") para enviarles publicidad referente al curso de francés. Empleamos el operador "minus" para obtener 
dicha información:

 select nombre, domicilio from ingles
  minus 
 select nombre,domicilio from frances;
Obtenemos los registros de la primer consulta que NO coinciden con ningún registro de la segunda consulta.

"minus" puede combinarse con la cláusula "order by".

Se pueden combinar más de dos sentencias con "minus".
*/




