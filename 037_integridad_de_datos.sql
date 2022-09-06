/* 
Es importante, al dise�ar una base de datos y las tablas que contiene, tener en cuenta la integridad de los datos, 
esto significa que la informaci�n almacenada en las tablas debe ser v�lida, coherente y exacta.

Hasta el momento, hemos controlado y restringido la entrada de valores a un campo mediante el tipo de dato que le 
definimos (cadena, num�ricos, etc.), la aceptaci�n o no de valores nulos, el valor por defecto. Tambi�n hemos asegurado 
que cada registro de una tabla sea �nico definiendo una clave primaria y empleando secuencias.

Oracle ofrece m�s alternativas, adem�s de las aprendidas, para restringir y validar los datos, las veremos ordenadamente
y al finalizar haremos un resumen de las mismas.

Comenzamos por las restricciones.

Las restricciones (constraints) son un m�todo para mantener la integridad de los datos, asegurando que los valores 
ingresados sean v�lidos y que las relaciones entre las tablas se mantenga.

Las restricciones pueden establecerse a nivel de campo o de tabla.

Pueden definirse al crear la tabla ("create table") o agregarse a una tabla existente (empleando "alter table") y 
se pueden aplicar a un campo o a varios. Tambi�n es posible habilitarlas y deshabilitarlas.

Oracle ofrece varios tipos de restricciones:


*/
