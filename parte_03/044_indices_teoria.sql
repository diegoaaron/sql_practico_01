/*
Otros objetos de base de datos son los �ndices.

Los �ndices sirven para acceder a los registros de una tabla r�pidamente, acelerando la localizaci�n de la informaci�n.

Los �ndices se emplean para facilitar la obtenci�n de informaci�n de una tabla. El indice de una tabla desempe�a 
la misma funci�n que el �ndice de un libro: permite encontrar datos r�pidamente; en el caso de las tablas, localiza registros.

Oracle accede a los datos de dos maneras:

1) recorriendo las tablas; comenzando el principio y extrayendo los registros que cumplen las condiciones de la consulta; 
lo cual implica posicionar las cabezas lectoras, leer el dato, controlar si coincide con lo que se busca (como si pas�ramos 
una a una las p�ginas de un libro buscando un tema espec�fico).

2) empleando �ndices; recorriendo la estructura de �rbol del �ndice para localizar los registros y extrayendo los que cumplen 
las condiciones de la consulta (comparando con un libro, diremos que es como leer el �ndice y luego de encontrar el tema 
buscado, ir directamente a la p�gina indicada).

Un �ndice posibilita el acceso directo y r�pido haciendo m�s eficiente las b�squedas. Sin �ndice, Oracle debe recorrer 
secuencialmente toda la tabla para encontrar un registro.

Los �ndices son estructuras asociadas a tablas, una tabla que almacena los campos indexados y se crean para 
acelerar las consultas.

Entonces, el objetivo de un indice es acelerar la recuperaci�n de informaci�n. La indexaci�n es una t�cnica que 
optimiza el acceso a los datos, mejora el rendimiento acelerando las consultas y otras operaciones. 
Es �til cuando la tabla contiene miles de registros, cuando se realizan operaciones de ordenamiento y agrupamiento y 
cuando se combinan varias tablas (tema que veremos m�s adelante).

La desventaja es que consume espacio en el disco y genera costo de mantenimiento (tiempo y recursos).

Es importante identificar el o los campos por los que ser�a �til crear un �ndice, aquellos campos por los cuales se realizan 
b�squedas con frecuencia: claves primarias, claves externas o campos que combinan tablas.

No se recomienda crear �ndices sobre campos que no se usan con frecuencia en consultas o en tablas muy peque�as.

Los cambios sobre la tabla, como inserci�n, actualizaci�n o eliminaci�n de registros, son incorporados autom�ticamente.

Cuando creamos una restricci�n "primary key" o "unique" a una tabla, Oracle autom�ticamente crea un �ndice sobre 
el campo (o los campos) de la restricci�n y le da el mismo nombre que la restricci�n. En caso que la tabla ya tenga 
un �ndice, Oracle lo usa, no crea otro.

Oracle permite crear distintos tipos de �ndices. "Normal" es el standard de Oracle, son �ndices tipo �rbol binario; 
contiene una entrada por cada valor de clave que almacena la direcci�n donde se encuentra el dato. 
Es el tipo predeterminado y el m�s com�n (el �nico que estudiaremos).
*/