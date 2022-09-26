/*
Continuamos aprendiendo las operaciones de conjuntos. Aprendimos "union", "union all", "intersect", nos resta ver "minus" 
(resta, diferencia).

Como cualquier otra operaci�n de conjuntos, "minus" se emplea cuando los datos que se quieren obtener pertenecen a 
distintas tablas y no se puede acceder a ellos con una sola consulta. Del mismo modo, las tablas referenciadas DEBEN 
tener tipos de datos similares, la misma cantidad de campos y el mismo orden de campos en la lista de selecci�n de cada 
consulta que intervenga en la operaci�n de resta.

"minus" (diferencia) devuelve los registros de la primera consulta que no se encuentran en segunda consulta, es decir, 
aquellos registros que no coinciden. Es el equivalente a "except" en SQL.

Sintaxis:

 SENTENCIASELECT1
  minus
  SENTENCIASELECT2;
  
No olvide que las consultas DEBEN tener el mismo numero de valores retornados y los valores deben ser del mismo tipo.

Una academia de ense�anza de idiomas da clases de ingl�s y frances; almacena los datos de los alumnos que estudian 
ingl�s en una tabla llamada "ingles" y los que est�n inscriptos en "franc�s" en una tabla denominada "frances".

La academia necesita el nombre y domicilio de todos los alumnos que cursan solamente ingl�s (no presentes en la 
tabla "frances") para enviarles publicidad referente al curso de franc�s. Empleamos el operador "minus" para obtener 
dicha informaci�n:

 select nombre, domicilio from ingles
  minus 
 select nombre,domicilio from frances;
Obtenemos los registros de la primer consulta que NO coinciden con ning�n registro de la segunda consulta.

"minus" puede combinarse con la cl�usula "order by".

Se pueden combinar m�s de dos sentencias con "minus".
*/




