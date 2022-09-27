/*
Una subconsulta (subquery) es una sentencia "select" anidada en otra sentencia "select", "insert", "update" o "delete" 
(o en otra subconsulta).

Las subconsultas se emplean cuando una consulta es muy compleja, entonces se la divide en varios pasos l�gicos y se 
obtiene el resultado con una �nica instrucci�n y cuando la consulta depende de los resultados de otra consulta.

Generalmente, una subconsulta se puede reemplazar por combinaciones y estas �ltimas son m�s eficientes.

Las subconsultas generalmente se incluyen entre par�ntesis.

Puede haber subconsultas dentro de subconsultas.

Generalmente las subconsultas se colocan en la cl�usula "where".

Una subconsulta puede retornar:

- un solo valor,

- una lista de valores de una sola columna,

- un conjunto de registros de varios campos.

Podemos averiguar si un valor de la consulta externa pertenece o no al conjunto devuelto por una subconsulta ("in", "not in"), 
si es mayor, menor o igual a todos ("all") o a algunos valores ("some", "any") del conjunto devuelto.

Se pueden emplear subconsultas:

- en lugar de una expresi�n, siempre que devuelvan un solo valor o una lista de valores.

- que retornen un conjunto de registros de varios campos en lugar de una tabla o para obtener el mismo resultado que una 
combinaci�n (join).

Hay varios tipos b�sicos de subconsultas:

- las que retornan un solo valor escalar que se utiliza con un operador de comparaci�n o en lugar de una expresi�n.

- las que retornan una lista de valores, se combinan con "in", o los operadores "any", "some" y "all".

- los que testean la existencia con "exists".
*/