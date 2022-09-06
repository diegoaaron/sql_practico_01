/* 
Es importante, al diseñar una base de datos y las tablas que contiene, tener en cuenta la integridad de los datos, 
esto significa que la información almacenada en las tablas debe ser válida, coherente y exacta.

Hasta el momento, hemos controlado y restringido la entrada de valores a un campo mediante el tipo de dato que le 
definimos (cadena, numéricos, etc.), la aceptación o no de valores nulos, el valor por defecto. También hemos asegurado 
que cada registro de una tabla sea único definiendo una clave primaria y empleando secuencias.

Oracle ofrece más alternativas, además de las aprendidas, para restringir y validar los datos, las veremos ordenadamente
y al finalizar haremos un resumen de las mismas.

Comenzamos por las restricciones.

Las restricciones (constraints) son un método para mantener la integridad de los datos, asegurando que los valores 
ingresados sean válidos y que las relaciones entre las tablas se mantenga.

Las restricciones pueden establecerse a nivel de campo o de tabla.

Pueden definirse al crear la tabla ("create table") o agregarse a una tabla existente (empleando "alter table") y 
se pueden aplicar a un campo o a varios. También es posible habilitarlas y deshabilitarlas.

Oracle ofrece varios tipos de restricciones:


*/
